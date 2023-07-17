with
    salesorderheader as (
        select distinct
            orderdate as dt_criacao_venda
        from 
            {{ ref("stg_raw__sales_salesorderheader") }}
    ),

    intermediate as (
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
            cast(substring(dt_criacao_venda, 0, 10) as date) dt_criacao_venda
        from 
            salesorderheader              
    ),
    transformacao as (
        select
            *,
            concat(
            case dt_mes
                when '01' then 'Jan'
                when '02' then 'Fev'
                when '03' then 'Mar'
                when '04' then 'Abr'
                when '05' then 'Mai'
                when '06' then 'Jun'
                when '07' then 'Jul'
                when '08' then 'Ago'
                when '09' then 'Set'
                when '10' then 'Out'
                when '11' then 'Nov'
                when '12' then 'Dez'
                end, '/', dt_ano)  as ds_mes_ano,
            current_datetime('America/Sao_Paulo') as dh_atualizacao
        from
            intermediate
    )

select * from transformacao order by sk_data
