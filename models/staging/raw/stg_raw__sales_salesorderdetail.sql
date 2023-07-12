with 

source as (

    select * from {{ source('raw', 'sales_salesorderdetail') }}

),

renamed as (

    select
        salesorderdetailid,
        productid,
        specialofferid,
        salesorderid,
        unitprice,
        orderqty,
        unitpricediscount,
        carriertrackingnumber,
        modifieddate

    from source

)

select * from renamed
