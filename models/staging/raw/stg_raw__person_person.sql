with 

source as (

    select * from {{ source('raw', 'person_person') }}

),

renamed as (

    select
        cast(businessentityid as int) as id_pessoa,
        cast(firstname  || ' ' || coalesce(middlename, '') || ' ' || coalesce(lastname, '') as string) as nm_pessoa,
        modifieddate as dh_modificado
    from source

)

select * from renamed