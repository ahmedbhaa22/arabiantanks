<div class="portlet light bordered">

    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?= $translate->_('Control Panel Users') ?></span>
        </div>


        <div class="actions">
            <a type="button" href="<?= $this->url->get('cp_users/new/') ?>" data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?= $translate->_('Add new account') ?>              </a>
        </div>

    </div>

    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <div><a id="reset-table" href=""><?php echo $translate->_("Reset All"); ?></a></div>
                <form name="deleteContentForm" id="deleteMobileUserForm" method="post" action="">
                    <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                        <thead>

                        <tr role="row">
                            <th>
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample_1 .checkboxes">
                                    <span></span>
                                </label>
                            </th>
                            <th class=""><?= $translate->_('Name') ?></th>
                            <th class=""><?= $translate->_('User Name') ?></th>
                            <th class=""><?= $translate->_('E-Mail') ?></th>
                            <th class=""><?= $translate->_('Registration Date') ?></th>
                            <th class=""><?= $translate->_('Registration Time') ?></th>
                            <th class=""><?= $translate->_('Active') ?></th>
                            <th class=""><?= $translate->_('Edit/Delete') ?></th>

                        </tr>
                        </thead>
                        <tfoot>
                        <tr role="row" class="filterow">
                            <th><?= $translate->_('Search') ?></th>
                            <th class="filter"><?= $translate->_('Name') ?></th>
                            <th class="filter"><?= $translate->_('User Name') ?></th>
                            <th class="filter"><?= $translate->_('E-Mail') ?></th>
                            <th class="filter dateFilter"><?= $translate->_('Registration Date') ?></th>
                            <th class=""></th>
                            <th class=""></th>
                            <th class=""></th>
                        </tr>
                        </tfoot>

                        <tbody>

                        </tbody>
                    </table>
                    <div class="btn-group">
                        <button class="btn  dark dropdown-toggle" type="button" data-toggle="dropdown"
                                aria-expanded="false"> <?php echo $translate->_("Checked Fuctions"); ?>
                            <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu" role="menu">

                            <li>
                                <a href="#" class="delete-btn" value="sss">
                                    <i class="icon-user"></i> <?php echo $translate->_("Delete Checked"); ?> </a>
                            </li>
                            <li>
                                <a href="#" class="active-btn" value="sss">
                                    <i class="icon-user"></i> <?php echo $translate->_("Activate Checked"); ?> </a>
                            </li>
                            <li>
                                <a href="#" class="deactive-btn" value="sss">
                                    <i class="icon-user"></i> <?php echo $translate->_("Deactivate Checked"); ?> </a>
                            </li>

                        </ul>
                    </div>
                </form>
            </div>

            <!--            <div class="row">-->
            <!--                <div class="col-md-5 col-sm-5">-->
            <!--                    <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">-->
            <!--                        --><?php //echo $page->current, "/", $page->total_pages ?>
            <!--                    </div>-->
            <!--                </div>-->
            <!--                <div class="col-md-7 col-sm-7"><div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">-->
            <!--                        <ul class="pagination" style="visibility: visible;">-->
            <!--                            <li>--><?php //echo $this->tag->linkTo("mobile_users", "الأولى") ?><!--</li>-->
            <!--                            <li>--><?php //echo $this->tag->linkTo("mobile_users?page=" . $page->before, "السابقة") ?><!--</li>-->
            <!--                            <li>--><?php //echo $this->tag->linkTo("mobile_users?page=" . $page->next, "التالية") ?><!--</li>-->
            <!--                            <li>--><?php //echo $this->tag->linkTo("mobile_users?page=" . $page->last, "الأخيرة") ?><!--</li>-->
            <!--                        </ul>-->
            <!--                    </div>-->
            <!--                </div>-->
            <!--            </div>-->

        </div>
    </div>

</div>

<?= $this->tag->javascriptInclude('js/filters/cp_users.js') ?>
<style>
    #sample_1 tfoot th.filter input{
        width:100px;
        height:25px;
    }
</style>
<script type="text/javascript">
    $( document ).ready(function() {
        $('.dateFilter').datepicker({
            format: "mm/dd/yyyy"
        });
        $('.dateFilter').on('changeDate', function(ev){
            $(this).datepicker('hide');
        });

    });

</script>