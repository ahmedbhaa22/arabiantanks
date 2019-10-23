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
        <p><?php $this->flashSession->output() ?></p>
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">تعديل خيارات الموديول</span>
        </div>

        <div class="actions">
        <a type="button" href="{{url('users_application_module/index/')}} " data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
            {{ translate._("Back")}}
        </a>
        </div>
    </div>


<div class="portlet-body">
    <div id="sample_1_wrapper">


        <?php
        echo $this->tag->form(
            [
                "users_application_module/settingssave",
                "autocomplete" => "off",
                "class" => "form-horizontal paymentForm",
                "role" => "form",
                "style" => "display:block",
                "enctype" => "multipart/form-data"
            ]
        );
        ?>

        <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
            <div class="col-md-6 col-xs-12"> <!--col right-->
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Active Gallery Content")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["Toggle_Grid", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>





            </div><!--end col right-->

            <div class="col-md-6 col-xs-12"> <!--col left-->



                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Orders Module")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["Has_Orders", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>
                </div>


            </div><!--end col left-->
        </div>

        <div class="clearfix"></div>


        <div class="col-md-12 col-xs-12">
            <div class="row"><h3>{{ translate._("Content Settings")}}</h3></div>
            <!-- Settigns Col Right -->
            <div class="col-md-6 col-xs-12">
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Title")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["Title", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Desc")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["Des", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Content Details")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->select(["Content", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Sort Order")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["Order", array("1" => $translate->_("Yes"), "0" => $translate->_("NO")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Main Picture")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["Img", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
<!--                <div class="col-md-12 col-xs-12">-->
<!--                    <div class="form-group">-->
<!--                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Visitors Number")}}</label>-->
<!--                        <div class="col-sm-7">-->
<!--                            --><?php //echo $this->tag->selectStatic(["VisitNum", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
<!--                        </div>-->
<!--                    </div>-->
<!---->
<!--                </div>-->

            </div>
            <!-- END Col Right -->

            <!-- Settigns Col Left -->
            <div class="col-md-6 col-xs-12">
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Date")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["DateTime", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Active")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["Active", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Departments")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["Depts", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Media")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["MediaImg", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Video")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["MediaVideo", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Other Options")}}</label>
                        <div class="col-sm-7">
                            <?php echo $this->tag->selectStatic(["KvInfo", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                        </div>
                    </div>

                </div>
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Content Has Child Content?")}}</label>
                        <div class="col-sm-7">
                            <?php
                            echo $this->tag->select(
				    [
				        "RelatedModule",
				        $ModulesList,
				        "using"      => [
				            "ID",
				            "Title",
				        ],
				        "useEmpty"   => true,
				        "emptyText"  => "No Child",
				        "emptyValue" => "0",
				    ]); 
							?>
                        </div>
                    </div>

                </div>

            </div>
            <!-- END Col Left -->

        </div>
        <?php
        echo $this->tag->hiddenField("ID");
        ?>
        <?php
        echo $this->tag->hiddenField("Module_ID");
        ?>

        <div class="form-group">
            <div class="col-sm-12 text-center">
                <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
            </div>
        </div>

        <?php echo $this->tag->endForm(); ?>
    </div>
</div>
</div>
