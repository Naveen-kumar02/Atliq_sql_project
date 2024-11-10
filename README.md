# Atliq_sql_project

# Goal 
The goal of this project is to provide clear and accurate insights for 10 specific business questions from the ad hoc requests. these insights will be used by executive as top management to 
improve decision - making.

# Role 
My role is to act as a data analyst who is responsible for analyzing business data using SQL and presenting actionable insights 

# Task 
- Run SQL queries to answer the ad hoc business requests
- Analyze the data and identify key insights that respond to the needs of the business

# Data Source:
A sql files is provided by codebasics, which i have imported into Mysql Workbech and have got access the database named gbd0041(atliq_db). It include six main table 
1. **dim_customer**                - contain customer-related data
2. **dim_product**                 - contain product-related data
3. **fact_gross_price**            - contain gross price information for each product
4. **fact_manufacturing_cost**     - contain the cost incurred in the prodcution of each product
5. **fact_pre_invoice_deductions** - contain pre invoice deductions information for each product
6. **fact_sales_monthly**          - contains monthly sales data for each product

# Data modelling
Here you can check the Data Model which is uded for this project. I have created this model in MySQL workbench

![datamodel](datamodel/atliq_datamodel.png)

# Business Questinos (ad - hoc - request) 
There are 9 ad hoc question on which i can run  SQL queries to extract answer and then analyze it for getting key insights from the outputs. 
you can see the ad - hoc - request [here](ad_hoc_request)

check out the Quries from [here](sql_queries/atliq_ad_hoc_queries.sql)

# Queries Insights 

1. Provide the list of markets in which customer "Atlique Exclusive" operates its business in the APAC region
   <p align="center"> 
     <img src = "sql_output/sql_1_output.png" alt="list of markets" /> 
   </p>
   These are the list of market that atliq handling the business in APAC region 

2. what is the percentage of unique product increase in 2021 vs 2020 ?
      <p align="center"> 
     <img src = "sql_output/sql_2_output.png" alt="list of markets" />
      </p>
- A 36.33% increase in unique products reflects a significant product expansion strategy.
- Growing product diversity may cater to evolving consumer demands, potentially enhancing market share.
3. Provide a report with all the unique product count for each segment andsort them in desceding order of product counts.
     <p align="center"> 
     <img src = "sql_output/sql_3_output.png" alt="list of markets" />
      </p>
      
4. Follow up which segment had the most increase in unique products in 2021 vs 2020
   <p align="center"> 
     <img src = "sql_output/sql_4_output.png" alt="list of markets" />
      </p>
5. Get the products that have the highest and lowest manufacturing costs
   <p align="center"> 
     <img src = "sql_output/sql_5_output.png" alt="list of markets" />
      </p>
6. Generate a report that contains the top 5 customers who received an average high_pre_invoice_discount_pct for the fiscal_year 2021 and in the indian_market.
   <p align="center"> 
     <img src = "sql_output/sql_6_output.png" alt="list of markets" />
      </p>
7. In which quater of 2020 got the maximum total_sold_quantity?
   <p align="center"> 
     <img src = "sql_output/sql_7_output.png" alt="list of markets" />
      </p>
8. which channel bring more gross sales in the fiscal year 2021 and the percentage of contribution
   <p align="center"> 
     <img src = "sql_output/sql_8_output.png" alt="list of markets" />
      </p>
9. Get the top 3 products in each division that have a high_total_sold_quantity in the year fiscal_year 2021 ?
    <p align="center"> 
     <img src = "sql_output/sql_9_output.png" alt="list of markets" />
      </p>
