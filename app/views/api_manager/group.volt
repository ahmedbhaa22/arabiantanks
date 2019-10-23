<div class="page-bar" >
    <ul class="page-breadcrumb">
        <li>
            <a href="#">Projects</a>
            <i class="icon-arrow-right"></i>
        </li>
        <li>
            <span>{{project.name}}</span>
        </li>
    </ul>

</div>

<div class="portlet light gap">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase">{{project.name}}</span>
        </div>
        <div class="actions">
            <a class="text-info" data-toggle="modal" data-target="#projectAttachments" aria-expanded="true">
                <b><i class="fa fa-paperclip" aria-hidden="true"></i> View Attachments</b>
            </a>
        </div>
        <div class="actions">
            <a class="text-info" data-toggle="modal" data-target="#addprojectAttachments" aria-expanded="true">
                <b><i class="fa fa-paperclip" aria-hidden="true"></i> Add Attachments</b>
            </a>
        </div>
        
    </div>

    <div class="portlet-body">
        <div class="container">

            <div class="bar bg-blue-chambray ">
                <ul> <!--Here u add the modules, each link open the modal-details part-->
                    {% for row in project_groups %}
                    <li> <a href="{{url('api_manager/group')}}?project_id={{row.project_id}}&group_id={{row.id}}">{{ row.group_title}} </a> </li>
                    {% endfor %}
                    <li>
                        <a href="#add-group" data-toggle="modal" data-target="#add-group">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i> Add Group
                        </a>
                    </li>

                </ul>
            </div>


            {% for screen in content %}
            <div class="modal-details">
                <div class="col-md-12 no-pad sub-title pointer clearfix gap" >
                   <div class="">
                                        <span class="col-xs-8 no-pad"  data-toggle="collapse" data-target=".api{{screen.id}}">
                                          <i class="fa fa-angle-down"></i> {{ screen.title}}
                                        </span>
                        <span class="col-xs-2 text-right ">
                                            <i class="fa fa-paperclip" aria-hidden="true"></i>
                            <a id="add-api-link" data-toggle="modal" data-target="#view_screen_att{{screen.id}}" data-id="{{screen.id}}">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i> Attachments
                        </a>
                            <a id="add-api-link" data-toggle="modal" data-target="#add_screen_att{{screen.id}}" data-id="{{screen.id}}">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i>  Add Attachments
                        </a>
                                        </span>
                        <span class="col-xs-2 text-right"><a href="#" onclick="return confirm('This Will Delete the page with all its associated api and screenshots, sure ?');">Delete Screen</a></span>
                    </div>
                </div>
            </div>


            <div class="api{{screen.id}} collapse ">
                <ul  class="nav nav-tabs">
                    <li class="active">
                        <a href="#screens{{screen.id}}" data-toggle="tab"> Screens </a>
                    </li>
                    {% for api in screen.Api %}
                    <li>
                        <a  href="#api{{api.id}}" data-toggle="tab">{{api.title}}</a>

                    </li>
                    {% endfor %}

                    <li>
                        <a id="add-api-link" href="#add-api" data-toggle="modal" data-target="#add-api" data-id="{{screen.id}}">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i> Add API
                        </a>
                    </li>
                </ul>

                <div class="tab-content clearfix">
                    <div class="tab-pane active" id="screens{{screen.id}}">
                        <div class="row">
                            {% for screenshot in screen.Screens%}
                            <div class=" col-md-2 col-sm-2">
                                <div class="portlet light bordered">
                                    <div class="block-section" >
                                        <img src="{{ url('uploads/') ~screenshot.media}}">
                                    </div>
                                    <div class="block-desc" >
                                        <span class="caption-subject bold uppercase">{{ screenshot.title}}</span>
                                        <p> {{ screenshot.title}}
                                        </p>
                                        <a href="{{url('api_manager/screenShotComments/' ~screenshot.id)}}" class="simple-button text-info"  data-toggle="modal" data-target="#screenComments{{screenshot.id}}">
                                            {{screenshot.comments|length}} Comments <i class="icon-bubbles"></i>
                                        </a>
                                        <a href="{{url('api_manager/screenshotDelete/') ~screenshot.id}}" onclick="return confirm('Sure ?')">Delete Screenshot</a>
                                    </div>
                                </div>
                            </div>
                            {% endfor %}


                            <div class="align-middle">
                                <a id="add-screen-link" href="#add-screen" data-toggle="modal" data-target="#add-screen" data-id="{{screen.id}}"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add Screen </a>
                            </div>
                        </div>


                    </div> <!--end of screens-->
                    {% for api in screen.Api %}
                    <div class="tab-pane" id="api{{api.id}}">
                        <div class=" ">
                            <div class="links">
                                <a href="{{api.api_link}}">
                                    {{api.api_link}}
                                </a>
                                <span class="pull-right">{{api.type_method}}</span>
                            </div>



                            <div class="col-xs-2"> <!-- required for floating -->
                                <!-- Nav tabs -->
                                <ul class="nav nav-tabs tabs-left">
                                    <li class=""><a href="#param{{api.id}}" data-toggle="tab">Parameter</a></li>
                                    <li class=""><a href="#Success{{api.id}}" data-toggle="tab">Success</a></li>
                                    <li class=""><a href="#Failed{{api.id}}" data-toggle="tab">Failed</a></li>
                                    <li class=""><a href="#Empty{{api.id}}" data-toggle="tab">Empty</a></li>
                                </ul>
                                <a href="{{url('api_manger/apiDelete/') ~api.id}}" onclick="return confirm('Sure ?')">Delete API</a>
                            </div>

                            <div class="col-xs-10 nopad-l">
                                <!-- Tab panes -->
                                <div class="tab-content">
                                    <div class="tab-pane state" id="param{{api.id}}">

                                        {% for param in api.Param %}
                                        <div class="bordered">
                                            <b>{{param.param_name}}</b> {{param.param_des}}
                                            <br>
                                            <a href="#">
                                                {{param.param_link}}
                                            </a>
                                        </div>
                                        {% endfor %}


                                        <div class="gap">
                                            <a id="add_param_btn" href="#add-param" data-toggle="modal" data-target="#add-param" data-id="{{api.id}}"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add Parameter </a>
                                        </div>

                                    </div>
                                    <div class="tab-pane state " id="Success{{api.id}}">
                                        <div class="col-xs-2" >
                                            <a data-toggle="modal" data-target="#editSuccess" href="{{url('api_manager/editSuccess/' ~api.id)}}">Edit</a>
                                        </div>
                                        <div class="col-xs-10 json bordered" >
                                            <code>{{ api.success_response}}</code>
                                        </div>
                                    </div>
                                    <div class="tab-pane state " id="Failed{{api.id}}">
                                        <div class="col-xs-2" >
                                            <a data-toggle="modal" data-target="#editFailed" href="{{url('api_manager/editFailed/' ~api.id)}}">Edit</a>
                                        </div>
                                        <div class="col-xs-10 json bordered" >
                                            <code>{{ api.fail_response}}</code>
                                        </div>
                                    </div>
                                    <div class="tab-pane state " id="Empty{{api.id}}">
                                        <div class="col-xs-2" >
                                            <a data-toggle="modal" data-target="#editEmpty" href="{{url('api_manager/editEmpty/' ~api.id)}}">Edit</a>
                                        </div>
                                        <div class="col-xs-10 json bordered" >
                                            <code>{{ api.empty_response}}</code>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix"></div>
                        </div>
                    </div> <!--end of 1a-->
                    {% endfor %}


                </div>
            </div>
            <!-- end modal-details -->
            {% endfor %}
        </div>


        <div class="col-md-12 no-pad sub-title clearfix gap">
            <a href="#add-page" data-toggle="modal" data-target="#add-page"><i class="fa fa-plus-circle" aria-hidden="true"></i> Add Page </a>
        </div>

    </div>

