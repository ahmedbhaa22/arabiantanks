<div class="form-group">
    <label for="keyvalue" class="col-sm-2 control-label">{{translate._("Title")}}</label>
    <div class="col-sm-8">
        {{ text_field("keyvalue_title_default"~keyvalue['kv_id'], "size": 20, "class":"form-control") }}
        {%if(keyvalue['has_langs']==1)%}
        {%for lang in app_langs%}
        {%if(lang.is_default==1)%}
        {%continue%}
        {%endif%}
        {{ text_field("keyvalue_title_lang"~keyvalue['kv_id']~"_"~lang.lang_id, "size": 20, "class":"form-control") }}
        {%endfor%}
        {%endif%}

    </div>
</div>