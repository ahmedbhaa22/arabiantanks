
        <div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="{{url('users_application_module')}}"><?php echo $translate->_("Main Page"); ?></a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <a href="{{url('content/main/') ~module['mod_id']}}">{{module['mod_title']}}</a>
            <i class="icon-arrow-left"></i>
        </li>
        
        <li>
            <a href="{{url('content/index/') ~module['mod_id']}}"><?php echo $translate->_("Content"); ?> </a>
            <i class="icon-arrow-left"></i>
        </li>
        
        <li>
            <a href=""><?php echo $translate->_("New"); ?> </a>
            
        </li>
        
    </ul>
</div>

<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url('{{this.url_shared.get('uploads/modules_pics/') ~module_setting.Content_Edit_Banner}}')  center no-repeat ; background-size: contain;">
        </div>
    </div>
</div>
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">
            	<?php echo $translate->_("Add Content"); ?>: {{module['mod_title']}}  
            	{%if(parent!=0)%}
            	- {{parent_name}}
            	{%endif%}
            	</span>
        </div>
        <div class="actions">
        	{%if(parent==0)%}
            <a type="button" href="{{url('content/productsList')}}" data-toggle="modal"
               class="btn green-jungle btn-outline">
                <?php echo $translate->_("Back"); ?>
            </a>
            {%else%}
            {%endif%}
        </div>
    </div>

    <p><?php echo $this->flashSession->output() ?></p>
    
    <!--tabs-->


        <?php
        echo $this->tag->form(
            [
              "content/create",
//             "content/addbulk",
               "autocomplete" => "off",
               "class" => "form-horizontal paymentForm form_new_content",
               "role" => "form",
               "style" => "display:block",
               "enctype" => "multipart/form-data",
               "id"=>"newContent$Module_ID",
            ]
        );
        ?>
<div class="col-xs-9">
    <!-- Title -->
    {% if(settings.Title==1) %}
    <div class="col-md-12 col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Title"); ?></h2> </div>

            <ul  class="nav nav-tabs">
                <li class="active">
                    <a  href="#title-en" class="small" data-toggle="tab">
                    	{% if(this.session.get('auth-identity')['Application_ID']==593) %}
                	English
                	{%else%}
                	Default 
                	{%endif%}
                    	
                    	</a>
                </li>
                {% for app_lang in app_langs %}
                    <li>
                        <a href="#title_{{ app_lang.lang_id }}" class="small"
                           data-toggle="tab">{{ app_lang.LangDetails.title }}</a>
                    </li>
                {% endfor %}
            </ul>
            <div class="tab-content clearfix">
                <div class="tab-pane active" id="title-en">
                    <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle", "placeholder" => "", "required" => "required"]) ?>
                </div>
                {% for app_lang in app_langs %}
                    <div class="tab-pane" id="title_{{ app_lang.lang_id }}">
                        <?php echo $this->tag->textField(["Title_".$app_lang->lang_id, "size" => 30, "class" =>
                        "form-control", "id" => "fieldTitle", "placeholder" => "", "required" => "required"]) ?>
                    </div>
                {% endfor %}
            </div>

        </div>
    </div>
    {% endif %}

    <!-- Des -->
    {% if(settings.Des==1) %}
    <div class="col-md-12 col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Desc"); ?></h2></div>
            <ul  class="nav nav-tabs">
                <li class="active">
                    <a  href="#desc-en" class="small" data-toggle="tab">
{% if(this.session.get('auth-identity')['Application_ID']==593) %}
                	English
                	{%else%}
                	Default 
                	{%endif%}
                    	
