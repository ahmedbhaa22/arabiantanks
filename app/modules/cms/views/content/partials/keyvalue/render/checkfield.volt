{%for key,option in keyvalue['multi_options']%}
{{option}}
{% if kv_checked_elements is defined %}
{% if key in kv_checked_elements[keyvalue['kv_id']] %}
{{ check_field("keyvalue_value_default"~keyvalue['kv_id']~"[]","class":" "~keyvalue["validation_classes"],"value":key,"checked":"checked") }}
<hr>
{%else%}
{{ check_field("keyvalue_value_default"~keyvalue['kv_id']~"[]","class":" "~keyvalue["validation_classes"],"value":key) }}
<hr>
{%endif%}

{%else%}
{{ check_field("keyvalue_value_default"~keyvalue['kv_id']~"[]","class":" "~keyvalue["validation_classes"],"value":key) }}
<hr>
{%endif%}
{%endfor%}