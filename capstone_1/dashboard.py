import streamlit as st
from google.cloud import bigquery
import altair as alt
import pandas as pd
from dotenv import load_dotenv
import os

# Load environment variables from the .env file
load_dotenv()
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = os.getenv('GOOGLE_VISION_CREDENTIALS')

# Initialize BigQuery client
client = bigquery.Client()

# Query to retrieve salary data
query = """
select 
    PARSE_DATE('%b %e, %Y', published_date) AS parsed_date, 
    REGEXP_replace(salary, r'[^\d]+','') as salaries ,
    food_drink
FROM `linen-source-411501.money_diaries_test.weekly_spending` 
"""

# Execute the query
query_job = client.query(query)

# Convert the results to a Pandas DataFrame
results = query_job.result()
df = results.to_dataframe()

# Streamlit app
st.title('Salary Distribution Histogram')

# Plotting the histogram using Altair
histogram_chart = alt.Chart(df).mark_bar(color='#e4fb2d').encode(
    alt.X("salaries:Q", bin=True, title="Salary"),
    alt.Y('count():Q', title="Frequency"),
).properties(
    width=600,
    height=400
).configure_axis(
    labelFontSize=12,
    titleFontSize=14
).configure_title(
    fontSize=20,
    color='#27345e'
)

# Plotting the salary over time using Altair
line_chart = alt.Chart(df).mark_line(color='#e91baa').encode(
    x=alt.X('parsed_date:T', title="Date"),
    y=alt.Y('food_drink:Q', title="Food Prices"),
    tooltip=['date_recorded:T', 'food_drink:Q']
).properties(
    width=600,
    height=400
).configure_axis(
    labelFontSize=12,
    titleFontSize=14
).configure_title(
    fontSize=20,
    color='#27345e'
)

# Display both charts in Streamlit
st.subheader('Salary Distribution Histogram')
st.altair_chart(histogram_chart, use_container_width=True)

st.subheader('Salary Over Time')
st.altair_chart(line_chart, use_container_width=True)