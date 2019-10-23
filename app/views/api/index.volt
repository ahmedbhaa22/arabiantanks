<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="page-header">
    <h1>
        Search api
    </h1>
    <p>
        <?php echo $this->tag->linkTo(["api/new", "Create api"]) ?>
    </p>
</div>

<?php echo $this->getContent() ?>

<?php
    echo $this->tag->form(
        [
            "api/search",
            "autocomplete" => "off",
            "class" => "form-horizontal"
        ]
    );
?>

<div class="form-group">
    <label for="fieldId" class="col-sm-2 control-label">Id</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["id", "type" => "number", "class" => "form-control", "id" => "fieldId"]) ?>
    </div>
</div>

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
        <?php echo $this->tag->textField(["project_id", "type" => "number", "class" => "form-control", "id" => "fieldProjectId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldScreenId" class="col-sm-2 control-label">Screen</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["screen_id", "type" => "number", "class" => "form-control", "id" => "fieldScreenId"]) ?>
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
        <?php echo $this->tag->selectStatic(["type_method", [], "class" => "form-control", "id" => "fieldTypeMethod"]) ?>
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
        <?php echo $this->tag->submitButton(["Search", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
