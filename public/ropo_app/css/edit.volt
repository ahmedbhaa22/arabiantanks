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

<script type="text/javascript">
   
   

    //    tinymce.init({
    //        selector: '#fieldDes'
    //    });
</script>
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

            <a type="button" href="{{url('content/index/' ~ Module_ID )}}" data-toggle="modal"
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
    "class" => "form-horizontal paymentForm validateForm",
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
                                            <label for="fieldTitle"
                                                   class="col-sm-2"><?php echo $translate->_("Title"); ?></label>
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
                                            <label for="fieldDes"
                                                   class="col-sm-2"><?php echo $translate->_("Desc"); ?></label>
                                            <div class="col-sm-10">
                                                <?php echo $this->tag->textField(["Des", "size" => 30, "class" =>
                                                "form-control", "id" => "fieldDes"]) ?>
                                            </div>
                                        </div>
                                    </div>
                                {% endif %}

                                <!-- Img -->
                                {% if(settings.Img==1) %}
                                    <div class="col-md-12 col-xs-12">
                                        <div class="col-md-2 col-sm-4 col-xs-6">
                                            <div class="funkyradio-default">
                                                {{ check_field("NoImg") }}
                                                <label for="Des">No Image</label>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="fieldImg"
                                                   class="col-sm-2"><?php echo $translate->_("Main Picture"); ?></label>
                                            <div class="col-sm-10">
                                                <?php echo $this->tag->fileField(["Img", "size" => 30, "class" =>
                                                "form-control", "id" => "fieldImg"]) ?>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-12 col-xs-12">
                                        <div style="overflow: hidden;height: 300px;margin-bottom: 15px;width: 400px;">
                                            <img src="{{ this.url_shared.get('uploads/') ~main_pic }} "
                                                 style="max-height:300px;max-width:400px"/>
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
                                            <label for="fieldActive"
                                                   class="col-sm-2"><?php echo $translate->_($related_module_title);
                                                ?></label>
                                            <div class="col-sm-2">
                                                <a href="{{ url('content/viewRelatedContent') }}&parent={{ ID }}&child_module={{ moduleRelated }}"
                                                   class="btn btn-transparent btn-info btn-outline btn-circle btn-sm active"><i
                                                            class="fa fa-gift"
                                                            aria-hidden="true"></i><?php echo $translate->_("View Promotions"); ?></a>
                                            </div>
                                            <div class="col-sm-2">
                                                <a href="{{ url('content/new/') ~moduleRelated }}&parent={{ ID }}"
                                                   target="_blank"
                                                   class="btn btn-transparent btn-info btn-outline btn-circle btn-sm active"><i
                                                            class="fa fa-glass"
                                                            aria-hidden="true"></i><?php echo $translate->_("Add Promotion"); ?></a>
                                            </div>
                                        </div>
                                    </div>
                                {%endif%}
                                <!-- Depts -->
                                {% if(settings.Depts==1) %}
                                    <div class="col-md-12 col-xs-12">
                                        <div class="form-group">
                                            <label for="fieldActive"
                                                   class="col-sm-2"><?php //echo $translate->_("Departments");
                                                ?></label>
                                            <div class="col-sm-10 dept_tree">
                                                <ul>
                                                    <?php
                                                $cats = new \Models\Content();
                                                $main_depts = DataCmsDepts::find(array("Module_ID={$Module_ID}"));
                                                foreach ($main_depts as $main_dept) {
                                                    if($main_dept->ID==30){continue;}
                                                    ?>
                                                    <div>
                                                        <?php
                                                        if(isset($_GET['lang_id'])){
                                                            $get_lang=\DataCmsDeptsLang::findFirst("core_dept_id={$main_dept->ID} AND lang_id={$_GET['lang_id']}");
                                                        if(!$get_lang){
                                                        echo $main_dept->Title;
                                                        }else{
                                                        echo $get_lang->title;
                                                        }

                                                        }else{
                                                        echo $main_dept->Title;
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

                                <!-- Special Cases -->
                                {% if(Module_ID==20195 or Module_ID==20196 ) %}
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <div class="kv-group-title"><h2><?php echo $translate->_("Zones"); ?></h2>
                                            </div>
                                            <div class="dept_tree">
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
                                        <label for="fieldContent"
                                               class="col-sm-2"><?php echo $translate->_("Content Details"); ?></label>
                                        <div class="col-sm-10">
                                            <?php echo $this->tag->textArea(["Content", "cols" => 30, "rows" => 4,
                                            "class" => "form-control", "id" => "fieldContent"]) ?>
                                        </div>
                                    </div>
                                </div>
                            {% endif %}
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
                <div class="tab-pane" id="5">
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
                        {{ partial("content/partials/keyvalue/edit_kv", []) }}

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
    $(function () {
        $('#Active').bootstrapToggle({
            on: 'Enabled',
            off: 'Disabled'
        });
    })

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

