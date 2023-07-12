with 

source as (

    select * from {{ source('raw', 'hr_employee') }}

),

renamed as (

    select
        businessentityid,
        birthdate,
        gender,
        jobtitle,
        hiredate,
        maritalstatus,
        salariedflag,
        nationalidnumber,
        currentflag,
        modifieddate
    from source

)

select * from renamed
