<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?= $translate->_('Content View') ?> - <?= $app_lang->LangDetails->title ?></span>
        </div>

        <div class="actions">
            <a type="button" href="<?= $this->url->get('application_localization/index') ?>" data-toggle="" data-target=""
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?= $translate->_('back') ?></a>
        </div>


    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <?php
            echo $this->tag->form(
                [
                    "application_localization/langSave",
                    "autocomplete" => "off",
                    "class" => "form-horizontal"
                ]
            );
            ?>

            <div class="form-group">
                <label for="fieldApplicationId" class="col-sm-2 control-label"><?= $translate->_('Default') ?></label>
                <div class="col-sm-10">
                    <input type="checkbox" name="is_default" value="1" <?= $default_checked ?>><br>
                </div>
            </div>


            <?php echo $this->tag->hiddenField("id") ?>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
                </div>
            </div>

            <?php echo $this->tag->endForm(); ?>
        </div>
    </div>
</div>