</a>
                </li>
                {% for app_lang in app_langs %}
                    <li>
                        <a href="#desc_{{ app_lang.lang_id }}" class="small"
                           data-toggle="tab">{{ app_lang.LangDetails.title }}</a>
                    </li>
                {% endfor %}
            </ul>
            <div class="tab-content clearfix">
                <div class="tab-pane active" id="desc-en">
                    <?php echo $this->tag->textField(["Des", "size" => 30, "class" => "form-control", "id" => "fieldDes", "required" => "required"]) ?>
                </div>
                {% for app_lang in app_langs %}
                    <div class="tab-pane" id="desc_{{ app_lang.lang_id }}">
                        <?php echo $this->tag->textField(["Des_".$app_lang->lang_id, "size" => 30, "class" =>
                        "form-control", "id" => "fieldDes", "required" => "required"]) ?>
                    </div>
                {% endfor %}
            </div>
        </div>
    </div>
    {% endif %}

    
    <!-- Content -->
    {% if(settings.Content==1) %}
    <div class="col-md-12 col-xs-12">
            <div class="form-group">
                <div class="kv-group-title"><h2><?php echo $translate->_("Content Details"); ?></h2></div>
                <ul  class="nav nav-tabs">
	                <li class="active">
	                    <a  href="#text-en" class="small" data-toggle="tab">
	                    	{% if(this.session.get('auth-identity')['Application_ID']==593) %}
                	English
                	{%else%}
                	Default 
                	{%endif%}
                    	
	                    </a>
	                </li>
                    {% for app_lang in app_langs %}
                        <li>
                            <a href="#content_{{ app_lang.lang_id }}" class="small"
                               data-toggle="tab">{{ app_lang.LangDetails.title }}</a>
                        </li>
                    {% endfor %}
	            </ul>
	            <div class="tab-content clearfix">
	                <div class="tab-pane active" id="text-en">
	                	<?php echo $this->tag->textArea(["Content", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldContent"]) ?>
            		</div>
                    {% for app_lang in app_langs %}
                        <div class="tab-pane" id="content_{{ app_lang.lang_id }}">
                            <?php echo $this->tag->textArea(["Content_".$app_lang->lang_id, "size" => 30, "class" =>
                            "form-control", "id" => "fieldDes"]) ?>
                        </div>
                    {% endfor %}
            	</div>
            </div>
        </div>
    {% endif %}

    <!-- Tags -->
    {% if(module_setting.has_tags==1) %}
    <div class="col-md-12 col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><label
                        for="fieldContent"><?php echo $translate->_("Tags"); ?></label>
                </h2></div>
            <div class="col-sm-12">
                <select multiple data-role="tagsinput" name="tags[]" id="tagsinput">

                </select>

            <!-- <input type="text" value="Amsterdam,Washington,Sydney,Beijing,Cairo" data-role="tagsinput"> -->
            </div>
        </div>
    </div>
    {%endif%}
    <!-- END of Tags -->

    <!-- MediaImg -->
    {% if(settings.MediaImg==1) %}
        <div id="upload">
            <div class="form-group">
                <div class="col-md-12">
                    <div class="kv-group-title"><h2><?php echo $translate->_("Pictures"); ?></h2></div>
                    <?php echo $this->tag->fileField(["Media[]", "size" => 30, "class" => "form-control", "id" => "fieldMedia",]) ?>
                </div>  
            </div>
        </div>
    {% endif %}

    <!-- Video -->
    {% if(settings.MediaVideo==1) %}
    <div class="">
        <div class="form-group">
            <div class="col-md-12 col-xs-12">
                <div class="kv-group-title">
                    <h2><?php echo $translate->_("YouTube Videos"); ?></h2> 

                </div>
                
                <div class="input_fields_wrap add-new">
                    <div class=" col-xs-10"><input type="text" class="form-control" name="mediaVideos[]"></div>

                    <div class="actions">
                        <a class="add_field_button btn btn-default btn-sm">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i> &nbsp; 
                            <?php echo $translate->_("Add More"); ?>
                        </a>
                    </div>
                </div>
                <!-- <button class="add_field_button btn btn-edit-my-data dark gap">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i><?php echo $translate->_("Add More"); ?>
                        
                    </button> -->


            </div>
        </div>
    </div>
    {% endif %}

    <div class="row">
        {% if(module_setting.extra_fields==8) %}
        <div class="col-md-12 col-xs-12">
            <div class="row">
                {%for extra_field in extra_fields%}
                <div class="col-xs-6"> <!-- Start Keyvalue Panel -->
                    <div class="panel panel-info">
                        <div class="panel-heading">{{translate._(extra_field)}}</div>
                        <div class="panel-body">
                            <div class="col-sm-12">
                                {% if extra_field == 'free_shipping' %}
                                <div class="form-group">
                                    <select required="required" name="extra_field_{{extra_field}}" class="form-control">
                                        <option value="0">لا</option>
                                        <option value="1">نعم</option>
                                    </select>
                                </div>
                                {% else %}
                                <div class="form-group">
                                    {{ text_field("extra_field_"~extra_field, "size": 20, "class":"form-control ", "maxlength": 30, "required":"required") }}
                                </div>
                                {% endif %}
                            </div>

                        </div>
                    </div>
                </div>
                {%endfor%}
            </div>
        </div>
        {%endif%}
        </div>

    <!-- KV -->
    {% if(settings.KvInfo==1) %}
    {{ partial("content/partials/keyvalue/new_kv2", ["keyvalues":keyvalues]) }}
    {% endif %}
    <div class="custom_attributes">

    </div>
</div> <!--end main col-xs-8 -->

<div class="col-xs-3 bg-info"> <!-- side bar -->
    <!-- Active -->
    {% if(settings.Active==1) %}
    <div class="col-xs-12 no-padding gap">
        <!-- <div class="form-group">
            <label for="fieldActive" class="col-sm-5"><?php echo $translate->_("Active"); ?></label>
            <div class="col-sm-7">
                <?php echo $this->tag->selectStatic(["Active", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldActive",]) ?>
            </div>
        </div> -->       
       <div class="funkyradio"> 
           <div class="funkyradio-success">
                <input type="checkbox" id="Active" name="Active" value="Y" checked="checked">   
                <label for="Active"><?php echo $translate->_("Active"); ?></label>
            </div> 
        </div>
    </div>
    {% endif %}

    <!-- Img -->
    {% if(settings.Img==1) %}
    <div class="col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Main Picture"); ?></h2></div>
            <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg", "required"=>"required","accept"=>"image/*"]) ?>
        </div>
    </div>
    {% endif %}

    <!-- Depts -->
    {% if(settings.Depts==1) %}
    <?php $main_depts = DataCmsDepts::find(array("Module_ID={$Module_ID}"));?>
    <div class="col-xs-12">
        <div class="form-group">
            {%if(main_depts|length >0)%}
            <div class="kv-group-title"><h2><?php echo $translate->_("Departments"); ?></h2></div>
            <div class="dept_tree">
                <ul>
                    <?php
                    $cats = new \Models\Content();
                    if(count($main_depts)>0){
                        foreach ($main_depts as $main_dept) {
                    if($main_dept->ID==30){continue;}
                            ?>
                            <div>
                                <?php
                                echo $main_dept->getTitleByLang($lang)
                                ?>
                            </div>
                            <?php
                            $cats->buildTree(\DataCmsDeptsRel::find([
                                "Core_Depts_ID=" . $main_dept->ID
                    ]), 0,$lang);
                        }
                    }
                    ?>
                </ul>
            </div>
            {%endif%}
        </div>
    </div>
    {% endif %}
    
    <!-- Special Cases -->
    {% if(this.session.get('auth-identity')['Application_ID']==593) %}
    <div class="col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Zones"); ?></h2></div>
            <div class="dept_tree">
            	   <?php 
            	   echo \Phalcon\Tag::select(array(
    "zones",
    $zones,
    
    "class" => "form-control",
    ));
            	   ?>
            </div>
        </div>
    </div>
    {% endif %}
    {% if(this.session.get('auth-identity')['is_admin']==1) %}
    <div class="col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Sort Order"); ?></h2></div>
            </div>
            <?php echo $this->tag->textField(["Order", "size" => 1, "class" =>
                        "form-control", "id" => "fieldOrder","value"=>"0"]) ?>
     </div>
     <div class="clearfix"></div>
    {%endif%}    
   </div>
    
    
    


    <div class="col-sm-12">
        <div class="form-group">
        	<input type="hidden" name="isParent" value="{{parent}}" />
            <?php echo $this->tag->submitButton(["Save", "class" => "btn green-jungle", "value"=>$translate->_("Save") ]) ?>
    <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn green-jungle" id="post"/>-->
    <!--        <input type='button' value='Test' class="btn green-jungle" id="testpost"/>-->
            <div class="testpost"></div>
        </div>
    </div>

    <?php echo $this->tag->hiddenField("ID") ?>
    <?php echo $this->tag->hiddenField("Module_ID") ?>
    <!-- Is All Languages Are Required ? -->
    {% if(this.session.get('auth-identity')['Application_ID']==593) %}
    <input type="hidden" name="LangsRequired" value="1"/>
    {% else %}
    <input type="hidden" name="LangsRequired" value="0"/>
    {% endif %}
    <!-- END OF  Is All Languages Are Required ? -->

    <?php echo $this->tag->endForm(); ?>

</div>





<!-- End Form -->

<div class="clearfix"></div>



<!--end tabs-->
<hr>
<script>
    // Wait for the DOM to be ready
    $(function() {

        // Initialize form validation on the registration form.
        // It has the name attribute "registration"
        $.validator.setDefaults({
            ignore: []
        });
        $("#newContent{{ Module_ID }}").validate({
            rules: {
               
                Title: {
                    required: true,
                },
                Content: {
                    //required: true,
                },
                Des: {
                    required: true,
                },

            }

        });
    });
</script>

        {{ javascript_include("js/ckeditor/ckeditor.js") }}
        <script>
            CKEDITOR.replace( 'Content' );
            CKEDITOR.replace( 'Content_1' );
        </script>

<!--<script>-->
<!--    (function($) {-->
<!--        $.fn.checkFileType = function(options) {-->
<!--            var defaults = {-->
<!--                allowedExtensions: [],-->
<!--                success: function() {},-->
<!--                error: function() {}-->
<!--            };-->
<!--            options = $.extend(defaults, options);-->
<!---->
<!--            return this.each(function() {-->
<!---->
<!--                $(this).on('change', function() {-->
<!--                    var value = $(this).val(),-->
<!--                        file = value.toLowerCase(),-->
<!--                        extension = file.substring(file.lastIndexOf('.') + 1);-->
<!---->
<!--                    if ($.inArray(extension, options.allowedExtensions) == -1) {-->
<!--                        options.error();-->
<!--                        $(this).focus();-->
<!--                    } else {-->
<!--                        options.success();-->
<!---->
<!--                    }-->
<!---->
<!--                });-->
<!---->
<!--            });-->
<!--        };-->
<!---->
<!--    })(jQuery);-->
<!---->
<!--    $(function() {-->
<!--        $('#fieldImg').checkFileType({-->
<!--            allowedExtensions: ['jpg', 'jpeg'],-->
<!--            success: function() {-->
<!--                alert('Success');-->
<!--            },-->
<!--            error: function() {-->
<!--                alert('Error');-->
<!--            }-->
<!--        });-->
<!---->
<!--    });-->
<!--</script>-->
        <script>
            $('.dept-item').click(function() {
                var value=$(this).attr('value');
                //alert($(this).attr('value'));  //-->this will alert id of checked checkbox.
                 $('#attributes_cat_'+value).html("");
                if(this.checked){
                    $('.custom_attributes').load('{{url("content/attributesView/")}}'+value);
                }
            });
        </script>



        {{ javascript_include("js/bootstrap-tagsinput.js") }}
        {{ stylesheet_link('css/bootstrap-tagsinput.css') }}

        <script>
            $(function() {
                // $('.bootstrap-tagsinput').tagsinput({
                //     confirmKeys: [13, 188]
                // });

                $('.bootstrap-tagsinput input').on('keypress', function(e){
                    if (e.keyCode == 13){
                        e.keyCode = 188;
                        e.preventDefault();
                    };
            });

            });
        </script>