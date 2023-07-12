with
    address as (
        select 
            addressid as id_endereco,
            stateprovinceid as id_estado,
            addressline1 as ds_endereco,
            addressline2 as ds_complemento,
            postalcode as cd_postal,
            city as ds_cidade
        from 
            {{ ref("stg_raw__person_address") }}
    ),
    transformacao as (
        select
            row_number() over (order by id_endereco) as sk_cidade,
            *,
            current_date                           as dh_atualizacao
        from 
            address
    )

select * from transformacao
