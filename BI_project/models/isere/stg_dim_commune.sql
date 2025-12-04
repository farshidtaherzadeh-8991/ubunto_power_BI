{{ config(
    materialized='table',
    schema='staging_isere'
) }}

with source as (
    select
        COM_CODE::varchar(10) AS code_commune,
        nom_commune varchar(255),
        code_postal varchar(5),
        region varchar(100),
        departement varchar(100),
        polygone_geo varchar(50)
    from {{ source('raw_isere', 'dim_commune') }}
)

select * from source