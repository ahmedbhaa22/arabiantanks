<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    tinymce.init({
        selector: '#fieldContent'
    });

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
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Add") ?> </span>
        </div>

        <div class="actions">
            <?php echo $this->tag->linkTo(["departments", $translate->_("Back")]) ?>
        </div>

    </div>
    <div class="portlet-body">
        <div id="sample_1_wrapper">


            <?php
            echo $this->tag->form(
                [
                    "departments/create",
                    "autocomplete" => "off",
                    "class" => "form-horizontal paymentForm",
                    "role" => "form",
                    "style" => "display:block",
                    "enctype" => "multipart/form-data"
                ]
            );
            ?>
            <div class="col-md-6 col-xs-12">
                <div class="form-group">
                    <label for="fieldTitle" class="col-sm-2 control-label"><?php echo $translate->_("Title") ?></label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xs-12">
                <div class="form-group">
                    <label for="fieldContent" class="col-sm-2 control-label"><?php echo $translate->_("Desc") ?></label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textArea(["Des", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldDes"]) ?>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xs-12">
                <div class="form-group">
                    <label for="fieldImg" class="col-sm-2 control-label"><?php echo $translate->_("Main Picture") ?></label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg"]) ?>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xs-12">
                <div class="form-group">
                    <label for="fieldActive" class="col-sm-2 control-label"><?php echo $translate->_("Title") ?></label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->selectStatic(["Active", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldActive"]) ?>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xs-12">
                <div class="form-group">
                    <label for="fieldContent" class="col-sm-2 control-label"><?php echo $translate->_("Sort Order") ?></label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["Orders", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldOrders"]) ?>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xs-12">
                <div class="form-group">
                    <label for="fieldOrder" class="col-sm-2 control-label"><?php echo $translate->_("Main Department") ?></label>
                    <div class="col-sm-10">
                        <?php echo Phalcon\Tag::select([
                            "Core_Depts_ID",
                            \DataCmsDepts::find(),
                            "using" => ["ID", "Title"] ]);
                        ?>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xs-12">
                <div class="form-group">
                    <label for="fieldOrder" class="col-sm-2 control-label"><?php echo $translate->_("Parent Department") ?></label>
                    <div class="col-sm-10">
                        <span><?php echo $translate->_("Yes") ?></span>
                        <?php
                        echo Phalcon\Tag::radioField(array("Has_Parent", "value" => "yes")); ?>
                        <span><?php echo $translate->_("No") ?></span>
                        <?php
                        echo Phalcon\Tag::radioField(array("Has_Parent", "value" => "no"))
                        ?>
                        <div class=row">
                            <?php echo Phalcon\Tag::select([
                                "Parent_Depts_ID",
                                \DataCmsDeptsRel::find(),
                                "using" => ["ID", "Title"] ]);
                            ?>
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xs-12">
                <div class="form-group">
                    <label for="fieldOrder" class="col-sm-2 control-label"><?php echo $translate->_("Subject To Maintenance") ?></label>
                    <div class="col-sm-10">
                        <span><?php echo $translate->_("Yes") ?></span>
                        <?php
                        echo Phalcon\Tag::radioField(array("maintenance", "value" => "yes")); ?>
                        <span><?php echo $translate->_("No") ?></span>
                        <?php
                        echo Phalcon\Tag::radioField(array("maintenance", "value" => "no"))
                        ?>


                    </div>
                </div>
            </div>


            <?php echo $this->tag->hiddenField("ID") ?>
            <?php echo $this->tag->hiddenField("Application_ID") ?>
            <?php echo $this->tag->hiddenField("Module_ID") ?>
            <?php echo $this->tag->hiddenField("Lang_ID") ?>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
                </div>
            </div>

            <?php echo $this->tag->endForm(); ?>
        </div>
    </div>
</div>
