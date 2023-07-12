with 

source as (

    select * from {{ source('raw', 'sales_salesperson') }}

),

renamed as (

    select
        businessentityid,
        territoryid,
        salesquota,
        bonus,
        salesytd,
        modifieddate,
        saleslastyear,
        rowguid,
        commissionpct
    from source

)

select * from renamed
