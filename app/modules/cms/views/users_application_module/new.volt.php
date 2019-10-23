<div class="portlet light bordered">
<div class="portlet-title">
    <p><?php $this->flashSession->output() ?></p>
    <div class="caption font-dark">
        <i class="icon-user font-dark"></i>
        <span class="caption-subject bold uppercase"><?= $translate->_('Add New Module') ?></span>
    </div>

    <div class="actions">
        <a type="button" href="<?= $this->url->get('users_application_module/index/') ?> " data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
            <?= $translate->_('Back') ?>
        </a>
    </div>
</div>


<div class="portlet-body">
    <div id="sample_1_wrapper">

<?php
    echo $this->tag->form(
        [
            "users_application_module/create",
            "autocomplete" => "off",
            "class" => "form-horizontal"
        ]
    );
?>



<div class="form-group">
    <label for="fieldTitle" class="col-sm-2 control-label">Title</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle","required"=>"required"]) ?>
    </div>
</div>


<div class="form-group">
    <label for="fieldActive" class="col-sm-2 control-label">Active</label>
    <div class="col-sm-10">
        <?php echo $this->tag->selectStatic(["Active", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldToggleGrid"]) ?>

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