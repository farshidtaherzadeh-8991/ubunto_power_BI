{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  "code",
  "description"
from {{ source('raw_mac_f', 'ref_tranche_effectifs_unite_legale') }}