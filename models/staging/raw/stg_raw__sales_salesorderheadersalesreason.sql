with 

source as (

    select * from {{ source('raw', 'sales_salesorderheadersalesreason') }}

),

renamed as (

    select
        salesreasonid,
        salesorderid,
        modifieddate
    from source

)

select * from renamed
