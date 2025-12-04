{{ config(
    materialized='table',
    schema='staging_isere'
) }}

with source as (
    select
        entreprise_id int,
        siren varchar(9),
        siret varchar(14),
        nom_entreprise varchar(255),
        date_creation date,
        statut varchar(50),
        type_voie varchar(50),
        numero_voie varchar(10),
        nom_voie varchar(255),
        code_postal varchar(5),
        nom_commune varchar(100),
        code_commune varchar(10),
        cordoonnees_geo varchar(20)
    from {{ source('raw_isere', 'dim_entreprise') }}
)

select * from source