-- An attempt to find out how many customers placed a certain number of orders and what percentage of the total they represent

with
order_per_customer as
	(
	select 
		customer_id 
		,count(order_id) as orders
	from orders o 
	group by 1
	),
all_customers as
	(
	select 
		count(distinct customer_id) as all_customers
	from orders o 
	),
customer_histogram as
	(	
	select
	orders
	,count(customer_id) as nr_of_customers
	from order_per_customer
	group by 1
	order by 1
	)
select 
	ch.orders
	,round((ch.nr_of_customers / ac.all_customers) * 100, 1) 
from customer_histogram ch
cross join all_customers ac