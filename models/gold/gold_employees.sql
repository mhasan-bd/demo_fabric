select employee_id, full_name, gender, city, job_title, salary, latitude, longitude,new_col
from {{ ref('silver_employees') }}
