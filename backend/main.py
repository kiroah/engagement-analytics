from fastapi import FastAPI
from backend.api import endpoints

app = FastAPI(title="(DEMO APP)Engagement Analytics API")

app.include_router(endpoints.router, prefix="/api/v1")

@app.get("/health")
def health_check():
    return {"status": "ok"}
