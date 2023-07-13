with 

source as (

    select * from {{ source('raw', 'sales_store') }}

),

renamed as (

    select
        businessentityid,
        salespersonid,
        name,
        modifieddate
    from source

)

select * from renamed
