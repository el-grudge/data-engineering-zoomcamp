In week 3️⃣ of the Data Engineering Zoomcamp we learned about 

Datawarehousing 
OLAP vs OLTP

BigQuery

Partitioning + Clustering

🪄 Data Orchestration with Mage
Mage is a data orchestration tool that helps developers:
* remain in a flow state 🌊
* speed up feedback loops 🔁
* decrease their cognitive load 🧱

In Mage 🧱 Blocks constitute the building blocks, and can be used to 🔨 Load, 👷🏻‍♂️ Transform, and ⚙️ Export data. Blocks make up 🏗️ Pipelines, end-to-end automated flows of data. Pipelines are housed in 🏠 Projects.

We learned about the different block types (data loaders, transformers, data exporters), saw how to load our data to a Google storage bucket, and how to load it from a GCS to BigQuery (an OLAP datawarehouse). We also understood the difference partitioned and unpartitioned data loading, and discussed why partitioned loading is the better option (offers better query performance, more efficient data retrieval, parallel processing being some of the reasons). We also covered parameterized execution, saw how to define triggers, and learned about Backfills.

👉 I used Mage to build a pipeline that loads 🚕 NYC taxi data, removes some unwanted records and transforms the data types of some columns, and finally loads the data into a Postgres DB and stores it in Parquet files on GCS. You can find the code [here](https://github.com/el-grudge/data-engineering-zoomcamp/tree/main/week_2) 

#data_engineering_zoomcamp #mage #data_engineering #learning_in_public