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
            personid,
            storeid
        from 
            {{ ref("stg_raw__sales_customer") }}
    ),
    store as (
        select 
            businessentityid, 
            name,
            salespersonid
        from 
            {{ ref("stg_raw__sales_store") }}
    ),
    transformacao as (
        select
            row_number() over (order by customer.customerid)    as sk_cliente,
            customer.customerid                                 as id_cliente,
            coalesce(person.nome, store.name)                   as nm_cliente,
            case
                when customer.personid is not null
                then 'Cliente'
                else 'Loja'
                end as ds_tipo_cliente,
            current_datetime('America/Sao_Paulo') as dh_atualizacao
        from 
            customer 
            left join person
                on person.businessentityid = customer.personid
            left join store
                on customer.storeid = store.businessentityid
    )

select * from transformacao order by sk_cliente

