<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="{{ url('users_application_module') }}"><?php echo $translate->_("Main Page"); ?></a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <a href="{{ url('content/main/') ~module['mod_id'] }}">{{ module['mod_title'] }}</a>
            <i class="icon-arrow-left"></i>
        </li>

        <li>
            <a href="{{ url('content/index/') ~module['mod_id'] }}"><?php echo $translate->_("Content"); ?> </a>
            <i class="icon-arrow-left"></i>
        </li>

        <li>
            <a href=""><?php echo $translate->_("Edit"); ?> </a>

        </li>

    </ul>
</div>
<script>
    var mediaImages = [
        <?php
        foreach($mediaImages as $Image):

        ?>
        {
            name: "<?php echo $Image->Img ?>",
            url: "<?php echo $this->config->application->baseUri; ?> /uploads/<?php echo $Image->Img ?>",
            file: "<?php echo $this->config->application->baseUri; ?>/uploads/<?php echo $Image->Img ?>",
            type: "image/jpg",
            size: 5453,
            ID: "<?php echo $Image->ID ?>"
        },
        <?php
        endforeach;
        ?>
    ]
</script>
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
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Edit Content"); ?>: {{module['mod_title']}}</span>
        </div>

        <div class="actions">

            <a type="button" href="{{url('content/productsList/')}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Back"); ?>
            </a>
        </div>

    </div>
    <?php
    if(isset($_GET['lang_id'])){
        $save_url="content/save"."?lang_id=".$_GET['lang_id'];
    }else{
        $save_url="content/save";
    }
    echo $this->tag->form(
    [
    $save_url,
    "autocomplete" => "off",
    "class" => "form-horizontal paymentForm validateForm form_new_content",
    "id" => "editContent$Module_ID",
    "role" => "form",
    "style" => "display:block",
    "enctype" => "multipart/form-data"
    ]
    );
    ?>

    <div class="container">
        <div class="row">
            <div class="col-sm-3">
                <title>Language</title>
                <select id="dynamic_select" class="form-control">

                    <option value="{{ url('content/edit/' ~content_id) }}"
                            {% if(lang_id_checked==0) %}selected{% endif %}>
                        {% if(this.session.get('auth-identity')['Application_ID']==593) %}
                            English
                        {% else %}
                            Default Content
                        {% endif %}
                    </option>
                    {% for lang in langs %}
                        <option value="{{ url('content/edit/' ~content_id) }}?lang_id={{ lang.lang_id }}"
                                {% if(lang_id_checked==lang.lang_id) %}selected{% endif %}>{{ lang.LangDetails.title }}</option>
                    {% endfor %}
                </select>
            </div>

            <script>
                $(function(){
                    // bind change event to select
                    $('#dynamic_select').on('change', function () {
                        var url = $(this).val(); // get selected value
                        if (url) { // require a URL
                            window.location = url; // redirect
                        }
                        return false;
                    });
                });
            </script>
        </div>
        <p></p>
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#1" data-toggle="tab"><?php echo $translate->_("Content Details"); ?></a>
            </li>

            <!-- MediaImg -->
            {% if(settings.MediaImg==1) %}
                <li>
                    <a href="#2" data-toggle="tab"><?php echo $translate->_("Media"); ?></a>
                </li>
            {% endif %}

            <!-- MediaVideo -->
            {% if(settings.MediaVideo==1) %}
                <li>
                    <a href="#3" data-toggle="tab"><?php echo $translate->_("Video"); ?></a>
                </li>
            {% endif %}

            {% if(Module_ID==20195) %}
                <li>
                    <a href="#5" data-toggle="tab"><?php echo $translate->_("Menus"); ?></a>
                </li>
            {% endif %}

            {% if(settings.KvInfo==1) %}
                <li>
                    <a href="#4" class="kv_tab" data-toggle="tab"><?php echo $translate->_("Other Options"); ?></a>
                </li>
            {% endif %}

        </ul>
        <div class="row"><p><?php $this->flashSession->output() ?></p></div>
        <div class="tab-content ">
            <div class="tab-pane active" id="1">

                <div class="portlet-body">
                    <div id="sample_1_wrapper">


                        <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
                            <div class="col-md-6 col-xs-12"> <!--col right-->
                                {% if(settings.Title==1) %}
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="kv-group-title"><h2><label
                                                        for="fieldTitle"><?php echo $translate->_("Title"); ?></label>
                                                </h2></div>
                                            <div class="col-sm-10">
                                                <?php echo $this->tag->textField(["Title", "size" => 30, "class" =>
                                                "form-control", "id" => "fieldTitle"]) ?>
                                            </div>
                                        </div>
                                    </div>
                                {% endif %}
                                <!-- Des -->
                                {% if(settings.Des==1) %}
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="kv-group-title"><h2><label
                                                        for="fieldDes"><?php echo $translate->_("Desc"); ?></label></h2>
                                            </div>
                                            <div class="col-sm-12">
                                                <?php echo $this->tag->textField(["Des", "size" => 30, "class" =>
                                                "form-control", "id" => "fieldDes"]) ?>
                                            </div>
                                        </div>
                                    </div>
                                {% endif %}
                                {% if(this.session.get('auth-identity')['is_admin']==1) %}
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="kv-group-title"><h2><label
                                                        for="fieldOrder"><?php echo $translate->_("Sort Order"); ?></label>
                                                </h2></div>
                                            <div class="col-sm-10">
                                                <?php echo $this->tag->textField(["Order", "size" => 30, "class" =>
                                                    "form-control", "id" => "fieldOrder"]) ?>
                                            </div>
                                        </div>
                                    </div>
                                {% endif %}
                                <!-- Img -->
                                {% if(settings.Img==1) %}
                                <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="kv-group-title"><h2><label
                                                        for="fieldImg"><?php echo $translate->_("Main Picture"); ?></label>
                                                </h2></div>
                                            <div class="col-sm-8">
                                                <?php echo $this->tag->fileField(["Img", "size" => 30, "class" =>
                                                "form-control", "id" => "fieldImg","accept"=>"image/*"]) ?>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="funkyradio clearfix">
                                                    <div class="funkyradio-success">
                                                        {{ check_field("NoImg") }}
                                                        <label for="NoImg">No Image</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                    <div class="form-group">
                                        <div style="overflow: hidden;height: 300px;margin-bottom: 15px;width: 400px;">
                                            <img src="{{ this.url_shared.get('uploads/') ~main_pic }} "
                                                 style="max-height:300px;max-width:400px"/>
                                        </div>
                                        </div>
                                    </div>
                                {% endif %}


                                <!--                                <div class="col-md-12 col-xs-12">-->
                                <!--                                    <div class="form-group">-->
                                <!--                                        <label for="fieldDatetime" class="col-sm-2">التاريخ والوقت</label>-->
                                <!--                                        <div class="col-sm-10">-->
                                <!--                                            --><?php //echo $this->tag->hiddenField(["DateTime", "class" => "form-control", "id" => "fieldDatetime"]) ?>
                                <!--                                        </div>-->
                                <!--                                    </div>-->
                                <!--                                </div>-->


                            </div><!--end col right-->

                            <div class="col-md-6 col-xs-12"> <!--col left-->
                                <div class="col-md-12 col-xs-12 nopadding-l"> </div>
                                <!-- If it has child content -->
                                {% if(hasRel==1)%}
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <div class="kv-group-title">
                                                <h2><?php echo $translate->_($related_module_title);
                                                    ?></h2></div>

                                            <a href="{{ url('content/viewRelatedContent') }}&parent={{ ID }}&child_module={{ moduleRelated }}"
                                                   class="btn btn-transparent btn-info btn-outline btn-circle btn-sm active"><i
                                                    class="fa fa-gift"
                                                    aria-hidden="true"></i><?php echo $translate->_("View Promotions"); ?>
                                            </a>
                                                <a href="{{ url('content/new/') ~moduleRelated }}&parent={{ ID }}"
                                                   target="_blank"
                                                   class="btn btn-transparent btn-info btn-outline btn-circle btn-sm active"><i
                                                        class="fa fa-glass"
                                                        aria-hidden="true"></i><?php echo $translate->_("Add Promotion"); ?>
                                                </a>
                                        </div>
                                    </div>
                                {%endif%}
                                <!-- Depts -->
                                {% if(settings.Depts==1) %}
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <!-- <label for="fieldActive"
                                                   class="col-sm-2"><?php //echo $translate->_("Departments");
                                            ?></label> -->
                                            <div class="dept_tree">
                                                <ul>
                                                    <?php
                                                $cats = new \Models\Content();
                                                $main_depts = DataCmsDepts::find(array("Module_ID={$Module_ID}"));
                                                foreach ($main_depts as $main_dept) {
                                                    if($main_dept->ID==30){continue;}
                                                    ?>
                                                    <div>
                                                        <?php

                                                        $get_lang=\DataCmsDeptsLang::findFirst("core_dept_id={$main_dept->ID} AND lang_id={$this->session->get('auth-identity')['Lang_ID']}");
                                                        if(!$get_lang){
                                                        echo $main_dept->Title;
                                                        }else{
                                                        echo $get_lang->title;
                                                        }


                                                        ?>
                                                    </div>
                                                    <?php
                                                     $cats->buildEditTree(\DataCmsDeptsRel::find([
                                                    "Core_Depts_ID=" . $main_dept->ID
                                                    ]), 0, $cats->getItemDept($ID),$lang_id);
                                                    }

                                                    ?>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                {% endif %}

                                <!-- Active -->
                                {% if(settings.Active==1) %}

                                <div class="col-xs-12 col-xs-12">

                                    <div class="funkyradio">
                                        <div class="funkyradio-success">
                                            {{ check_field("Active") }}
                                            <label for="Active"><?php echo $translate->_("Active"); ?></label>
                                        </div>
                                    </div>
                                </div>

                                {% endif %}

                                <div class="col-xs-12 col-xs-12">

                                    <div class="funkyradio">
                                        <div class="funkyradio-success">
                                            {{ check_field("most_selling") }}
                                            <label for="most_selling"><?php echo $translate->_("Most Selling"); ?></label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Special Cases -->
                                {% if(Module_ID==20195 or Module_ID==20196 ) %}
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <div class="kv-group-title"><h2><?php echo $translate->_("Zones"); ?></h2>
                                            </div>
                                            <div class="">
                                                <?php
            	   echo \Phalcon\Tag::select(array(
    "zones",
    $zones,

                       "class"=>"form-control"
                                                ));
                                                ?>
                                            </div>
                                        </div>
                                    </div>
                                {% endif %}



                            </div><!--end col left-->

                            <!-- Content -->
                            {% if(settings.Content==1) %}
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <div class="kv-group-title"><h2><label
                                                    for="fieldContent"><?php echo $translate->_("Content Details"); ?></label>
                                            </h2></div>
                                        <div class="col-sm-12">
                                            <?php echo $this->tag->textArea(["Content", "cols" => 30, "rows" => 4,
                                            "class" => "form-control", "id" => "fieldContent"]) ?>
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
                                        <select multiple data-role="tagsinput" name="tags[]">
                                            {%for tag in assigned_tags%}
                                            <option value="{{tag}}">{{tag}}</option>
                                            {%endfor%}
                                        </select>

                                    </div>
                                </div>
                            </div>
                            {%endif%}
                            <!-- END of Tags -->

                            {% if(module_setting.extra_fields==8) %}
                            <div class="col-md-12 col-xs-12">
                                <div class="row">
                                    {%for extra_field in extra_fields%}
                                    <div class="col-xs-6"> <!-- Start Keyvalue Panel -->
                                        <div class="panel panel-info">
                                            <div class="panel-heading">{{translate._(extra_field)}}</div>
                                            <div class="panel-body">
                                                <div class="col-sm-12">
                                                    <div class="form-group">
                                                        {{ text_field("extra_field_"~extra_field, "size": 20, "class":"form-control ", "maxlength": 30) }}

                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    {%endfor%}
                                </div>
                            </div>
                            {%endif%}
                        </div>


                        <?php echo $this->tag->hiddenField("ID") ?>
                    </div>
                </div>
            </div>

            <!-- MediaImg -->
            {% if(settings.MediaImg==1) %}
                <div class="tab-pane" id="2">

                    <div id="upload">
                        <div class="form-group">

                            <div class="col-sm-12">
                                <?php echo $this->tag->fileField(["Media[]", "size" => 30, "class" => "form-control",
                                "id" => "ImgEditContent",]) ?>

                            </div>

                        </div>
                    </div>

                </div>
            {% endif %}


            {% if(Module_ID==20195) %}
                <div class="tab-pane" id="5"> {{ partial("content/partials/placesMenusEdit", ['mediaMenus': mediaMenus]) }}
                    {{ partial("content/partials/placesMenusEdit", ['mediaMenus': mediaMenus]) }}
                </div>
            {% endif %}

            <!-- Video -->
            {% if(settings.MediaVideo==1) %}
                <div class="tab-pane" id="3">
                    <div class="input_fields_wrap add-new">
                        <button
                                class="add_field_button btn btn-edit-my-data dark"><?php echo $translate->_("Add More");
                            ?>
                        </button>
                        <?php foreach ($videos as $video):

                        ?>
                        <div class="linkContainer"><input class="contentMediaVideos" type="text" name="mediaVideos[]"
                                                          size="30"
                                                          value="<?php echo $video->Link ?>" disabled/><a href="#"
                                                                                                          class="remove_field">Remove</a>
                        </div>

                        <?php

                    endforeach; ?>
                    </div>

                </div>
            {% endif %}

            <!-- KV -->
            {% if(settings.KvInfo==1) %}
                <div class="tab-pane" id="4">
                    <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
                        {{ partial("content/partials/keyvalue/new_kv2", ['keyvalues': keyvalues]) }}
                        {{ partial("content/partials/keyvalue/new_kv2", ['keyvalues': attributes]) }}

                    </div>
                </div>
            {% endif %}
            <!-- END OF TAB 4 -->


        </div>
        <div class="form-group">
            <div id="deletedMedia"></div>
            <div id="newContent"></div>
            <div id="deletedMediaVideo"></div>

        </div>


    </div>
    <div class="col-sm-12">
        <div class="form-group">

            <input type="hidden" name="Module_ID" value="<?php echo $Module_ID ?>"/>
            <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-primary", "value" => $translate->_("Save")]) ?>

        </div>
    </div>
    <?php echo $this->tag->endForm(); ?>
    <div class="clearfix"></div>

