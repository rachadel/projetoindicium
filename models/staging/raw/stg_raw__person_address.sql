with 

source as (

    select * from {{ source('raw', 'person_address') }}

),

renamed as (

    select
        addressid,
        city,
        spatiallocation,
        postalcode,
        addressline2,
        modifieddate,
        stateprovinceid,
        addressline1,
        rowguid

    from source

)

select * from renamed
