<div class="portlet light bordered">
<div class="portlet-title">
    <p><?php $this->flashSession->output() ?></p>
    <div class="caption font-dark">
        <i class="icon-user font-dark"></i>
        <span class="caption-subject bold uppercase">{{ translate._('Edit Module')}}</span>
    </div>

    <div class="actions">
        <a type="button" href="{{url('users_application_module/index/')}} " data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
            {{ translate._("Back")}}
        </a>
    </div>
</div>


<div class="portlet-body">
    <div id="sample_1_wrapper">




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
    <label for="fieldTitle" class="col-sm-2 control-label">{{translate._("Title")}}</label>
    <div class="col-sm-10">
        <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
    </div>
</div>

{%for title_lang in title_langs%}
<div class="form-group">
    <label for="fieldTitle" class="col-sm-2 control-label">{{title_lang['lang_title']}}</label>
    <div class="col-sm-10">
		<input type="text" class="form-control" name="Lang{{title_lang['lang_id']}}" value="{{title_lang['title']}}" />		
    </div>
</div>
{%endfor%}
<?php echo $this->tag->hiddenField("ID") ?>

<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-primary"]) ?>
    </div>
</div>

<?php echo $this->tag->endForm(); ?>
</div>
</div>
</div>
