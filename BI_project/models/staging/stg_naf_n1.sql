{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  "naf rév. 2, 2008 - niveau 1 - liste des sections" as code,
  "unnamed 1" as libelle
from {{ source('dwh_raw', 'naf2008_liste_n1') }}
where
  "naf rév. 2, 2008 - niveau 1 - liste des sections" is not null
  and "naf rév. 2, 2008 - niveau 1 - liste des sections" != ''
  and "naf rév. 2, 2008 - niveau 1 - liste des sections" != 'Code'