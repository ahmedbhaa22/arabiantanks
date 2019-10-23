<div class="portlet light bordered">

    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?= $translate->_('Module Translations') ?></span>
        </div>


        <div class="actions">
            <a type="button" href="<?= $this->url->get('users_application_module/moduleTranslationNew/') ?>" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?= $translate->_('Add new string') ?> </a>
        </div>

    </div>

    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <table
                    class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                    id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th>String</th>
                        <th>Value</th>
                        <th>Language</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($translation as $translate) { ?>
                    <td><?= $translate->word_key ?></td>
                    <td><?= $translate->value ?></td>
                    <td><?= $translate->lang_id ?></td>
                    <?php } ?>
                    </tbody>
                </table>
            </div>



        </div>
    </div>

</div>
