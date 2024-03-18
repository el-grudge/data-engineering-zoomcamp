import requests
import dlt
import duckdb
import os
from dotenv import load_dotenv

# Load environment variables from the .env file
load_dotenv()

BASE_API_URL = "https://www.refinery29.com"
blog_main_url = "/en-us/money-diary"


def paginated_getter(n_pages=1):
    page_number = 0
    
    while page_number <= n_pages:
        # Set the query parameters
        params = {'json':'true', 'page': page_number}
        
        # Make the GET request to the API
        response = requests.get(f'{BASE_API_URL}{blog_main_url}', params=params)
        response.raise_for_status()  # Raise an HTTPError for bad responses
        page_json = response.json()['result']['content']['modules']
        print(f'got page number {page_number} with {len(page_json)} records')
        
        # if the page has no records, stop iterating
        if page_json:
            yield page_json
            page_number += 1
        else:
            # No more data, break the loop
            break


def find_element_with_string(data, search_string):
    if isinstance(data, str):
        if search_string.lower() in data.lower():
            return data
    elif isinstance(data, list):
        for item in data:
            result = find_element_with_string(item, search_string)
            if result:
                return result
    elif isinstance(data, dict):
        for key, value in data.items():
            result = find_element_with_string(value, search_string)
            if result:
                return {key: result}
    return None


# Define a function to read SQL queries from a file
def read_sql_from_file(file_path):
    with open(file_path, 'r') as file:
        sql_queries = file.read()
    return sql_queries


if __name__ == '__main__':
    
    pipeline = dlt.pipeline(destination='duckdb', dataset_name='money_diaries')

    conn = duckdb.connect(f"{pipeline.pipeline_name}.duckdb")

    n_pages=0
    pipeline.run(paginated_getter(n_pages=n_pages), table_name="diary_links", write_disposition="replace")

    conn.sql(f"SET search_path = '{pipeline.dataset_name}'")

    sql_path = os.getenv('SQL_PATH')
    sql_file_path = f'{sql_path}/get_blogs.sql'

    sql_queries = read_sql_from_file(sql_file_path)

    blog_entries = conn.sql(sql_queries).df()

    # get blog entries
    params = {'json': 'true'}
    blog_url_1 = f'{BASE_API_URL}{blog_entries.object__url[0]}'
    response_1 = requests.get(blog_url_1, params=params)
    response_1.raise_for_status()  # Raise an HTTPError for bad responses
    page_json_1 = response_1.json()

    blog_url_2 = f'{BASE_API_URL}{blog_entries.object__url[1]}'
    response_2 = requests.get(blog_url_2, params=params)
    response_2.raise_for_status()  # Raise an HTTPError for bad responses
    page_json_2 = response_2.json()

    blog_url_3 = f'{BASE_API_URL}{blog_entries.object__url[2]}'
    response_3 = requests.get(blog_url_3, params=params)
    response_3.raise_for_status()  # Raise an HTTPError for bad responses
    page_json_3 = response_3.json()

    pipeline.run([page_json_1, page_json_2, page_json_3], table_name="blog_entry", write_disposition="append")

    sql_file_path = f'{sql_path}/get-content.sql'

    sql_queries = read_sql_from_file(sql_file_path)

    results = conn.sql(sql_queries).df()

    print(results)

    conn.close()
