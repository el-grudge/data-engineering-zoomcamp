In workshop 1️⃣ of the Data Engineering Zoomcamp we learned about

📥 Data Load Tool Library dlt

dlt is an open-source python library created by Adrian Brudaru that can be used for building perfect data ingestion pipelines. 

The library was built with the layman data engineer in mind, as it abstracts a lot of the drudgery associated with a number of tasks such as data extraction, schema management, and data type detection. It helps create a self-healing, self-maintaining, fully normalized pipeline, in a simple and fast way.

`pip install dlt` to install the tool 

⛏️ Data Extraction 
One of the core principles of dlt is loading with generators. Using generators to yield data is recognized as a data extraction best practice, as it enables more efficient memory management by preventing the loading of an indeterminate amount of data into RAM.

The `dlt.pipeline(destination=<destination-name>, dataset_name=<dataset-name>)` command defines a dlt pipeline. To ingest data, simply use the run command:

```
pipeline.run(<generator>,
             table_name=<table-name>,
             write_disposition="replace")
```

📏 Normalization
dlt auto detects the data schema and normalizes the data upon ingestion, saving data engineers a ton of time, especially when dealing with JSON files or other nested data.

🔼 Incremental Loading
When running your pipeline, you can set the `write_dsposition` to append or merge and dlt will update the state of the data accordingly.

👉 For a demo of the tool check out this [colab](https://github.com/el-grudge/data-engineering-zoomcamp/blob/main/workshop_1/data_talks_club_dlt.ipynb)

#data_engineering_zoomcamp #dlt #data_ingestion #data_engineering #learning_in_public
