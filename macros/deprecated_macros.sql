{% macro get_custom_schema(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
        {{ default_schema }}_{{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}

{#- DEPRECATED: adapter_macro is deprecated in favor of adapter.dispatch #}
{% macro adapter_macro(name, *args, **kwargs) -%}
    {% do log("This uses deprecated adapter_macro pattern", info=true) %}
    {{ return(adapter.dispatch(name, macro_namespace='dbt')(*args, **kwargs)) }}
{%- endmacro %}

{#- Example macro using old pattern #}
{% macro custom_date_trunc(date_column, date_part) -%}
    {#- DEPRECATED: This should use adapter.dispatch pattern #}
    {% set macro = adapter_macro('date_trunc', date_column, date_part) %}
    {{ macro }}
{%- endmacro %}

