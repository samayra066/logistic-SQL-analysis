use logistics_delivery_db;
#Basic SQL + Filtering
# Display all orders with complete order details
select * from orders;

# Find orders where the order amount is greater than ₹5,000
select * from orders where orderamount>5000;

#Find orders placed between 2026-01-01 and 2026-03-31 two given dates
select * from orders where orderdate between "2026-01-01" and "2026-03-31";

# Find orders where delivery cost is between ₹100 and ₹250
select * from delivery where DeliveryCost between "100" and "250";

#Find customers whose name starts with the letter A.
select * from customers where FirstName like "a%";

#Display unique cities and delivery methods available in the dataset
select distinct city from customers;
select distinct deliverymethod from delivery;

#Aggregate Functions
#Find the total number of orders.
select count(*) as total_orders from orders;

#Find the total revenue.
select sum(orderamount) as total_revenue from orders;

#Find the average order amount.
select avg(orderamount) as avg_order_amount from orders;

#Find the highest and lowest order amount.
select min(orderamount) as lowest_amount,
 max(orderamount) as highest_amount from orders;
 
 #group by + having
 #Find the delivery methods that have more than 10 orders.
 select deliverymethod, count(*) as total_orders
 from delivery group by DeliveryMethod having count(*)>10;
 
 #String Functions
 #Display customer names in uppercase and city names in lowercase.
 select upper(concat(firstname," ", lastname)) as customer_name,
         lower(city) as city_name from customers;
         
#Extract the first 3 characters of each city.
select city, substring(city,1,3) as first_three_charecters from customers;

#Find the length of each customer's name.
SELECT CustomerID,
    CONCAT(FirstName, ' ', LastName) AS Customer_Name,
    LENGTH(CONCAT(FirstName, ' ', LastName)) AS Name_Length FROM Customers;
    
#Date Functions
#Find year-wise and month-wise order counts.
SELECT 
    YEAR(OrderDate) AS Order_Year,
    MONTH(OrderDate) AS Order_Month,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Order_Year, Order_Month;

#Find orders delivered after their expected delivery date.
SELECT 
    OrderID,
    ExpectedDeliveryDate,
    ActualDeliveryDate,
    DATEDIFF(ActualDeliveryDate, ExpectedDeliveryDate) 
        AS Delay_Days
FROM Delivery
WHERE ActualDeliveryDate > ExpectedDeliveryDate;

#CASE Statement
#Categorize orders as Low, Medium and High Value.
SELECT 
    OrderID,
    OrderAmount,
    CASE
        WHEN OrderAmount < 2000 THEN 'Low Value'
        WHEN OrderAmount BETWEEN 2000 AND 5000 THEN 'Medium Value'
        ELSE 'High Value'
    END AS Order_Category
FROM Orders;

#window functions
#Rank orders based on OrderAmount
select orderid, orderamount, dense_rank() over(order by orderamount desc) as order_rank from orders;

#Calculate the running total of OrderAmount based on order date.
select orderid, orderdate, orderamount,
      sum(orderamount) over(order by orderdate) as running_total
from orders;

#Find the previous order amount
select orderid, orderdate, orderamount,
   lag(orderamount) over(order by orderdate) as previous_order_amount
from orders;

#Find the next order amount.
select orderid, orderdate, orderamount,
    lead(orderamount) over(order by orderdate) as nexr_order_amount
from orders;

#Calculate the difference between the current order amount and previous order amount.
select orderid, orderdate, orderamount-lag(orderamount) over(order by orderdate) as amount_difference from orders;

#Rank orders within each customer based on order amount.
select orderid, orderdate, orderamount,
       rank() over(partition by customerid order by orderamount desc) as customer_rank
from orders;

#Mathematical / Numeric Functions
#Calculate final order amount after discount using arithmetic operators and ROUND().
select orderid, discount, orderamount,
    round(orderamount-(orderamount* discount/100),2) as final_order_amount
from orders;

#Calculate absolute difference between estimated and actual delivery days using ABS().
SELECT 
    OrderID,
    ExpectedDeliveryDate,
    ActualDeliveryDate,
    ABS(DATEDIFF(ActualDeliveryDate, ExpectedDeliveryDate)) 
        AS Delivery_Day_Difference
FROM Delivery;

# Use CEIL() and FLOOR() to round delivery costs.
SELECT 
    OrderID,
    DeliveryCost,
    CEIL(DeliveryCost) AS Rounded_Up_Cost,
    FLOOR(DeliveryCost) AS Rounded_Down_Cost
FROM Delivery;

#Use MOD() to identify whether Order IDs are even or odd.
SELECT 
    OrderID,
    MOD(OrderID, 2) AS Remainder,
    CASE
        WHEN MOD(OrderID, 2) = 0 THEN 'Even'
        ELSE 'Odd'
    END AS Order_Type
FROM Orders;























































 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 





