with
    pessoas as (
        select
            *
        from
            {{ ref('stg_raw__person_person') }}
    ),
    businessentity as (
        select
            *
        from
            {{ ref('stg_raw__person_businessentity') }}
    ),
    businessentityaddress as (
        select
            *
        from
            {{ ref('stg_raw__person_businessentityaddress') }}
    ),
    address as (
        select
            *
        from
            {{ ref('stg_raw__person_address') }}
    ),
    stateprovince as (
        select
            *
        from
            {{ ref('stg_raw__person_stateprovince') }}
    ),
    countryregion as (
        select
            *
        from
            {{ ref('stg_raw__person_countryregion') }}
    )

select 
    row_number() over(order by pesssoas.businessentityid) as sk_pessoa,
    pesssoas.businessentityid as id_pessoa,
    pesssoas.nome as nm_pessoa,
    endereco.addressline1 as ds_rua,
    endereco.addressline2 as ds_complemento,
    endereco.postalcode as cd_postal,
    endereco.city as ds_cidade,
    estado.name as ds_estado,
    pais.name as ds_pais,
    current_date as dh_modificado
from
    pessoas                             as pesssoas
    left join businessentity            as business
        on pesssoas.businessentityid = business.businessentityid
    left join businessentityaddress     as businessaddress
        on businessaddress.businessentityid = business.businessentityid 
    left join address                   as endereco 
        on endereco.addressid = businessaddress.addressid 
    left join stateprovince             as estado 
        on estado.stateprovinceid = endereco.stateprovinceid 
    left join countryregion             as pais 
        on pais.countryregioncode = estado.countryregioncode 