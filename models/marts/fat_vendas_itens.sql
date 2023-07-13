with 
    clientes as (
        select 
            *
        from
            {{ ref('dim_clientes') }}
    ),
    vendedores as (
        select 
            *
        from
            {{ ref('dim_vendedores') }}
    ),
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
            freight as vl_frete,
            orderdate as dt_criacao_venda,
            creditcardapprovalcode as cd_cartao_credito,
            shipdate as dt_envio_cliente,
            totaldue as vl_total_venda,
            duedate as dt_pedido_cliente,
            subtotal as vl_subtotal,
            taxamt as vl_imposto,
            status as ds_status
        from
            {{ ref('stg_raw__sales_salesorderheader') }}
    ),
    join_tabelas as (
        select
            clientes.sk_cliente,
            vendedores.sk_vendedor,
            produtos.sk_produto,
            vendas.*
        from
            vendas
            left join clientes
                on clientes.id_cliente = pedido_itens.id_cliente
            left join vendedores
                on vendedores.id_vendedor = pedido_itens.id_vendedor
            left join produtos
                on produtos.id_produto = pedido_itens.id_produto
    ),
    transformacao as (
        select
            {{dbt_utils.generate_surrogate_key(['id_venda', 'sk_produto'])}} as sk_venda,
            *,
            vl_preco_venda * qt_produto as vl_total_bruto,
            (1 - vl_desconto) * vl_preco_venda * qt_produto as vl_total_liquido,
            case 
                when vl_desconto > 0 then true
                when vl_desconto = 0 then false
                else false
                end as fl_possui_desconto
        from    
           join_tabelas 
    )

select * from transformacao order by sk_venda

