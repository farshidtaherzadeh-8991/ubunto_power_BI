
{{ config(
    schema='staging_entreprise',
    materialized='table') }}

select
    niv5::text as niv_5,
    niv4::text as niv_4,
    niv3::text as niv_3,
    (niv2::numeric::int)::text as niv_2,
    niv1::text as niv_1
from {{ source('dwh_raw', 'naf2008_5_niveaux') }}