<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="page-header">
    <h1>
        Search screen_media
    </h1>
    <p>
        <?php echo $this->tag->linkTo(["screen_media/new", "Create screen_media"]) ?>
    </p>
</div>

<?php echo $this->getContent() ?>

<?php
    echo $this->tag->form(
        [
            "screen_media/search",
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
    <label for="fieldMedia" class="col-sm-2 control-label">Media</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["media", "size" => 30, "class" => "form-control", "id" => "fieldMedia"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldScreenId" class="col-sm-2 control-label">Screen</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["screen_id", "type" => "number", "class" => "form-control", "id" => "fieldScreenId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldType" class="col-sm-2 control-label">Type</label>
    <div class="col-sm-10">
        <?php echo $this->tag->selectStatic(["type", [], "class" => "form-control", "id" => "fieldType"]) ?>
    </div>
</div>


<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Search", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
