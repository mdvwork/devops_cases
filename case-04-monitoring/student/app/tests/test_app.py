from fastapi.testclient import TestClient
from main import app
client = TestClient(app)
def test_root(): assert client.get("/").json()["service"] == "career-academy-demo"
def test_health(): assert client.get("/health").json() == {"status": "healthy"}
def test_metrics():
    response=client.get("/metrics/")
    assert response.status_code == 200
    assert "http_requests_total" in response.text
    assert "http_request_duration_seconds" in response.text
