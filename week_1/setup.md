1) create ssh 
ssh-keygen -t rsa -f ~/.ssh/gcp -C username -b 2048

ssh -i ~/.ssh/gcp username@ip

ssh-keygen -f "~/.ssh/known_hosts" -R "ip"

2) create gcp instance (using gui)

3) setup ssh config
echo "Host de-zoomcamp
	HostName 34.133.224.31
	User minasonbol
	IdentityFile ~/.ssh/gcp" | tee ~/.ssh/config 
	
4) setup conda python 
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh
bash Anaconda3-2023.09-0-Linux-x86_64.sh

5) install docker 
sudo apt update && sudo apt install docker.io

6) make docker executable without sudo
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart
docker run hello-world

7) install docker-compose 
wget https://github.com/docker/compose/releases/download/v2.24.3/docker-compose-linux-x86_64 

8) make docker-compose executable from anywhere
mkdir bin
mv docker-compose-linux-x86_64 bin/docker-compose 
chmod +x docker-compose 
vim .bashrc 
export PATH=${HOME}/bin:/${PATH}
source .bashrc 
which docker-compose 

9) install pgcli 
pip install pgcli
pgcli -h localhost -U root -d ny_taxi

10) install gcc and psycopg2 
sudo apt install gcc
pip install psycopg2

11) create docker-compose.yml file 

12) run docker-compuse up (to avoid being stuck at 'booting worker with pid' step, use detach mode)

13) test data ingestion in REPL 

14) run ingest data python script
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"
python ingest-data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}

15) port forward

16) create server in pgadmin
for the name field use pgdatabase

17) build docker image
docker build -t taxi_ingest:v001 .
to avoid problems with ny_data folder, go to docker-compose yml file and change volume from "./ny_taxi_postgres_data:/var/lib/postgresql/data:rw" to "./data/ny_taxi_postgres_data:/var/lib/postgresql/data:rw"

18) run docker
to get network name run `docker network ls` 
for host name use pgdatabase
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

curl -X POST -H "Content-Type: application/json" -d '{"user":"root", "password":"root", "host":"localhost", "port":"5431", "db":"ny_taxi", "table_name":"yellow_taxi_trips", "url":"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"}' http://localhost:9696/ingest

pgcli -h localhost -p 5431 -u root -d ny_taxi