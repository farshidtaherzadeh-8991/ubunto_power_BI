{{ config(
    materialized='table',
    schema='staging_entreprise'
) }}


    select
        codgeo::varchar(10) AS code_geo,
        libgeo::varchar(255) AS nom_geo,
        reg:: varchar(100) AS code_region,
        dep::varchar(100) AS code_departement,
        "geometry":: varchar(50) AS code_polygone
    from {{ source('raw_mac_f', 'a_com2021_2154') }}
