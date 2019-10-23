<div class="row">


    <div class="col-md-12">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="fa fa-bell" aria-hidden="true"></i>
                    <span class="caption-subject bold uppercase">
                        {{ translate._("Settings") }}
                    </span>
                </div>

            </div>
            <div class="portlet-body">

                <form role="form" action="{{url('manager_settings/update')}}" enctype="multipart/form-data" method="post">


                    <div class="col-md-12 no-pad col-xs-12">

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">DB Type</label>
                            <div class="col-sm-9">
                                <label>Mysql</label>
                                <input type="radio" value="1" name="db_type" class="form-control"
                                {% if settings.db_type == 1 %}
                                checked 
                                {% endif %}
                                />
                                <label>Firebase</label>
                                <input type="radio" value="2" name="db_type" class="form-control"
                                {% if settings.db_type == 2 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Chat Type</label>
                            <div class="col-sm-9">
                                <label>Messages</label>
                                <input type="radio" value="1" name="chat_type" class="form-control"
                                {% if settings.chat_type == 1 %}
                                checked 
                                {% endif %}
                                />
                                <label>7adana</label>
                                <input type="radio" value="2" name="chat_type" class="form-control"
                                {% if settings.chat_type == 2 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Banner Image</label>
                            <div class="col-sm-9">
                                <input type="file" name="banner_image" class="form-control"/>
                            </div>
                        </div>


                    </div>

    

                    <a href="{{url('index')}}" class="btn btn-danger">{{ translate._('Cancel') }}</a>
                    <input type="submit" class="btn green-jungle " value="{{ translate._('Update') }}">

                </form>
        
            </div>
        </div>

    </div>
</div>