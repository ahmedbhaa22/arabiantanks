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
                            <label class="col-sm-3 control-label">Enable Continent</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_continents" class="form-control"
                                {% if settings.enable_continents == 1 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Countries</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_countries" class="form-control"
                                {% if settings.enable_countries == 1 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable States</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_states" class="form-control"
                                {% if settings.enable_states == 1 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Cities</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_city" class="form-control"
                                {% if settings.enable_city == 1 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Regions</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_regions" class="form-control"
                                {% if settings.enable_regions == 1 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Streets</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_streets" class="form-control"
                                {% if settings.enable_streets == 1 %}
                                checked 
                                {% endif %}
                                />
                            </div>
                        </div>

                        <hr>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Banner Image</label>
                            <div class="col-sm-9">
                                <input type="file" name="banner_image" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Modal Image</label>
                            <div class="col-sm-9">
                                <input type="file" name="modal_image" class="form-control"/>
                            </div>
                        </div>

                        <hr>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Languages</label>
                            <div class="col-sm-9">
                                <select multiple name="langs[]">
                                    {% for lang in langs %}
                                    <option value="{{lang.id}}"
                                    {% if settings.hasLang(lang.id) %}
                                    selected
                                    {% endif %} 
                                    >{{lang.title}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>


    

                    <a href="{{url('index')}}" class="btn btn-danger">{{ translate._('Cancel') }}</a>
                    <input type="submit" class="btn green-jungle " value="{{ translate._('Update') }}">

                </form>
        
            </div>
        </div>

    </div>
</div>
