<label> English</label>
{{ text_field("keyvalue_value_default"~keyvalue['kv_id'], "size": 30, "class":"form-control "~keyvalue["validation_classes"], "maxlength": 60, "placeholder": keyvalue['title']) }}
{%if(keyvalue['has_langs']==1)%}
{%for lang in app_langs%}
{%if(lang.is_default==1)%}
{%continue%}
{%endif%}
<label>العربية</label>
{{ text_field("keyvalue_value_lang"~keyvalue['kv_id']~"_"~lang.lang_id, "size": 30, "class":"form-control "~keyvalue["validation_classes"], "maxlength": 60, "placeholder": keyvalue['title']) }}
{%endfor%}
{%endif%}