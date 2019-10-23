<div class="portlet light bordered">
    <div class="portlet-title">
        <p><?php $this->flashSession->output() ?></p>
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?= $translate->_('Edit Module Options:') ?> <?= $Module->Title ?></span>
        </div>

        <div class="actions">
            <a type="button" href="<?= $this->url->get('users_application_module/index/') ?> " data-toggle="modal" class="btn green-jungle btn-outline">
                <?= $translate->_('Back') ?>
            </a>
        </div>
    </div>
    <div class="portlet-body">
        <?php
        echo $this->tag->form(
            [
                "users_application_module/settingssave",
                "autocomplete" => "off",
                "class" => "form-horizontal paymentForm",
                "role" => "form",
                "style" => "display:block",
                "enctype" => "multipart/form-data"
            ]
        );
        ?>
        <div class="funkyradio clearfix">
            <div class="col-md-6 col-sm-6 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Toggle_Grid']) ?>
                    <label for="Toggle_Grid"><?= $translate->_('Activate Images Grid Content') ?></label>
                </div>
            </div>

            <div class="col-md-6 col-sm-6 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Has_Orders']) ?>
                    <label for="Has_Orders"><?= $translate->_('Orders Module ?') ?></label>
                </div>
            </div>
        </div>
        <div class=""></div>

        <legend class="gap"><?= $translate->_('Main Banners') ?></legend>
        <div class="bar bg-blue-chambray gap clearfix">
            <div class="text-center col-xs-12">
                <div class="form-group">
                    <label for="Content_Banner" class="control-label"><b><?= $translate->_('Content Banner') ?></b></label>
                    <input type="file" name="Content_Banner" value="" class="form-control">
                </div>

            </div>
            <div class="text-center col-xs-12">
                <div class="form-group">
                    <label for="Module_Banner" class="control-label"><b><?= $translate->_('Module Banner') ?></b></label>
                    <input type="file" name="Module_Banner" value="default_content.jpg" class="form-control">
                </div>

            </div>
            <div class="text-center col-xs-12">
                <div class="form-group">
                    <label for="Content_Edit_Banner" class="control-label"><b><?= $translate->_('Content Edit Module') ?></b></label>
                    <input type="file" name="Content_Edit_Banner" value="default_content.jpg" class="form-control">
                </div>

            </div>
        </div>

        <legend class="gap"><?= $translate->_('Icon Pictures') ?></legend>

        <div class="bar bg-blue-chambray gap clearfix">
            <div class="col-md-4 col-xs-6">
                <div class="form-group">
                    <label for="ModulePic" class="control-label"><b> <?= $translate->_('Module Picture') ?></b></label>
                    <input type="file" name="ModulePic" value="" class="form-control">
                    <div><img src="http://penta-test.com/robo_cms/uploads/modules_pics/2b5ca6f7-7ec7-47a6-901f-625cc6607f1d.png"> </div>
                </div>

            </div>
            <div class="col-md-4 col-xs-6">
                <div class="form-group">
                    <label for="Content_Img" class="control-label"><b> <?= $translate->_('Content Picture') ?> </b></label>
                    <input type="file" name="Content_Img" value="default_content.jpg" class="form-control">
                    <div><img src="http://penta-test.com/robo_cms/uploads/modules_pics/default_content.jpg"> </div>
                </div>

            </div>

            <div class="col-md-4 col-xs-12">
                <div class="form-group">
                    <label for="Content_Stat_Img" class="control-label"><b> <?= $translate->_('Content Statistics Picture') ?> </b></label>
                    <input type="file" name="Content_Stat_Img" value="default_content_stat.jpg" class="form-control">
                    <div><img src="http://penta-test.com/robo_cms/uploads/modules_pics/default_content_stat.jpg"> </div>
                </div>

            </div>
        </div>
        <div class="funkyradio gap">
            <legend><?= $translate->_('Content Options') ?></legend>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Title']) ?>
                    <label for="Title"><?= $translate->_('Title') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Des']) ?>
                    <label for="Des"><?= $translate->_('Description') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Content']) ?>
                    <label for="Content"><?= $translate->_('Content Details') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Order']) ?>
                    <label for="Order"><?= $translate->_('Sort Order') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Img']) ?>
                    <label for="Img"><?= $translate->_('Main Picture') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['DateTime']) ?>
                    <label for="DateTime"><?= $translate->_('Date') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-success">
                    <?= $this->tag->checkField(['Active']) ?>
                    <label for="Active"><?= $translate->_('Active') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Depts']) ?>
                    <label for="Depts"><?= $translate->_('Departments') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['MediaImg']) ?>
                    <label for="MediaImg"><?= $translate->_('Media') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['MediaVideo']) ?>
                    <label for="MediaVideo"><?= $translate->_('Video') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['KvInfo']) ?>
                    <label for="KvInfo"><?= $translate->_('Other Options') ?></label>
                </div>
            </div>
        </div>


        <div class="funkyradio gap">
            <legend><?= $translate->_('Content Permissions') ?></legend>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Add']) ?>
                    <label for="Add"><?= $translate->_('Add New') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Del']) ?>
                    <label for="Del"><?= $translate->_('Delete') ?></label>
                </div>
            </div>
            
            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['Import']) ?>
                    <label for="Import"><?= $translate->_('Import Data') ?></label>
                </div>
            </div>


        </div>


        <div class="funkyradio gap">
            <legend><?= $translate->_('Content List Fields') ?></legend>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['ListTitle']) ?>
                    <label for="ListTitle"><?= $translate->_('Title') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['ListDes']) ?>
                    <label for="ListDes"><?= $translate->_('Description') ?></label>
                </div>
            </div>



            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['ListOrder']) ?>
                    <label for="ListOrder"><?= $translate->_('Sort Order') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['ListImg']) ?>
                    <label for="ListImg"><?= $translate->_('Main Picture') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-default">
                    <?= $this->tag->checkField(['ListDateTime']) ?>
                    <label for="ListDateTime"><?= $translate->_('Date') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-success">
                    <?= $this->tag->checkField(['ListVisit_Num']) ?>
                    <label for="ListVisit_Num"><?= $translate->_('Visitors Number') ?></label>
                </div>
            </div>

            <div class="col-md-2 col-sm-4 col-xs-6">
                <div class="funkyradio-success">
                    <?= $this->tag->checkField(['ListActive']) ?>
                    <label for="ListActive"><?= $translate->_('Active') ?></label>
                </div>
            </div>


        </div>
        




        <div class="col-md-12 col-xs-12 gap">
            <div class="form-group">
                <label for="RelatedModule" class="control-label"><b><?= $translate->_('Content Has Child ?') ?> </b></label>

                <?php
                echo $this->tag->select(
                    [
                        "RelatedModule",
                        $ModulesList,
                        "using"      => [
                            "ID",
                            "Title",
                        ],
                        "useEmpty"   => true,
                        "emptyText"  => "No Child",
                        "emptyValue" => "0",
                    ]);
                ?>

            </div>

        </div>

        <div class="col-md-12 col-xs-12 no-padding">
            <?php
            echo $this->tag->hiddenField("ID");
            ?>
            <?php
            echo $this->tag->hiddenField("Module_ID");
            ?>

            <div class="form-group">
                <div class="col-sm-12 text-center">
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn green-jungle"]) ?>
                </div>
            </div>

            <?php echo $this->tag->endForm(); ?>

        </div>
        <div class="clearfix"></div>
        <?php echo $this->tag->endForm(); ?>

    </div>
</div>