</div>



<!-- Modals Divs-->


<div class="static modal fade" id="add-group" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Add New Group</h4>
            </div>
            <form role="form" action="{{url('api_manager/groupAdd')}}" id="" method="post">
                <div class="modal-body clearfix" >
                    <div class="portlet-body">
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> Group Name</label>
                                <input type="text" class="form-control" name="group_title">
                            </div>
                        </div>

                    </div>
                </div>

                <div class="modal-footer">
                    <input type="hidden" name="project_id" value="{{project.id}}" />
                    <input data-dismiss="modal" class="btn dark " value="Cancel">
                    <input type="submit" class="btn green-jungle " value="Save">
                </div>

            </form>
        </div>
    </div>
</div>

<div class="static modal fade" id="add-page" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Add New Page</h4>
            </div>
            <form role="form" action="{{url('api_manager/pageAdd')}}" id="" method="post" enctype="multipart/form-data">
                <div class="modal-body clearfix" >
                    <div class="portlet-body">

                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label"> Page Name</label>
                                <input type="text" class="form-control" name="page_name" required>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label"> ID</label>
                                <input type="text" class="form-control" placeholder="#" required>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> Page Description </label>
                                <input type="text" class="form-control" placeholder="Page Description" name="page_desc" required>
                            </div>
                        </div>


                        <div class="col-xs-12 col-md-12">
                            <h4 class="text-center inside-titles">
                                Add Screens
                            </h4>
                        </div>

                        <div class="repeated form-group">
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label"> ScreenShot Title </label>
                                    <input type="text" class="form-control" placeholder="Screen Title" name="screenshot_title" required>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label"> Upload Screen </label>
                                    <input type="file" class="form-control" name="first_screenshot" required> <!-- multiple uploader -->
                                </div>
                            </div>

                        </div> <!--end repeated-->


                        <div class="col-xs-12 col-md-12">
                            <a href=""><i class="fa fa-plus-circle" aria-hidden="true"></i> Add New Screen </a>
                        </div>


                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="project_id" value="{{project.id}}" />
                    <input type="hidden" name="group_id" value="{{group_id}}" />
                    <input type="" data-dismiss="modal" class="btn dark " value="Cancel">
                    <input type="submit" class="btn green-jungle " value="Save">
                </div>
            </form>
        </div>
    </div>
