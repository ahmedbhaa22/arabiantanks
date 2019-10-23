<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["users_application_module", "Back"]) ?></li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>
        Edit users_application_module
    </h1>
</div>

<?php echo $this->getContent(); ?>

<?php
    echo $this->tag->form(
        [
            "users_application_module/save",
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
    <label for="fieldPackageId" class="col-sm-2 control-label">Package Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Package_ID", "type" => "number", "class" => "form-control", "id" => "fieldPackageId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldOrginalId" class="col-sm-2 control-label">Orginal Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Orginal_ID", "type" => "number", "class" => "form-control", "id" => "fieldOrginalId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldCopyModuleId" class="col-sm-2 control-label">Copy Of Module Of ID</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Copy_Module_ID", "type" => "number", "class" => "form-control", "id" => "fieldCopyModuleId"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldTitle" class="col-sm-2 control-label">Title</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldLogin" class="col-sm-2 control-label">Login</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Login", "type" => "number", "class" => "form-control", "id" => "fieldLogin"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldSetting" class="col-sm-2 control-label">Setting</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textArea(["Setting", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldSetting"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldAuthSetting" class="col-sm-2 control-label">Auth Of Setting</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textArea(["Auth_Setting", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldAuthSetting"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldBgIphone" class="col-sm-2 control-label">BG Of Iphone</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["BG_Iphone", "size" => 30, "class" => "form-control", "id" => "fieldBgIphone"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldBgIpad" class="col-sm-2 control-label">BG Of Ipad</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["BG_Ipad", "size" => 30, "class" => "form-control", "id" => "fieldBgIpad"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldBgAndroid" class="col-sm-2 control-label">BG Of Android</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["BG_Android", "size" => 30, "class" => "form-control", "id" => "fieldBgAndroid"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldBaseUrl" class="col-sm-2 control-label">Base Of URL</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Base_URL", "size" => 30, "class" => "form-control", "id" => "fieldBaseUrl"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldGetOrdersSetting" class="col-sm-2 control-label">Get Of Orders Of Setting</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textArea(["Get_Orders_Setting", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldGetOrdersSetting"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldColor" class="col-sm-2 control-label">Color</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Color", "size" => 30, "class" => "form-control", "id" => "fieldColor"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldWithKeyValue" class="col-sm-2 control-label">With Of Key Of Value</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["With_Key_Value", "type" => "number", "class" => "form-control", "id" => "fieldWithKeyValue"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldMappingApi" class="col-sm-2 control-label">Mapping Of Api</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Mapping_Api", "type" => "number", "class" => "form-control", "id" => "fieldMappingApi"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldPluginApi" class="col-sm-2 control-label">Plugin Of Api</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Plugin_Api", "type" => "number", "class" => "form-control", "id" => "fieldPluginApi"]) ?>
    </div>
</div>

<div class="form-group">
    <label for="fieldActive" class="col-sm-2 control-label">Active</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Active", "type" => "number", "class" => "form-control", "id" => "fieldActive"]) ?>
    </div>
</div>


<?php echo $this->tag->hiddenField("id") ?>

<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
