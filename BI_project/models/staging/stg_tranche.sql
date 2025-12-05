{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  "code",
  "description"
from {{ source('dwh_raw', 'ref_tranche_effectifs_unite_legale') }}