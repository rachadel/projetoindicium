with 

source as (

    select * from {{ source('raw', 'person_businessentity') }}

),

renamed as (

    select
        businessentityid,
        modifieddate
    from source

)

select * from renamed
