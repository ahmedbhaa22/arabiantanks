<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["api", "Go Back"]) ?></li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Create api
    </h1>
</div>

<?php echo $this->getContent(); ?>

<?php
    echo $this->tag->form(
        [
            "api/create",
            "autocomplete" => "off",
            "class" => "form-horizontal"
        ]
    );
?>

<div class="form-group">
    <label for="fieldTitle" class="col-sm-2 control-label">Title</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldDes" class="col-sm-2 control-label">Des</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["des", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldProjectId" class="col-sm-2 control-label">Project</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["project_id", "type" => "number", "class" => "form-control", "id" => "fieldProjectId","value"=>$app_id]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldScreenId" class="col-sm-2 control-label">Screen</label>
    <div class="col-sm-10">
        <?php echo Phalcon\Tag::select([
            "screen",
            \Screen::find(["project_id={$app_id}"]),
            "using" => ["id", "title"] ]);
        ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldSuccessResponse" class="col-sm-2 control-label">Success Of Response</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textArea(["success_response", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldSuccessResponse"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldFailResponse" class="col-sm-2 control-label">Fail Of Response</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textArea(["fail_response", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldFailResponse"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldEmptyResponse" class="col-sm-2 control-label">Empty Of Response</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textArea(["empty_response", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldEmptyResponse"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldTypeMethod" class="col-sm-2 control-label">Type Of Method</label>
    <div class="col-sm-10">
        <?php echo $this->tag->selectStatic(["type_method", ["POST","GET","REQUEST"], "class" => "form-control", "id" => "fieldTypeMethod"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldApiLink" class="col-sm-2 control-label">Api Of Link</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textArea(["api_link", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldApiLink"]) ?>
    </div>
</div>


<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
