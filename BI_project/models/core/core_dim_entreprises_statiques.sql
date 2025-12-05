{{ config(
    schema='core_entreprise',
    materialized='table') }}

select
    siren,
    siret,
    categorie_entreprise,
    date_creation_entreprise,
    enseigne_1_ets,
    denomination_usuelle_ets,
    numero_voie_ets,
    type_voie_ets,
    libelle_voie_ets,
    code_postal_ets,
    code_commune_ets,
    libelle_commune_ets,
    coordonnee_lambert_abscisse_ets,
    coordonnee_lambert_ordonnee_ets
from {{ ref('stg_etablissements') }}