</div>


<div class="static modal fade" id="add-api" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Add New API</h4>
            </div>
            <form role="form" action="{{ url('api_manager/apiAdd') }}" id="" method="post" enctype="multipart/form-data">
                <div class="modal-body clearfix" >
                    <div class="portlet-body">

                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> API Name</label>
                                <input type="text" class="form-control" name="api_title" required>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> API Desc</label>
                                <input type="text" class="form-control" name="api_des" required>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label"> API Link</label>
                                <input type="text" class="form-control" name="api_link" required>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label"> Type Method</label>
                                <input type="text" class="form-control"  name="api_method" required>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-12">
                            <h4 class="text-center inside-titles">
                                Add Parameters
                            </h4>
                        </div>

                        <div id="parameter_add_container">
                        <div class="repeated form-group">
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label"> Name</label>
                                    <input type="text" class="form-control" placeholder="Parameter Title" name="param_name1" required>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label"> Description</label>
                                    <input type="text" class="form-control" placeholder="Parameter Description" name="param_des1" required>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-12">
                                <div class="form-group">
                                    <label class="control-label"> Link</label>
                                    <input type="text" class="form-control" placeholder="Link" name="param_link1">
                                </div>
                            </div>

                            <input type="hidden" name="param_ids[]" value="1">

                        </div> <!--end repeated -->
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <a id="add-repeat-parameter" href="#" ><i class="fa fa-plus-circle" aria-hidden="true"></i> Add Parameter </a>
                        </div>


                        <div class="col-xs-12 col-md-12">
                            <h4 class="text-center inside-titles">
                                States
                            </h4>
                        </div>

                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> Success</label>
                                <input type="file" class="form-control" placeholder="Upload img">
                                <textarea class="form-control" placeholder="json code" name="success_response" required> </textarea>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> Failed</label>
                                <input type="file" class="form-control" placeholder="Upload img">
                                <textarea class="form-control" placeholder="json code" name="fail_response" required> </textarea>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> Empty</label>
                                <input type="file" class="form-control" placeholder="Upload img">
                                <textarea class="form-control" placeholder="json code" name="empty_response" required> </textarea>
                            </div>
                        </div>

                        <!--- -->

                    </div>

                    <div class="modal-footer">
                        <input type="hidden" name="project_id" value="{{project.id}}" />
                        <input type="hidden" name="group_id" value="{{group_id}}" />
                        <input type="hidden" id="screen_id" name="screen_id" value="" />
                        <input type="" data-dismiss="modal" class="btn dark " value="Cancel">
                        <input type="submit" class="btn green-jungle " value="Save">
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<div class="static modal fade" id="add-param" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Add Parameters</h4>
            </div>
            <form role="form" action="{{ url('api_manager/paramAdd')}}" id="" method="post">
                <div class="modal-body clearfix" >
                    <div class="portlet-body">

                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label"> Name</label>
                                <input type="text" class="form-control" placeholder="Parameter Title" name="param_name">
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label"> Description</label>
                                <input type="text" class="form-control" placeholder="Parameter Description" name="param_des">
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> Link</label>
                                <input type="text" class="form-control" placeholder="Link" name="param_link">
                            </div>
                        </div>



                    </div>

                    <div class="modal-footer">
                        <input id="param_api_id" type="hidden" name="param_api_id" value="">
                        <input type="" data-dismiss="modal" class="btn dark " value="Cancel">
                        <input type="submit"  class="btn green-jungle " value="Save">
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<div class="static modal fade" id="add-screen" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Add Screen</h4>
            </div>
            <form role="form" action="{{url('api_manager/screenshotAdd')}}" id="" method="post" enctype="multipart/form-data">
                <div class="modal-body clearfix" >
                    <div class="portlet-body">

                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label"> Name</label>
                                <input type="text" class="form-control" placeholder="Screenshot Title" name="screenshot_title" required>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label"> Description</label>
                                <input type="text" class="form-control" placeholder="Screenshot Description" name="screenshot_des" required>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label"> Upload Screen</label>
                                <input type="file" class="form-control" placeholder="Screenshot" name="first_screenshot">
                            </div>
                        </div>



                    </div>

                    <div class="modal-footer">
                        <input type="hidden" name="project_id" value="{{project.id}}" />
                        <input type="hidden" name="group_id" value="{{group_id}}" />
                        <input type="hidden" id="screen_id_hidden" name="screen_id" value="" />
                        <input type="" data-dismiss="modal" class="btn dark " value="Cancel">
                        <input type="submit" class="btn green-jungle " value="Save">
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<!-- Modal Ajax Edit Success -->
<div class="modal fade" id="editSuccess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content clearfix">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Success Response</h4>

            </div>
            <div class="modal-body clearfix"><div class="te"></div></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<!-- Modal Ajax Edit Failed -->
