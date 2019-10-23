<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Additional Options Default Values"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="<?= $this->url->get('useres_application_module/index/' . $Module_ID) ?>" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Back"); ?>
            </a>
        </div>

    </div>

    <div class="container">
        <div id="sample_1_wrapper">
            <?php
            echo $this->tag->form(
                [
                    "users_application_module/additionalDefaultSave",
                    "autocomplete" => "off",
                    "class" => "form-horizontal paymentForm",
                    "role" => "form",
                    "style" => "display:block",
                    "method"=>"post",
                    "enctype" => "multipart/form-data",
                    "id" => "newContent",

                ]
            );
            ?>
            <div class="row">
                <?php

                $groupname = "";
                foreach ($keyValueData as $data):
                    if ($groupname !== $data['GroupName']):
                        ?>
                        <div class="kv-group-title"><h2><?php echo $data['GroupName'] ?></h2></div>
                        <?php
                        $groupname = $data['GroupName']; ?>

                    <?php endif; ?>
                    <div class="bg-dark btn-circle text-center" style="padding: 2px ; color: #fff;">
                        <div class="light text-uppercase"><?php echo $data['KeyValueTitle']; ?></div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">

                            <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Value"); ?></label>
                            <div class="col-sm-10">
                                <?php echo $data['ControlValue']; ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">

                            <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Title"); ?></label>
                            <div class="col-sm-10">
                                <?php echo $data['Title']; ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">

                            <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Desc"); ?></label>
                            <div class="col-sm-10">
                                <?php echo $data['Des']; ?>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <div class="form-group">

                            <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Show By Default"); ?></label>
                            <div class="col-sm-10">
                                <?php echo $this->tag->selectStatic(["KV".$data['KV_ID'], array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>

                            </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>
                    <?php if ($data['Add'] == 1): ?>
                    <input type="hidden" name="kvAddIDs[]" value="<?php echo $data['KV_ID'] ?>"/>
                <?php endif; ?>
                <?php endforeach; ?>
                <input type="hidden" name="Module_ID" value="<?php echo $Module_ID ?>"/>
            </div>
            <div class="form-group">
                <div class="col-sm-12">
                    <?php echo $this->tag->submitButton(["Search", "class" => "btn btn-default", "value" => $translate->_("Search")]) ?>
                    <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn btn-default" id="post"/>-->
                    <!--        <input type='button' value='Test' class="btn btn-default" id="testpost"/>-->
                    <div class="testpost"></div>
                </div>
            </div>
        </div>
    </div>
</div>
