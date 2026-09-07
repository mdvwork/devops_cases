from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_root(monkeypatch):
    monkeypatch.setenv("APP_ENV", "test")
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"service": "career-academy-demo", "status": "ok", "environment": "test"}


def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}
