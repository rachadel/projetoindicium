with 

source as (

    select * from {{ source('raw', 'sales_salesreason') }}

),

renamed as (

    select
        salesreasonid,
        name,
        reasontype,
        modifieddate
    from source

)

select * from renamed
