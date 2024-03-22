# ToDo:
1. first pipeline: get json from website 
    - make project name parameterizable
2. second pipeline: extract text from images 
3. setup dbt: transform data for dashboard preparation
4. build dashboard using streamlit
5. finish description
6. docstring all functions
7. attest vision extracts agains json
8. RAG: embed text into vector database
9. deploy mage to the cloud
10. note permission to scrap
11. streaming pipeline that extracts new posts

# Criteria
- [x] Problem description: 2 points: Problem is well described and it's clear what the problem the project solves
- [ ] Cloud: 4 points: The project is developed in the cloud and IaC tools are used 
    - [ ] setup mage.ai in the cloud using terraform
- [x] Data ingestion (choose either batch or stream): 4 points: End-to-end pipeline: multiple steps in the DAG, uploading data to data lake
- [x] Data warehouse: 4 points: Tables are partitioned and clustered in a way that makes sense for the upstream queries (with explanation)
    - can be hard to achieve given dlt use (it loads data in DWH automatically) and given data size (a small dataset)
- [ ]  Transformations (dbt, spark, etc): 4 points: Tranformations are defined with dbt, Spark or similar technologies 
    - learn how to use dbt in mage.ai
- [x]  Dashboard: 4 points: A dashboard with 2 tiles 
    - Salary distribution
    - Price per category over time
    - weekly spending per location
    - ...
- [ ]  Reproducibility: 4 points: Instructions are clear, it's easy to run the code, and the code works
    - make sure that all elements of the project are parameterized. The final project will require an active google cloud account, project-id, ...

## Problem Description 
Money Diaries is a blog that comes out 3 times a week, each post is anonymously written by a different contributor. Contributors share the following:
* location
* job
* annual income
* monthly bills
* track their spending for a week
* answer a set of question 
* write the blog
The blog has been active since .... The information provided in the blog is a treasure trove! We can use it to track inflation, compare prices in different location, learn about average salaries per job and location.

### Pipeline

## Cloud

## Data ingestion
Data is ingested using two pipelines, both are implemented in Mage.ai. The first pipeline scraps the data from the website using `dlt`, and loads into BigQuery. The second pipeline calls the google vision api to extract text from blog post images and loads the extract text into BigQuery.

## Data warehouse

## Transformations

## Dashboard

## Reproducibility