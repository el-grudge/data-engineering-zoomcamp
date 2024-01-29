FROM python:3.9.1

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2 flask gunicorn

WORKDIR /app
COPY ingest-data.py ingest-data.py 

EXPOSE 9696

ENTRYPOINT ["gunicorn", "--timeout=60", "--bind=0.0.0.0:9696", "ingest-data:app"]
