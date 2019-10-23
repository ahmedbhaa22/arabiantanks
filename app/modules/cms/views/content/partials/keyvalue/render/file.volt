{{ file_field("keyvalue_value_default"~keyvalue['kv_id'],"class":"form-control "~keyvalue["validation_classes"]) }}
<div class="row">
    <script>
        $(function() {
            $("#{{'keyvalue_value_default'~keyvalue['kv_id']~'_link'}}").hide();
            var file_url = "";
            var val = $("#{{'keyvalue_value_default'~keyvalue['kv_id']}}").val();
            console.log(val);
            if (val != "") {
                var file_url = '{{this.url_shared.get("uploads/")}}' + val;
                $("#{{'keyvalue_value_default'~keyvalue['kv_id']}}").html(val);
                $("#{{'keyvalue_value_default'~keyvalue['kv_id']~'_link'}}").attr("href", file_url)
                $("#{{'keyvalue_value_default'~keyvalue['kv_id']~'_link'}}").show();
            }
        });

    </script>
    <a href="" id="{{'keyvalue_value_default'~keyvalue['kv_id']}}_link"></a>

</div>