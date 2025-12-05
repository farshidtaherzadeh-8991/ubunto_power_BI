{{ config(
    materialized='table',
    schema='staging_entreprise'   
) }}


select
    "catégories juridiques"::text as code,
    "dernière mise à jour le 1er septembre 2022"::text as libelle



from {{ source('dwh_raw', 'cj_septembre_2022_niveau3')}}
where 
    "catégories juridiques" is not null
    and "catégories juridiques" != ''
    and "catégories juridiques" != 'Niveau III'
    and "catégories juridiques" != 'Code'
    and "dernière mise à jour le 1er septembre 2022" is not null
    and "dernière mise à jour le 1er septembre 2022" != ''
    and "dernière mise à jour le 1er septembre 2022" != 'Libellé'