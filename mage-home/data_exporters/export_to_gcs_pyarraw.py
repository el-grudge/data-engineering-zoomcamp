import pyarrow as pa 
import pyarrow.parquet as pq 
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/src/personal-gcp.json'

bucket_name = 'linen_source_411501_bucket'
project_id = 'linen-source-411501'

directory_name = "taxi_data_all"

@data_exporter
def export_data(data, *args, **kwargs):
    table = pa.Table.from_pandas(data)

    taxi_line = 'fhv'
    year = kwargs['execution_date'].year
    month = kwargs['execution_date'].month
    
    path = '{}/{}/{:02d}'.format(taxi_line, year, month)
    
    root_path = f'{bucket_name}/{directory_name}/{path}/'

    gcs = pa.fs.GcsFileSystem()
    
    pq.write_to_dataset(
        table,
        root_path=root_path,
        basename_template='data{i}.parquet',
        filesystem=gcs
    )