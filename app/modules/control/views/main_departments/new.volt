<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    tinymce.init({
        selector: '#fieldContent'
    });
    //    tinymce.init({
    //        selector: '#fieldDes'
    //    });
</script>

<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"> {{translate._("Add Main Department")}}</span>
        </div>
        <div class="actions">
            <a type="button" href="{{url('main_departments/index/') ~ Module_ID}} " data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                {{translate._("Back")}}
            </a>
        </div>


    </div>

    <div class="portlet-body">
        <div class="container">
        <div id="sample_1_wrapper">


            <?php
            echo $this->tag->form(
                [
                    "main_departments/create",
                    "autocomplete" => "off",
                    "class" => "form-horizontal paymentForm",
                    "role" => "form",
                    "style" => "display:block",
                    "enctype" => "multipart/form-data",
                    "id" => "form-new-maindept"
                ]
            );
            ?>

            <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
                <div class="col-md-6 col-xs-12"> <!--col right-->
                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <label for="fieldTitle" class="col-sm-2"> {{translate._("Title")}}</label>
                            <div class="col-sm-10">
                                <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="fieldTitle" class="col-sm-2"> {{translate._("Description")}}</label>
                            <div class="col-sm-10">
                                <?php echo $this->tag->textField(["Des", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                            </div>
                        </div>
                    </div>





                </div><!--end col right-->

                <div class="col-md-6 col-xs-12"> <!--col left-->

                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <label for="fieldImg" class="col-sm-2"> {{translate._("Image")}}</label>
                            <div class="col-sm-10">
                                <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImgDept"]) ?>
                            </div>
                        </div>

                    </div>


                </div><!--end col left-->
            </div>


            <?php
            echo $this->tag->hiddenField("ID");
            echo $this->tag->hiddenField(["Module_ID"," value" => $Module_ID]);


            ?>

            <div class="form-group">
                <div class="col-sm-12 text-center">
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-warning"]) ?>
                    <input type="submit" data-dismiss="modal" class="btn dark " value=" {{translate._("Cancel")}}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-12 text-center">

                </div>
            </div>


            <?php echo $this->tag->endForm(); ?>
        </div>
        </div>
    </div>

</div>







