with 
    dim_clientes as (
        select 
            *
        from
            {{ ref('dim_clientes') }}
    ),
    dim_vendedores as (
        select 
            *
        from
            {{ ref('dim_vendedores') }}
    ),
    dim_data_vendas as (
        select
            *
        from
            {{ ref('dim_data_vendas') }}
    ),
    dim_cidades as (
        select
            *
        from
            {{ ref('dim_cidades') }}
    ),
    vendas as (
        select 
            *
        from
            {{ ref('int_vendas') }}
    ),
    join_tabelas as (
        select
            dim_clientes.sk_cliente,
            dim_vendedores.sk_vendedor,
            dim_data_vendas.sk_data,
            dim_cidades.sk_cidade,
            vendas.id_venda,
            vendas.ds_cartao,
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
            left join dim_clientes
              on dim_clientes.id_cliente = vendas.id_cliente
            left join dim_vendedores
                on dim_vendedores.id_vendedor = vendas.id_vendedor
            left join dim_data_vendas
                on vendas.dt_criacao_venda = dim_data_vendas.dt_criacao_venda
            left join dim_cidades
                on dim_cidades.id_endereco = vendas.id_endereco_cliente
    ),
    transformacao as (
        select
            {{dbt_utils.generate_surrogate_key(['id_venda', 'sk_cliente'])}} as sk_venda,
            *
        from    
           join_tabelas 
    )

select * from transformacao order by sk_venda






