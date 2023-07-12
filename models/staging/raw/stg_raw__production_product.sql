with 

source as (

    select * from {{ source('raw', 'production_product') }}

),

renamed as (

    select
        productid,
        productmodelid,
        productsubcategoryid,
        name,
        productline,
        color,
        modifieddate,
        finishedgoodsflag,
        listprice,
        discontinueddate,
        class,
        standardcost,
        daystomanufacture,
        makeflag,
        weight,
        reorderpoint,
        weightunitmeasurecode,
        size,
        safetystocklevel,
        productnumber,
        sellenddate,
        sizeunitmeasurecode,
        style,
        sellstartdate
    from source

)

select * from renamed
