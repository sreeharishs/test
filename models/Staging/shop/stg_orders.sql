with orders as(
select id as order_id,
user_id as customer_id,
order_date 
from {{ source('shop', 'orders') }}
)

Select * from orders