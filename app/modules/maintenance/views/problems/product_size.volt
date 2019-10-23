<label>الحجم</label>
<select class=" form-control" name="capacity" id="capacity">
    <option></option>
    {%for item in result["attribute_options"]%}
    <option value="{{item['option_id']}}">{{item['title']}}</option>
    {%endfor%}

</select>
<input type="hidden" name="attribute_id" value="{{result['attribute_id']}}" id="attribute_id" />
<input type="hidden" name="attribute_value" id="attribute_value" value="" />

<script>

    $("#capacity").change(function() {
        var data_cms_depts_rel_id = $("#main_dept").val();
        var category_attribute_id = $("#attribute_id").val();
        var category_attribute_value = $("#capacity option:selected").text();
        var category_attribute_value_id = $("#capacity option:selected").val();
        $("#attribute_value").val(category_attribute_value_id);
        var problems_url="{{url('maintenance_module/requests/problems_in_cat/')}}?data_cms_depts_rel_id="+data_cms_depts_rel_id+"&category_attribute_id="+category_attribute_id+"&category_attribute_value="+category_attribute_value_id;
        $("#problems_in_cat").load(problems_url);
        var capacity_text = $("#capacity option:selected").text();
        $('#revise_tank_capacity').text(capacity_text);
        var value = $("#capacity").val();
        var attribute_id=$("#attribute_id").val();
        var dept_id=$("#product_type").val();
        var products_url ="{{url('maintenance_module/requests/getProductsWithAttribute/')}}"+value+"/"+attribute_id+"/"+data_cms_depts_rel_id;
        $("#products_container").load(products_url);

    });

</script>