# ignyte-casestudy
Case Study for Ignyte: Creating dashboards for sensor datas

Requires Docker, Node, Express, and Internet Connection

First run Postgres Docker Container with the docker-compose file and initialize sql scripts
```
docker-compose up -d
docker exec -it pg-ignyte psql
```

You can find sql scripts in the psql folder. They will set up the tables and stored procedures necessary to run this demo. You will need to initialize them using psql. Create Tables in the following order using psql/createtables.sql

1. office_location
2. machine
3. sensor
4. sensor_readings
5. machine_lookup
6. sensor_lookup


data_vis has node + express dashboard set up. You can run with the following commands
```
cd data_vis
npm start
```