</div>

<style>
    .keyvalue-options-wrapper h3 {
        direction: rtl;
    }
</style>


<script>
    // Wait for the DOM to be ready
    $(function () {

        // Initialize form validation on the registration form.
        // It has the name attribute "registration"
        $("#editContent{{ Module_ID }}").validate({
            rules: {
                Title: {
                    required: true
                },
                Des: {
                    required: true
                },

                //Key Value Validation(Dynamic)

            }

        });
    });


</script>

<script>
    $(document).ready(function () {
        $.validator.addMethod("kvCheck232[]", function (value, elem, param) {
            if ($(".kvCheck232[]:checkbox:checked").length > 0) {
                return true;
            } else {
                alert("Error");
                return false;
            }
        }, "You must select at least one!");
    });

</script>

{{ javascript_include("js/ckeditor/ckeditor.js") }}
<script>
    CKEDITOR.replace( 'Content' );
    <?php
    if(isset($_GET['lang_id']) && $_GET['lang_id']==1 ){
       echo " CKEDITOR.replace( 'Content_1' );";
    }
    ?>
   // CKEDITOR.replace( 'Content_1' );
</script>

{{ javascript_include("js/bootstrap-tagsinput.js") }}
{{ stylesheet_link('css/bootstrap-tagsinput.css') }}



<script>
    $(function() {
        $('.bootstrap-tagsinput').tagsinput({
            confirmKeys: [13, 188]
        });

        $('.bootstrap-tagsinput input').on('keypress', function(e){
            if (e.keyCode == 13){
                e.keyCode = 188;
                e.preventDefault();
            };
        });

    });
</script>