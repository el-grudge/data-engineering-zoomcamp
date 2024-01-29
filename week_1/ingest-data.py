#!/usr/bin/env python
# coding: utf-8

import os
from time import time
import pandas as pd
from sqlalchemy import create_engine
from flask import Flask, request, jsonify

app = Flask(__name__)

def ingest_data(user, password, host, port, db, table_name, url):
    # the backup files are gzipped, and it's important to keep the correct extension
    # for pandas to be able to open the file
    if url.endswith('.csv.gz'):
        csv_name = 'output.csv.gz'
    else:
        csv_name = 'output.csv'

    os.system(f"wget {url} -O {csv_name}")

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # Rest of your existing code...
    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=50000)

    df = next(df_iter)

    # df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    # df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    df.to_sql(name=table_name, con=engine, if_exists='append')

    while True:

        try:
            t_start = time()
            df = next(df_iter)

            # df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
            # df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

            df.to_sql(name=table_name, con=engine, if_exists='append')

            t_end = time()
            print('inserted another chunk, took %.3f second' % (t_end - t_start))
            engine.dispose()
        except StopIteration:
            print("Finished ingesting data into the postgres database")
            break

        finally:
            engine.dispose()

@app.route('/ingest', methods=['POST'])
def ingest():
    try:
        # Extract parameters from the request
        user = request.json['user']
        password = request.json['password']
        host = request.json['host']
        port = request.json['port']
        db = request.json['db']
        table_name = request.json['table_name']
        url = request.json['url']

        # Call your data ingestion function
        ingest_data(user, password, host, port, db, table_name, url)
    
        return jsonify({'status': 'success', 'message': 'Data ingestion successful'})

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9696)