#Introduction

The purpose of this project was to help 
the Linux Cluster Administration team to 
monitor node resource usage (e.g.,CPU,memory)
in real time. Our job was to write bash scripts that will
help the LCA team easily set up the postgresql instance, 
create the database and appropriate tables,
then save the usage data into the database. 
We implemented scripts that can run 
simultaneously on different machines that will
track the usages from multiple machines into 
one database. We used docker to provision the
postgresql instance and the automation process was achieved
using crontab. 

#Quick Start

Starting a psql instance using psql_docker.sh
```bash
./scripts/psql_docker.sh start|stop|create [db_username][db_password]

```
Creating tables using ddl.sql
```bash
psql -h localhost -U postgres -d host_agent -f sql/ddl.sql
```
Inserting hardware specs data into the database using host_info.sh
```bash
./scripts/host_info.sh psql_host psql_port db_name psql_user psql_password
```
Inserting hardware usage data into the database using host_usage.sh
```bash
bash scripts/host_usage.sh psql_host psql_port db_name psql_user psql_password

```
Crontab setup
```bash
* * * * * bash /home/centos/dev/jrvs/bootcamp/linux_sql/host_agent/scripts/host_usage.sh localhost 5432 host_agent postgres password > /tmp/host_usage.log
```
#Implementation

The first bash script that was implemented was the 
psql_docker.sh file. This provisions the postgresql instance
that we need to build our database on. Using the instance, we 
created a database called host_agent. Then we implemented
the ddl.sql script that will create the info and usage table if the table does not exist.
We can run the file on the psql instance using the -f option. Now the tables have been
set up with the appropriate data types and relations. We then wrote two more scripts that insert
system information to the info table and usage information to the usage table. Finally, we set up crontab 
for the host_usage script to run every minute, which inserts data into the table automatically.

#Architecture

![architecture](https://user-images.githubusercontent.com/91636946/151421004-f243b09c-8e28-42e5-8402-dc6008df3030.png)

##Scripts

- psql_docker.sh 
  - This script first starts the docker
  and can do one of three things depending on the command line input. It can either create and start the container
  if the container doesn't already exist using the create command. It can also start or stop existing
  containers by passing in start or stop as the input. This script helps different linux machines set 
  up the docker and start the postgresql instance with ease 
- host_info.sh 
  - This script needs 5 command line inputs to run. It needs host name,
port number, database name, user name, password. Then it parses through 
host hardware specifications using bash commands and inserts 
the extracted data into the info table.
- host_usage.sh  
  - This script is the same as host_info.sh but 
this script gets the data for the usage data instead. 
- crontab 
  - Crontab was used to run host_usage.sh script every minute
to store and monitor the usage data.
- queries.sql 
  - The first query was used to see which host has the highest
total memory within each cpu group. For example, if we want to know
which host has the highest total memory out of the computers with 1 cpu, we can run this
query to answer that question.
  - The second query was used to see the average used memory for every 5 minutes.
The used memory was calculated by subtracting free memory from the total memory.
This query can be used to see which time frame has the highest average used memory. 
If there is a sudden spike in the average used memory for a specific time, then we can 
look into it to find potential problems.
  - The third query was used to monitor the status of our automated scripts.
In theory, our script, host_usage.sh, should run and insert data every minute since we set up crontab.
If there is a problem somewhere and there is a server failure, we can find the time
when the server failed.

## Database Modeling

- host_info
  - id : SERIAL (PRIMARY KEY)
  - hostname : VARCHAR
  - cpu_number : INT
  - cpu_architecture : VARCHAR
  - cpu_model : VARCHAR
  - cpu_mhz : FLOAT
  - L2_cache : INT
  - total_mem : INT
  - timestamp : TIMESTAMP
- host usage
  - timestamp : TIMESTAMP
  - host_id : SERIAL (FOREIGN KEY)
  - memory_free : INT
  - cpu_idle : INT
  - cpu_kernel : INT
  - disk_io : INT
  - disk_available : INT

# Test

- To test psql_docker.sh, we created an instance 
of the psql docker and ran the script to create another container.
It showed an error message: container already exist, 
which is what we expected it to be. We then deleted the instance, 
then tried to start/stop the non-existent instance, and again showed 
error as expected. After all the error checks, we made sure the script was creating the instance correctly
by checking the container status.
- To test host_info.sh, host_usage.sh and crontab, I connected
to the psql instance on the terminal, and checked the tables
by using queries. They were being updated correctly and the host usage table
was getting updated every minute.
- To test the queries, I waited a couple of days for data to fill the table 
and used dbeaver to write the queries in a more graphically oriented environment.

#Improvements

3 things that I would like to improve:
- Paying attention to detail to reduce errors
  - (e.g) know when to use " " instead of ' ' and vice versa
  - Data types
- Git commands 
- Bash scripts


