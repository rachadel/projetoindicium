with 

source as (

    select * from {{ source('raw', 'person_person') }}

),

renamed as (

    select
        businessentityid,
        cast(firstname  || ' ' || coalesce(middlename, '') || ' ' || coalesce(lastname, '') as string) as nome,
        modifieddate
    from source

)

select * from renamed