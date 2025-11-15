FROM python:3.11-slim

WORKDIR /app

# Install/Copy needed dependencies
COPY src/ ./src
COPY requirements.txt .
RUN pip install -r requirements.txt

# Hacemos app importable desde ./tests
ENV PYTHONPATH="${PYTHONPATH}:/app/src"

# Expose Flask port
EXPOSE 5000

# Default environment
#ENV FLASK_ENV=production

# Execute app
CMD ["python", "src/run.py"]
