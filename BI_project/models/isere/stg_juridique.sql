{{ config(
    materialized='table',
    schema='staging_entreprise'
) }}


    SELECT
    *
    FROM {{ source('raw_mac_f', 'cj_septembre_2022') }}

