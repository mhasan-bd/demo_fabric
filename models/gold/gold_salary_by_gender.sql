select
    coalesce(gender, 'Unknown')     as gender,
    count(*)                        as employee_count,
    cast(round(avg(salary), 2) as decimal(18, 2)) as avg_salary
from {{ ref('silver_employees') }}
group by coalesce(gender, 'Unknown')
