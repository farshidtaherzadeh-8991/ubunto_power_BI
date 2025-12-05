
{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  "naf rév. 2, 2008 - niveau 5 - liste des sous-classes" as code,
  "unnamed 1" as libelle
from {{ source('dwh_raw', 'naf2008_liste_n5') }}
where
  "naf rév. 2, 2008 - niveau 5 - liste des sous-classes" is not null
  and "naf rév. 2, 2008 - niveau 5 - liste des sous-classes" != ''
  and "naf rév. 2, 2008 - niveau 5 - liste des sous-classes" != 'Code'