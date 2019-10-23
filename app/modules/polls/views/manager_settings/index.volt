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
                                <input type="radio" value="0" name="use_fb" class="form-control"
                                {% if settings.use_fb == 0 %}
                                checked 
                                {% endif %}
                                />
                                <label>Firebase</label>
                                <input type="radio" value="1" name="use_fb" class="form-control"
                                {% if settings.use_fb == 1 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Firebase URL</label>
                            <div class="col-sm-9">
                                <input type="text" name="fb_url" class="form-control"
                                {% if settings.fb_url %}
                                value="{{settings.fb_url}}"
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Firebase Token</label>
                            <div class="col-sm-9">
                                <input type="text" name="fb_token" class="form-control"
                                {% if settings.fb_token %}
                                value="{{settings.fb_token}}"
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Firebase Api Key</label>
                            <div class="col-sm-9">
                                <input type="text" name="fb_api_key" class="form-control"
                                {% if settings.fb_api_key %}
                                value="{{settings.fb_api_key}}"
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Firebase Database Url</label>
                            <div class="col-sm-9">
                                <input type="text" name="fb_db_url" class="form-control"
                                {% if settings.fb_db_url %}
                                value="{{settings.fb_db_url}}"
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Firebase Storage</label>
                            <div class="col-sm-9">
                                <input type="text" name="fb_storage" class="form-control"
                                {% if settings.fb_storage %}
                                value="{{settings.fb_storage}}"
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Firebase Bucker Name</label>
                            <div class="col-sm-9">
                                <input type="text" name="fb_bucket_name" class="form-control"
                                {% if settings.fb_bucket_name %}
                                value="{{settings.fb_bucket_name}}"
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Firebase Project ID</label>
                            <div class="col-sm-9">
                                <input type="text" name="fb_project_id" class="form-control"
                                {% if settings.fb_project_id %}
                                value="{{settings.fb_project_id}}"
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Firebase Service Key</label>
                            <div class="col-sm-9">
                                <input type="text" name="fb_service_key" class="form-control"
                                {% if settings.fb_service_key %}
                                value="{{settings.fb_service_key}}"
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