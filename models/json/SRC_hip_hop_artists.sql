{% set json_column_query %}
select distinct
json.key as column_name
from {{source('json','hip_hop_artists')}},

lateral flatten(input=>artist_data) json
{% endset %}

{% set results = run_query(json_column_query) %}

{% if execute %}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

select
ARTIST_DATA,
{% for column_name in results_list %}
artist_data:{{ column_name }}:: varchar as {{ column_name }}{% if not loop.last %},{% endif %}
{% endfor %}

from {{source('json','hip_hop_artists')}}


