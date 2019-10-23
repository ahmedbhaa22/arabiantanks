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
            <span class="caption-subject bold uppercase">{{ translate._("Add new account")}}</span>
        </div>



    </div>


    <div class="portlet-body">
        <div class="errorMessage"></div>

        <div id="sample_1_wrapper">


            <?php
            echo $this->tag->form(
                [
                    "cp_users/create",
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
                        <label for="fieldTitle" class="col-sm-2">{{ translate._("Name")}}</label>
                        <div class="col-sm-10">
                            <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="fieldTitle" class="col-sm-2">{{ translate._("Password")}}</label>
                        <div class="col-sm-10">
                            <?php echo $this->tag->passwordField(["Pass", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="fieldTitle" class="col-sm-2">{{ translate._("User Name")}}</label>
                        <div class="col-sm-10">
                            <?php echo $this->tag->textField(["User", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="fieldTitle" class="col-sm-2">{{ translate._("E-Mail")}}</label>
                        <div class="col-sm-10">
                            <?php echo $this->tag->emailField(["Email", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                        </div>
                    </div>

                    <div></div>
					 {% if(is_admin==1) %}
                    <div class="col-md-4 col-sm-6 col-xs-8">
                    <div class="funkyradio-default">
                    {{ check_field("super_admin") }}
                    <label for="super_admin">Super Admin</label>
                    </div>
                    </div>
                    {%endif%}


                    {% for rule in rules %}

                        <div class="col-md-4 col-sm-6 col-xs-8">

                            <input type="radio" name="rule" value="{{ rule.id }}">{{ rule.name }}

                        </div>
                        {#<div class="form-group">#}
                        {#<label for="fieldTitle" class="col-sm-2">{{ rule.name }}</label>#}

                        {#<div class="col-sm-10">#}
                        {#<input type="checkbox" value="{{ rule.id }}"/>#}
                        {#</div>#}

                        {#</div>#}
                    {% endfor %}


                </div><!--end col right-->

                <div class="col-md-6 col-xs-12 no-pad"> <!--col left-->

                    <div class="col-md-12 col-xs-12">

                    </div>


                </div><!--end col left-->
            </div>


            <div class="form-group">
                <input type="hidden" name="<?php echo $this->security->getTokenKey() ?>"
                       value="<?php echo $this->security->getToken() ?>"/>
                <div class="col-sm-12">
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-danger",
                    "value"=>$translate->_('Save')]) ?>
                </div>
            </div>

            <?php echo $this->tag->endForm(); ?>
        </div>
    </div>
</div>

