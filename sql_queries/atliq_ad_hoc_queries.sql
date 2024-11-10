 -- Q1) provide the list of markets in which customer "Atlique Exclusive" operates its business in the APAC region 

	select distinct(market) from dim_customer
	where region = "APAC" and customer="Atliq Exclusive";

-- Q2) what is the percentage of unique product increase in 2021 vs 2020 ?
--     the final output contains these fields, unique_products_2020 , unique_products_2021, percentage_chg
	with cte1 as(
	select 
		count(distinct(product_code)) as unique_product_2020
	from fact_sales_monthly 
	where fiscal_year = 2020),
	cte2 as(
	select count(distinct(product_code)) as unique_product_2021
	from fact_sales_monthly
	where fiscal_year = 2021)
	select 
		unique_product_2020,
		unique_product_2021,
		round((unique_product_2021 - unique_product_2020)/(unique_product_2020)*100,2) as total_difference
	from cte1,cte2;

-- Q3) provide a report with all the unique product count for each segment andsort them in desceding order of product counts. 
--     the final output contain these fields segment, product_count

	select 
		segment,
		count(distinct(product_code)) as unique_product_count 
	from dim_product 
	group by segment 
	order by unique_product_count desc;

-- Q4) follow up which segment had the most increase in unique products in 2021 vs 2020 the 
--     final output contains these feilds, segment_product_count_2020,produtct_count_2021, difference 

	with unique_products as (
			select count(distinct(product_code)) as unique_products_count, 
			segment, 
			fiscal_year 
		from fact_sales_monthly s
		join dim_product p using(product_code)
		group by p.segment, s.fiscal_year)
	select 
		up20.segment, 
		up20.unique_products_count as product_count_2020,
		up21.unique_products_count as product_count_2021,
		up21.unique_products_count - up20.unique_products_count as difference
	from unique_products up20
	join unique_products up21
	on up20.segment = up21.segment and up20.fiscal_year = 2020 and up21.fiscal_year = 2021
	order by difference desc;

-- Q5) Get the products that have the highest and lowest manufacturing costs. 
--     the final output should contain these fields, product_code,product , manufacturing_cost

	select 
		p.product_code, 
		product, segment, 
		manufacturing_cost 
	from fact_manufacturing_cost mc
	join dim_product p using(product_code)
	where manufacturing_cost in (
		(select max(manufacturing_cost) from fact_manufacturing_cost),
		(select min(manufacturing_cost) from fact_manufacturing_cost)
	)
	order by manufacturing_cost desc;

-- Q6) Generate a report that contains the top 5 customers who received an average high_pre_invoice_discount_pct for the fiscal_year 2021 and in the indian_market.
--     the final output contain these field - customer_code, customer, average_discount_percentage;

	select 
		c.customer_code,
		c.customer,
		round(avg(pd.pre_invoice_discount_pct)*100,2) as average_pct
	from fact_pre_invoice_deductions pd
	join dim_customer c 
	on pd.customer_code = c.customer_code
	where pd.fiscal_year=2021 and c.market = "India"
	group by c.customer_code 
	order by average_pct desc
	limit 5;


-- q7) In which quater of 2020 got the maximum total_sold_quantity?
--     the final output contains these fields sorted by the total_sold_quantity -> quater, total_sold_quantity 

	select 
		case 
		 when month(date) in (9,10,11) then 'Q1'
		 when month(date) in (12,1,2) then "Q2"
		 when month(date) in (3,4,5) then "Q3"
		 when month(date) in (6,7,8) then "Q4"
		 end as quarter,
	round(sum(sold_quantity)/1000000,2) as total_sold_quantity_in_millions
	from fact_sales_monthly
	where fiscal_year = 2020
	group by quarter
	order by total_sold_quantity_in_millions desc  ;

-- Q8) which channel bring more gross sales in the fiscal year 2021 and the percentage of contribution 
--     The final output contains these fields -> channel, gross_sales_mln, percentage

	with channel_gs as(
select 
	channel, 
	sum(gross_price*sold_quantity) as gross_sales 
from fact_gross_price
join fact_sales_monthly using(product_code, fiscal_year)
join dim_customer using(customer_code)
where fiscal_year = 2021
group by channel)

select 
	channel, 
	round(gross_sales/1000000,2) as gross_sales_mln, 
	round((gross_sales/(select sum(gross_sales) from channel_gs))*100,2) as percentage
from channel_gs
order by percentage desc; 

-- Q9) Get the top 3 products in each division that have a high_total_sold_quantity in the year fiscal_year 2021 ? 
--      the final output contains these fields division , product_code

	with top_products as(
	select 
		p.division as division,
		p.product_code as product_code,
	sum(s.sold_quantity) as total_sold_quantity,
	dense_rank() over(partition by p.division order by sum(s.sold_quantity)desc) as rnk
	from dim_product p 
	join fact_sales_monthly s
	on p.product_code = s.product_code
	where s.fiscal_year = 2021
	group by p.division,p.product_code)
	select  *
    from top_products 
	where rnk<=3;
 
