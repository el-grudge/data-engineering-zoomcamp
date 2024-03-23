# ToDo
- [x] first pipeline: get json from website  
- [x] make project name parameterizable in mage
- [x] second pipeline: extract text from images 
- [x] setup dbt: transform data for dashboard preparation
- [x] build dashboard using streamlit
- [x] finish description
- [x] ~~attest vision extracts agains json~~
- [x] deploy mage to the cloud
- [x] note permission to scrap
- [ ] use dbt for second pipeline instead
- [ ] attest using google vision
- [ ] deploy streamlit
- [ ] dockerize streamlit
- [ ] docstring all functions
- [ ] add prerequisite / permission list
- [ ] add pipeline image
- [ ] add dag image
- [ ] add 'how to set project id in mage' gif
- [ ] add dashboard link 
- [ ] add dashboard screenshot image 
- [ ] increase the number of bins of the salary distribution histogram
- [ ] filter on all charts in dashbaord 
- [ ] add title (Money: An oral history)
- [ ] add paragraph to dashboard about inflation disconnect
- [ ] create partitioned + clustered tables using dbt and store in bigquery
- [ ] delete criteria from final readme
- [ ] move next steps to the bottom of readme
- [ ] (variables tf) `export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/credentials.json"`
- [ ] (variables tf) `export project_id `
- [ ] (variables tf) `export gcp region`
- [ ] (variables tf) `export gcp zone`
- [ ] (variables tf) `export bq_dataset_name `

# Next steps
1. create streaming pipeline that extracts new posts
2. RAG: embed text into vector database

# Criteria
1. **Problem description** (_2 points_): Problem is well described and it's clear what the problem the project solves
2. **Cloud** (_4 points_): The project is developed in the cloud and IaC tools are used 
3. **Data ingestion (choose either batch or stream)** (*4 points*): End-to-end pipeline: multiple steps in the DAG, uploading data to data lake
4. **Data warehouse** (*4 points*): Tables are partitioned and clustered in a way that makes sense for the upstream queries (with explanation)
5.  **Transformations (dbt, spark, etc)** (*4 points*): Tranformations are defined with dbt, Spark or similar technologies 
6.  **Dashboard** (*4 points*): A dashboard with 2 tiles 
7.  **Reproducibility** (*4 points*): Instructions are clear, it's easy to run the code, and the code works


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
The following cloud resources are provisioned / created using Terraform:
- Mage.ai 
- BigQuery dataset

Follow the instructions [here](https://docs.mage.ai/production/deploying-to-cloud/gcp/setup) & [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main/01-docker-terraform/1_terraform_gcp) for more details on how to create these resources with Terrform.

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

1. [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
2. [python](https://www.python.org/downloads/)
3. [Docker](https://docs.docker.com/engine/install/)
4. [Docker compose](https://docs.docker.com/compose/install/)
5. [pip](https://pip.pypa.io/en/stable/installation/)
6. [dbt](https://docs.getdbt.com/docs/core/connect-data-platform/bigquery-setup)
7. [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
8. GCP account

### Permsissions

- Artifact Registry Read
- Artifact Registry Writer
- Cloud Run Developer
- Cloud SQL
- Service Account Token Creator

...

### Run 

1. Clone the repo 


```bash
git clone ...(giturl) \ 
```

2. Export the following environment variables 

   * `export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/credentials.json"`
   * (variables tf) `export project_id `
   * (variables tf) `export gcp region`
   * (variables tf) `export gcp zone`
   * (variables tf) `export bq_dataset_name `

3. Rename dev.env file to .env
```bash
mv dev.env .env
```

4. Initialize terraform
```bash
cd terraform \
terraform init
```

5. View the resoures that will be provisioned to the cloud using the plan command

```bash
terraform plan
```

6. Deploy resources to the cloud with the apply command

```bash
terraform apply
```

Set project id in mage 
[gif here]

...