
{{ config(
    schema='staging_entreprise',
    materialized='table') }}

select
    date_day::date as date_day,
    day_of_week::text as day_of_week,
    day_of_week_name::text as day_of_week_name,
    day_of_month::text as day_of_month,
    day_of_year::text as day_of_year,
    prior_date_day::date as prior_date_day,
    next_date_day::date as next_date_day,
    prior_year_date_day::date as prior_year_date_day,
    prior_year_over_year_date_day::date as prior_year_over_year_date_day
from {{ source('dwh_raw', 'dates') }}