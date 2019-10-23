<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["data_forms_response", "Back"]) ?></li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Edit data_forms_response
    </h1>
</div>

<?php echo $this->getContent(); ?>

<?php
    echo $this->tag->form(
        [
            "data_forms_response/save",
            "autocomplete" => "off",
            "class" => "form-horizontal"
        ]
    );
?>

<div class="form-group">
    <label for="fieldFormId" class="col-sm-2 control-label">Form Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Form_ID", "type" => "number", "class" => "form-control", "id" => "fieldFormId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldResponse" class="col-sm-2 control-label">Response</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textArea(["Response", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldResponse"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldIp" class="col-sm-2 control-label">IP</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["IP", "size" => 30, "class" => "form-control", "id" => "fieldIp"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldUserId" class="col-sm-2 control-label">User Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["User_ID", "type" => "number", "class" => "form-control", "id" => "fieldUserId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldDate" class="col-sm-2 control-label">Date</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Date", "size" => 30, "class" => "form-control", "id" => "fieldDate"]) ?>
    </div>
</div>


<?php echo $this->tag->hiddenField("id") ?>

<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
