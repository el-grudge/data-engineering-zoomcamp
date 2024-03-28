# ToDo
- [ ] build the second pipeline with google vision - to get missing values
- [ ] docstring all functions
- [ ] add prerequisite / permission list
- [ ] combine docker images
- [ ] add README to terraform
- [ ] add README to dbt 
- [ ] add README to streamlit
- [ ] add README to docker
- [ ] filter on all charts in dashbaord 
- [ ] add paragraph to dashboard about inflation disconnect
- [ ] move next steps to the bottom of readme
- [x] ~~dockerize streamlit~~
- [x] ~~add 'how to set project id in mage' gif~~
- [x] first pipeline: get json from website  
- [x] make project name parameterizable in mage
- [x] second pipeline: extract text from images 
- [x] setup dbt: transform data for dashboard preparation
- [x] build dashboard using streamlit
- [x] finish description
- [x] ~~attest vision extracts agains json~~
- [x] deploy mage to the cloud
- [x] note permission to scrap
- [x] ~~(variables tf) `export bq_dataset_name`~~
- [x] use dbt for second pipeline instead
- [x] deploy streamlit
- [x] cache queries in streamlit (see authentication page)
- [x] add pipeline image
- [x] add dag image
- [x] add dashboard link 
- [x] add dashboard screenshot image 
- [x] increase the number of bins of the salary distribution histogram
- [x] add title (Money: An oral history)
- [x] create partitioned + clustered tables using dbt and store in bigquery
- [x] delete criteria from final readme
- [x] (variables tf) `export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/credentials.json"`
- [x] (variables tf) `export project_id `
- [x] (variables tf) `export gcp region`
- [x] (variables tf) `export gcp zone`
- [x] (variables tf) `export gcp location`

# Next steps
1. create streaming pipeline that extracts new posts
2. RAG: embed text into vector database
3. attest using google vision

# Criteria
1. **Problem description** (_2 points_): Problem is well described and it's clear what the problem the project solves
2. **Cloud** (_4 points_): The project is developed in the cloud and IaC tools are used 
3. **Data ingestion (choose either batch or stream)** (*4 points*): End-to-end pipeline: multiple steps in the DAG, uploading data to data lake
1. **Data warehouse** (*4 points*): Tables are partitioned and clustered in a way that makes sense for the upstream queries (with explanation)
2.  **Transformations (dbt, spark, etc)** (*4 points*): Tranformations are defined with dbt, Spark or similar technologies 
3.  **Dashboard** (*4 points*): A dashboard with 2 tiles 
4.  **Reproducibility** (*4 points*): Instructions are clear, it's easy to run the code, and the code works


