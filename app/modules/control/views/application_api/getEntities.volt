<div class="related_entity">
    <a class="remove_related_entity_{{ruid}} btn btn-link">Remove Related Entity</a>
    <div class="form-group">
        <label>Related Entity</label>
    <select class="form-control" name="related_entities[]" id="entity_select_{{ruid}}">
        {%for entity in entities%}
        <option value="{{entity.id}}">{{entity.name}}</option>
        {%endfor%}
    </select>
    </div>
    <div>
        <a class="btn btn-sm btn-info pull-right" onclick="add_related_entity_param()"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add More</a>
    </div>
    <div id="entity_params_{{ruid}}">

    </div>
    <script>

        // Makes sure the code contained doesn't run until
        //     all the DOM elements have loaded

        $('#entity_select_{{ruid}}').change(function(){
            var num_main_entity_div = $( ".repeatRelatedEntity" ).length;
            var model_id= $(this).val();
            var num_div = $( ".relatedEntityParam_"+model_id).length;
            var uid= num_div+num_main_entity_div+1;

            var url= "{{this.url_shared.get('control_module/application_api/getRelatedEntityFields/')}}"+model_id+"&uid="+uid;
            $("#entity_params_{{ruid}}").load(url)

        });
        function add_related_entity_param() {
            var model_id= $("#entity_select_{{ruid}}").val();
            var num_div = $( ".relatedEntityParam_"+model_id ).length;
            var uid= num_div+1;

            var url= "{{this.url_shared.get('control_module/application_api/getRelatedEntityFields/')}}"+model_id+"&uid="+uid;
            var response;
            $.ajax({ type: "GET",
                url: url,
                async: false,
                success : function(text)
                {
                    response= text;
                }
            })
            $("#entity_params_{{ruid}}").append(response);
        }


    </script>
</div>
<script>
    $(".remove_related_entity_{{ruid}}").click(function(event) {
        event.preventDefault();
        $(this).parent('div').remove();
    });
</script>