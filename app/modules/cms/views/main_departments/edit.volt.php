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
            <span class="caption-subject bold uppercase">تعديل قسم رئيسي</span>
        </div>
            <div class="action">

            <a type="button" href="<?= $this->url->get('content/main/') . $Module_ID ?> " data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                السابق
            </a>
            </div>
        </div>
    <div class="portlet-body">
        <div class="row">
            <div class="col-sm-3">
                <title>Language</title>
                <select id="dynamic_select">
                    <option>Choose Language</option>
                    <option value="<?= $this->url->get('main_departments/edit/' . $ID) ?>">Default</option>
                    <?php foreach ($langs as $lang) { ?>
                    <option value="<?= $this->url->get('main_departments/edit/' . $ID) ?>?lang_id=<?= $lang->lang_id ?>"><?= $lang->LangDetails->title ?></option>
                    <?php } ?>
                </select>
            </div>

            <script>
                $(function(){
                    // bind change event to select
                    $('#dynamic_select').on('change', function () {
                        var url = $(this).val(); // get selected value
                        if (url) { // require a URL
                            window.location = url; // redirect
                        }
                        return false;
                    });
                });
            </script>
        </div>
        <p></p>
        <div id="sample_1_wrapper">


            <?php
            if(isset($_GET['lang_id'])){
                $save_url="main_departments/save"."?lang_id=".$_GET['lang_id'];
            }else{
                $save_url="main_departments/save";
            }
            echo $this->tag->form(
                [
                    $save_url,
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
                            <label for="fieldTitle" class="col-sm-2">العنوان</label>
                            <div class="col-sm-10">
                                <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="fieldTitle" class="col-sm-2">الوصف</label>
                            <div class="col-sm-10">
                                <?php echo $this->tag->textField(["Des", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                            </div>
                        </div>
                    </div>





                </div><!--end col right-->

                <div class="col-md-6 col-xs-12"> <!--col left-->

                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <label for="fieldImg" class="col-sm-2">الصوره</label>
                            <div class="col-sm-10">
                                <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg"]) ?>
                            </div>
                        </div>
                    </div>


                </div><!--end col left-->
            </div>


            <?php
            echo $this->tag->hiddenField("ID");
            echo $this->tag->hiddenField("Module_ID");
            echo $this->tag->hiddenField("Target_Layout_ID");
            echo $this->tag->hiddenField("Target_Action_ID");
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


