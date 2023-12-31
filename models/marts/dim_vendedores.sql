with
    person as (
        select 
            businessentityid, 
            nome
        from 
            {{ ref("stg_raw__person_person") }}
    ),
    employee as (
        select 
            businessentityid,
            cast(birthdate as date) birthdate,
            gender,
            jobtitle,
            cast(hiredate as date) as hiredate,
            maritalstatus,
            salariedflag,
            nationalidnumber,
            currentflag
        from 
            {{ ref("stg_raw__hr_employee") }}
    ),
    salesperson as (
        select 
            businessentityid
        from 
            {{ ref("stg_raw__sales_salesperson") }}
    ),
    transformacao as (
        select
            row_number() over (order by employee.businessentityid)  as sk_vendedor,
            employee.businessentityid                               as id_vendedor,
            person.nome                                             as nm_vendedor,
            date(employee.birthdate)                                as dt_nascimento,
            date(employee.hiredate)                                 as dt_contratado,
            case 
                when employee.gender = 'M'
                then 'Male'
                when employee.gender = 'F'
                then 'Female'
                end                                                 as ds_genero,
            case 
                when employee.currentflag is false
                then 'Inactive'
                when employee.currentflag is true
                then 'Active'
                end                                                 as ds_situacao,
            current_datetime('America/Sao_Paulo') as dh_atualizacao
        from 
            salesperson  
            join employee
                on salesperson.businessentityid = employee.businessentityid 
            join person
                on person.businessentityid = employee.businessentityid            
    )

select * from transformacao order by sk_vendedor
