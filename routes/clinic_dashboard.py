from fastapi import APIRouter
from database import get_connection

router = APIRouter(prefix="/clinic", tags=["Clinic Dashboard"])


@router.get("/dashboard/{clinic_id}")
def get_dashboard_stats(clinic_id: str):
    cid = clinic_id.strip().upper()

    conn = get_connection()
    cur = conn.cursor(dictionary=True)

    try:
        # ✅ Check clinic exists
        cur.execute(
            "SELECT clinic_id FROM clinics WHERE UPPER(TRIM(clinic_id)) = %s",
            (cid,)
        )
        if not cur.fetchone():
            return {
                "status": "fail",
                "message": "Invalid clinic_id",
                "total_doctors": 0,   # ✅ ADDED
                "total_patients": 0,
                "total_cases": 0,
                "completed": 0,
                "drafts": 0,
                "in_progress": 0
            }

        # ✅ TOTAL DOCTORS (NEW)
        cur.execute(
            """
            SELECT COUNT(*) AS count
            FROM doctors
            WHERE UPPER(TRIM(clinic_id)) = %s
            """,
            (cid,)
        )
        total_doctors = cur.fetchone()["count"]

        # ✅ TOTAL PATIENTS
        cur.execute(
            """
            SELECT COUNT(*) AS count
            FROM patients
            WHERE UPPER(TRIM(clinic_id)) = %s
            """,
            (cid,)
        )
        total_patients = cur.fetchone()["count"]

        # ✅ CASE STATS (OPTIMIZED IN ONE QUERY)
        cur.execute(
            """
            SELECT 
                COUNT(*) AS total_cases,
                SUM(UPPER(status) = 'DRAFT') AS drafts,
                SUM(UPPER(status) = 'IN_PROGRESS') AS in_progress,
                SUM(UPPER(status) = 'COMPLETED') AS completed
            FROM cases
            WHERE UPPER(TRIM(clinic_id)) = %s
            """,
            (cid,)
        )

        case_data = cur.fetchone()

        total_cases = case_data["total_cases"] or 0
        drafts = case_data["drafts"] or 0
        in_progress = case_data["in_progress"] or 0
        completed = case_data["completed"] or 0

        # ✅ FINAL RESPONSE
        return {
            "status": "success",
            "total_doctors": total_doctors,   # ✅ ADDED
            "total_patients": total_patients,
            "total_cases": total_cases,
            "completed": completed,
            "drafts": drafts,
            "in_progress": in_progress
        }

    except Exception as e:
        return {
            "status": "fail",
            "message": f"DB error: {str(e)}",
            "total_doctors": 0,   # ✅ ADDED
            "total_patients": 0,
            "total_cases": 0,
            "completed": 0,
            "drafts": 0,
            "in_progress": 0
        }

    finally:
        cur.close()
        conn.close()