with
    person as (
        select 
            businessentityid, 
            nome
        from 
            {{ ref("stg_raw__person_person") }}
    ),
    customer as (
        select 
            customerid, 
            personid
        from 
            {{ ref("stg_raw__sales_customer") }}
    ),
    businessentity as (
        select 
            businessentityid
        from 
            {{ ref("stg_raw__person_businessentity") }}
    ),
    businessentityaddress as (
        select 
            businessentityid,
            addressid
        from 
            {{ ref("stg_raw__person_businessentityaddress") }}
    ),
    transformacao as (
        select
            row_number() over (order by customer.customerid)    as sk_cliente,
            customer.customerid                                 as id_cliente,
            businessentityaddress.addressid                     as id_endereco,
            person.nome                                         as nm_cliente,
            current_date                                        as dh_modificado
        from 
            customer 
            join person
                on person.BusinessEntityID = customer.personid
            left join businessentity 
                on businessentity.businessentityid = customer.customerid 
            left join businessentityaddress 
                on businessentityaddress.businessentityid = businessentity.businessentityid 
    )

select * from transformacao
