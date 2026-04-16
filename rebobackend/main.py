from fastapi import FastAPI
from dotenv import load_dotenv
from openai import OpenAI
from os import getenv
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import os

load_dotenv()

app = FastAPI()

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allow all origins for development
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

client = OpenAI(api_key=getenv("OPENROUTER_API_KEY"), base_url=getenv("OPENROUTER_BASE_URL"))

class ChatRequest(BaseModel):
    message: str
    model: str = "openai/gpt-4o"

class ChatResponse(BaseModel):
    message: str

@app.post("/chat", response_model=ChatResponse)
def chat(request: ChatRequest):
    try: 
        response = client.chat.completions.create(
            model=request.model,
            messages=[
                {"role": "user", "content": request.message}
            ]
        )
        return ChatResponse(message=response.choices[0].message.content)
    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})

@app.get("/")
def read_root():
    return {"Hello": "World"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
