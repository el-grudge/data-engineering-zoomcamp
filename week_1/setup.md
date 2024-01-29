1) create ssh 
```
ssh-keygen -t rsa -f ~/.ssh/gcp -C username -b 2048  
ssh -i ~/.ssh/gcp username@ip  
ssh-keygen -f "~/.ssh/known_hosts" -R "ip"
```
2) create gcp instance (using gui)

3) setup ssh config    

```
echo "Host de-zoomcamp
	HostName 34.133.224.31
	User minasonbol
	IdentityFile ~/.ssh/gcp" | tee ~/.ssh/config 
```	
4) setup conda python   
```
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
bash Anaconda3-2023.09-0-Linux-x86_64.sh
```
5) install docker   
```
sudo apt update && sudo apt install docker.io
```

6) make docker executable without sudo
```
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart
docker run hello-world
```

7) install docker-compose 
```
wget https://github.com/docker/compose/releases/download/v2.24.3/docker-compose-linux-x86_64 
```

8) make docker-compose executable from anywhere
```
mkdir bin
mv docker-compose-linux-x86_64 bin/docker-compose 
chmod +x docker-compose 
echo -e "\nexport PATH=${HOME}/bin:/${PATH}" | tee -a .bashrc 
which docker-compose 
```

9) install pgcli 
```
pip install pgcli
pgcli -h localhost -U root -d ny_taxi
```

10) install gcc and psycopg2 
```
sudo apt install gcc
pip install psycopg2
```

11) create docker-compose.yml file 

12) run docker-compuse up (to avoid being stuck at 'booting worker with pid' step, use detach mode)

13) test data ingestion in REPL 

14) run ingest data python script
```
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"
python ingest-data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}
```

15) port forward

16) create server in pgadmin
for the name field use *pgdatabase*

17) build docker image
```
mkdir data
sudo rm -rf ny_taxi_postgres_data
sed -i 's/.\/ny_taxi_postgres_data\:\/var\/lib\/postgresql\/data\:rw/.\/data\/ny_taxi_postgres_data\:\/var\/lib\/postgresql\/data\:rw/g' docker-compose.yml
echo data | tee .dockerignore
docker build -t taxi_ingest:v001 .
```

18) run docker
to get network name run `docker network ls` 
for host name use `pgdatabase`
```
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"
docker run -it \
  --network=week_1_default \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=pgdatabase \
    --port=5432 \
    --db=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=${URL}
```
19) convert ingest-data into flask a app

20) test flask app
```
curl -X POST -H "Content-Type: application/json" -d '{"user":"root", "password":"root", "host":"localhost", "port":"5432", "db":"ny_taxi", "table_name":"yellow_taxi_trips", "url":"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"}' http://localhost:9696/ingest
```

21) install gunicorn 
```
pip install gunicorn
```

22) test gunicorn   
increase timeout of gunicorn to allow it to finish
```
gunicorn --timeout 60 --bind 0.0.0.0:9696 ingest-data:app
```

23) build docker image of flask app
```
docker build -t taxi_ingest:v002 .
```

24) run docker image of flas app
```
docker run -it --rm --network=week_1_default -p 9696:9696 taxi_ingest:v002 .
```

25) add new docker to docker-compose
expose port 9696

26) load taxi data 
change host field value from `localhost` to `pgdatabase`
```
curl -X POST -H "Content-Type: application/json" -d '{"user":"root", "password":"root", "host":"pgdatabase", "port":"5432", "db":"ny_taxi", "table_name":"green_taxi_trips", "url":"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"}' http://localhost:9696/ingest
```

26) load zones data 
change table_name field value from `green_taxi_trips` to `zones` and change url field
```
curl -X POST -H "Content-Type: application/json" -d '{"user":"root", "password":"root", "host":"pgdatabase", "port":"5432", "db":"ny_taxi", "table_name":"zones", "url":"https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv"}' http://localhost:9696/ingest
```

27) install terraform
```
wget https://releases.hashicorp.com/terraform/1.7.1/terraform_1.7.1_linux_386.zip
unzip terraform_1.7.1_linux_386.zip 
rm terraform_1.7.1_linux_386.zip 
which terraform
```

28) setup service account on gcp

29) authenticate gcp service account using json file
```
export GOOGLE_APPLICATION_CREDENTIALS=~/.gc/linen-source.json
gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS
```

30) setup terraform files
