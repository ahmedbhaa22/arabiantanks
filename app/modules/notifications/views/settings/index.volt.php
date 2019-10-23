<div class="row">


    <div class="col-md-12">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="fa fa-bell" aria-hidden="true"></i>
                    <span class="caption-subject bold uppercase">
                        <?= $translate->_('Settings') ?>
                    </span>
                </div>

            </div>
            <div class="portlet-body">

                <form role="form" action="<?= $this->url->get('settings/update') ?>" enctype="multipart/form-data" method="post">


                    <div class="col-md-12 no-pad col-xs-12">



                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Android App Key</label>
                            <div class="col-sm-9">
                                <input type="text" placeholder="android app key" value="<?= $settings->android_app_key ?>" name="android_app_key" class="form-control"/>
                            </div>
                        </div>

                        <hr>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">iPhone App Bundle ID</label>
                            <div class="col-sm-9">
                                <input type="text" placeholder="iPhone App Bundle ID" value="<?= $settings->iphone_bundle_id ?>" name="iphone_bundle_id" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Sandbox Certificate</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_sandbox" class="form-control"
                                <?php if ($settings->enable_sandbox == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Sandbox Certificate Passphrase</label>
                            <div class="col-sm-9">
                                <input type="text" placeholder="Sandbox Certificate Passphrase" value="<?= $settings->sandbox_passphrase ?>" name="sandbox_passphrase" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Production Certificate Passphrase</label>
                            <div class="col-sm-9">
                                <input type="text" placeholder="Production Certificate Passphrase" value="<?= $settings->production_passphrase ?>" name="production_passphrase" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Sandbox Certificate</label>
                            <div class="col-sm-9">
                                <input type="file" name="sandbox_certificate" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Production Certificate</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_production" class="form-control"
                                <?php if ($settings->enable_production == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>


                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Production Certificate</label>
                            <div class="col-sm-9">
                                <input type="file" name="production_certificate" class="form-control"/>
                            </div>
                        </div>

                        <hr>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Mail Smtp server</label>
                            <div class="col-sm-9">
                                <input type="text" name="smtp_server" class="form-control" value="<?= $settings->smtp_server ?>" />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Mail Smtp Port</label>
                            <div class="col-sm-9">
                                <input type="text" name="smtp_port" class="form-control" value="<?= $settings->smtp_port ?>" />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Mail Username</label>
                            <div class="col-sm-9">
                                <input type="text" name="smtp_username" class="form-control" value="<?= $settings->smtp_username ?>" />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Mail Password</label>
                            <div class="col-sm-9">
                                <input type="text" name="smtp_password" class="form-control" value="<?= $settings->smtp_password ?>" />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">From Name</label>
                            <div class="col-sm-9">
                                <input type="text" name="mail_from_name" class="form-control" value="<?= $settings->mail_from_name ?>" />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">From Email</label>
                            <div class="col-sm-9">
                                <input type="text" name="mail_from_email" class="form-control" value="<?= $settings->mail_from_email ?>" />
                            </div>
                        </div>



                    </div>

    

                    <a href="<?= $this->url->get('index') ?>" class="btn btn-danger"><?= $translate->_('Cancel') ?></a>
                    <input type="submit" class="btn green-jungle " value="<?= $translate->_('Update') ?>">

                </form>
        
            </div>
        </div>

    </div>
</div>