import io
import pandas as pd
import requests
from mage_ai.data_preparation.variable_manager import set_global_variable

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API  
    """
    url = kwargs['url']
    taxi_line = kwargs['taxi_line']
    year = kwargs['execution_date'].year
    month = kwargs['execution_date'].month
    # year = 2021
    # month = 1
    data_url = '{}{}/{}_tripdata_{}-{:02d}.csv.gz'.format(url, taxi_line, taxi_line, year, month)
    pipeline_uuid = kwargs['pipeline_uuid']

    path = '{}/{}/{:02d}'.format(taxi_line, year, month)
    set_global_variable(pipeline_uuid, 'path', path)
    
    df = pd.read_csv(data_url,compression='gzip',sep=',')
    df.to_csv(f'taxi_trips{year}-{month}.csv', index=False)

    return df

@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'