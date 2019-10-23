<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    tinymce.init({
        selector: '#fieldContent'
    });
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
<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>
<?php


?>
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Edit Content"); ?></span>
        </div>

        <div class="actions">

            <a type="button" href="{{url('content/index/' ~ Module_ID )}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Back"); ?>
            </a>
        </div>

    </div>
    <?php
    echo $this->tag->form(
        [
            "content/save",
            "autocomplete" => "off",
            "class" => "form-horizontal paymentForm validateForm",
            "id" => "validateForm1",
            "role" => "form",
            "style" => "display:block",
            "enctype" => "multipart/form-data"
        ]
    );
    ?>

    <div class="container">
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

            {% if(settings.KvInfo==1) %}
            <li>
                <a href="#4" data-toggle="tab"><?php echo $translate->_("Other Options"); ?></a>
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
                                            <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
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
                                            <?php echo $this->tag->textField(["Des", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                                        </div>
                                    </div>
                                </div>
                                {% endif %}

                                <!-- Img -->
                                {% if(settings.Img==1) %}
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="fieldImg"
                                               class="col-sm-2"><?php echo $translate->_("Main Picture"); ?></label>
                                        <div class="col-sm-10">
                                            <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg"]) ?>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-12 col-xs-12">
                                    <div style="overflow: hidden;height: 300px;margin-bottom: 15px;width: 400px;">
                                        <img src="{{url('uploads/') ~main_pic}} " style="max-height:300px;max-width:400px" />
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
                                <div class="col-md-12 col-xs-12 nopadding-l">
                                    <!-- Order -->
                                    {% if(settings.Order==1) %}
                                    <div class="col-md-6 col-xs-12 nopadding-r">
                                        <div class="form-group">
                                            <label for="fieldOrder"
                                                   class="col-sm-4 "><?php echo $translate->_("Sort Order"); ?></label>
                                            <div class="col-sm-8">
                                                <?php echo $this->tag->textField(["Order", "type" => "number", "class" => "form-control", "id" => "fieldOrder"]) ?>
                                            </div>
                                        </div>
                                    </div>
                                    {% endif %}

                                    <!-- Active -->
                                    {% if(settings.Active==1) %}
                                    <div class="col-md-6 col-xs-12 nopadding-l">
                                        <div class="form-group">
                                            <label for="fieldActive"
                                                   class="col-sm-5 "><?php echo $translate->_("Active"); ?>ا</label>
                                            <div class="col-sm-7">

                                                <?php
                                                if($Active == 1){
                                                    echo Phalcon\Tag::checkField(array("Active", "checked"=>"checked","data-toggle"=>"toggle","data-on"=>"Enabled","data-off"=>"Disabled"));
                                                }else{
                                                    echo Phalcon\Tag::checkField(array("Active", "data-toggle"=>"toggle","data-on"=>"Enabled","data-off"=>"Disabled"));
                                                }

                                                ?>
                                            </div>
                                        </div>
                                    </div>
                                    {% endif %}
                                </div>

                                <!-- Depts -->
                                {% if(settings.Depts==1) %}
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="fieldActive"
                                               class="col-sm-2"><?php echo $translate->_("Departments"); ?></label>
                                        <div class="col-sm-10 dept_tree">
                                            <ul>
                                                <?php
                                                $cats = new \Models\Content();
                                                $main_depts = DataCmsDepts::find(array("Module_ID={$Module_ID}"));
                                                foreach ($main_depts as $main_dept) {
                                                    ?>
                                                    <div>
                                                        <?php
                                                        echo $main_dept->Title
                                                        ?>
                                                    </div>
                                                    <?php
                                                    $cats->buildEditTree(\DataCmsDeptsRel::find([
                                                        "Core_Depts_ID=" . $main_dept->ID
                                                    ]), 0, $cats->getItemDept($ID));
                                                }

                                                ?>
                                            </ul>
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
                                        <?php echo $this->tag->textArea(["Content", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldContent"]) ?>
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
                            <?php echo $this->tag->fileField(["Media[]", "size" => 30, "class" => "form-control", "id" => "ImgEditContent",]) ?>

                        </div>

                    </div>
                </div>

            </div>
            {% endif %}

            <!-- Video -->
            {% if(settings.MediaVideo==1) %}
            <div class="tab-pane" id="3">
                <div class="input_fields_wrap add-new">
                    <button
                        class="add_field_button btn btn-edit-my-data dark"><?php echo $translate->_("Add More"); ?></button>
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
                    <div class="row">
                        <?php

                        $groupname = "";
                        foreach ($keyValueData as $data):
                            if ($groupname !== $data['GroupName']):
                                ?>
                                <div class="kv-group-title"><h2><?php echo $data['GroupName'] ?></h2></div>
                                <?php
                                $groupname = $data['GroupName'];
                            endif;
                            ?>
                            <div class="bg-dark btn-circle text-center" style="padding: 2px ; color: #fff;">
                                <div class="light text-uppercase"><?php echo $data['KeyValueTitle']; ?></div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">

                                    <label for="keyvalue"
                                           class="col-sm-2 control-label"><?php echo $translate->_("Value"); ?></label>
                                    <div class="col-sm-10">
                                        <?php echo $data['ControlValue']; ?>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">

                                    <label for="keyvalue"
                                           class="col-sm-2 control-label"><?php echo $translate->_("Title"); ?></label>
                                    <div class="col-sm-10">
                                        <?php echo $data['Title']; ?>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group">

                                    <label for="keyvalue"
                                           class="col-sm-2 control-label"><?php echo $translate->_("Desc"); ?></label>
                                    <div class="col-sm-10">
                                        <?php echo $data['Des']; ?>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div class="form-group">

                                    <label for="keyvalue"
                                           class="col-sm-2 control-label"><?php echo $translate->_("Picture"); ?></label>
                                    <div class="col-sm-10">
                                        <?php echo $data['Img']; ?>
                                    </div>
                                </div>
                            </div>
                            <?php if ($data['Add'] == 1): ?>
                            <input type="hidden" name="kvAddIDs[]" value="<?php echo $data['KV_ID'] ?>"/>
                        <?php endif; ?>
                        <?php endforeach; ?>

                    </div>

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
            <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default", "value" => $translate->_("Save")]) ?>

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
        $("#validateForm1").validate({
            rules: {
                Title: {
                    required: true
                },
                Des: {
                    required: true
                },
                Order: {
                    number: true,
                },
                //Key Value Validation(Dynamic)
                <?php
                foreach ($none_assigned_kv as $item):
                    $validate_kv = new \Vokuro\Pentavalue\Keyvalue();
                    echo $validate_kv->returnAddValidation($item->ID);
                    unset($validate_kv);
                endforeach;
                ?>
                <?php if (isset($keyvalue_userdata)):?>
                <?php foreach ($keyvalue_userdata as $data_user):
                $validate_kv = new \Vokuro\Pentavalue\Keyvalue();
                echo $validate_kv->returnEditValidation($data_user->DKV_ID, $data_user->ID);
                unset($validate_kv);
            endforeach;
                endif;
                ?>
            }

        });
    });
    $(function() {
        $('#Active').bootstrapToggle({
            on: 'Enabled',
            off: 'Disabled'
        });
    })

</script>

