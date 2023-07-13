with 

source as (

    select * from {{ source('raw', 'sales_salesorderdetail') }}

),

renamed as (

    select
        cast(salesorderdetailid as int)     salesorderdetailid,
        cast(productid as int)              productid,
        cast(specialofferid as int)         specialofferid,
        cast(salesorderid as int)           salesorderid,
        cast(unitprice as numeric)          unitprice,
        cast(orderqty as numeric)           orderqty,
        cast(unitpricediscount as numeric)  unitpricediscount,
        cast(modifieddate as timestamp)     modifieddate

    from source

)

select * from renamed
