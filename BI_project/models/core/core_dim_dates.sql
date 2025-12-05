
{{ config(
    schema='core_entreprise',
    materialized='table') }}

select
    date_day,
    day_of_week,
    day_of_week_name,
    day_of_month,
    day_of_year,
    prior_date_day,
    next_date_day,
    prior_year_date_day,
    prior_year_over_year_date_day
from {{ ref('stg_dates') }}