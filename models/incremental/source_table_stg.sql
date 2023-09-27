{{config (materialized = 'table' )}}

with source_table as 
(select  
student_id ,
name ,
collage_name ,
age ,
passed_out_year ,
created_Date ,
Modified_Date from {{ source('incremental', 'source_table') }}
)

select * from source_table