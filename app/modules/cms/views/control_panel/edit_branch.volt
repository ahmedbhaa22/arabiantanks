<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class=""
                 style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get()}}img/alarabiatanks.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-tag font-dark"></i>
            <span class="caption-subject bold uppercase"> {{translate._("Edit Branch")}}</span>
        </div>
    </div>
    <div class="portlet-body">
        <div class="row">
            <form role="form" action="{{this.url_shared.get('cms_module/control_panel/save_branch')}}" method="post" enctype="multipart/form-data">

                <div class="col-sm-6">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Name")}}</label>
                        <input type="text" class="form-control" name="branch_name" value="{{branch.name}}">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Address")}}</label>
                        <input type="text" class="form-control" name="branch_address" value="{{branch.address}}">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Phone")}}</label>
                        <input type="text" class="form-control" name="branch_phone" value="{{branch.phone}}">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Latitude")}}</label>
                        <input type="text" class="form-control" name="branch_lat" value="{{branch.lat}}">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Longitude")}}</label>
                        <input type="text" class="form-control" name="branch_long" value="{{branch.long}}">
                    </div>
                </div>
                <div class="col-sm-12">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Mail")}}</label>
                        <input type="text" class="form-control" name="mail" value="{{branch.mail}}">
                    </div>
                </div>
                <div class="col-sm-12">
                    <input type="hidden" value="{{branch.id}}" name="branch_id" />
                    <button class="btn btn-primary" type="submit">{{translate._("Save")}}</button>
                </div>
        </div>
    </div>
</div>