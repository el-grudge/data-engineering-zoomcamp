In week 5️⃣ of the Data Engineering Zoomcamp we learned about 

🔄🌊 Batch Processing
We discussed the difference between batch processing and streaming. Batch processing involves collecting data over period of time and processing it in one go, or at a regular cadence (weekly/daily/hourly). On the other hand, in streaming, data is processed on the fly in real time. Batch processing jobs are easier to manage using workflow tools like Airflow. Also, they're easier to troubleshoot since the jobs are not running in-real-time. And finally, they're easier to scale. On the flip side, batch jobs introduce higher latency because they typically run at specific intervals, and deal with higher throughput. 

⭐ Spark 
The official definition of Apache Spark is: "a multi-language engine for executing data engineering, data science, and machine learning on single-node machines or clusters." We can use Scala, Java, Python, SQL, or R to interact with Spark. Its features include: handles of batch and streaming data, executes SQL analytics, runs Data Science and ML at scale.

🔀 Interacting with Spark
We learned how to start a Spark session using Pyspark, and saw how CSV files are stored in partitions. We looked at the Spark UI interface, which can be used to monitor the status and resource consumption of the jobs on the Spark cluster, and where we can view see the execution DAG of any executed job.

🔗🧩Spark SQL
Next, we used Spark SQL to run some basic analytic statements, using Joins and GroupBys. We saw how GroupBy statements are run in Spark, in the first step Spark executors will deal with the data stored on separate partitions, and in the second step the data is shuffled so that records with the same key (think the GroupBy column) are grouped together to produce the final output. We also learned how different Join operations are executed. When joining two large datasets, Spark shuffles the data among its executors to join them. When joining one large dataset with one small dataset Spark will broadcast the small dataset to all executors where the join happens in memory.

☁️ Spark in the Cloud 
We also learned how to connect a local Spark engine to GCS using the `gcs-connector-hadoop3-2.2.5.jar` and `hadoopConfiguration` settings. We saw how to submit a Spark job to a cluster on the cloud using DataProc, and how to store the output in BigQuery.

👉 I installed Spark on a cloud VM, set up a local session, and used to it to run some analytics on NY Taxi dataset. You can find the code [here](https://github.com/el-grudge/data-engineering-zoomcamp/tree/main/week_5). 

#data_engineering_zoomcamp #spark #pyspark #data_engineering #batch_processing #learning_in_public