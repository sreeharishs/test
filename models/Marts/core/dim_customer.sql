with customers as 
(
    select * from {{ref ('stg_customers')}}
),
orders as
(
select * from {{ref ('stg_orders')}}
),
customers_orders as
(
select customer_id,
min(order_date)as f_order_date,
max(order_date)as l_order_date,
count(order_id) as number_of_orders
from orders
group by 1
),
final as (
select 
customers.customer_id,
customers.first_name,
customers.last_name,
customers_orders.f_order_date,
customers_orders.l_order_date,
coalesce(customers_orders.number_of_orders,0) as number_of_orders
from customers
left join customers_orders using (customer_id)
)
select * from final