<div class="portlet light bordered">
    <div class="portlet-title">
        <p><?php $this->flashSession->output() ?></p>
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">{{ translate._('KeyValue')}}</span>
        </div>


    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="bar bg-blue-chambray ">
            <ul class="nav nav-tabs">
                {%for group in groups%}
                <li><a data-toggle="tab" href="#{{group.ID}}">{{group.GroupLang.Title}}</a></li>
                {%endfor%}
                <li>

                    <a href="{{url('keyvalue/newGroup/') ~Module_ID}}" data-toggle="modal" data-target="#add-group">
                        <i class="fa fa-plus-circle" aria-hidden="true"></i>{{translate._('Add Group')}}
                    </a>
                </li>
            </ul>
                </div>

            <div class="gap">
            <div class="tab-content clear-fix">
                {%for group in groups%}
                <div id="{{group.ID}}" class="tab-pane fade">
                    <div class="row">
                        <div class="actions">
                            <a href="{{url('keyvalue/editGroup/' ~group.ID)}}" class="btn btn-info btn-xs" data-toggle="modal" data-target="#edit_group{{group.ID}}">Edit Group</a>
                        </div>
                        <div class="actions">
                            <a href="{{url('keyvalue/deleteGroup/' ~group.ID)}}" class="btn btn-info btn-xs deleteKvs" onclick="return confirm('Are you sure?')">Delete Group</a>
                        </div>
                        <div class="clearfix"></div>
                        <div class="modal fade" tabindex="1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="edit_group{{group.ID}}">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                        </div>
                    </div>
                    {%for keyvalue in group.KeyValue%}
                    <div class="col-sm-3 col-xs-12">
                        <div class="panel panel-info">
                            <div class="panel-heading">{{keyvalue.DataKeyvalueLang.Title}}</div>
                            <div class="panel-body">
                                <i class="fa icon-pencil"></i> {{keyvalue.CoreKeyvalueType.Title}}
                            </div>
                            <div class="panel-footer clearfix">
                                <a href="{{url('keyvalue/editKeyvalue/' ~keyvalue.ID)}}" class="btn btn-info btn-xs"  data-toggle="modal" data-target="#edit_kv{{keyvalue.ID}}">
                                    {{translate._("Edit")}} </i>
                                </a>
                                <a href="{{url('keyvalue/deleteKeyvalue/' ~keyvalue.ID)}}" class="btn btn-info btn-xs" onclick="return confirm('Are you sure?')">
                                    {{translate._("Delete")}} </i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- Modal For Ajax Keyvalue Edit -->
                    <div class="modal fade" tabindex="1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="edit_kv{{keyvalue.ID}}">
                        <div class="modal-dialog">
                            <div class="modal-content">

                            </div>
                            <!-- /.modal-content -->
                        </div>
                        <!-- /.modal-dialog -->
                    </div>
                    <!-- END Modal For Ajax Keyvalue Edit -->
                    {%endfor%}
                    <div class="align-middle">
                        <a href="{{url('keyvalue/newKeyvalue/') ~group.ID}}" data-toggle="modal" class="btn btn-info btn-sm" data-target="#add-keyval-group{{group.ID}}"><i class="fa fa-plus-circle" aria-hidden="true"></i> {{translate._("Add More")}} </a>
                    </div>
                    <!-- Modal To Add KeyValue To Current Group -->
                    <div class="add-keyval-group{{group.ID}} modal fade" tabindex="1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="add-keyval-group{{group.ID}}">
                        <div class="modal-dialog ">
                            <div class="modal-content">

                            </div>
                        </div>
                    </div>
                    <!-- END Modal To Add KeyValue To Current Group -->

                   </div>
                {%endfor%}
            </div>
                </div>
            <div class="clearfix"></div>

        </div>
    </div>
</div>

<!-- Modal For Ajax Keyvalue Edit -->
<div class="modal fade" tabindex="1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="add-group">
    <div class="modal-dialog">
        <div class="modal-content">

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- END Modal For Ajax Keyvalue Edit -->


<script>
	$('.modal').on('hidden.bs.modal', function () {
    $('#edit_group{{group.ID}}').html('');


})
</script>