## Problem Description 
[Money Diaries](https://www.refinery29.com/en-us/money-diary) is a blog created in 2016 and hosted by the Refinery29 website. It comes out 3 times a week, where in each post an anonymous contributor writes about their money spending habits. All posts share a similar structure:
* The first section has information on the contributor's occupation, the industry they work in, their age, location, salary, net worth, debt, paycheck amount and cadence, and pronouns
* The second section covers their monthly expenses
* The third section is a list of background questions
* The fourth section is the diary, where the contributor tracks and shares their money spending for a week
* The fifth and final section is the breadkown, in which all their spending is aggregated into six cateogries: Food+Drink, Home+Health, Clothes+Beauty, Entertainment, Transport, Other

The blog is a rich source of data for anyone who wants to learn about how money shapes our lives. My goal is to create an interactive dashboard that summarizes some of the information in the blog such as salary distribution, prices over time, and debt vs. net worth. 


### Pipeline

[pipeline image here]

...

## Cloud
The following cloud resources are provisioned using Terraform:
- Mage.ai 
- BigQuery dataset

See instructions in the Reproducibility section for details on how to deploy and run these resources.

## Data ingestion
Data is ingested using a pipelines are created in Mage.ai. 

The DAG steps are:
1. Scrap the blog home page and load it's json objects in BigQuery using `dlt`*
2. Extract the blog urls from "diary_links__rows__entities" table
3. Scrap the blog posts and load their json contents in BigQuery using `dlt`

[dag image here]

\* Note about scraping: Refinery29's webstie robot.txt file has no explicit restrictions regarding scrapping Money Diaries blog posts. You can check it [here](https://www.refinery29.com/robots.txt)

## Data warehouse

BigQuery dataware

...

## Transformations

...

## Dashboard

[image](...)

The dashboard can be accessed [here](...)

The dashboard has the following charts:
* Number overlays showing ...
* Salary distribution histogram
* Debt-Net worth divergent bar chart
* Category prices over time line chart
* Inflation calculator

...

## Reproducibility

### Prerequisite

1. [Docker](https://docs.docker.com/engine/install/)
2. [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. [dbt](https://docs.getdbt.com/docs/core/connect-data-platform/bigquery-setup)
4. GCP account

### Permissions

- Artifact Registry Read (mage)
- Artifact Registry Writer (mage)
- Cloud Run Developer (mage in the cloud) (try Cloud Run Admin instead) 
- Cloud SQL Admin (mage in the cloud)
- Service Account Token Creator (mage in the cloud)
- BigQuery Admin (BigQuery) # if needed 
- Cloud Vision AI Service Agent (Vision) # if needed
- Secret Manager Secret Accessor (mage) # if needed
- Vision AI Analysis Editor (Vision) # if needed
- Vision AI Application Editor (Vision) # if needed
- Service Usage Admin () # if needed
- Service Object Viewer () # if needed

...

### Run 

1. Clone the repo 


```bash
git clone https://github.com/el-grudge/money-diaries.git 
```

2. Export the following environment variables 

Change the values of the following environment variables or set them in the `variables.tf` file

```bash
export GOOGLE_PROJECT=[project-name]
export GOOGLE_PROJECT_ID=[project-id]
export GCP_REGION=[region]
export GCP_ZONE=[us-central1-c]
export GCP_LOCATION=[location]
export DB_PASSWORD=[database_password]
```

Note: The DB_PASSWORD parameter is for the Postgres database that will be used by Mage.ai's internal operations. The dashboard's data will be stored in a BigQuery dataset. 

1. Provision cloud resources with terraform

*terraform init* 
```bash
cd terraform \
terraform init
```

*terraform plan*
```bash
terraform plan \
  -var="project=${GOOGLE_PROJECT}" \
  -var="project_id=${GOOGLE_PROJECT_ID}" \
  -var="region=${GCP_REGION}" \
  -var="zone=${GCP_ZONE}" \
  -var="location=${GCP_LOCATION}"
```

*terraform apply*
```bash
terraform apply \
  -var="project=${GOOGLE_PROJECT}" \
  -var="project_id=${GOOGLE_PROJECT_ID}" \
  -var="region=${GCP_REGION}" \
  -var="zone=${GCP_ZONE}" \
  -var="location=${GCP_LOCATION}"
```

Terraform will deploy Mage.ai as a Google Clound Run service, which you can access by navigating to the Cloud Run option on the left navigation menu. On the service details page, you'll find the URL of the running service listed under the "Service URL" section. Copy & go to this URL to find the Mage.ai service:

[]

Once inside Mage.ai service, you'll find the money_diaries pipeline already created. To run the pipeline, click on it to go the triggers page then press the Run@Once button, then the Run Now button in the Run Pipeline Now pop-up window. You can view the run's log by going to Run on the left navigation menu and clicking on the logs logo next to the Running pipeline:

[]

The pipeline will extract the blog posts from Money Diaries and load them into the BigQuery dataset called money_diaries, also provisioned by Terraform. You can view the dataset by navigating to BigQuery on the left navigation menu, then click on BigQuery Studio. Once the Explorer loads, expand the project containing your dataset to list all datasets: 

[]

To delete these resources, run the `terraform destroy` command:

*terraform destroy*
```bash
terraform destroy \
  -var="project=${GOOGLE_PROJECT}" \
  -var="project_id=${GOOGLE_PROJECT_ID}" \
  -var="region=${GCP_REGION}" \
  -var="zone=${GCP_ZONE}" \
  -var="location=${GCP_LOCATION}"
```
