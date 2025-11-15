# Proyecto Final DevOps: Entorno local de desarrollo

Este entorno permite ejecutar una aplicación web, desarrollada utilizando el framework de Python Flask, de forma reproducible haciendo uso de Docker.

## Arquitectura del software

- Python + Flask framework
- PostgreSQL como base de datos
- Docker + Docker Compose para orquestación
- Tests con Pytest y cobertura con Coverage
- Versionado utilizando Git como VCS

## Ejecucción en Docker
* Este es el método recomendado para poner en marcha la aplicación, porque gracias a Docker es reproducible en entornos diferentes
```bash
docker compose build
docker compose up
Acceder a http://localhost:5000/data
```

### Ejecucción de tests
```bash
# Poner en marcha el contenedor docker
docker compose up -d
# Ejecutar el servicio 'web', y ejecutar los tests definidos en el directorio tests, con coverage
docker compose exec web coverage run -m pytest tests
# Para obtener el reporte generado por coverage
docker compose exec web coverage report -m
```

## Ejecucción en Docker utilizando el Makefile

* Para simplificar la tareas de desarrollo, es posible utilizar el comando `make` para ejecutar los comandos dockerr compose anteriormente mencionados.

```bash
make build; make run # o con un único comando: make up
Acceder a la app a través de http://localhost:5000/data
```

### Ejecución de tests

```
make test
```

## Normas de Colaboración
* Modelo de ramas: Se debe utilizar GitHub Flow. Toda nueva funcionalidad debe desarrollarse en una rama con nombre descriptivo (feature/login, fix/db-connection, etc.).
* Commits: Los mensajes deben ser claros y semánticos.
  * Ejemplos:
    * feat: añade endpoint de login
    * fix: corrige error de conexión con PostgreSQL

* Pull Requests:
  1. Toda PR debe incluir descripción clara del cambio.
  2. No se aceptan PR sin tests o sin validación local (make test debe pasar).
  3. Se requiere al menos una revisión antes de hacer merge.

* Cobertura mínima: Los tests deben cubrir al menos el 80% del código.
  *  Usa make coverage para verificar antes de subir cambios.

* Estilo de código:
  * Sigue PEP8. Usa flake8 localmente antes de subir.
  * No se aceptan PR con errores de linting.

* Documentación: Toda nueva funcionalidad debe incluir instrucciones en el README.md o en un archivo separado dentro de docs/.


## TODO: Para Futuro Sprints

### Versionado con Docker Hub
Una vez creada la pipeline de CI (por ejemplo, con Jenkins o GitHub Actions), se podrá:

* Generar automáticamente una imagen Docker por cada versión del paquete
* Etiquetar imágenes con el número de versión (myapp:0.1.0, myapp:0.2.0, etc.)
* Publicar en Docker Hub o en un registry privado
* Instalar el software vía docker pull y ejecutar sin necesidad de clonar el repo
* Este entorno de desarrollo permitirá despliegues reproducibles, con rollback controlado y distribución segura.
