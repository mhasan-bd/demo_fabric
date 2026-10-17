select employee_id, full_name, gender, city, job_title, salary, latitude, longitude
from {{ ref('silver_employees') }}
