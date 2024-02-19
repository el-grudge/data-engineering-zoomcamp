import os
import pyarrow.parquet as pq
import pandas as pd
from google.cloud import storage, bigquery
from dotenv import load_dotenv
from gcsfs import GCSFileSystem

# Load environment variables from the .env file
load_dotenv()

# Set your GCS credentials file path
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = os.getenv('GOOGLE_STORAGE_CREDENTIALS')

# Set your GCS bucket name
bucket_name = os.getenv("GCP_GCS_BUCKET")

# Set your BigQuery project ID
project_id = 'linen-source-411501'

# Set your BigQuery dataset ID and table ID
dataset_id = 'trips_data_all'
table_id = 'fhv_data'

# Initialize the BigQuery client with your credentials
client = bigquery.Client(project=project_id)

# Initialize the Google Cloud Storage client
storage_client = storage.Client()

# Read Parquet files and enforce schema
dfs = []
bucket = storage_client.bucket(bucket_name)
gcs = GCSFileSystem()
blobs = bucket.list_blobs(prefix='fhv/')
for blob in blobs:
    if blob.name.endswith('.parquet'):
        table = pq.read_table(bucket_name + '/' + blob.name, filesystem=gcs)
        df = table.to_pandas()

        dfs.append(df)

# Concatenate all dataframes into a single dataframe
combined_df = pd.concat(dfs)

# Load data into BigQuery
job = client.load_table_from_dataframe(combined_df, "{}.{}".format(dataset_id, table_id))

# Wait for the job to complete
job.result()

# Print the number of rows loaded
print("Loaded {} rows into {}.{}".format(job.output_rows, dataset_id, table_id))