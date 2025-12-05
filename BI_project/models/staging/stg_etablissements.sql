{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  siren::text as siren,
  siret::text as siret,
  datecreationunitelegale::date as date_creation_entreprise,
  activiteprincipaleunitelegale::text as code_activite_principale_entreprise,
  categoriejuridiqueunitelegale::text as code_categorie_juridique_entreprise,
  trancheeffectifsunitelegale::text as code_tranche_effectifs_entreprise,
  categorieentreprise::text as categorie_entreprise,
  enseigne1etablissement::text as enseigne_1_ets,
  denominationusuelleetablissement::text as denomination_usuelle_ets,
  numerovoieetablissement::text as numero_voie_ets,
  typevoieetablissement::text as type_voie_ets,
  libellevoieetablissement::text as libelle_voie_ets,
  codepostaletablissement::text as code_postal_ets,
  libellecommuneetablissement::text as libelle_commune_ets,
  codecommuneetablissement::text as code_commune_ets,
  coordonneelambertabscisseetablissement::text as coordonnee_lambert_abscisse_ets,
  coordonneelambertordonneeetablissement::text as coordonnee_lambert_ordonne_ets
from {{ source('dwh_raw', 'etablissements') }}