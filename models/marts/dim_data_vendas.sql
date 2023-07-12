with
    salesorderheader as (
        select 
            salesorderid as id_venda,
            customerid   as id_cliente,
            shiptoaddressid as id_endereco_venda,
            date(orderdate) as dt_criacao_venda,
            date(duedate) as dt_pedido_cliente,
            date(shipdate) as dt_envio_cliente,
            status
        from 
            {{ ref("stg_raw__sales_salesorderheader") }}
    ),

    transformacao as (
        select
            row_number() over (order by salesorderheader.id_venda)  as sk_venda,
            *,
            current_date                                            as dh_atualizacao
        from 
            salesorderheader              
    )

select * from transformacao
