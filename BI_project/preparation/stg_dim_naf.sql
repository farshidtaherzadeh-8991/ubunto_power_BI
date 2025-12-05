{{ config(
    materialized='table',
    schema='staging_isere'
) }}

with source as (
    select
        code_naf varchar(10),
        libelle_naf varchar(255),
        section_naf varchar(1),
        code_niveau1 varchar(10),
        code_niveau2 varchar(10),
        code_niveau3 varchar(10),
        code_niveau4 varchar(10)
    from {{ source('raw_isere', 'dim_naf') }}
)

select * from source