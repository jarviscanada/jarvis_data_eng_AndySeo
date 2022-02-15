# Introduction

A gift-ware company named London Gift Shop (LGS) located in the UK
has been running online shops for more than 10 years but struggled to increase revenue in the recent years. The LGS marketing team wants to conduct a data analysis on their customers and decides to engage with Jarvis consulting. This project was to create a proof of concept (POC) that will help the LGS marketing by analyzing customer shopping behavior. LGS marketing team will use our analysis to implement necessary marketing strategies to attract new customers and to maintain their relationships with existing customers. We used docker to provision the PostgreSQL instance and and loaded the retail data received from LGS into the PSQL data warehouse.We then used a SQL client to explore the data/ write queries and to get a better understanding before the official analysis. The analysis was conducted through Jupyter Notebook and we used the Pandas library for data manipulation, matplotlib for visualizations and numpy for numerical operations. To finish the analysis, we integrated the RFM Segmentation table that group customers into meaningful categories to help determine the optimal strategies for marketing.

# Implementaion
## Project Architecture

The architecture of this project consists of the LGS web app, the Jarvis data warehouse, and Jupyter Notebook. The LGS web app is a typical web application consisting of front-end and backend APIs. For front end, it consists of HTML/CSS, Javascript, and images files and is managed by a Content Delivery Network(CDN) that distributes files to different servers around the world. The backend consists of a bunch of microservices done in Springboot or other web applications in the form of containers managed by Kubernetes. These services will store transactional data in Azure SQL Server. We then perform ETL from the OLTP database into our OLAP datawarehouse. For this case, we used PostgreSQL database as our data warehouse. Data was extracted by the LGS IT team and data was delivered to us as a SQL file. LGS IT team also transformed the data to make sure confidential information was excluded. Finally, we connected our Jupyter Notebook to the data warehouse to load the data and to perform analysis on customer shopping behaviors.

![LGSarchitecture](https://user-images.githubusercontent.com/91636946/153911280-958df0bd-0fa6-400b-82ea-d6e323cec558.png)

## Data Analytics and Wrangling

[Link to Analysis (Jupyter Notebook)](./retail_data_analytics_wrangling.ipynb)

### Marketing Strategy Proposal
Based on the analysis, we can propose a few marketing strategies that 
may potentially increase the company's revenue.

1) I suggest giving promotions and discounts to the Champion 
customer segment to maintain a good relationship with loyal customers
and to show appreciation which in return would benefit the company
in the long run. The champions are the companies most valuable customer
segment that sustains the business and the company cannot afford to lose any of them. 

2) We also need to pay attention to the can't lose customer segment because
although these customers have not recently made purchases, these customers 
buy alot when they do. If we can boost up the consistencies of these customers, they could 
potentially be the next champions. Since the customers in this segment tend to by a lot, we 
can give discounts when purchased in bulks. 
# Improvements

If there was more time, I could've improved the analysis by:
1) Fitting a machine learning model to further analyze the customers to make predictions/ classifications
2) Coming up with another way to segment the customers to enhance the analysis
3) Making an interactive dashboard for the stakeholders to see and visualize

