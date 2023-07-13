{{
    config(
        severity = 'error'
    )
}}

with
    vendas_em_2011 as (
        select 
            sum(vl_total_venda) as total_vendido
        from
            {{ ref('fat_vendas') }} 
        where
            dt_criacao_venda between '2011-01-01' and '2011-12-31' 
    )

select
    total_vendido
from
    vendas_em_2011
where
    total_vendido not between 14155698 and 14155700