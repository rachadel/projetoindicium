with
    salesreason as (
        select
            salesorderheadersalesreason.salesorderid                        as id_venda, 
            string_agg(salesreason.name, ', ' order by salesreason.name)    as ds_motivo_venda
        from 
            {{ ref('stg_raw__sales_salesorderheadersalesreason') }} salesorderheadersalesreason
            left join {{ ref("stg_raw__sales_salesreason") }}       salesreason
                on salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid
        group by 
            salesorderheadersalesreason.salesorderid
    ),
    transformacao as (
        select
            row_number() over(order by id_venda) as sk_motivo_venda,
            *,
            case 
                when ds_motivo_venda like '%Promotion%'
                then true
                else false
                end as fl_promotion, 
            current_datetime('America/Sao_Paulo') as dh_atualizacao
        from 
            salesreason
    )

select * from transformacao order by sk_motivo_venda