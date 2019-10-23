{% if keyvalue['kv_id'] == 11 or keyvalue['kv_id'] == 8 or keyvalue['kv_id'] == 9 or keyvalue['kv_id'] == 13 or keyvalue['kv_id'] == 7 %}
{{ select("keyvalue_value_default"~keyvalue['kv_id'],"class":"form-control "~keyvalue["validation_classes"], keyvalue['multi_options'], 'required':'required') }}
{% else %}
{{ select("keyvalue_value_default"~keyvalue['kv_id'],"class":"form-control "~keyvalue["validation_classes"], keyvalue['multi_options']) }}
{% endif %}