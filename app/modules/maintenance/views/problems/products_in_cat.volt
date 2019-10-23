<label>{{translate._("Products")}}</label>
<select class=" form-control" name="data_cms_id" id="data_cms_id">
    <option></option>
    {%for item in content["items"]%}
    <option value="{{item.ID}}">
        {%if(item.getContent_lang(["lang_id=1"]))%}
        {{item.getContent_lang(["lang_id=1"]).title}}
        {%else%}
        {{item.Title}}
        {%endif%}
    </option>
    {%endfor%}

</select>

<script>


</script>