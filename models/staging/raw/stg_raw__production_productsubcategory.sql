with 

source as (

    select * from {{ source('raw', 'production_productsubcategory') }}

),

renamed as (

    select
        productsubcategoryid,
        productcategoryid,
        name,
        modifieddate
    from source

)

select * from renamed
