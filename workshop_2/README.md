🚀 In Workshop 2️⃣ of the Data Engineering Zoomcamp, we learned about

🌊💻 Stream Processing  
Streaming data is dynamic, high-volume, and high-velocity. It can originate from sources like IoT sensors, feeds, and databases. 🔍 In streaming, operations are performed incrementally. States evolve as events arrive, we compute the delta between the old and new states, and increment it it to the processed data 🛠️ The choice between batch and streaming depends on the specific use case. For instance, analyzing social media feeds for sentiment analysis could be a streaming application for near real-time sentiment, such as trading stocks. Conversely, it could be a batch application for understanding trends, like how the COVID pandemic impacted people over time.

🌊 RisingWave  
RisingWave is a cost-effective and scalable database solution designed primarily for streaming. It prioritizes performance and reliability. RisingWave can ingest data from multiple sources, including MongoDB, Kafka, PostgreSQL, MySQL (and more!), and can deliver data to Elasticsearch, ClickHouse, ICEBERG (and more!).

🔄 Stateful vs. Stateless processing   
Stateful computation does not maintain any memory of past data elements, each one processed in isolation. On the other hand, stateful computation maintains a state across multiple data elements and updates it as new data elements come in. For instance, when joining two tables, the computation engine updates the state of each table as new records come in and emmits matching records on the fly to be materialized.

👉 In the workshop, we also dived into dynamic filters. These operations enable real-time filtering on data streams, as demonstrated by this SQL statement:

```
WITH max_profit AS (SELECT max(profit_margin) max FROM sales) 
SELECT product_name FROM products, max_profit 
WHERE product_profit > max; 
```

📚 You can find more examples [here](https://github.com/el-grudge/data-engineering-zoomcamp/tree/main/workshop_2)

#data_engineering_zoomcamp #streaming #data_engineering #learning_in_public