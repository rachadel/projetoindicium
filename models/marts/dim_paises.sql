with
    pais as (
        select 
            countryregioncode as cd_pais,
            name as ds_pais
        from 
            {{ ref("stg_raw__person_countryregion") }}
    ),
    transformacao as (
        select
            row_number() over (order by cd_pais) as sk_pais,
            *,
            current_date                           as dh_atualizacao
        from 
            pais
    )

select * from transformacao
