

{{ config(
    schema='core_entreprise',
    materialized='table'
) }}


with naf_5_niv as (
    select
        niv_5,
        niv_4,
        niv_3,
        niv_2,
        niv_1
    from {{ ref('stg_naf_5_niv') }}
),


naf_n5 as (
    select
        code,
        libelle
    from {{ ref('stg_naf_n5') }}
),

naf_n4 as (
    select
        code,
        libelle
    from {{ ref('stg_naf_n4') }}
),

naf_n3 as (
    select
        code,
        libelle
    from {{ ref('stg_naf_n3') }}
),

naf_n2 as (
    select
        code,
        libelle
    from {{ ref('stg_naf_n2') }}
),

naf_n1 as (
    select
        code,
        libelle
    from {{ ref('stg_naf_n1') }}
)

select
    naf_5_niv.niv_5 as niv_5_code,
    n5.libelle as niv_5_libelle,
    naf_5_niv.niv_4 as niv_4_code,
    n4.libelle as niv_4_libelle,
    naf_5_niv.niv_3 as niv_3_code,
    n3.libelle as niv_3_libelle,
    naf_5_niv.niv_2 as niv_2_code,
    n2.libelle as niv_2_libelle,
    naf_5_niv.niv_1 as niv_1_code,
    n1.libelle as niv_1_libelle


from naf_5_niv
left join naf_n5 n5 on naf_5_niv.niv_5 = n5.code
left join naf_n4 n4 on naf_5_niv.niv_4 = n4.code
left join naf_n3 n3 on naf_5_niv.niv_3 = n3.code
left join naf_n2 n2 on naf_5_niv.niv_2 = n2.code
left join naf_n1 n1 on naf_5_niv.niv_1 = n1.code