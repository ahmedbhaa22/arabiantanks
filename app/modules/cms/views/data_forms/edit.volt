<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["data_forms", "Back"]) ?></li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Edit data_forms
    </h1>
</div>

<?php echo $this->getContent(); ?>

<?php
    echo $this->tag->form(
        [
            "data_forms/save",
            "autocomplete" => "off",
            "class" => "form-horizontal"
        ]
    );
?>

<div class="form-group">
    <label for="fieldApplicationId" class="col-sm-2 control-label">Application Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Application_ID", "type" => "number", "class" => "form-control", "id" => "fieldApplicationId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldType" class="col-sm-2 control-label">Type</label>
    <div class="col-sm-10">
        <?php echo $this->tag->selectStatic(["Type", [], "class" => "form-control", "id" => "fieldType"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldModuleId" class="col-sm-2 control-label">Module Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Module_ID", "type" => "number", "class" => "form-control", "id" => "fieldModuleId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldTargetModuleId" class="col-sm-2 control-label">Target Of Module Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Target_Module_ID", "type" => "number", "class" => "form-control", "id" => "fieldTargetModuleId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldTargetActionId" class="col-sm-2 control-label">Target Of Action Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Target_Action_ID", "type" => "number", "class" => "form-control", "id" => "fieldTargetActionId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldTargetLayoutId" class="col-sm-2 control-label">Target Of Layout Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Target_Layout_ID", "type" => "number", "class" => "form-control", "id" => "fieldTargetLayoutId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldLogin" class="col-sm-2 control-label">Login</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Login", "type" => "number", "class" => "form-control", "id" => "fieldLogin"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldApi" class="col-sm-2 control-label">Api</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Api", "size" => 30, "class" => "form-control", "id" => "fieldApi"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldNotifications" class="col-sm-2 control-label">Notifications</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Notifications", "type" => "number", "class" => "form-control", "id" => "fieldNotifications"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldSeeResponses" class="col-sm-2 control-label">See Of Responses</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["See_Responses", "type" => "number", "class" => "form-control", "id" => "fieldSeeResponses"]) ?>
    </div>
</div>


<?php echo $this->tag->hiddenField("id") ?>

<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
