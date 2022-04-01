# Introduction

We have successfully built a data analytics solution for London Gift Shop (LGS) 
by analyzing their customer shopping behavior using Jupyter Notebook and Python for our previous project.
This project helped the marketing team build effective marketing campaigns and the company decided
to invest more money into data engineering. As the existing solution cannot handle big data,
our team lead decides to re-architect the data solution using Apache Spark. We first used
Zeppelin notebook and wrote queries using the WDI data to get familiar with pyspark. Then we 
used Microsoft Azure Databricks to create the workspace and the spark clusters to work with the LGS data. 
We used one master and one worker node for the spark cluster. For the data ingestion process, since the LGS data was small data, we just
dumped the data into a csv file straight from the data warehouse into databricks. Finally, we reimplemented the same business questions from 
the previous project but this time we are using parallel processing to analyze the data, so if the dataset gets bigger, 
we will have no problem handling the big data.



# Databricks and Hadoop Implementation
- The dataset that we used was the same dataset from the LGS python data analytics data. We dumped it into a csv from the 
data warehouse using the copy command. We have one driver(master) and one worker node in the spark cluster. It communicates with 
the file system and the azure storage, and the databricks workspace interacts with the hive metastore.
- ![databricks diagram](https://raw.githubusercontent.com/jarviscanada/jarvis_data_eng_AndySeo/feature/spark_wdi/spark/assets/databricks_architecture.png)


# Zeppelin and Hadoop Implementation
- The dataset that we used for the Zeppelin and Hadoop was the WDI dataset. We ran various queries to get a grasp
of how PySpark is like. We used the same Hadoop Cluster from the previous Hadoop project, with 2 worker nodes and one master node.
![hive diagram](https://raw.githubusercontent.com/jarviscanada/jarvis_data_eng_AndySeo/feature/readme/hadoop/assets/hive%20diagram.drawio.png)


# Future Improvement
- If I were to do this project in the future, I would use more nodes if the dataset is bigger to increase speeds.
- I would try to go further with my analysis using machine learning in the future.
- Instead of dumping the data straight from the data warehouse into databricks using CSV, I can use JDBC ingestion for bigger data. 