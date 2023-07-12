with 

source as (

    select * from {{ source('raw', 'sales_customer') }}

),

renamed as (

    select
        cast(customerid as int) customerid,
        cast(personid as int) personid,
        cast(territoryid as int) territoryid,
        cast(storeid as int) storeid,
        cast(modifieddate as datetime) modifieddate
    from source

)

select * from renamed
