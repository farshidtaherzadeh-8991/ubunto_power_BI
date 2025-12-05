{{ config(
    materialized='table',
    schema='core_entreprise'
) }}

select
    code,
    description
from {{ ref('stg_tranche_effectifs') }}

CASE
        WHEN code IN ('NN', '00') THEN '0'
        WHEN code = '01' THEN '1.5'
        WHEN code = '02' THEN '4'
        WHEN code = '03' THEN '7.5'
        WHEN code = '11' THEN '14.5'
        WHEN code = '12' THEN '34.5'
        WHEN code = '21' THEN '74.5'
        WHEN code = '22' THEN '149.5'
        WHEN code = '31' THEN '224.5'
        WHEN code = '32' THEN '374.5'
        WHEN code = '41' THEN '749.5'
        WHEN code = '42' THEN '1499.5'
        WHEN code = '51' THEN '3499.5'
        WHEN code = '52' THEN '7499.5'
        WHEN code = '53' THEN '10000'

END ::float as moyenne


