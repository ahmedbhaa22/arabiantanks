
<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<?php
use Phalcon\Tag;
use Phalcon\Escaper;
use Phalcon\Mvc\Url;
$url = new Url();
$e = new Escaper();
?>
<?php

?>


<div class="portlet light bordered">
    <!--<div class="row">-->
    <!--    <nav>-->
    <!--        <ul class="pager">-->
    <!--            <li class="next">--><?php //echo $this->tag->linkTo(["content/new", "Create "]); ?><!--</li>-->
    <!--        </ul>-->
    <!--    </nav>-->
    <!--</div>-->
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?= $translate->_('Import Data') ?></span>
        </div>

        <div class="actions">
            <a type="button" href="#" id="filter-toggle-btn" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?= $translate->_('Import Data') ?>
            </a>
        </div>

    </div>



    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="row col-sm-12" id="filter-toggle">
                <form method="POST" action="<?= $this->url->get('import_data/create/') ?>" enctype="multipart/form-data">
                    <div class="col-md-6 col-xs-12">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Source"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php
                                    echo $this->tag->select(
                                        [
                                            "Dept",
                                            $depts_sources,
                                            "using" => [
                                                "ID",
                                                "Title",
                                            ]
                                        ]
                                    );
                                    ?>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Name"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <input type="text" name="Name" id="" />
                                </div>
                            </div>

                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Data"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <input type="text" name="Data" id="" />
                                </div>
                            </div>

                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Type"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php
                                    echo $this->tag->select(
                                        [
                                            "Type",
                                            $source_types,
                                            "using" => [
                                                "ID",
                                                "Title",
                                            ]
                                        ]
                                    );
                                    ?>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Order Data"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php
                                    echo $this->tag->select(
                                        [
                                            "Order",
                                            $order_types,
                                            "using" => [
                                                "ID",
                                                "Order_Title",
                                            ]
                                        ]
                                    );
                                    ?>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Operating Menu"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <input type="text" name="op_menu" id="" />
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Content"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <input type="text" name="Content" id="" />
                                </div>
                            </div>

                        </div>


                    </div>
                    <div class="form-group">
                        <div class="col-md-12 col-xs-12">
                            <input type="hidden" value="<?= $Module_ID ?>" name="module"/>
                            <input type="hidden" value="<?= $ID ?>" name="ID"/>
                            <input type="submit" value="<?php echo $translate->_("Import"); ?>" class="btn btn-default">
                        </div>
                    </div>
                </form>
            </div>
            <div class="table-scrollable">
                <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting"><?= $translate->_('Name') ?></th>
                        <th class="sorting"><?= $translate->_('Data') ?></th>
                        <th class="sorting"><?= $translate->_('Type') ?></th>
                        <th class="sorting"><?= $translate->_('Order Data') ?></th>
                        <th class="sorting"><?= $translate->_('Operating Menu') ?></th>
                        <th class="sorting"><?= $translate->_('Content') ?></th>
                        <th class="sorting"><?= $translate->_('Source') ?></th>
                        <th class="sorting"><?= $translate->_('Edit/Delete') ?></th>

                    </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($page->items as $content) { ?>

                            <tr class="gradeX">
                                <td><?= $content->Name ?></td>
                                <td><?= $content->Data ?></td>
                                <td><?= $content->ImportType->Title ?></td>
                                <td><?= $content->OrderName->Order_Title ?></td>
                                <td><?= $content->Operating_Menu ?></td>
                                <td><?= $content->Content ?></td>
                                <td><?= $content->Dept->Title ?></td>
                                <td>
                                    <div class="btn-group" style="position:relative">
                                        <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"><?= $translate->_('Edit/Delete') ?>
                                            <i class="fa fa-angle-down"></i>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">

                                            <li>
                                                <a href="<?= $this->url->get('import_data/edit/' . $content->ID) ?>" data-toggle="">
                                                    <i class="icon-tag"></i> <?= $translate->_('Edit') ?></a>
                                            </li>
                                            <li>
                                                <a href="<?= $this->url->get('import_data/delete/' . $content->ID) ?>" data-toggle="">
                                                    <i class="icon-tag"></i> <?= $translate->_('Delete') ?></a>
                                            </li>

                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </div>

            <div class="row">
                <div class="col-md-5 col-sm-5">
                    <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                        <?php echo $page->current, "/", $page->total_pages ?>
                    </div>
                </div>
                <div class="col-md-7 col-sm-7"><div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                        <ul class="pagination" style="visibility: visible;">
                            <li><?php echo $this->tag->linkTo("import_data/index/{$Module_ID}", "First") ?></li>
                            <li><?php echo $this->tag->linkTo("import_data/index/{$Module_ID}?page=" . $page->before, "Previous") ?></li>
                            <li><?php echo $this->tag->linkTo("import_data/index/{$Module_ID}?page=" . $page->next, "Next") ?></li>
                            <li><?php echo $this->tag->linkTo("import_data/index/{$Module_ID}?page=" . $page->last, "Last") ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
