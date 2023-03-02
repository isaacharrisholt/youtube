FROM python:3.11-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY {{ project_name }} /app/{{ project_name }}

CMD ["uvicorn", "{{ project_name }}.main:app", "--host", "0.0.0.0", "--port", "{{ port }}"]