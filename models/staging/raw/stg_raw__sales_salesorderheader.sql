with 

source as (

    select * from {{ source('raw', 'sales_salesorderheader') }}

),

renamed as (

    select
        salesorderid,
        salespersonid,
        customerid,
        shiptoaddressid,
        billtoaddressid,
        currencyrateid,
        creditcardid,
        shipmethodid,
        onlineorderflag,
        territoryid,
        purchaseordernumber,
        freight,
        orderdate,
        creditcardapprovalcode,
        shipdate,
        accountnumber,
        totaldue,
        duedate,
        subtotal,
        revisionnumber,
        comment,
        taxamt,
        status,
        modifieddate
    from source

)

select * from renamed
