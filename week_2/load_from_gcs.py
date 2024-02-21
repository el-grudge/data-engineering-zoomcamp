from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from os import path
import glob
import pandas as pd
from google.cloud import storage

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_from_google_cloud_storage(*args, **kwargs):
    """
    Template for loading data from a Google Cloud Storage bucket.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    # Initialize a client
    client = storage.Client()

    # Define the bucket name and directory where your CSV files are located
    bucket_name = 'linen_source_411501_bucket'
    directory = "green_taxi_data/"

    # Get the bucket
    bucket = client.get_bucket(bucket_name)

    # List all files in the directory
    blobs = bucket.list_blobs(prefix=directory)

    # Initialize an empty DataFrame to store the data
    dfs = []

    # Iterate over each blob (file) in the bucket
    for blob in blobs:
        # Get the blob name
        blob_name = blob.name

        # Check if the blob is a CSV file
        if blob_name.endswith('.parquet'):
            # Read the CSV file directly into a DataFrame
            data = GoogleCloudStorage.with_config(ConfigFileLoader(config_path, config_profile)).load(
                bucket_name,
                object_key=blob_name,
                format='parquet'
                )

            # Append the data to the main DataFrame
            dfs.append(data)

    df = pd.concat(dfs, ignore_index=True)

    return df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
