
{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  "naf rév. 2, 2008 - niveau 3 - liste des groupes" as code,
  "unnamed 1" as libelle
from {{ source('dwh_raw', 'naf2008_liste_n3') }}
where
  "naf rév. 2, 2008 - niveau 3 - liste des groupes" is not null
  and "naf rév. 2, 2008 - niveau 3 - liste des groupes" != ''
  and "naf rév. 2, 2008 - niveau 3 - liste des groupes" != 'Code'