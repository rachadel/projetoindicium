with
    salesorderheader as (
        select distinct
            orderdate as dt_criacao_venda
        from 
            {{ ref("stg_raw__sales_salesorderheader") }}
    ),

    transformacao as (
        select
            cast(
                concat(
                substring(dt_criacao_venda, 0, 4),
                substring(dt_criacao_venda, 6, 2),
                substring(dt_criacao_venda, 9, 2)
                )   
                as int)  as sk_data,
            substring(dt_criacao_venda, 0, 4) as dt_ano,
            substring(dt_criacao_venda, 6, 2) as dt_mes,
            substring(dt_criacao_venda, 9, 2) as dt_dia,
            cast(substring(dt_criacao_venda, 0, 10) as date) dt_criacao_venda,
            current_datetime('America/Sao_Paulo') as dh_atualizacao
        from 
            salesorderheader              
    )

select * from transformacao order by sk_data
