# Variables
APP_DIR=src
PYTHON=python
DOCKER_EXEC=docker compose exec web
DB_URI=postgresql://myuser:mypassword@db:5432/mydatabase

# Construye y ejecuta la aplicación en Docker
up:
	make build
	make run

# Ejecuta la aplicación en Docker
run:
	docker compose up --remove-orphans -d
	make init-db-docker

# Reconstruye la imagen desde cero y ejecuta init-db
build:
	docker compose build --no-cache

# Ejecuta tests con coverage en Docker
test:
	$(DOCKER_EXEC) bash -c "PYTHONPATH=/app/src coverage run -m pytest"
	$(DOCKER_EXEC) coverage report -m

# Linting con flake8 en Docker
lint:
	$(DOCKER_EXEC) flake8 $(APP_DIR)/app

# Inicializa la base de datos dentro del contenedor
init-db-docker:
	$(DOCKER_EXEC) bash -c "export DB_HOST=db; ./manage.sh"

# Detiene los contenedores
stop:
	docker compose down

# Reconstruye la imagen desde cero
rebuild:
	make build

# Limpia contenedores y volúmenes
clean:
	docker compose down -v
