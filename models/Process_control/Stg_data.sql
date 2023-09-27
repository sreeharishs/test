{{
    config (materialized = 'incremental',
    unique_key = ['case_id','Status','collectiondate']
    )
}}

select case_id,Status,name,collectiondate from {{ source('incremental', 'details') }}
{% if is_incremental()%}
where case_id||Status||collectiondate not in (select case_id||Status||collectiondate from {{ this}})
{% endif %}
