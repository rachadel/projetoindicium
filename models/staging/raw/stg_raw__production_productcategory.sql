with 

source as (

    select * from {{ source('raw', 'production_productcategory') }}

),

renamed as (

    select
        productcategoryid,
        name,
        modifieddate
    from source

)

select * from renamed
