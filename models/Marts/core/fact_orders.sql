with
    payment as (select * from {{ ref("stg_payment") }}),
    orders as (select * from {{ ref("stg_orders") }}),

    order_payments as (
        select order_id, sum(case when status = 'success' then amount end) as amount
        from payment
        group by 1
    ),

    final as (
        select
        order_payments.amount,
        orders.customer_id,
        orders.order_date,
        orders.order_id
        from orders
        left join order_payments using (order_id)
    )
select *
from final
