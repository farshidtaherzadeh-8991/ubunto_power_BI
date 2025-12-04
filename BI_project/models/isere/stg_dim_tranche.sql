{{ config(
    materialized='table',
    schema='staging_isere'
) }}

with source as (
    select
        tranche_id int,
        libelle_tranche varchar(100),
        borne_inf int,
        borne_sup int,
        borne_moyenne int
    from {{ source('raw_isere', 'dim_tranche') }}
)

select * from source