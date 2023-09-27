with customers as 
(select id as customer_id,
order_id,
paymentmethod,
amount/100 as amount,
status,
created
from NDP_EDW.EDW.payment
)

select * from payment