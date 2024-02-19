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
    url = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2019-01.csv.gz'
    # url = kwargs['url']
    # taxi_line = kwargs['taxi_lines'][0]
    # years = kwargs['years']
    # dfs = []
    # for year in years:
    #     # for i in range(1, 13):    
    #     for i in range(1, 2):    
    #         filename = "{}{}/{}_tripdata_{}-{:02d}.csv.gz".format(url, taxi_line, taxi_line, year, i)
    #         print(filename)
    
    df = pd.read_csv(url,compression='gzip')

    return df


    