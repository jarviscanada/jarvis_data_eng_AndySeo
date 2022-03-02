# Hadoop Project
Table of contents
* [Introduction](#Introduction)
* [Hadoop Cluster](#Hadoop Cluster)
* [Hive Project](#Hive Project)
* [Improvements](#Improvements)

# Introduction
The purpose of this project was to process data using big data platforms like
Apache Hadoop and evaluate different tools. We evaluated Core Hadoop components, 
including MapReduce, HDFS, and YARN. We provisioned the Hadoop cluster using
Google Cloud Platform with 1 master node and 2 worker nodes. Then we loaded/queried 
the data to answered business questions using Apache Hive and Zeppelin Notebook. 
During the process, we implemented various strategies to optimize our query
execution times and compared their performances to gain a better understanding of 
what is happening internally.

# Hadoop Cluster
- Cluster Architecture Diagram
![hive diagram](https://raw.githubusercontent.com/jarviscanada/jarvis_data_eng_AndySeo/feature/readme/hadoop/assets/hive%20diagram.drawio.png)
- Hardware Specifications for this cluster
    - 2 CPU 
    - 12GB Memory
    - 100GB Disk Space
    - 2 worker nodes
    - 4 YARN Core
    - 12GB YARN Memory

# Hive Project
- As the project progressed, we noticed that the Hive queries took a long time to run
and we had to take measures to optimize them.
  - Instead of using a table that points into google storage, we moved the data into the HDFS to speed up the query
  - Created a partition table (partitioned by year) to query information about years
  - Optimized HQL query using columnar file. We stored the table as a parquet to speed up the queries. 
- Post your Zeppelin Notebook screenshot here
   
# Improvements
- Had some difficulty adjusting to the HQL syntax from SQL but quickly adjusted to the new syntax
- I had to pay extra attention to detail because each query takes a long time to run and not doing so will cost a lot more time
- I should look into partitions more in depth as I consumed a lot of time on figuring out the syntax. Once I get familiar with the syntax, the rest should follow through.