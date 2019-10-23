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
                            <label class="col-sm-3 control-label">Enable Schedueling</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_schedueling" class="form-control"
                                <?php if ($settings->enable_schedueling == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Enable Statistics</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="enable_statistics" class="form-control"
                                <?php if ($settings->enable_statistics == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Use Default Key Value</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="use_default_kv" class="form-control"
                                <?php if ($settings->use_default_kv == 1) { ?>
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

                        <hr>

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Filter Male/Female</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="filter_mf" class="form-control"
                                <?php if ($settings->filter_mf == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>

                        <hr>
                        <?php foreach ($follow_types as $type) { ?>
                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Filter <?= $type->type ?></label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="<?= $type->id ?>" name="filter[]" class="form-control"
                                <?php if ($settings->hasPermission($type)) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div>
                        <?php } ?>
                        <hr>

                        <!-- <div class="form-group ">
                            <label class="col-sm-3 control-label">Filter Favourite</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="filter_favourite" class="form-control"
                                <?php if ($settings->filter_favourite == 1) { ?>
                                checked 
                                <?php } ?>
                                />
                            </div>
                        </div> -->

                        <div class="form-group ">
                            <label class="col-sm-3 control-label">Filter Guest Users</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="1" name="filter_guests" class="form-control"
                                <?php if ($settings->filter_guests == 1) { ?>
                                checked 
                                <?php } ?>
                                />
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