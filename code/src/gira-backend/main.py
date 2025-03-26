from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from ai_module import analyze_incident
from database import save_incident

app = FastAPI()

# Define allowed origins
origins = [
    "http://localhost:5173",  # React development server
    "http://13.203.207.238:5173",  # Replace with your actual frontend URL
]

# Add CORS middleware to the application
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # Allows specified origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# Define request model
class IncidentRequest(BaseModel):
    description: str

# Root endpoint to verify the API is running
@app.get("/")
def home():
    return {"message": "GIRA API is running successfully!"}

# Incident resolution endpoint
@app.post("/resolve")
async def resolve_incident(request: IncidentRequest):
    analysis = analyze_incident(request.description)
    save_incident(request.description, analysis)
    return {"status": "resolved", "analysis": analysis}

