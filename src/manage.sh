#!/bin/bash
# Requires the database to be up

# Host configurable por variable de entorno
DB_HOST=${DB_HOST:-127.0.0.1}
DB_PORT=${DB_PORT:-5432}

FLASK_ENV=development DATABASE_URI=postgresql://myuser:mypassword@${DB_HOST}:5432/mydatabase python manage.py
