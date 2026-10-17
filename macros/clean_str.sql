{# trim, and turn '' / 'NULL' / 'null' into real NULLs #}
{% macro clean_str(col) -%}
    case when upper(trim({{ col }})) in ('', 'NULL') then null else trim({{ col }}) end
{%- endmacro %}
