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

                <form role="form" action="<?= $this->url->get('manager_settings/update') ?>" enctype="multipart/form-data" method="post">


                    <div class="col-md-12 no-pad col-xs-12">

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Width</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_width" class="form-control"
                                <?php if ($settings->enable_width == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Height</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_height" class="form-control"
                                <?php if ($settings->enable_height == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Start Date</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_start_date" class="form-control"
                                <?php if ($settings->enable_start_date == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable End Date</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_end_date" class="form-control"
                                <?php if ($settings->enable_end_date == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Picture</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_picture" class="form-control"
                                <?php if ($settings->enable_picture == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Thumbnail</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_thumbnail" class="form-control"
                                <?php if ($settings->enable_thumbnail == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Section</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_section" class="form-control"
                                <?php if ($settings->enable_section == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Is Video</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_is_video" class="form-control"
                                <?php if ($settings->enable_is_video == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Content</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_content" class="form-control"
                                <?php if ($settings->enable_content == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Banner Image</label>
                            <div class="col-sm-9">
                                <input type="file" name="banner_image" class="form-control"/>
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