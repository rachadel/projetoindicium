with 
    vendas as (
        select 
            salesorderid as id_venda,
            salespersonid as id_vendedor, 
            customerid as id_cliente,
            shiptoaddressid as id_endereco_cliente,
            billtoaddressid as id_endereco_faturamento,
            currencyrateid as id_taxa_cambio,
            creditcardid as id_cartao_credito,
            shipmethodid as id_metodo_envio,
            territoryid as id_territorio,
            creditcardapprovalcode as cd_cartao_credito,
            date(orderdate) as dt_criacao_venda,
            date(duedate) as dt_pedido_cliente,
            date(shipdate) as dt_envio_cliente,
            freight as vl_frete,
            totaldue as vl_total_venda,
            subtotal as vl_subtotal,
            taxamt as vl_imposto,
            status as ds_status
        from
            {{ ref('stg_raw__sales_salesorderheader') }}
    ),
    cartoes as (
        select
            creditcardid as id_cartao_credito,
            cardtype as ds_cartao,
            cardnumber as nr_cartao,
            expmonth as nr_mes_expiracao,
            expyear as  nr_ano_expiracao
        from
            {{ ref('stg_raw__sales_creditcard') }}
    ),
    join_tables as (
        select
            vendas.id_venda,
            vendas.id_vendedor,
            vendas.id_cliente,
            vendas.id_endereco_cliente,
            coalesce(cartoes.ds_cartao, 'Não Informado') as ds_cartao,
            vendas.dt_criacao_venda,
            vendas.dt_pedido_cliente,
            vendas.dt_envio_cliente,
            vendas.vl_frete,
            vendas.vl_total_venda,
            vendas.vl_subtotal,
            vendas.vl_imposto,
            vendas.ds_status
        from
            vendas
            left join cartoes
                on vendas.id_cartao_credito = cartoes.id_cartao_credito
    )

select * from join_tables order by id_venda



