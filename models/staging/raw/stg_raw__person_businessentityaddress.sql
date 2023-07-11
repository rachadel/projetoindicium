with 

source as (

    select * from {{ source('raw', 'person_businessentityaddress') }}

),

renamed as (

    select
        businessentityid,
        addressid,
        addresstypeid,
        modifieddate
    from source

)

select * from renamed
