with 
    vendas_itens as (
        select 
            salesorderdetailid as id_venda_item,
            salesorderid as id_venda,
            productid as id_produto,
            specialofferid as id_oferta,
            unitprice as vl_item,
            orderqty as qt_item,
            unitpricediscount as vl_desconto_item
        from
            {{ ref('stg_raw__sales_salesorderdetail') }}
    )

select * from vendas_itens order by id_venda, id_venda_item



