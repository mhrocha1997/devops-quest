FROM python:3.13-alpine3.21

WORKDIR /app


COPY requirements.txt /app/

RUN pip install  --no-cache-dir -r requirements.txt

COPY main.py /app/

CMD ["python", "main.py"]