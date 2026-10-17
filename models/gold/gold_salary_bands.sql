with banded as (
    select
        case
            when salary is null  then 'Unknown'
            when salary < 40000  then '< 40k'
            when salary < 60000  then '40k-60k'
            when salary < 80000  then '60k-80k'
            else '>= 80k'
        end as salary_band
    from {{ ref('silver_employees') }}
)
select
    salary_band,
    count(*) as employee_count,
    case salary_band
        when '< 40k'   then 1
        when '40k-60k' then 2
        when '60k-80k' then 3
        when '>= 80k'  then 4
        else 5
    end as sort_order
from banded
group by salary_band
