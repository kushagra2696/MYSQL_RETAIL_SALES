create database project;
use project;

describe retail;

-- 1. Quantity of each product sold in an year by a retail shop.
select description, sum(quantity) as "Quantity" from retail
group by description;


-- 2. Customer preference between online and In-store channel.
select saleschannel , count(saleschannel) as "Total Sales Channel" from retail
group by saleschannel;


-- 3. Product category wise discount offers by retailers.
select category ,avg(discount) as "Average Discount", max(discount) as "Maximum Discount",
 sum(discount) as "Total Discount" from retail
group by category;


-- 4. Favourable mode of payment of the customers.
select paymentmethod, count(paymentmethod) as "Total" from retail
group by paymentmethod;


-- 5. Check the number of products returned 
select returnstatus,count(returnstatus) as "Total" from retail
group by returnstatus;


-- 6. Total shipping cost 
select round(sum(shippingcost),2) as "Total Expenditure on Shipping over an Year" from retail;

 
-- 7. Average unit price of the product allover the world
select description, avg(unitprice) as "Average Cost of the Product in different parts of World" from retail
group by description;


-- 8. Yearly Revenue Generated
select round(sum(revenue),2) as "Total Revenue" from retail;


-- 9. Yearly Profit of the Retail Shops
select round(sum(totalsales)-sum(totalcost),2) as"Total Profit" from retail;


-- 10. Months with maximum sales and minimum sales
-- firstly creating a view to sum up the monthly sales data using group by function
create view monthlysales as
select month, round(sum(totalsales),2) as "Sales" from retail
group by month;

-- Order by function can be used to get the maximum and minimum sales by limiting the rows 
select * from monthlysales
order by sales desc
limit 1;

-- OR Without Creating a VIEW
select month, round(sum(totalsales),2) as "Sales"from retail
group by month
order by sales desc
limit 1;

-- Nested function can also be  used to get the sales data of a specific month
select * from monthlysales
where sales = (select min(sales) from monthlysales);


-- 11. Maximum sales of a product in a single day.
select * from retail
order by totalsales desc
limit 1;



-- 12. Days with maximum sales
-- creating view to summarise the daily data
create view dailysales
as 
select invoicedate, round(sum(totalsales),2) as "DailySales", round(sum(quantity),2) as "TotalQuantity",
round(sum(revenue),2) as "TotalRevenue", round(sum(discount),2) as "TotalDiscount",
round(sum(shippingcost),2) as "TotalShippingCost" from retail
group by invoicedate;

select * from dailysales
order by dailysales desc
limit 5; 

-- OR  we can get the maximum sales like this but with the help of view we do not need to write the whole query 
-- order by function can only be applied  on new column where summation of TotalSales is assigned.
select invoicedate,round(sum(totalsales),2)  as "Sales" from retail
group by invoicedate
order by sales desc
limit 5;


-- 13. Orders Shipped from Various Warehouses
select warehouselocation, count(warehouselocation) as "Total_Orders_shipped" from retail
group by warehouselocation;


-- 14. Country with Maximum Orders / Country giving Maximum business to the retail shop
select country, count(country) as "Total_Orders" from retail
group by country
order by Total_Orders desc;


-- 15. Effect of Order priority on shipment cost
select orderpriority, round(sum(shippingcost),2) as "Shipping Cost" from retail
group by orderpriority;


-- 16. Preferred day for the customers for shopping.
select day, round(sum(totalsales),2) as "Daily_Sales" from retail
group by day
order by Daily_Sales desc;


select * from retail;



