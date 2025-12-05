{{ config(
    schema='core_entreprise',
    materialized='table'
) }}


with n3 as (
    select
        code as code_n3,
        libelle as libelle_n3,
        left(code, 2) as code_n2,
        left(code, 1) as code_n1
    from {{ ref('stg_juridique_niveau3') }}

),

n2 as (
    select
        code as code_n2,
        libelle as libelle_n2
    from {{ ref('stg_juridique_niveau2') }}
),

n1 as (
    select
        code as code_n1,
        libelle as libelle_n1
    from {{ ref('stg_juridique_niveau1') }}
)

select
    n3.code_n3,
    n3.libelle_n3,
    n2.code_n2,
    n2.libelle_n2,
    n1.code_n1,
    n1.libelle_n1
from n3
left join n2 on n3.code_n2 = n2.code_n2
left join n1 on n3.code_n1 = n1.code_n1