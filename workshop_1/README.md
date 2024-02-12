In week 3️⃣ of the Data Engineering Zoomcamp we learned about 

🏢 Datawarehousing 
We learned about OLTP and OLAP systems:
* 🛠️ OLTP systems are used for crucial business operations. They can better handle short and fast updates, and because they use a normalized design they are more efficient. Examples include online banking systems, e-commerce platforms, and airline reservation systems.
* 🖥️ OLAP systems are used for analytics and insight discovery. They are large and multi-dimensional, and are the go to resource for business managers and data analysts.  Examples include business intelligence (BI) tools, online analytical reporting systems, executive dashboards.

A datawarehouse is an OLAP solution that relies on multiple resources to faciliate reporting and data analysis. They consist of raw data, meta data, and summary data, and can thus serve different purposes (ex. summary data can be used for dashboards, while raw data can be used for machine learning)

☁️ BigQuery
Provides a serverless warehouse solution. The storage system is separated from the compute system to guarantee scalability and high availability. Some of its built-in features include machine learning, geospatial analysis, and business intelligence. BigQuery has an on-demand (~$5 / TB) and flat-price (by requested slots) tiers.

🧩 Partitioning + Clustering
We saw how partitioning and clustering can improve query performance. Partitioned data is divided into smaller segments, usually by a time-unit column, making the interaction with a large dataset more efficient (by restricting data scans) and manageable (earier archiving and back-up). As for clustered data, it is orgainized within a partition by one or more columns, speeding up data retrieval and aggregation. 

🧰 BigQuery Internals
BigQuery uses stores the data in Colossus, and uses Dremel for computational operations. Because the systems are separated, users can increase their data size without incurring huge costs. The two systems communicate through the Jupyter network. Data is stored in a column-oriented structure which is better suited for warehouse operations.

🤖🧠 ML in BigQuery
We also discussed ML in BigQuery. BQ allows in-place ML, and it doesn't require python knowledge. The ML solution has a number of useful features that help with data collection, feature engineering, and train-test split. And it offers several ML algorithms out-of-the-box, that can be tuned, validated and deployed from within the BigQuery Studio. Here are some of useful commands:
* 🛠️ The `CREATE OR REPLACE MODEL <model-name>` creates an ML model. You can specify the `model_type`, the target variable, and the `DATA_SPLIT_METHOD` method in the `OPTIONS` section, where you can also specify which hyperparameters to tune.
* 🎨 The `ML.FEATURE_INFO` command provides summary statistics about the training features.
* 📊 The `ML.EVALUATE` command provides a number of evaluation metrics to validate the model's performance. 
* 🔮 The `ML.PREDICT` command is used for making predictions.
* 📝 The `ML.EXPLAIN_PREDICT` command shows the top 3 features used by the model
* 📤 Finally, you can extract the trained model using the CLI command `bq --project_id <project-id> extract -m <model-name> <location>`

👉 Again, I used Mage to load the data from NYC Gov website and export it to a GCS bucket. Once there, I loaded the data into a BigQuery dataset, created an external table, a non-partitioned tabled, and a partitioned / clustered table and compared query performance across the different types of tables. You can find the code [here](https://github.com/el-grudge/data-engineering-zoomcamp/tree/main/week_3). You can also find the queries [here](https://github.com/el-grudge/data-engineering-zoomcamp/blob/main/week_3/homework-3.sql).

#data_engineering_zoomcamp #bigquery #data_warehouse #data_engineering #learning_in_public