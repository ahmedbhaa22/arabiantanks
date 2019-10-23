<div class="portlet light" xmlns="http://www.w3.org/1999/html">
    <div class="portlet-title">
        <div class="caption font-dark">
                            <span class="caption-subject bold uppercase">
                                Insert Action
                          </span>
        </div>
    </div>
    <div class="portlet-body clearfix">
        <div class="row" >
            <form action="{{url('application_api/action_create')}}" method="post" />
            <div class="form-group col-sm-6">
                <label>Action name</label>
                <input type="text" class="form-control" name="name" required>
            </div>
            <div class="form-group col-sm-6">
                <label>Action</label>
                <select class="form-control" name="main_action">
                    {%for main_action in main_actions%}
                    <option value="{{main_action.id}}">{{main_action.name}}</option>
                    {%endfor%}
                </select>
            </div>
            <div class="col-xs-12">
                <button class="btn btn-sm btn-info" ><i class="fa fa-file" aria-hidden="true"></i> save</button>
            </div>
            </form>
        </div>
    </div>
</div>
