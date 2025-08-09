FROM python:3.13.6-alpine3.21

WORKDIR /app

COPY requirements.txt /app

RUN pip install --no-cache-dir -r requirements.txt

RUN opentelemetry-bootstrap -a install

COPY src/ /app/

CMD [ "opentelemetry-instrument", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "3000"]