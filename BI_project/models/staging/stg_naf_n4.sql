
{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  "naf rév. 2, 2008 - niveau 4 - liste des classes" as code,
  "unnamed 1" as libelle
from {{ source('dwh_raw', 'naf2008_liste_n4') }}
where
  "naf rév. 2, 2008 - niveau 4 - liste des classes" is not null
  and "naf rév. 2, 2008 - niveau 4 - liste des classes" != ''
  and "naf rév. 2, 2008 - niveau 4 - liste des classes" != 'Code'