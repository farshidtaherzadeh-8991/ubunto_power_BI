
{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  "naf rév. 2, 2008 - niveau 2 - liste des divisions" as code,
  "unnamed 1" as libelle
from {{ source('dwh_raw', 'naf2008_liste_n2') }}
where
  "naf rév. 2, 2008 - niveau 2 - liste des divisions" is not null
  and "naf rév. 2, 2008 - niveau 2 - liste des divisions" != ''
  and "naf rév. 2, 2008 - niveau 2 - liste des divisions" != 'Code'