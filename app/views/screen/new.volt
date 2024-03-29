<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["screen", "Go Back"]) ?></li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Create screen
    </h1>
</div>

<?php echo $this->getContent(); ?>

<?php
    echo $this->tag->form(
        [
            "screen/create",
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
        <?php echo $this->tag->textField(["project_id", "type" => "number", "class" => "form-control", "id" => "fieldProjectId"]) ?>
    </div>
</div>


<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