<div class="modal fade" id="editFailed" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content clearfix">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Fail Response/h4>

            </div>
            <div class="modal-body clearfix"><div class="te"></div></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<!-- Modal Ajax Edit Empty -->
<div class="modal fade" id="editEmpty" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content clearfix">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                 <h4 class="modal-title">Empty Response/h4>

            </div>
            <div class="modal-body clearfix"><div class="te"></div></div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<script>
    $(document).on("click", "#add-screen-link", function () {
        var page_id = $(this).data('id');
        $("#add-screen #screen_id_hidden").val( page_id );
        // As pointed out in comments,
        // it is superfluous to have to manually call the modal.
        // $('#addBookDialog').modal('show');
    });
    $(document).on("click", "#add-api-link", function () {
        var page_id = $(this).data('id');
        $("#add-api #screen_id").val( page_id );
        // As pointed out in comments,
        // it is superfluous to have to manually call the modal.
        // $('#addBookDialog').modal('show');
    });
    $(document).on("click", "#add_param_btn", function () {
        var page_id = $(this).data('id');
        $("#add-param #param_api_id").val( page_id );
        // As pointed out in comments,
        // it is superfluous to have to manually call the modal.
        // $('#addBookDialog').modal('show');
    })

    $(document).ready(function() {
        var max_fields      = 25; //maximum input boxes allowed
        var wrapper         = $("#parameter_add_container"); //Fields wrapper
        var add_button      = $("#add-repeat-parameter"); //Add button ID

        var x = 1; //initlal text box count
        $(add_button).click(function(e){ //on add input button click
            e.preventDefault();
            if(x < max_fields){ //max input box allowed
                x++; //text box increment


                $(wrapper).append('' +
                    '<div class="repeated form-group">\
                    <div class="col-xs-12 col-md-6">\
                    <div class="form-group">\
                    <label class="control-label"> Name</label>\
                    <input type="text" class="form-control" placeholder="Parameter Title" name="param_name'+x+' required">\
                    </div>\
                    </div>\
                    <div class="col-xs-12 col-md-6">\
                    <div class="form-group">\
                    <label class="control-label"> Description</label>\
                    <input type="text" class="form-control" placeholder="Parameter Description" name="param_des'+x+'">\
                    </div>\
                    </div>\
                    <div class="col-xs-12 col-md-12">\
                    <div class="form-group">\
                    <label class="control-label"> Link</label>\
                    <input type="text" class="form-control" placeholder="Link" name="param_link'+x+'">\
                    </div>\
                    </div>\
                    <input type="hidden" name="param_ids[]" value="'+x+'">\
                    <a class="remove-paramater-fields">Remove</a>\
                    </div>'); //add input box
            }
        });

        $(wrapper).on("click",".remove-paramater-fields", function(e){ //user click on remove text
            var val = $(this).parent('div').children('input').val();
            //var val = $(this).closest("div.linkContainer").find("input[name='mediaVideos[]']").val();
            e.preventDefault(); $(this).parent('div').remove(); x--;
        });



    });
