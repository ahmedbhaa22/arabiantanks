<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    tinymce.init({
        selector: '#description'
    });
</script>
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Add Ad"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('index')}}" data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Back"); ?>
            </a>
        </div>

    </div>
    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="row">
            <form method="POST" action="{{url('index/update/') ~ ad.id}}" enctype="multipart/form-data" id="adsForm">
                <div class="col-md-6 col-xs-12">
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("Title"); ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="title" placeholder="<?php echo $translate->_("Title"); ?>" value="{{ ad.title }}" required/>
                            </div>
                        </div>
                    </div>
                
                
                    <!-- <div class="form-group">
                        <div class="col-md-12">
                            <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Module"); ?></label>
                            <div class="col-md-10 col-sm-10" >
                                <select name="module_id" id="module" onchange="fetch_select(this.value)">
                                    <option value=""><?php echo $translate->_("Choose Module"); ?></option>
                                    {% for module in modules %}
                                        <option value="{{module.id}}"
                                        {% if module.id == ad.module_id %}
                                        selected
                                        {% endif %}
                                        >{{module.title}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                    </div> -->

                    {% if settings.enable_section %}
                    <div class="form-group">
                        <div class="col-md-12">
                            <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Section"); ?></label>
                            <div class="col-md-10 col-sm-10" >
                                <select name="module_id" id="module" onchange="fetch_select(this.value)">
                                    <!-- <option value=""><?php echo $translate->_("Choose Section"); ?></option> -->
                                    <option value="">Discover</option>
                                    <option value="">Mega Events</option>
                                    <option value="">Places Categories</option>
                                    <option value="">Events Categories</option>
                                    <option value="">Happening Today</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    {% endif %}

                    {% if settings.enable_is_video %}
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("Is Video?"); ?></label>
                            <div class="col-sm-10">
                                <input type="checkbox" name="is_video" value="1"
                                {% if ad.is_video %}
                                checked
                                {% endif %} 
                                />
                            </div>
                        </div>
                    </div>
                    {% endif %}

                    <div class="form-group" id="ModuleDepts">

                    </div>
                
                    
                </div>

                <div class="col-md-6 col-xs-12">
                    {% if settings.enable_height %}
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("Height"); ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="height" placeholder="<?php echo $translate->_("Height"); ?>" value="{{ ad.height }}" >
                            </div>
                        </div>
                    </div>
                    {% endif %}

                    {% if settings.enable_width %}
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("Width"); ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="width" placeholder="<?php echo $translate->_("Width"); ?>" value="{{ ad.width }}">
                            </div>
                        </div>
                    </div>
                    {% endif %}

                    {% if settings.enable_start_date %}
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("Start Date"); ?></label>
                            <div class="col-sm-10">
                                <input type="text" class="date-picker" name="startdate" placeholder="<?php echo $translate->_("Start Date"); ?>" value="{{ad.startdate}}">
                            </div>
                        </div>
                    </div>
                    {% endif %}

                    {% if settings.enable_end_date %}
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("End Date"); ?></label>
                            <div class="col-sm-10">
                                <input type="text" class="date-picker" name="enddate" placeholder="<?php echo $translate->_("End Date"); ?>" value="{{ad.enddate}}">
                            </div>
                        </div>
                    </div>
                    {% endif %}
                
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("Link"); ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="link" placeholder="<?php echo $translate->_("Link"); ?>" value="{{ ad.link }}" required>
                            </div>
                        </div>
                    </div>
                
                    {% if settings.enable_picture %}
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("Picture"); ?></label>
                            <div class="col-sm-10">
                                <img src="{{ url.getStatic(ad.img) }}" class="img-responsive">
                                <input type="file" name="img">
                                <span id="img_error" class="error" style="display:none;">Image size too large</span>
                            </div>
                        </div>
                    </div>
                    {% endif %}

                    {% if settings.enable_thumbnail %}
                    <div class="form-group">
                        <div class="col-md-12">
                            <label for="fieldTitle" class="col-sm-2 bg-info control-label"><?php echo $translate->_("Thumbnail"); ?></label>
                            <div class="col-sm-10">
                                <img src="{{ url.getStatic(ad.thumbnail) }}" class="img-responsive">
                                <input type="file" name="thumbnail">
                                <span id="thumbnail_error" class="error" style="display:none;">Image size too large</span>
                            </div>
                        </div>
                    </div>
                    {% endif %}
                </div>

                {% if settings.enable_content %}
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldDes" class="col-sm-2 bg-info form-group control-label"><?php echo $translate->_("Content Details"); ?></label>
                        <div class="col-sm-10">
                            <textarea id="description" name="description">{{ ad.des }}</textarea>
                        </div>
                    </div>
                </div>
                {% endif %}

                <div class="col-md-12 col-xs-12">
                    <div class="form-group">                        
                            <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-primary", "value"=>$translate->_("Save")]) ?>
                        
                    </div>
                </div>
            </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    function fetch_select(val)
    {
        $.ajax({
            type: 'post',
            url: main_url+'ads/getDepartmentsAjax',
            data: {
                get_option:val
            },
            success: function (response) {
                document.getElementById("ModuleDepts").innerHTML=response;
            }
        });
    }



        function autocompleteTest() {
            $('#auto_complete_content').autocomplete({
                serviceUrl: main_url+'/ads/getAjaxContentByModule/'+$("#module").val(),
                onSelect: function (suggestion) {
                    //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
                    $('#Content_ID').val(suggestion.data);
                }
            });
        }
    $("#adsForm").on('submit',function (e){
        if($('#auto_complete_content').val()==""){
            $('#Content_ID').val("");
        }
    });



</script>
<style>
    .autocomplete-suggestions { border: 1px solid #999; background: #FFF; overflow: auto; }
    .autocomplete-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; }
    .autocomplete-selected { background: #F0F0F0; }
    .autocomplete-suggestions strong { font-weight: normal; color: #3399FF; }
    .autocomplete-group { padding: 2px 5px; }
    .autocomplete-group strong { display: block; border-bottom: 1px solid #000; }
</style>
