import io
import pandas as pd
import requests

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    url = 'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-'
    dfs = []
    for i in range(1, 13):
        filename = "{}{:02d}.parquet".format(url, i)

        df_tmp = pd.read_parquet(filename)#, dtype=taxi_dtypes)

        dfs.append(df_tmp)

    df = pd.concat(dfs, ignore_index=True)

    print(df.dtypes)

    return df

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
