<div class="modal-content">
    <div class="modal-header hidden-xs">
        <div class="col-xs-12 ">
            <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('<?= $this->url_shared->get('ropo_app/') ?>img/default-form-img.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
    <form method="post" action="" id="editKeyvalueSave" >
        <div class="modal-body" >
            <div class="portlet-body " style=" padding: 15px;">
                <div class="row">


<!--                        <div class="col-xs-6">-->
<!--                            <div class="form-group">-->
<!--                                <input type="text" id="fieldTitle" name="Paramter" class="form-control"required="required" placeholder="Parameter">-->
<!--                            </div>-->
<!--                        </div>-->
                        <div class="col-xs-12 funkyradio">
                            <div class="funkyradio-default">
                                <?= $this->tag->checkField(['showMenu']) ?>
                                <label for="showMenu"><?= $translate->_('Show in Content List') ?></label>
                            </div>
                        </div>

                        <div class="col-xs-12">
                            <div class="form-group">

                                <div class="col-xs-4 nopadding-r">
                                    <label for="fieldTitle" class="control-label col-xs-12 no-padding"><?= $translate->_('Default') ?></label>
                                    <input type="text" id="fieldTitle<?= $kv[0]->ID ?>" name="TitleDefault" class="formDefault-control" required value="<?= $kv[0]->Title ?>">
                                </div>
                                <?php foreach ($app_langs as $app_lang) { ?>
                              
                                <?php if ($keyvalue->getDataKeyvalueLang(['Lang_ID=' . $app_lang->lang_id])) { ?>
                                <div class="col-xs-4 nopadding-r">
                                    <label for="fieldTitle" class="control-label col-xs-12 no-padding"><?= $app_lang->LangDetails->title ?></label>
                                    <input type="text" id="fieldTitle<?= $app_lang->lang_id ?>" name="Title<?= $app_lang->lang_id ?>" class="form-control" value='<?= $keyvalue->getDataKeyvalueLang(['Lang_ID=' . $app_lang->lang_id])->Title ?>'>
                                </div>
                                <?php } else { ?>
                                <div class="col-xs-4 nopadding-r">
                                    <label for="fieldTitle" class="control-label col-xs-12 no-padding"><?= $app_lang->LangDetails->title ?></label>
                                    <input type="text" id="fieldTitle<?= $app_lang->lang_id ?>" name="Title<?= $app_lang->lang_id ?>" class="form-control" value=''>
                                </div>
                                <?php } ?>
                                <?php } ?>

                            </div>
                        </div>
                        <!-- <div class="col-xs-4">
                            <div class="form-group">
                                <label for="fieldActive" class="control-label">الجروب</label>
                                    <select id="Module_ID" name="Module_ID">
                                        <option value="">جروب 1</option>
                                        <option value="">جروب 2</option>
                                    </select>
                            </div>
                        </div> -->

                        <div class="col-xs-12">
                            <div class="form-group">
                                <div class="funkyradio gap">
                                <label for="fieldActive" class="control-label"><?= $translate->_('Additional Fields Show Options') ?></label>
                                <div class="col-xs-12 no-padding">

                                    <div class="col-xs-3 nopadding-r">
                                        <div class="funkyradio-default">
                                            <?= $this->tag->checkField(['Title']) ?>
                                            <label for="Title"><?= $translate->_('Title') ?></label>
                                        </div>
                                    </div>

                                    <div class="col-xs-3 nopadding-r">
                                        <div class="funkyradio-default">
                                            <?= $this->tag->checkField(['Des']) ?>
                                            <label for="Des"><?= $translate->_('Description') ?></label>
                                        </div>
                                    </div>

                                    <div class="col-xs-3 nopadding-r">
                                        <div class="funkyradio-default">
                                            <?= $this->tag->checkField(['Img']) ?>
                                            <label for="Img"><?= $translate->_('Image') ?></label>
                                        </div>
                                    </div>


                                </div>
                                    </div>
                            </div>
                        </div>

                        <?php if (($kv_type == 1 || $kv_type == 3)) { ?>
                        <div class="col-sm-12" id="select-options" style="display: block;">
                        <div class="form-group">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding"><?= $translate->_('Select Options') ?></label>
                            <?php foreach ($options as $option) { ?>
                            <div class="col-xs-12 nopadding-r">
                                <div id="existed-options">
                                    <?php foreach ($option->getDataKeyvalueOptionLang('Lang_ID=1') as $lang) { ?>
                                    <div>
                                        <div class="col-xs-4 nopadding-r">
                                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">Default</label>
                                            <input type="text" id="option<?= $option->ID ?>lang1" name="option<?= $option->ID ?>lang1" class="form-control"  value="<?= $lang->Title ?>">
                                        </div>

                                    </div>
                                    <?php } ?>
                                    <?php foreach ($app_langs as $app_lang) { ?>
                                    <?php if (($app_lang->lang_id == 1)) { ?><?php continue; ?><?php } ?>
                                    <?php if ($this->length($option->getDataKeyvalueOptionLang('Lang_ID=' . $app_lang->lang_id)) == 0) { ?>
                                    <div>
                                        <div class="col-xs-4 nopadding-r">
                                            <label for="fieldTitle" class="control-label col-xs-12 no-padding"><?= $app_lang->LangDetails->title ?></label>
                                            <input type="text" id="fieldTitle<?= $app_lang->lang_id ?>" name="option<?= $option->ID ?>lang<?= $app_lang->lang_id ?>" class="form-control"  value="">
                                        </div>

                                    </div>
                                    <?php } ?>
                                    <?php foreach ($option->getDataKeyvalueOptionLang('Lang_ID=' . $app_lang->lang_id) as $lang) { ?>
                                    <div>
                                        <div class="col-xs-4 nopadding-r">
                                            <label for="fieldTitle" class="control-label col-xs-12 no-padding"><?= $app_lang->LangDetails->title ?></label>
                                            <input type="text" id="fieldTitle<?= $app_lang->lang_id ?>" name="option<?= $option->ID ?>lang<?= $app_lang->lang_id ?>" class="form-control"  value="<?= $lang->Title ?>">
                                        </div>

                                    </div>
                                    <?php } ?>
                                    <?php } ?>



                                </div>

                            </div>
                            <?php } ?>
                            <div class="col-xs-12 nopadding-r" id="new-option">
                                <div class="col-xs-4 nopadding-r">
                                    <label for="fieldTitle" class="control-label col-xs-12 no-padding">Default</label>
                                    <input type="text" id="fieldTitle<?= $app_lang->lang_id ?>" name="option_new1[]" class="form-control"  value="">
                                </div>
                                <?php foreach ($app_langs as $app_lang) { ?>
                                <?php if (($app_lang->lang_id == 1)) { ?><?php continue; ?><?php } ?>
                                <div>
                                    <div class="col-xs-4 nopadding-r">
                                        <label for="fieldTitle" class="control-label col-xs-12 no-padding"><?= $app_lang->LangDetails->title ?></label>
                                        <input type="text" id="fieldTitle<?= $app_lang->lang_id ?>" name="option_new<?= $app_lang->lang_id ?>[]" class="form-control"  value="">
                                    </div>

                                </div>
                                <?php } ?>

                            </div>


                        </div>
                            <a class="btn btn-xs btn-primary" onclick="repeat()">
                                <i class="fa fa-plus-circle" aria-hidden="true"></i>  <?= $translate->_('Add Option') ?>
                            </a>
                        <script type="text/javascript">
                            var i = 0;
                            var original = document.getElementById('new-option');

                            function repeat() {
                                var clone = original.cloneNode(true);
                                clone.id = "new-option" + ++i;
                                original.parentNode.appendChild(clone);
                            }



                        </script>

                    </div>
                        <?php } ?>


                </div>
            </div>
        </div>
        <div class="modal-footer">
            <input type="" data-dismiss="modal" class="btn dark " value="<?= $translate->_('Cancel') ?>">
            <input type="submit" id="submit"  class="btn green-jungle " value="<?= $translate->_('Save') ?>">
        </div>
    </form>
</div>


<script>

    $("#editKeyvalueSave").submit(function(e) {
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var url = "<?= $this->url->get('keyvalue/editKeyvalueSave/') . $kv_id ?>"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#editKeyvalueSave").serialize(), // serializes the form's elements.
            success: function(data)
            {
                alert(data); // show response from the php script.
                 location.reload();
            }
        });


    });





</script>












<!-- OLD View -->
