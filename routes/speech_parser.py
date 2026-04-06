import os
import json
import re
import time
from fastapi import APIRouter
from pydantic import BaseModel, create_model
from dotenv import load_dotenv
from google import genai
from google.genai import types

# --- INITIALIZATION ---
load_dotenv()
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY", "")

# The 2026 SDK Client
client = genai.Client(api_key=GEMINI_API_KEY)

# Use the recommended 2026 extraction model: Gemini 3.1 Flash-Lite
MODEL_NAME = "gemini-3.1-flash-lite-preview" 

router = APIRouter(prefix="/speech", tags=["Speech AI"])

# --- DATA SCHEMA ---
FULL_EMPTY_RESPONSE = {
    "chief_complaint": "", "presenting_illness": "", "past_medical_history": "",
    "medication": "", "diet": "", "smoking": "", "pan_chewing": "",
    "gutkha": "", "thumb_chewing": "", "tongue_thrusting": "",
    "nail_biting": "", "lip_biting": "", "mouth_breathing": "",
    "treatment_suggestions": "", "treatment_notes": "", "surgical_contraindications": "",
    "teeth_indicated_for_extraction": "", "impacted_teeth_war": "",
    "need_for_orthognathic_surgery": "", "type_of_orthognathic_corrections": "",
    "growth_or_swelling_present": "", "page3_treatment_suggestions": "",
    "page3_notes": "", "missing_teeth": "", "edentulousness": "",
    "acp_pdi_classification": "", "abutment_adjunct_therapy": "",
    "abutment_inadequate_tooth_structure": "", "occlusal_evaluation": "",
    "class_iv_variant": "", "sieberts_classification": "", "full_mouth_rehab_required": "",
    "head_shape": "", "face_shape": "", "arch_shape": "", "palatal_vault": "",
    "dental_malocclusion": "", "skeletal_malocclusion": "", "chin_prominence": "",
    "nasolabial_angle": "", "lip_examination": "", "maxilla_features": "",
    "mandible_features": "", "interarch_relation": "", "individual_tooth_variations": "",
    "perio_notes": "", "facial_form": "", "profile_form": "", "salivary_gland": "",
    "tm_joint": "", "cervical_lymph_nodes": "", "others": "", "lip": "",
    "gingiva": "", "alveolar_mucosa": "", "labial_buccal_mucosa": "", "tongue": "",
    "floor_of_mouth": "", "palate": "", "oro_pharynx": "", "labial_frenum_upper": "",
    "labial_frenum_lower": "", "buccal_frenum_upper_left": "", "buccal_frenum_upper_right": "",
    "buccal_frenum_lower_left": "", "buccal_frenum_lower_right": "", "lingual_frenum": ""
}

SpeechSchema = create_model('SpeechSchema', **{k: (str, ...) for k in FULL_EMPTY_RESPONSE.keys()})

class SpeechRequest(BaseModel):
    transcript: str

# --- CORE FUNCTIONS ---

def call_gemini(prompt: str, max_retries: int = 3):
    """Calls Gemini with robust error handling for 2026 models."""
    for attempt in range(max_retries):
        try:
            response = client.models.generate_content(
                model=MODEL_NAME,
                contents=prompt,
                config=types.GenerateContentConfig(
                    response_mime_type="application/json",
                    response_schema=SpeechSchema,
                    temperature=0.1, 
                )
            )
            
            if response.parsed:
                return response.parsed.model_dump()
            return json.loads(response.text) if response.text else {}

        except Exception as e:
            err_msg = str(e)
            
            # 429: Rate Limit - Extract wait time or default to 30s
            if "429" in err_msg:
                wait_time = 30
                match = re.search(r"retry in (\d+\.?\d*)s", err_msg)
                if match:
                    wait_time = float(match.group(1)) + 1
                print(f"⏳ Quota hit. Waiting {wait_time}s before retry...")
                time.sleep(wait_time)
                continue
                
            # 503: Overloaded
            if "503" in err_msg:
                print(f"⚠️ Server busy. Retrying in 5s...")
                time.sleep(5)
                continue

            print(f"❌ Gemini Error: {e}")
            break
            
    return {}

def final_post_process(data: dict, transcript: str):
    """Manual overrides to ensure accuracy if AI skips clear fields."""
    t = transcript.lower()
    
    # 1. Clean 'Not mentioned'
    for k, v in data.items():
        if isinstance(v, str) and v.lower() in ["not mentioned", "none", "n/a"]:
            data[k] = ""
            
    # 2. Hardcoded checks for high-priority fields
    if "non vegetarian" in t or "non-veg" in t: data["diet"] = "nonVeg"
    elif "vegetarian" in t: data["diet"] = "veg"

    # Habit Normalization
    for habit in ["smoking", "pan_chewing", "gutkha", "nail_biting"]:
        key = habit.replace("_", " ")
        if f"{key} yes" in t: data[habit] = "yes"
        elif f"{key} no" in t: data[habit] = "no"

    return data

# --- API ENDPOINT ---

@router.post("/parse")
async def parse_speech(req: SpeechRequest):
    transcript = req.transcript.strip()
    if not transcript:
        return FULL_EMPTY_RESPONSE

    prompt = f"Extract all clinical dental data. Missing = 'Not mentioned'.\n\nTranscript: {transcript}. If transcript was in other languages than english convert them to english."

    extracted_data = call_gemini(prompt)
    
    # Initialize with full template to ensure structure
    final_output = {**FULL_EMPTY_RESPONSE, **extracted_data}
    final_output = final_post_process(final_output, transcript)

    print(f"✅ Processed using {MODEL_NAME}")
    return final_output