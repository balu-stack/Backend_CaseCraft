from fastapi import APIRouter
from pydantic import BaseModel
from database import get_connection
from passlib.context import CryptContext
from email_service import send_email
import secrets
import hashlib
from datetime import datetime, timedelta
import re

router = APIRouter(prefix="/clinic", tags=["Clinic Forgot Password"])

pwd_ctx = CryptContext(schemes=["bcrypt_sha256", "bcrypt"], deprecated="auto")
OTP_TTL_MINUTES = 5


class ClinicForgotPasswordRequest(BaseModel):
    clinic_id: str


class ClinicResetPasswordRequest(BaseModel):
    clinic_id: str
    otp: str
    new_password: str


def hash_otp(otp: str, clinic_id: str) -> str:
    raw = f"{clinic_id}|{otp}".encode("utf-8")
    return hashlib.sha256(raw).hexdigest()


def generate_otp() -> str:
    return f"{secrets.randbelow(1000000):06d}"


@router.post("/forgot-password/send-otp")
def clinic_forgot_password_send_otp(req: ClinicForgotPasswordRequest):
    clinic_id = req.clinic_id.strip()

    conn = get_connection()
    cur = conn.cursor()

    try:
        cur.execute(
            "SELECT clinic_email, is_active FROM clinics WHERE clinic_id=%s",
            (clinic_id,),
        )
        row = cur.fetchone()

        if not row:
            return {"status": "fail", "message": "Invalid Clinic ID"}

        clinic_email, is_active = row

        if not is_active:
            return {"status": "fail", "message": "Clinic is not active"}

        otp = generate_otp()
        otp_h = hash_otp(otp, clinic_id)
        expires_at = datetime.utcnow() + timedelta(minutes=OTP_TTL_MINUTES)

        cur.execute(
            "UPDATE clinic_login_otps SET used=TRUE WHERE clinic_id=%s AND used=FALSE",
            (clinic_id,),
        )

        cur.execute(
            """
            INSERT INTO clinic_login_otps (clinic_id, otp_hash, expires_at, used)
            VALUES (%s, %s, %s, FALSE)
            """,
            (clinic_id, otp_h, expires_at),
        )
        conn.commit()

        send_email(
            clinic_email,
            "CaseCraft Reset Password OTP",
            f"Your OTP is {otp}. It is valid for {OTP_TTL_MINUTES} minutes."
        )

        return {"status": "success", "message": "OTP sent to registered email"}

    except Exception as e:
        conn.rollback()
        return {"status": "fail", "message": f"{str(e)}"}

    finally:
        cur.close()
        conn.close()


@router.post("/forgot-password/reset")
def clinic_reset_password(req: ClinicResetPasswordRequest):
    clinic_id = req.clinic_id.strip()
    otp = req.otp.strip()
    new_password = req.new_password.strip()

    if len(new_password) < 6:
        return {"status": "fail", "message": "Password must be at least 6 characters"}

    if not re.search(r"[A-Z]", new_password):
        return {"status": "fail", "message": "Password must contain at least one uppercase letter"}

    if not re.search(r"[0-9]", new_password):
        return {"status": "fail", "message": "Password must contain at least one number"}

    if not re.search(r"[!@#$%^&*(),.?\":{}|<>]", new_password):
        return {"status": "fail", "message": "Password must contain at least one special character"}

    if len(otp) != 6 or not otp.isdigit():
        return {"status": "fail", "message": "Invalid OTP"}

    otp_h = hash_otp(otp, clinic_id)

    conn = get_connection()
    cur = conn.cursor()

    try:
        cur.execute(
            """
            SELECT id, otp_hash, expires_at
            FROM clinic_login_otps
            WHERE clinic_id=%s AND used=FALSE
            ORDER BY created_at DESC
            LIMIT 1
            """,
            (clinic_id,),
        )
        row = cur.fetchone()

        if not row:
            return {"status": "fail", "message": "OTP not found. Please request again."}

        otp_id, db_hash, expires_at = row

        if datetime.utcnow() > expires_at:
            cur.execute(
                "UPDATE clinic_login_otps SET used=TRUE WHERE id=%s",
                (otp_id,),
            )
            conn.commit()
            return {"status": "fail", "message": "OTP expired. Please request again."}

        if db_hash != otp_h:
            return {"status": "fail", "message": "Invalid OTP"}

        new_hash = pwd_ctx.hash(new_password)

        cur.execute(
            "UPDATE clinics SET password_hash=%s WHERE clinic_id=%s",
            (new_hash, clinic_id),
        )

        cur.execute(
            "UPDATE clinic_login_otps SET used=TRUE WHERE id=%s",
            (otp_id,),
        )

        conn.commit()
        return {"status": "success", "message": "Password reset successful"}

    except Exception as e:
        conn.rollback()
        return {"status": "fail", "message": f"{str(e)}"}

    finally:
        cur.close()
        conn.close()