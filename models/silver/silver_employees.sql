with typed as (
    select
        try_cast({{ clean_str('id') }} as int)                         as employee_id,
        {{ clean_str('first_name') }}                                   as first_name,
        {{ clean_str('last_name') }}                                    as last_name,
        {{ clean_str('gender') }}                                       as gender,
        {{ clean_str('city') }}                                         as city,
        {{ clean_str('jobtitle') }}                                     as job_title,
        try_cast(replace(replace({{ clean_str('salary') }}, '$', ''), ',', '')
                 as decimal(18, 2))                                     as salary,
        try_cast({{ clean_str('latitude') }}  as float)                 as latitude,
        try_cast({{ clean_str('longitude') }} as float)                 as longitude,
        _ingested_at
    from {{ source('bronze', 'bronze_employees') }}
),

deduped as (
    select *,
           row_number() over (partition by employee_id order by _ingested_at desc) as rn
    from typed
    where employee_id is not null
)

select
    employee_id,
    first_name,
    last_name,
    concat_ws(' ', first_name, last_name) as full_name,
    gender,
    city,
    job_title,
    salary,
    latitude,
    longitude,
    _ingested_at
from deduped
where rn = 1
