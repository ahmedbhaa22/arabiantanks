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
            <span class="caption-subject bold uppercase">{{ translate._('Edit Item')}}</span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('menus')}} " data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                {{ translate._("Back")}}
            </a>
        </div>
    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">


            <?php
            echo $this->tag->form(
                [
                    "menus/save",
                    "autocomplete" => "off",
                    "class" => "form-horizontal paymentForm",
                    "role" => "form",
                    "style" => "display:block",
                    "enctype" => "multipart/form-data"
                ]
            );
            ?>



            <div class="col-md-12 col-xs-12">

                <!-- Settigns Col Right -->
                <div class="col-md-6 col-xs-12">
                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Title")}}</label>
                            <div class="col-sm-7">
                                <?php echo $this->tag->textField(["name", "class" => "form-control", "id" => "name"]) ?>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Link")}}</label>
                            <div class="col-sm-7">
                                <?php echo $this->tag->textField(["href", "class" => "form-control", "id" => "href"]) ?>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Sort Order")}}</label>
                            <div class="col-sm-7">
                                <?php echo $this->tag->textField(["order", "class" => "form-control", "id" => "order"]) ?>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <label for="fieldToggleGrid" class="col-sm-5 ">{{ translate._("Icon")}}</label>
                            <div class="col-sm-7">
                                <?php echo $this->tag->textField(["icon", "class" => "form-control", "id" => "icon"]) ?>
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

                <!-- END Col Left -->

            </div>
            <?php
            echo $this->tag->hiddenField("id");
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
