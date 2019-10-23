<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="row">
    <nav>
        <ul class="pager">
<!--            <li class="previous">--><?php //echo $this->tag->linkTo(["media", "Go Back"]) ?><!--</li>-->
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Add Media
    </h1>
</div>

<?php echo $this->getContent(); ?>

<?php
echo $this->tag->form(
    [
        "content/createmedia",
        "autocomplete" => "off",
        "class" => "form-horizontal paymentForm",
        "role" => "form",
        "style" => "display:block",
        "enctype" => "multipart/form-data"
    ]
);
?>

<div class="form-group">
    <label for="fieldClientName" class="col-sm-2 control-label">Link</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Link", "size" => 30, "class" => "form-control", "id" => "fieldLink"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldClientNumber" class="col-sm-2 control-label">Img</label>
    <div class="col-sm-10">
        <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg", "required" => "required"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldClientNumber" class="col-sm-2 control-label">Type</label>
    <div class="col-sm-10">
        <?php echo $this->tag->selectStatic(["Type", array("Video" => "فيديو", "Picture" => "صورة"), "class" => "form-control", "id" => "fieldActive"]) ?>
    </div>
</div>
<?php echo $this->tag->hiddenField("ID") ?>
<input type="hidden" id="hiddenID" name="Item_ID" value="<?php echo $hiddenID ?>">
<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
