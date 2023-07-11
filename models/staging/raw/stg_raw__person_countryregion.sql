with 

source as (

    select * from {{ source('raw', 'person_countryregion') }}

),

renamed as (

    select
        countryregioncode,
        name,
        modifieddate
    from source

)

select * from renamed
