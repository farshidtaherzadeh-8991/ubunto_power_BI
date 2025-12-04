{{ config(
    materialized='table',
    schema='staging_isere'
) }}

with source as (
    select
        code_juridique varchar(10),
        libelle_juridique varchar(255)
    from {{ source('raw_isere', 'dim_juridique') }}
)

select * from source