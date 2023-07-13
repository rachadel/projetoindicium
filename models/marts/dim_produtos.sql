with
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
    model as (
        select 
            productmodelid as id_modelo_produto,
            name as nm_modelo_produto
        from
            {{ ref("stg_raw__production_productmodel") }}
    ),
    subcategory as (
        select 
            productsubcategoryid as id_subcategoria_produto,
            productcategoryid as id_categoria_produto,
            name as nm_subcategoria_produto
        from
            {{ ref("stg_raw__production_productsubcategory") }}
    ),
    category as (
        select 
            productcategoryid as id_categoria_produto,
            name as nm_categoria_produto
        from
            {{ ref("stg_raw__production_productcategory") }}
    ),
    transformacao as (
        select distinct
            row_number() over (order by product.id_produto)  as sk_produto,
            product.id_produto,
            product.nm_produto,
            model.nm_modelo_produto,
            subcategory.nm_subcategoria_produto,
            category.nm_categoria_produto,
            product.ds_cor,
            product.nr_produto,
            current_date                                     as dh_atualizacao
        from 
            product
            left join model
                on product.id_modelo_produto = model.id_modelo_produto
            left join subcategory
                on product.id_subcategoria_produto = subcategory.id_subcategoria_produto
            left join category
                on subcategory.id_categoria_produto = category.id_categoria_produto           
    )

select * from transformacao order by sk_produto
