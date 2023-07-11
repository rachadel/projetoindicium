with 

source as (

    select * from {{ source('raw', 'person_stateprovince') }}

),

renamed as (

    select
        stateprovinceid,
        territoryid,
        stateprovincecode,
        name,
        countryregioncode,
        modifieddate
    from source

)

select * from renamed
