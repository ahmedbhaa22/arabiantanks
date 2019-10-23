<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    tinymce.init({
        selector: '#fieldContent'
    });
    //    tinymce.init({
    //        selector: '#fieldDes'
    //    });
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
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Content Details"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('content/index/' ~Module_ID)}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Back"); ?>
            </a>
        </div>

    </div>

    <!--tabs-->

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
        <?php
        echo $this->tag->form(
            [
                  "content/create",
//                "content/addbulk",
                "autocomplete" => "off",
                "class" => "form-horizontal paymentForm",
                "role" => "form",
                "style" => "display:block",
                "enctype" => "multipart/form-data",
                "id"=>"newContent",

            ]
        );
        ?>
        <div class="tab-content ">
            <div class="tab-pane active" id="1">
                <div class="portlet-body">
                    <div id="sample_1_wrapper">


                        <div class="col-md-12 col-xs-12 nopadding-r nopadding-l no-pad">
                            <div class="col-md-6 col-xs-12 no-pad"> <!--col right-->
                                <!-- Title -->
                                {% if(settings.Title==1) %}
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="fieldTitle" class="col-sm-2"><?php echo $translate->_("Title"); ?></label>
                                        <div class="col-sm-10">
                                            <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle",]) ?>
                                        </div>
                                    </div>
                                </div>
                                {% endif %}

                                <!-- Des -->
                                {% if(settings.Des==1) %}
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="fieldDes" class="col-sm-2"><?php echo $translate->_("Desc"); ?></label>
                                        <div class="col-sm-10">
                                            <?php echo $this->tag->textField(["Des", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                                        </div>
                                    </div>
                                </div>
                                {% endif %}



                            </div><!--end col right-->

                            <div class="col-md-6 col-xs-12 no-pad"> <!--col left-->
                                <div class="col-md-12 col-xs-12 nopadding-l">
                                    <!-- Order -->
                                    {% if(settings.Order==1) %}
                                    <div class="col-md-6 col-xs-12 nopadding-r">
                                        <div class="form-group">
                                            <label for="fieldOrder" class="col-sm-4"><?php echo $translate->_("Sort Order"); ?></label>
                                            <div class="col-sm-8">
                                                <?php echo $this->tag->textField(["Order", "type" => "number", "class" => "form-control", "id" => "fieldOrder",]) ?>
                                            </div>
                                        </div>
                                    </div>
                                    {% endif %}

                                    <!-- Active -->
                                    {% if(settings.Active==1) %}
                                    <div class="col-md-6 col-xs-12 nopadding-l">
                                        <div class="form-group">
                                            <label for="fieldActive" class="col-sm-5"><?php echo $translate->_("Active"); ?></label>
                                            <div class="col-sm-7">
                                                <?php echo $this->tag->selectStatic(["Active", array("1" => "نعم", "0" => "لا"), "class" => "form-control", "id" => "fieldActive",]) ?>
                                            </div>
                                        </div>
                                    </div>
                                    {% endif %}
                                </div>

                                <!-- Img -->
                                {% if(settings.Img==1) %}
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="fieldImg" class="col-sm-2"><?php echo $translate->_("Main Picture"); ?></label>
                                        <div class="col-sm-10">
                                            <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg",]) ?>
                                        </div>
                                    </div>
                                </div>
                                {% endif %}

                                <!-- Depts -->
                                {% if(settings.Depts==1) %}
                                <div class="col-md-12 col-xs-12">
                                    <div class="form-group">
                                        <label for="fieldActive" class="col-sm-2"><?php echo $translate->_("Departments"); ?></label>
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
                                                        $cats->buildTree(\DataCmsDeptsRel::find([
                                                            "Core_Depts_ID=" . $main_dept->ID
                                                        ]), 0);
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
                                        <label for="fieldContent" class="col-sm-1"><?php echo $translate->_("Content Details"); ?></label>
                                        <div class="col-sm-11">
                                            <?php echo $this->tag->textArea(["Content", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldContent"]) ?>
                                        </div>
                                    </div>
                                </div>
                            {% endif %}

                        </div>


                    </div>
                </div>
            </div>

            <!-- MediaImg -->
            {% if(settings.MediaImg==1) %}
            <div class="tab-pane" id="2">
                <div id="upload">
                    <div class="form-group">

                        <div class="col-md-12">
                            <?php echo $this->tag->fileField(["Media[]", "size" => 30, "class" => "form-control", "id" => "fieldMedia",]) ?>

                        </div>

                </div>
            </div>
        </div>
            {% endif %}

            <!-- Video -->
            {% if(settings.MediaVideo==1) %}
            <div class="tab-pane" id="3">
            <div class="form-group">
                <div class="col-md-12 col-xs-12">
                    <div class="input_fields_wrap add-new">
                        <button class="add_field_button btn btn-edit-my-data dark"><?php echo $translate->_("Add More"); ?></button>
                        <div><input type="text" name="mediaVideos[]" size="30"></div>
                    </div>
                </div>
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
                                    <div class="light text-uppercase"><?php echo $data['KeyValueTitle'] ; ?></div>
								</div>                            
								<div class="col-sm-6">
										<div class="form-group">
										
										<label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Value"); ?></label>
										<div class="col-sm-10">
											<?php echo $data['ControlValue'] ; ?>
										</div>
									</div>
								</div>
 <div class="col-sm-6">
                            <div class="form-group">

                                <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Title"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $data['Title'] ; ?>
                                </div>
                            </div>
</div>
 <div class="col-sm-6">
                            <div class="form-group">

                                <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Desc"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $data['Des'] ; ?>
                                </div>
                            </div>
</div>
 <div class="col-sm-6">
                            <div class="form-group">

                                <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Picture"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $data['Img'] ; ?>
                                </div>
                            </div>
</div>
                            <?php if($data['Add']==1): ?>
                            <input type="hidden" name="kvAddIDs[]" value="<?php echo $data['KV_ID'] ?>"/>
                        <?php endif; ?>
                        <?php endforeach; ?>

                    </div>

                </div>
            </div>
            {% endif %}
            <!-- END OF TAB 4 -->
    </div>

    <div class="col-sm-12">
        <div class="form-group">
            <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default", "value"=>$translate->_("Save") ]) ?>
    <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn btn-default" id="post"/>-->
    <!--        <input type='button' value='Test' class="btn btn-default" id="testpost"/>-->
            <div class="testpost"></div>
        </div>
    </div>

</div>





<!-- End Form -->
<?php echo $this->tag->hiddenField("ID") ?>
<?php echo $this->tag->hiddenField("Module_ID") ?>

    <?php echo $this->tag->endForm(); ?>
<div class="clearfix"></div>
</div>


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
        $("#newContent").validate({
            rules: {
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
                echo $validate_kv->returnEditValidation($data_user->DKV_ID,$data_user->ID);
                unset($validate_kv);
            endforeach;
                endif;
                ?>
                Title: {
                    required: true,
                },
                Content: {
                    required: true,
                },
                Des: {
                    required: true,
                },
            }

        });
    });
</script>


