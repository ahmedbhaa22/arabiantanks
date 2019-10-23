<div class="portlet light bordered">
    <div class="portlet-title">
        <p><?php $this->flashSession->output() ?></p>
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?= $translate->_('Edit Group') ?></span>
        </div>


    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">

            <?php
            echo $this->tag->form(
                [
                    "users_application_module/saveString",
                    "autocomplete" => "off",
                    "class" => "form-horizontal",
                    "id" => "saveString"
                ]
            );
            ?>

            <div class="col-xs-12">
                <div class="form-group">
                    <?php foreach ($app_langs as $app_lang) { ?>
                    <?php $check_lang = $app_lang->getStrings(["word_key='{$word_key}' and lang_id={$app_lang->lang_id} and module_id={$Module_ID}"]) ?>
                    <?php if (($check_lang)) { ?>
                    <div class="col-xs-4 nopadding-r">
                        <label for="fieldTitle<?= $app_lang->lang_id ?>" class="control-label col-xs-12 no-padding"><?= $app_lang->LangDetails->title ?></label>
                        <input type="text" id="fieldTitle<?= $app_lang->lang_id ?>" name="Value<?= $app_lang->lang_id ?>" class="form-control" value='<?= $check_lang->value ?>'>
                    </div>
                    <?php } else { ?>
                    <div class="col-xs-4 nopadding-r">
                        <label for="fieldTitle<?= $app_lang->lang_id ?>" class="control-label col-xs-12 no-padding"><?= $app_lang->LangDetails->title ?></label>
                        <input type="text" id="fieldTitle<?= $app_lang->lang_id ?>" name="Value<?= $app_lang->lang_id ?>" class="form-control" value=''>
                    </div>
                    <?php } ?>
                    <?php } ?>

                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="hidden" value="<?= $word_key ?>" name="word_key" />
                    <input type="hidden" value="<?= $Module_ID ?>" name="Module_ID" />
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
                </div>

            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="" data-dismiss="modal" class="btn dark " value="إلغاء">
                </div>

            </div>

            <?php echo $this->tag->endForm(); ?>

        </div>
    </div>
</div>

<script>
    $("#saveGroup").submit(function(e) {
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var url = "<?= $this->url->get('users_application_module/saveString/') ?>"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#saveString").serialize(), // serializes the form's elements.
            success: function(data)
            {
                alert(data); // show response from the php script.
            }
        });


    });
</script>