with 

source as (

    select * from {{ source('raw', 'person_address') }}

),

renamed as (

    select
        addressid,
        stateprovinceid,
        addressline1,
        addressline2,
        postalcode,
        city,
        modifieddate
    from source

)

select * from renamed
