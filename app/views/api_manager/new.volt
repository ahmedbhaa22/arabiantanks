<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<?php
use Phalcon\Tag;
use Phalcon\Escaper;
use Phalcon\Mvc\Url;

$url = new Url();
$e = new Escaper();
?>


<div class="portlet light bordered">

    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"> <?php echo $translate->_("APIs Manager"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('api_manager/new/')}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("API ADD"); ?>
            </a>

        </div>

    </div>
    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <p><?php $this->flashSession->output() ?></p>

            <div class="clearfix"></div>

            <div class="row">
                <?php
                echo $this->tag->form(
                    [
                        "api_manager/create",
                        "autocomplete" => "off",
                        "class" => "form-horizontal",
                        "enctype" => "multipart/form-data",
                    ]
                );
                ?>

                <div class="form-group">
                    <label for="fieldTitle" class="col-sm-2 control-label">Title</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["title", "size" => 30, "class" => "form-control", "id" => "fieldTitle","required"=>"required"]) ?>
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldDes" class="col-sm-2 control-label">Des</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["des", "size" => 30, "class" => "form-control", "id" => "fieldDes" ,"required"=>"required"]) ?>
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldProjectId" class="col-sm-2 control-label">Project</label>
                    <div class="col-sm-10">
                        <?php echo Phalcon\Tag::select([
                            "project_id",
                            Vokuro\Models\Projects::find(),
                            "using" => ["id", "name"] ]);
                        ?>                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldScreenTitle" class="col-sm-2 control-label">Screen Title</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["screen_title", "type" => "number", "class" => "form-control", "id" => "fieldProjectId","required"=>"required"]) ?>

                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldScreenDes" class="col-sm-2 control-label">Screen Des</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["screen_des", "type" => "number", "class" => "form-control", "id" => "fieldProjectId","required"=>"required"]) ?>

                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldupload" class="col-sm-2 control-label">Screen Shots</label>
                    <div class="col-sm-10">
                        <div class="input_fields_wrap_api add-new_api">
                            <button class="add_field_button_api btn btn-edit-my-data dark"><?php echo $translate->_("Add More"); ?></button>
                            <div><input type="file" name="mediaVideos[]" size="30"></div>
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label for="fieldSuccessResponse" class="col-sm-2 control-label">Success Of Response</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textArea(["success_response", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldSuccessResponse","required"=>"required"]) ?>
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldFailResponse" class="col-sm-2 control-label">Fail Of Response</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textArea(["fail_response", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldFailResponse","required"=>"required"]) ?>
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldEmptyResponse" class="col-sm-2 control-label">Empty Of Response</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textArea(["empty_response", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldEmptyResponse","required"=>"required"]) ?>
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldTypeMethod" class="col-sm-2 control-label">Type Of Method</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->selectStatic(["type_method", ["POST","GET","REQUEST"], "class" => "form-control", "id" => "fieldTypeMethod","required"=>"required"]) ?>
                    </div>
                </div>

                <div class="form-group">
                    <label for="fieldApiLink" class="col-sm-2 control-label">Api Of Link</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textArea(["api_link", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldApiLink","required"=>"required"]) ?>
                    </div>
                </div>


                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
                    </div>
                </div>

                <?php echo $this->tag->endForm(); ?>

            </div>

        </div>
    </div>
    <style>
        .contentImg {
            height: 100px;
            width: 100px;
        }
    </style>
</div>

<style>
    #sample_1 tfoot th.filter input{
        width:100px;
        height:25px;
    }
</style>

<!------ End OF List ------->

<script type="text/javascript">
    $( document ).ready(function() {
        $('#date_from').datepicker({
            format: "yyyy-mm-dd"
        });
        $('#date_to').datepicker({
            format: "yyyy-mm-dd"
        });
    });



</script>

{{ javascript_include("js/dynamic_api_upload.js") }}










