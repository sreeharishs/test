{{
    config (materialized = 'incremental'
    )
}}
with source_table as 
(
select * from {{ref('source_table_stg')}}
{% if is_incremental()%}
where Modified_Date >= (select dateadd(day,-3, max(Modified_Date)) from {{ this}})
{% endif %}
)
Select * from  source_table