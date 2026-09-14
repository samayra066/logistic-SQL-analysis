use logistics_delivery_db;
#JOINs
# 28) Display customer name, order ID and order amount using INNER JOIN.
select concat(c.firstname," ", c. lastname) as customer_name,
        o.orderid, o.orderamount from customers c join orders o on c.customerid=o.customerid;

# 29) Display order details with product name and category.
select o.orderid, p.productname, p.category, od.quantity, p.unitprice from orders o join order_details od on o.orderid=od.orderid
join products p on od.productid=p.productid;

# 30) Display all customers and their orders, incluidlding customers who have not placed an order.
select c.customerid, concat(c.firstname, " ", c.lastname) as customer_name,
       o.orderid, o.orderamount from customers c left join orders o on c.customerid=o.customerid;
       
#join + group by + having
# 31) Find city-wise total orders.
select c.city, count(o.orderid) as total_order
 from customers c join orders o on c.customerid=o.customerid
 group by c.city order by total_order desc;
 
# 32) Find customers who have placed more than 3 orders.
select c.customerid, concat(c.firstname, " ", c.lastname) as customer_name,
		count(o.orderid) as total_order
from customers c join orders o on c.customerid=o.customerid
group by c.customerid, customer_name
having count(o.orderid)>3;

#join + date function
# 33) Calculate actual delivery days.
select d.orderid, o.orderdate, d.actualdeliverydate,
 datediff(d.actualdeliverydate, o.orderdate) as actual_delivery_day
 from orders o join delivery d on o.orderid=d.orderid;
 
 # 34) Find each customer's first and most recent order date.
 select c.customerid, concat(c.firstname, " ", c.lastname) as customer_name,
 min(o.orderdate) as first_order_date,
 max(o.orderdate) as last_order_date
 from customers c join orders o on c.customerid=o.customerid
 group by c.customerid, customer_name;
 
 #join + CASE Statement
 # 35) Create customer segments based on total spending.
 select c.customerid, concat(c.firstname, " " , c. lastname) as customer_name,
 sum(o.orderamount) as total_spending,
    case
      when sum(o.orderamount)<="l0000" then "low value"
      when sum(o.orderamount)between 10000 and 20000 then "medium value"
	else "high value"
end as spending_segments
from customers c join orders o on c.customerid=o.customerid
group by c.customerid, customer_name;

 


 
 
 
 
 
 
 
 
 
 
 
 
 
 