</script>

<!-- MODALS-->
<!-- view projectAttachments-->
<div class="modal fade" id="projectAttachments" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Project's Attachments</h4>
            </div>
            <div class="modal-body">
                <table class="table gap table-striped table-bordered table-hover table-checkable order-column">
                    <thead>
                    <tr class="odd gradeX">
                        <th> Attachment Name </th>
                        <th> Type </th>
                        <th> Description</th>
                    </tr>
                    </thead>
                    <tbody>
                    {%for row in project_attach%}
                    <tr class="odd gradeX">
                        <td> <a href="{{url('uploads/api_files/' ~row.file)}}"> <i class="fa fa-download" aria-hidden="true"></i> {{row.file}} </a> </td>
                        <td> {{row.type}} </td>
                        <td> {{row.des}}</td>
                    </tr>
                    {%endfor%}

                    </tbody>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info">Download All</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
<!-- add projectAttachments-->
<div class="modal fade" id="addprojectAttachments" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Add App Attachments</h4>
            </div>
            <form role="form" action="{{url('api_manager/addAppAttachments')}}" id="" method="post" enctype="multipart/form-data">
                <div class="modal-body clearfix">
                    <div class="portlet-body">
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label">Des</label>
                                <input type="text" class="form-control" name="des">
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label">Type</label>
                                <input type="text" class="form-control" name="type">
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label">File</label>
                                <input type="file" class="form-control" name="file">
                            </div>
                        </div>

                    </div>
                </div>

                <div class="modal-footer">
                    <input type="hidden" name="project_id" value="{{project_id}}">
                    <input data-dismiss="modal" class="btn dark " value="Cancel">
                    <input type="submit" class="btn green-jungle " value="Save">
                </div>

            </form>
        </div>

    </div>
</div>
<!-- view screenAttachments-->
{%for screen in content%}
<div class="modal fade" id="view_screen_att{{screen.id}}" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Project's Attachments</h4>
            </div>
            <div class="modal-body">
                <table class="table gap table-striped table-bordered table-hover table-checkable order-column">
                    <thead>
                    <tr class="odd gradeX">
                        <th> Attachment Name </th>
                        <th> Type </th>
                        <th> Description</th>
                    </tr>
                    </thead>
                    <tbody>
                    {%for row in screen.attach%}
                    <tr class="odd gradeX">
                        <td> <a href="{{url('uploads/api_files/' ~row.file)}}"> <i class="fa fa-download" aria-hidden="true"></i> {{row.file}} </a> </td>
                        <td> {{row.type}} </td>
                        <td> {{row.des}}</td>
                    </tr>
                    {%endfor%}

                    </tbody>
                </table>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info">Download All</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
{%endfor%}
<!-- add screenAttachments-->
{%for screen in content%}
<div class="modal fade" id="add_screen_att{{screen.id}}" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title">Add Screen Attachments</h4>
            </div>
            <form role="form" action="{{url('api_manager/addScreenAttachments')}}" id="" method="post" enctype="multipart/form-data">
                <div class="modal-body clearfix">
                    <div class="portlet-body">
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label">Des</label>
                                <input type="text" class="form-control" name="des">
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label">Type</label>
                                <input type="text" class="form-control" name="type">
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-12">
                            <div class="form-group">
                                <label class="control-label">File</label>
                                <input type="file" class="form-control" name="file">
                            </div>
                        </div>

                    </div>
                </div>

                <div class="modal-footer">
                    <input type="hidden" name="project_id" value="{{project_id}}">
                    <input type="hidden" name="screen_id" value="{{screen.id}}">
                    <input data-dismiss="modal" class="btn dark " value="Cancel">
                    <input type="submit" class="btn green-jungle " value="Save">
                </div>

            </form>
        </div>

    </div>
</div>
{%endfor%}
<!-- screenshots ajax comments-->
{% for screen in content %}
{%for screenshot in screen.Screens%}
<div class="modal fade" tabindex="1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="screenComments{{screenshot.id}}">
<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">Modal title</h4>

        </div>
        <div class="modal-body"><div class="te"></div></div>
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Save changes</button>
        </div>
    </div>
    <!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
{%endfor%}
{%endfor%}

