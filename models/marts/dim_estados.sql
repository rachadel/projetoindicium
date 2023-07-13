with
    stateprovince as (
        select 
            stateprovinceid as id_estado,
            territoryid as id_territorio,
            stateprovincecode as cd_estado,
            name as nm_estado,
            countryregioncode as cd_pais
        from 
            {{ ref("stg_raw__person_stateprovince") }}
    ),
    transformacao as (
        select
            row_number() over (order by id_estado) as sk_estado,
            *,
            current_date                           as dh_atualizacao
        from 
            stateprovince
    )

select * from transformacao order by sk_estado
