import google.generativeai as genai
import os

genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

def analyze_incident(description):
    model = genai.GenerativeModel("gemini-1.5-pro")
    response = model.generate_content(description)
    return response.text

