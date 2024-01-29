In week 1️⃣ of the Data Engineering Zoomcamp we learned about 

☁️Google Cloud Platform
We created and configured a virtual machine on GCP and used ssh to connect to it from our local machine. 

🐳Docker, 
Why care about containarization? Easy way to run local experiments, reproducible outcomes, isolated enviornments, automated pipelines
How to setup a docker container? Using docker configuration files that can be downloaded from the docker hub
We also covered docker networks, and how to use docker compose to run concurrent containers

📊 DBMS & SQL
We learned how to use pgcli for running SQL commands in a REPL fation. It's a great tool for quick debugging and testing DB connections. We also learned how to run a containerized version of pgadmin, a data base management system, and used it to refresh our SQL skills.

🌐 Terraform
Finally, we learned about Terraform, an open-source tool used for provisioning infrastracture resources through the use of configuration files that can be shared, maintained, and collaborated on. We saw how to use a variables.tf file to define common values that can be easily maintained, and learned how to use the main tf commands `terraform init`, `terraform plan`, `terraform apply`, and `terraform destroy`. We used Terraform to setup a Data Lake on Google Cloud Storage and a Data Warehouse in BigQuery.

👉 To demonstrate my learnings, I used docker-compose to run a postgres db, a pgadmin instance that connects with it, and a data ingestion service that loads data into it. You can find the code here: 

#mlzoomcamp #ml_engineering #data_science #learning_in_public #boosting #decision_trees