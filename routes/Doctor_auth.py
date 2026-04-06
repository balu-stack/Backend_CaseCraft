from fastapi import APIRouter
from passlib.context import CryptContext

from database import get_connection
from models import LoginRequest

router = APIRouter(prefix="", tags=["Doctor Auth"])

pwd_context = CryptContext(
    schemes=["bcrypt_sha256", "bcrypt"],
    deprecated="auto"
)

@router.post("/login")
def login(req: LoginRequest):
    conn = get_connection()
    cur = conn.cursor(dictionary=True)

    try:
        cur.execute(
            """
            SELECT doctor_id, password_hash, doctor_name, doctor_phone, specialization
            FROM doctors
            WHERE doctor_id = %s
            """,
            (req.doctor_id.strip(),)
        )
        row = cur.fetchone()

        if not row:
            return {"status": "fail", "message": "Invalid Doctor ID or Password"}

        stored_hash = row["password_hash"]

        try:
            ok = pwd_context.verify(req.password.strip(), stored_hash)
        except Exception:
            return {
                "status": "fail",
                "message": "Password hash is invalid (check bcrypt setup)"
            }

        if not ok:
            return {"status": "fail", "message": "Invalid Doctor ID or Password"}

        return {
            "status": "success",
            "message": "Login success",
            "doctor_name": row["doctor_name"] or "",
            "doctor_phone": row["doctor_phone"] or "",
            "specialization": row["specialization"] or ""
        }

    finally:
        cur.close()
        conn.close()