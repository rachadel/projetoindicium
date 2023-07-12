with
    salesreason as (
        select 
            salesreasonid as id_razao_venda,
            reasontype as ds_tipo_razao_venda,
            name as ds_razao_venda
        from 
            {{ ref("stg_raw__sales_salesreason") }}
    ),
    transformacao as (
        select
            row_number() over(order by id_razao_venda) as sk_razao_venda,
            *,
            current_date as dh_atualizacao
        from 
            salesreason
    )

select * from transformacao