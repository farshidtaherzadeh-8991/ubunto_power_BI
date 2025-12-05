
{{ config(
    schema='core_entreprise',
    materialized='table') }}

select
    code,
    description,
    moyenne
from (
    select
        code,
        description,
        case
            when code = 'NN' then 0
            when code = '00' then 0
            when code = '01' then 1.5
            when code = '02' then 4
            when code = '03' then 7.5
            when code = '11' then 14.5
            when code = '12' then 34.5
            when code = '21' then 74.5
            when code = '22' then 149.5
            when code = '31' then 224.5
            when code = '32' then 374.5
            when code = '41' then 749.5
            when code = '42' then 1499.5
            when code = '51' then 3499.5
            when code = '52' then 7499.5
            when code = '53' then 10000
            else null
        end as moyenne
    from {{ ref('stg_tranche_effectifs') }}
)