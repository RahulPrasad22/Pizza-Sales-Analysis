Create Database Pizza_DB

Use Pizza_DB

Select * from pizza_sales;

-----KPI's Requirement

--1) Total Revenue

Select SUM(total_price) AS Total_Revenue from pizza_sales;

--2) Average order Value

Select Sum(total_price) / Count(DISTINCT order_id) AS Avg_order_Value from pizza_sales;

--3) Total Pizza Sold

Select Sum(quantity) AS Total_Pizzas_Sold from pizza_sales;

--4) Total Orders

Select COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales;

--5) Average Pizzas Per Order

Select CAST(CAST(Sum(quantity) AS Decimal(10,2)) / 
CAST(COUNT(Distinct order_id) AS Decimal(10,2)) AS Decimal(10,2)) AS Avg_Pizzas_Per_Order from pizza_sales;

----Business Requirements

--1) Daily Trend For Total Orders

Select DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

--2) Hourly Trend For Total Orders

Select DATEPART(HOUR, order_time) AS order_hours, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);

--3) Percentage of Sales by Pizza Category

Select pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

--4) Percentage of Sales by Pizza Size

Select pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

--5) Total Pizza Sold By Pizza Caregory

Select pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

--6) Top 5 Best Sellers by Total Pizza Sold

SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

--7) Bottom 5 Worst Seller by Total Pizza Sold:

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC




