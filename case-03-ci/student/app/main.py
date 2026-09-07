import os

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def root():
    return {"service": "career-academy-demo", "status": "ok", "environment": os.getenv("APP_ENV", "development")}


@app.get("/health")
def health():
    return {"status": "healthy"}


def calculate_health_score(value: int) -> int:
    return max(0, min(100, value))
