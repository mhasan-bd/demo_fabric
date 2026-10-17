select
    coalesce(job_title, 'Unknown')  as job_title,
    count(*)                        as employee_count,
    cast(round(avg(salary), 2) as decimal(18, 2)) as avg_salary,
    min(salary)                     as min_salary,
    max(salary)                     as max_salary
from {{ ref('silver_employees') }}
group by coalesce(job_title, 'Unknown')
