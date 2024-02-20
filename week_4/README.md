In week 4️⃣ of the Data Engineering Zoomcamp we learned about 

🏢 Analytics Engineering with DBT 

* things i did
    - loaded yellow and green taxi data from bigquery marketplace 
    - loaded fhv data using scripts 
    - used dbt cloud to connect to bigquery 
    - created subdirectory under data-engineering-zoomcamp repo for dbt from dbt cloud 
    - made changes to dbt_project.yml and made my first commit
    - created `schema.yml` file under models directory
    - defined souces green, yellow, fhv in `schema.yml`
    - generated models for each source
    - used `dbt build` command to build my project
    - created a macro 'get_payemnt_type_description' under macros directory 
    - created `package.yml` file under home path taxi_rides_ny and added dbt_utils
    - used `dbt deps` command to build dependencies
    - called dbt_utils.generate_surrogate_key macro from dbt_utils


* to do:
    - create dbt project within mage 
    - tried using mage backfilling but couldn't make it work, created a bug. try fixing it
    - use dbt locally


👉 code [here](https://github.com/el-grudge/data-engineering-zoomcamp/tree/main/week_4). 

#data_engineering_zoomcamp #analytics_engineering #dbt #data_engineering #learning_in_public