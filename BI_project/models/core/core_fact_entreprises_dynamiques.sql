{{ config(
    schema='core_entreprise',
    materialized='table'
)}}

with etablissements as (
    select
        siren,
        code_activite_principale_entreprise,
        code_categorie_juridique_entreprise,
        code_tranche_effectifs_entreprise,
        code_commune_ets
    from {{ ref( 'stg_etablissements') }}
)

select
    concat(siren, '_', current_date) as siren_date_dbt_run,
    siren,
    current_date as date_dbt_run,
    code_activite_principale_entreprise,
    code_categorie_juridique_entreprise,
    code_tranche_effectifs_entreprise,
    code_commune_ets    
    
from etablissements