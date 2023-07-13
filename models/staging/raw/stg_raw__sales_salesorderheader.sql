with 

source as (

    select * from {{ source('raw', 'sales_salesorderheader') }}

),

renamed as (

    select
        cast(salesorderid as int)               salesorderid,    
        cast(salespersonid as int)              salespersonid,
        cast(customerid as int)                 customerid,
        cast(shiptoaddressid as int)            shiptoaddressid,    
        cast(billtoaddressid as int)            billtoaddressid,
        cast(currencyrateid as int)             currencyrateid,
        cast(creditcardid as int)               creditcardid,
        cast(shipmethodid as int)               shipmethodid,    
        cast(territoryid as int)                territoryid,    
        cast(onlineorderflag as boolean)        onlineorderflag,    
        cast(purchaseordernumber as string)     purchaseordernumber,    
        cast(freight as numeric)                freight,    
        cast(orderdate as string)               orderdate,    
        cast(creditcardapprovalcode as string)  creditcardapprovalcode,        
        cast(shipdate as date)                  shipdate,    
        cast(accountnumber as string)           accountnumber,        
        cast(totaldue as numeric)               totaldue,        
        cast(duedate as date)                   duedate,        
        cast(subtotal as numeric)               subtotal,            
        cast(revisionnumber as numeric)         revisionnumber,        
        cast(comment as string)                 comment,    
        cast(taxamt as numeric)                 taxamt,    
        cast(case status
            when 1 then 'In process'
            when 2 then 'Approved'
            when 3 then 'Backordered'
            when 4 then 'Rejected'
            when 5 then 'Shipped'
            when 6 then 'Cancelled'
            end as string)                      status,
        cast(modifieddate as timestamp)         modifieddate    
    from source

)

select * from renamed
