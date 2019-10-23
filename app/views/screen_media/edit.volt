<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["screen_media", "Back"]) ?></li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Edit screen_media
    </h1>
</div>

<?php echo $this->getContent(); ?>

<?php
    echo $this->tag->form(
        [
            "screen_media/save",
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
    <label for="fieldMedia" class="col-sm-2 control-label">Media</label>
    <div class="col-sm-10">
        <?php echo $this->tag->fileField(["media", "size" => 30, "class" => "form-control", "id" => "fieldMedia"]) ?>
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
    <label for="fieldType" class="col-sm-2 control-label">Type</label>
    <div class="col-sm-10">
        <?php echo $this->tag->selectStatic(["type", ["Img"], "class" => "form-control", "id" => "fieldType"]) ?>
    </div>
</div>


<?php echo $this->tag->hiddenField("id") ?>

<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
