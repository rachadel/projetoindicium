with 

source as (

    select * from {{ source('raw', 'production_productmodel') }}

),

renamed as (

    select
        productmodelid,
        name,
        modifieddate
    from source

)

select * from renamed
