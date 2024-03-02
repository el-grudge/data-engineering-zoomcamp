# 5.1 Introduction

## 5.1.1 Introduction to Batch processing
* Batch vs streaming
* Types of batch jobs
* Orchestration batch jobs
* Advantages and disadvantages of batch jobs

Batch - process a chunk of data at regular intervals. Stream - processing data on the fly

Types of batch jobs: SQL, Python scripts, Spark, Flink

Advantages: easy to manage, retry, scale, easier to orchestrate
Disadvantages: delay

## 5.1.2 Spark Introduction
* What is Spark
* Why do we need it

Spark is a "general purpose distributed processing engine". Common use cases: batch-work worklaods. Also streaming.

When would you use Spark? For the same things you'd use SQL - but for executing the queries on the files in your datalake.

If you can write this in SQL and use Hive/Presto/Athena/BQ - do it. But not everything can/should be expressed in SQL.

Common case - ML algorithms. You can't easily use SQL for most of it.

Typical pipeline

Raw data -> Data lake -> Some transformations in SQL -> Spark -> Batch job in Python for training in model 

Raw data -> Data lake -> SQL -> Spark -> Spark for applying the model -> SQL 

# 5.2 Installation

## 5.2.1. Installing Spark (Linux)
* Connecting to an instance on GCP and installing it there 

# 5.3 Spark SQL and DataFrames

## 5.3.1 First Look at Spark/PySpark
* Reading CSV files
* Partitions
* Saving data to Parquet for local experiments 
* Spark master UI

## 5.3.2 Spark DataFrames
* Actions vs transformations
* Functions and UDFs

## 5.3.3 Spark SQL
* Temporary tables 
* Some simple queries from week 4

## 5.3.4 Joins in Spark
* Merge sort join 
* Broadcasting

# 5.4 Spark Internals

## 5.4.1 Spark Cluster
* Spark Driver, Master and Executors

## 5.4.2 GroupBy in Spark
* How GroupBy works internally
* Shuffling

## 5.4.3 Joins in Spark 
* Joining two large tables
* Merge sort join 
* Joining one large and one small table 
* Broadcasting


# 5.5 (Optional) Resilient Distributed Datasets

## 5.5.1 Resilient Distributed Datasets: map and reduce
* What is RDD and how is it related to dataframes 
* From DataFrame to RDD 
* Operations on RDDs: map, mapPartition, reduceByKey
* From RDD to DataFrame

## 5.5.2 Spark RDD mapPartition
* Using mapPartition on RDDs

# 5.6 Running Spark in the Cloud

## 5.6.1 Connecting to Google Cloud Storage
* Uploading data to GCS
* Connecting Spark jobs to GCS

## 5.6.2 Creating a Local Spark Cluster
* Creating the cluster cluster
* Turning the notebook into a script 
* Using spark-submit for submitting spark jobs

## 5.6.3 Setting up a Dataproc Cluster
* Creating a cluster
* Running a spark job with Dataproc
* Submitting the job with the cloud SDK

## 5.6.4 Connecting Spark to Big Query
* Writing the spark job results to BigQuery

# 5.7 Spark and Docker

## 5.7.1 Running Hadoop and YARN Locally
* What is Hadoop, YARN and HDFS
* Starting YARN locally in a stand-alone mode 
* Running Spark jobs with YARN