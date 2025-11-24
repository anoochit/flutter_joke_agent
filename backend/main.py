from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import requests
import os

app = FastAPI()

# ADK Server URL (default port is often 8080 or defined by user)
# We assume the agent server is running on localhost:8080
AGENT_URL = os.getenv("AGENT_URL", "http://localhost:8080/run")

class JokeRequest(BaseModel):
    topic: str

@app.post("/joke")
async def tell_joke(req: JokeRequest):
    try:
        # The ADK API server typically expects a JSON payload.
        # For a simple agent, it might just be the input string or a dict.
        # We'll send it as {"input": ...} which is a common convention.
        payload = {"input": req.topic}
        
        # Call the Agent Service
        response = requests.post(AGENT_URL, json=payload)
        response.raise_for_status()
        
        # Return the data from the agent
        return response.json()
        
    except requests.exceptions.ConnectionError:
        raise HTTPException(status_code=503, detail="Agent Service is unavailable. Is 'adk api_server' running?")
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@app.get("/health")
async def health_check():
    return {"status": "ok"}
