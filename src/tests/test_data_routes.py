import pytest
from app import create_app, db
from app.models import Data

@pytest.fixture
def client():
    app = create_app("development")
    app.config["TESTING"] = True
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///:memory:"
    with app.app_context():
        db.create_all()
        yield app.test_client()
        db.session.remove()
        db.drop_all()

def test_insert_data(client):
    response = client.post("/data", json={"name": "TestUser"})
    assert response.status_code == 200
    assert response.get_json()["message"] == "Data inserted successfully"

def test_insert_duplicate_data(client):
    client.post("/data", json={"name": "TestUser"})
    response = client.post("/data", json={"name": "TestUser"})
    assert response.status_code == 409
    assert response.get_json()["message"] == "Data already exists"

def test_get_all_data(client):
    client.post("/data", json={"name": "User1"})
    client.post("/data", json={"name": "User2"})
    response = client.get("/data")
    assert response.status_code == 200
    data = response.get_json()
    assert len(data) == 2
    assert {"id": 1, "name": "User1"} in data
    assert {"id": 2, "name": "User2"} in data

def test_delete_data(client):
    client.post("/data", json={"name": "ToDelete"})
    response = client.delete("/data/1")
    assert response.status_code == 200
    assert response.get_json()["message"] == "Data deleted successfully"

def test_delete_nonexistent_data(client):
    response = client.delete("/data/999")
    assert response.status_code == 404
    assert response.get_json()["message"] == "Data not found"
