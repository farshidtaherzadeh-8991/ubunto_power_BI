{{ config(
    schema='staging_entreprise',
    materialized='table'
) }}

select
  codgeo::text as code_commune,
  libgeo::text as libelle_commune,
  NULLIF(p13_pop, '')::numeric::int as population_2013,
  NULLIF(p14_pop, '')::numeric::int as population_2014,
  NULLIF(p15_pop, '')::numeric::int as population_2015,
  NULLIF(p16_pop, '')::numeric::int as population_2016,
  NULLIF(p17_pop, '')::numeric::int as population_2017,
  NULLIF(p18_pop, '')::numeric::int as population_2018,
  NULLIF(p19_pop, '')::numeric::int as population_2019,
  NULLIF(p20_pop, '')::numeric::int as population_2020,
  NULLIF(p21_pop, '')::numeric::int as population_2021
from {{ source('dwh_raw', 'population_municipale_communes_france') }}