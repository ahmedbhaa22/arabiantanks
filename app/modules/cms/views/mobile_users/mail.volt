<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    tinymce.init({
        selector: '#fieldReplay'
    });;
</script>
<div class="portlet light bordered">
    <div class="row">
<div class="portlet-body" style="display: block;">
    <div id="sample_1_wrapper">


        <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
            <div class="col-md-6 col-xs-12 no-pad" style="padding:0;"> <!--col right-->
                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldTitle" class="col-sm-2 bg-info">{{ translate._("Name") }}</label>
                        <div class="col-sm-10 row-bordered">
                            {{ user.Title}}
                        </div>
                    </div>
                </div>

                <div class="col-md-12 col-xs-12">
                    <div class="form-group">
                        <label for="fieldDes" class="col-sm-2 bg-info">{{ translate._("User Name") }}</label>
                        <div class="col-sm-10">
                            {{ user.User}}
                        </div>
                    </div>
                </div>




            </div><!--end col right-->

            <div class="col-md-6 col-xs-12 no-pad" style="padding:0;"> <!--col left-->



            </div><!--end col left-->
            <div class="clearfix"></div>

        </div>


        <div id="replyForm" class="col-md-12 col-xs-12 nopadding-r nopadding-l">
            <?php
            echo $this->tag->form(
                [
                    "mobile_users/sendmail",
                    "autocomplete" => "off",
                    "class" => "form-horizontal ",
                    "id" => "form_reponse_replay",
                    "role" => "form",
                    "style" => "display:block",
                    "enctype" => "multipart/form-data"
                ]
            );
            ?>
            <div class="form-group col-md-12 col-sm-12">
                <label for="fieldreplay" class="col-sm-2 bg-info">{{ translate._("Message") }}</label>
                <div class="col-sm-10">
                    <?php echo $this->tag->textField(["Message", "size" => 200, "class" => "form-control", "id" => "fieldReplay"]) ?>
                </div>
            </div>
            <div class="form-group col-md-12 col-sm-12">
                <label for="fieldEMail" class="col-sm-2 bg-info">{{ translate._("E-Mail") }}</label>
                <div class="col-sm-10 text-center">
                    <?php echo $this->tag->textField(["EMail", "size" => 30, "class" => "form-control", "id" => "fieldEmail", "value" => $user->Mail]) ?>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-12">
                    <?php echo $this->tag->hiddenField("ID") ?>
                    <?php echo $this->tag->submitButton(["Send", "class" => "btn btn-default"]) ?>
                </div>
            </div>
            <?php echo $this->tag->endForm(); ?>

        </div>

    </div>
</div>
        </div>
    </div>