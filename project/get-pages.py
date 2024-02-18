import requests
import dlt
import duckdb


BASE_API_URL = "https://www.refinery29.com"
blog_main_url = "/en-us/money-diary"
blog_url = ""

# I call this a paginated getter
# as it's a function that gets data
# and also paginates until there is no more data
# by yielding pages, we "microbatch", which speeds up downstream processing

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


# Define a function to read SQL queries from a file
def read_sql_from_file(file_path):
    with open(file_path, 'r') as file:
        sql_queries = file.read()
    return sql_queries


if __name__ == '__main__':
    
    pipeline = dlt.pipeline(destination='duckdb', dataset_name='taxi_rides')
    
    # run the pipeline with the paginated geeter and set the n_pages parameter
    n_pages = 0
    pipeline.run(paginated_getter(n_pages=n_pages), table_name="diary_links", write_disposition="replace")
    
    conn = duckdb.connect(f"{pipeline.pipeline_name}.duckdb")

    conn.sql(f"SET search_path = '{pipeline.dataset_name}'")

    sql_file_path = './get_blogs.sql'

    sql_queries = read_sql_from_file(sql_file_path)

    blog_entries = conn.sql(sql_queries).df()
    
    print(blog_entries)
