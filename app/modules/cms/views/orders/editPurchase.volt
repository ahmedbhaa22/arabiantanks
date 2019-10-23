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
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Edit"); ?></span>
        </div>

        <div class="actions">
        <a type="button" href="{{url('orders/vieworder/' ~purchase.Orders_ID)}} " data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
            <?php echo $translate->_("Back"); ?>
        </a>
        </div>
    </div>


<div class="portlet-body">
    <div id="sample_1_wrapper">


        <?php
        echo $this->tag->form(
            [
                "orders/savePurchase",
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
                        <label for="fieldTitle" class="col-sm-2"><?php echo $translate->_("Total Cost"); ?></label>
                        <div class="col-sm-10">
                            <?php echo $this->tag->textField(["Cost", "size" => 30, "class" => "form-control", "id" => "fieldCost"]) ?>
                        </div>
                    </div>
                </div>





            </div><!--end col right-->

            <div class="col-md-6 col-xs-12"> <!--col left-->



            </div><!--end col left-->
        </div>


        <?php
        echo $this->tag->hiddenField("ID");
        ?>

        <div class="form-group">
            <div class="col-sm-12 text-center">
                <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-danger"]) ?>
            </div>
        </div>

        <?php echo $this->tag->endForm(); ?>
    </div>
</div>

</div>