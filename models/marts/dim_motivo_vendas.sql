with
    salesreason as (
        select 
            salesreasonid as id_motivo_venda,
            reasontype as ds_tipo_motivo_venda,
            name as ds_motivo_venda
        from 
            {{ ref("stg_raw__sales_salesreason") }}
    ),
    transformacao as (
        select
            row_number() over(order by id_motivo_venda) as sk_motivo_venda,
            *,
            current_datetime('America/Sao_Paulo') as dh_atualizacao
        from 
            salesreason
    )

select * from transformacao order by sk_motivo_venda