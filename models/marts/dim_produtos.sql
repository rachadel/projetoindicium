with
    salesorderdetail as (
        select 
            salesorderdetailid as id_detalhe_ordem_venda,
            productid as id_produto,
            specialofferid as id_oferta_especial,
            salesorderid as id_ordem_venda,
            unitprice as vl_preco_unitario,
            orderqty  as qt_por_produto,
            unitpricediscount as vl_desconto
        from 
            {{ ref("stg_raw__sales_salesorderdetail") }}
    ),
    product as (
        select
            productid as id_produto,
            productmodelid as id_modelo_produto,
            productsubcategoryid as id_subcategoria_produto,
            name as nm_produto,
            productline as nm_linha_produto,
            color as ds_cor,
            productnumber as nr_produto
        from
            {{ ref("stg_raw__production_product") }}
    ),
    transformacao as (
        select distinct
            row_number() over (order by product.id_produto)  as sk_produto,
            product.id_produto,
            product.id_modelo_produto,
            product.id_subcategoria_produto,
            product.nm_produto,
            product.nm_linha_produto,
            product.ds_cor,
            product.nr_produto,
            current_date                                     as dh_atualizacao
        from 
            salesorderdetail 
            join product
                on product.id_produto = salesorderdetail.id_produto              
    )

select * from transformacao
