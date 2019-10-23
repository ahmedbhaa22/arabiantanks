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
            <span class="caption-subject bold uppercase">تعديل عضوية</span>
        </div>



    </div>


<div class="portlet-body">
    <div id="sample_1_wrapper">


        <?php
        echo $this->tag->form(
            [
                "cp_users/save",
                "autocomplete" => "off",
                "class" => "form-horizontal paymentForm",
                "role" => "form",
                "style" => "display:block",
                "enctype" => "multipart/form-data"
            ]
        );
        ?>

        <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
            <div class="col-md-6 no-pad col-xs-12"> <!--col right-->
                    <div class="form-group">
                        <label for="fieldTitle" class="col-sm-2">الاسم</label>
                        <div class="col-sm-10">
                            <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle", "value"=>$user->UsersMobile->Title]) ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="fieldTitle" class="col-sm-2">البريد</label>
                        <div class="col-sm-10">
                            <?php echo $this->tag->emailField(["Mail", "size" => 30, "class" => "form-control", "id" => "fieldDes", "value"=>$user->UsersMobile->Mail]) ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="fieldTitle" class="col-sm-2">اسم المستخدم</label>
                        <div class="col-sm-10">
                            <?php echo $this->tag->textField(["User", "size" => 30, "class" => "form-control", "id" => "fieldDes", "value"=>$user->UsersMobile->User,"disabled"=>"disabled"]) ?>
                        </div>
                    </div>
                <div class="form-group">
                    <label for="fieldTitle" class="col-sm-2"> كلمة المرور</label>
                    <div class="col-sm-10">
                        <a href="<?= $this->url_shared->get('user_control/forgetPassPost') ?>?mail=<?= $user->UsersMobile->Mail ?>">ارسال كلمة مرور بديلة</a>
                    </div>
                </div>

            </div><!--end col right-->

            <div class="col-md-6 col-xs-12 no-pad"> <!--col left-->

                <div class="col-md-12 col-xs-12">

                </div>


            </div><!--end col left-->
        </div>
        <?php echo $this->tag->hiddenField("User_ID"); ?>


        <div class="form-group">
            <div class="col-sm-12">
                <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-danger"]) ?>
            </div>
        </div>

        <?php echo $this->tag->endForm(); ?>
    </div>
</div>
</div>

