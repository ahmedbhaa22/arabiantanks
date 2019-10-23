<div class="portlet light">
    <div class="portlet-title">
        <div class="caption font-dark">
                            <span class="caption-subject bold uppercase">
                                Settings
                          </span>
        </div>
    </div>
    <div class="portlet-body clearfix">
        <div class="row" >
            <form action="{{url('application_api/create')}}" method="post">
            <div class="form-group col-sm-12">
                <label>Specific action</label>
                <select class="form-control" name="specific_action">
                    {%for specific_action in specific_actions%}
                    {%set selected = ""%}
                    {%if(specific_action.id == specific_action_id)%}
                    {%set selected ="selected"%}
                    {%endif%}
                    <option value="{{specific_action.id}}" {{selected}}>{{specific_action.name}}</option>
                    {%endfor%}
                </select>
            </div>

            <div class="form-group col-sm-12">
                <label>Root Entity</label>
                <select class="form-control" name="entity" id="entity_select">
                    {%for entity in entities%}
                    <option value="{{entity.id}}">{{entity.name}}</option>
                    {%endfor%}
                </select>
            </div>
            <div class="col-md-12" >
                <div id="repeatRootEntity" class="form-group" >


                </div>
            </div>

            <div>
                <a class="btn btn-sm btn-info pull-right" onclick="repeatRootEntityFn()"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add More</a>
            </div>
            <div class="clearfix"></div>
            <br/>

            <div class="col-md-12">
                <div class="panel-group accordion">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a class="accordion-toggle" data-toggle="collapse"  href="#collapse1">
                                    Related Entites <i class="fa fa-angle-down" aria-hidden="true"></i>
                                </a>
                            </h4>
                        </div>

                        <div class="panel-body panel-collapse collapse" id="collapse1">
                            <div>
                                <a class="btn btn-sm btn-info pull-right" onclick="repeatRelatedEntityFn()"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add More Related</a>
                            </div>
                            <div id="related_entities_content">

                            </div>

<!--                                <div class="repeatRelatedEntity borderd">-->
<!--                                    -->
<!--                                </div>-->

                            <div class="clearfix"></div>
                            <br/>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <input type="hidden" name="main_action" value="{{selected_specific_action.general_action_id}}" />
                <input type="submit" value="Save" class="form-control btn btn-sm btn-info" />
            </div>
                </form>
        </div>
        <div class="clearfix"></div>
    </div>

    <!-- END widgets box-->
</div>


<script>
    $(function() {
        // Makes sure the code contained doesn't run until
        //     all the DOM elements have loaded

        $('#entity_select').change(function(){
            var num_div = $( ".repeatRootEntity" ).length;
            var uid= num_div+1;
            var model_id= $(this).val();
            var url= "{{this.url_shared.get('control_module/application_api/getModelFields/')}}"+model_id+"&uid="+uid;
            $("#repeatRootEntity").load(url)

        });

    });
</script>
<script>
    function repeatRootEntityFn() {
        var num_div = $( ".repeatRootEntity" ).length;
        var uid= num_div+1;
        var model_id= $("#entity_select").val();
        var url= "{{this.url_shared.get('control_module/application_api/getModelFields/')}}"+model_id+"&uid="+uid;
        var response;
        $.ajax({ type: "GET",
            url: url,
            async: false,
            success : function(text)
            {
                response= text;
            }
        })
        $("#repeatRootEntity").append(response);
    }

    function repeatRelatedEntityFn(){
        var num_div = $( ".related_entity" ).length;
        var uid= num_div+1;
        var url= "{{this.url_shared.get('control_module/application_api/getEntities/')}}"+"&uid="+uid;
        var response;
        $.ajax({ type: "GET",
            url: url,
            async: false,
            success : function(text)
            {
                response= text;
            }
        })
        $("#related_entities_content").append(response);
    }
</script>