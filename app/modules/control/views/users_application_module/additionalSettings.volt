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
                    "users_application_module/additionalSave",
                    "autocomplete" => "off",
                    "class" => "form-horizontal paymentForm",
                    "role" => "form",
                    "style" => "display:block",
                    "enctype" => "multipart/form-data"
                ]
            );
            ?>
            <p><?php $this->flashSession->output() ?></p>
            <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
                <div class="col-md-6 col-xs-12"> <!--col right-->
                    <?php foreach ($data_kv as $item): ?>
                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <label for="fieldToggleGrid" class="col-sm-5 "><?php echo $item->DataKeyvalueLang->Title ?></label>
                            <div class="col-sm-7">
                                <?php echo $this->tag->selectStatic(["KV{$item->ID}", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>
                            </div>
                            <input type="hidden" value="<?php echo $item->ID ?>" name="ID[]" />
                        </div>

                    </div>
                    <?php endforeach; ?>





                </div><!--end col right-->

                <div class="col-md-6 col-xs-12"> <!--col left-->






                </div><!--end col left-->
            </div>

            <div class="clearfix"></div>

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