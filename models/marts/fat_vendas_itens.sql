with 
    dim_produtos as (
        select 
            *
        from
            {{ ref('dim_produtos') }}
    ),
    vendas_itens as (
        select 
            *
        from
            {{ ref('int_vendas_itens') }}
    ),
    join_tabelas as (
        select
            dim_produtos.sk_produto,
            vendas_itens.id_venda,
            vendas_itens.id_venda_item,
            vendas_itens.vl_item,
            vendas_itens.qt_item,
            vendas_itens.vl_desconto_item
        from
            vendas_itens
            left join dim_produtos
                on dim_produtos.id_produto = vendas_itens.id_produto
    ),
    transformacao as (
        select
            {{dbt_utils.generate_surrogate_key(['id_venda_item', 'sk_produto'])}} as sk_venda_item,
            join_tabelas.*,
            vl_item * qt_item as vl_total_bruto,
            (1 - vl_desconto_item) * vl_item * qt_item as vl_total_liquido,
            case 
                when vl_desconto_item > 0 then true
                when vl_desconto_item = 0 then false
                else false
                end as fl_possui_desconto
        from    
           join_tabelas 
    )

select * from transformacao order by id_venda, id_venda_item
