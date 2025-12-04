{{ config(
    materialized='table',
    schema='staging_isere'
) }}

with source as (
    select
        fact_id int,
        date_observation date,
        entreprise_id int,
        commune_id int,
        tranche_id int,
        juridique_id int,
        naf_id int,
        secteur_id int
    from {{ source('raw_isere', 'fact_entreprises_instant_t') }}
)

select * from source