{%for result in attributes%}
<label>{{result["attribute_title"]}}</label>
<select class=" form-control" name="{{result['attribute_type']}}" id="{{result['attribute_type']}}">
    <option></option>
    {%for item in result["attribute_options"]%}
    <option value="{{item['option_id']}}">{{item['title']}}</option>
    {%endfor%}

</select>
{%if(result['attribute_type']=="type")%}
<input type="hidden" name="attribute_type_id" value="{{result['attribute_id']}}" id="attribute_type_id" />
<input type="hidden" name="attribute_type_value" id="attribute_type_value" value="" />
{%else%}
<input type="hidden" name="attribute_id" value="{{result['attribute_id']}}" id="attribute_id" />
<input type="hidden" name="attribute_value" id="attribute_value" value="" />
{%endif%}


{%endfor%}
<script>

    $("#capacity").change(function() {


        var data_cms_depts_rel_id = $("#product_type").val();
        var category_attribute_id = $("#attribute_id").val();
        var category_attribute_value = $("#capacity option:selected").text();
        $("#attribute_value").val(category_attribute_value);
        var capacity_text = $("#capacity option:selected").text();
        $('#revise_tank_capacity').text(capacity_text);
        var value = $("#capacity").val();
        var attribute_id=$("#attribute_id").val();



    });


    $("#type").change(function() {
        var category_attribute_type_value = $("#type option:selected").text();
        $("#attribute_type_value").val(category_attribute_type_value);

    });

</script>