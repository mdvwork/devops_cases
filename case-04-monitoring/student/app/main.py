import os
import time

from fastapi import FastAPI, Request
from prometheus_client import Counter, Histogram, make_asgi_app

app = FastAPI()
REQUESTS = Counter("http_requests_total", "Total HTTP requests", ["method", "path", "status"])
DURATION = Histogram("http_request_duration_seconds", "HTTP request duration", ["method", "path"])

@app.middleware("http")
async def observe(request: Request, call_next):
    start = time.perf_counter()
    response = await call_next(request)
    path = request.url.path
    if path != "/metrics":
        REQUESTS.labels(request.method, path, str(response.status_code)).inc()
        DURATION.labels(request.method, path).observe(time.perf_counter() - start)
    return response

@app.get("/")
def root():
    return {"service": "career-academy-demo", "status": "ok", "environment": os.getenv("APP_ENV", "development")}

@app.get("/health")
def health():
    return {"status": "healthy"}

app.mount("/metrics", make_asgi_app())
