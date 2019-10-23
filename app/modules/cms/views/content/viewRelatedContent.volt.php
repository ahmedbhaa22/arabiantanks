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

<?php if (true): ?>
    <div class="portlet light bordered">

        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="icon-user font-dark"></i>
                <span class="caption-subject bold uppercase"> <?php echo $translate->_("Promotions Of "); ?><?= $parent_module->Title ?></span>
            </div>

            <div class="actions">
                <a type="button" href="<?= $this->url->get('content/new/') . $Module_ID ?>&parent=<?= $parent_id ?>" data-toggle="modal"
                   class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                    <?php echo $translate->_("New Content"); ?>
                </a>

            </div>


        </div>

        <div class="portlet-body">
            <div id="sample_1_wrapper">
                <p><?php $this->flashSession->output() ?></p>
                
                <div class="clearfix"></div>
                <div class="table-scrollable">
                    <div><a id="reset-table" href=""><?php echo $translate->_("Reset All"); ?></a></div>
<!--                    <div><a href="<?= $this->url->get('content/index/' . $Module_ID) ?>">--><?php //echo $translate->_("Search By Date"); ?><!--</a></div>-->
                    <form name="deleteContentForm" id="deleteContentForm" method="post" action="">

                        <table
                            class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                            id="sample_1" role="grid" aria-describedby="sample_1_info">
                            <thead>
                            <tr role="row">
                                <th class="sorting">
                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                        <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample_1 .checkboxes">
                                        <span></span>
                                    </label></th>
                                <?php if (($list_settings->Img == 1)) { ?>
                                <th class="sorting"><?php echo $translate->_("Main Picture"); ?></th>
                                <?php } ?>
                                <?php if (($list_settings->Title == 1)) { ?>
                                <th class="sorting"><?php echo $translate->_("Title"); ?></th>
                                <?php } ?>
                                <?php if (($list_settings->Des == 1)) { ?>
                                <th class="sorting"><?php echo $translate->_("Desc"); ?></th>
                                <?php } ?>
                                <?php if (($list_settings->Order == 1)) { ?>
                                <th class="sorting"><?php echo $translate->_("OrderBy"); ?></th>
                                <?php } ?>
                                <?php if (($list_settings->Visit_Num == 1)) { ?>
                                <th class="sorting"><?php echo $translate->_("Visitors Count"); ?></th>
                                <?php } ?>
                                <?php if (($list_settings->DateTime == 1)) { ?>
                                <th class="sorting"><?php echo $translate->_("Date"); ?></th>
                                <th class="sorting"><?php echo $translate->_("Time"); ?></th>
                                <?php } ?>
                                <?php if (($list_settings->Active == 1)) { ?>
                                <th class="sorting"><?php echo $translate->_("Active"); ?></th>
                                <?php } ?>
                                <?php if ($this->length('dkvs') !== 0) { ?>
                                <?php foreach ($dkvs as $dkv): ?>
                                    <th><?php echo $dkv->DataKeyvalueLang->Title?></th>
                                <?php endforeach; ?>
                                <?php } ?>

                                <th class="sorting"><?php echo $translate->_("Edit/Delete"); ?></th>

                            </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($page->items as $content): ?>
                                <tr class="gradeX">
                                    <td><label class="mt-checkbox mt-checkbox-single mt-checkbox-outline"><input type="checkbox" name="deleteCheckbox[]" class="checkboxes" value="<?php echo $content->ID ?>"><span></span></label></td>
                                    <?php if (($list_settings->Img == 1)) { ?>
                                    <td><img src="<?= $this->url->get('uploads/') ?><?php echo $content->Offers->Img ?>" style="width: 50px;height: 50px;"></td>
                                    <?php } ?>
                                    <?php if (($list_settings->Title == 1)) { ?>
                                    <td><?php echo $content->Offers->Title ?></td>
                                    <?php } ?>
                                    <?php if (($list_settings->Des == 1)) { ?>
                                    <td><?php echo $content->Offers->Des ?></td>
                                    <?php } ?>
                                    <?php if (($list_settings->Order == 1)) { ?>
                                    <td><?php echo $content->Offers->Order ?></td>
                                    <?php } ?>
                                    <?php if (($list_settings->Visit_Num == 1)) { ?>
                                    <td><?php echo $content->Offers->Visit_Num ?></td>
                                    <?php } ?>
                                    <?php if (($list_settings->DateTime == 1)) { ?>
                                    <td><?php echo date('m/d/Y', $content->Offers->DateTime); ?></td>
                                    <td><?php echo date('H:i:s', $content->Offers->DateTime); ?></td>
                                    <?php } ?>
                                    <?php if (($list_settings->Active == 1)) { ?>
                                    <td>
                                        <?php if($content->Offers->Active ==1): ?>
                                            <i class="text-success glyphicon glyphicon-ok" aria-hidden="true"></i>
                                        <?php else: ?>
                                            <i class="text-warning glyphicon glyphicon-remove" aria-hidden="true"></i>
                                        <?php endif;?>
                                    </td>
                                    <?php } ?>
                                    <?php if ($this->length('dkvs') !== 0) { ?>
                                    <?php foreach ($dkvs as $dkv): ?>
                                    <td>
                                        <?php
                                         $kv_userdata = DataKeyvalueUserdata::findFirst("DKV_ID={$dkv->ID} AND Item_ID={$content->ID}");
                                        if(!isset($kv_userdata->Value)){
                                            echo "";
                                        }else{
                                         echo \Vokuro\Pentavalue\Keyvalue::getKeyvalue($kv_userdata->DataKeyvalue->CKV_ID,$kv_userdata->DKV_ID,$kv_userdata->Value);
                                        }
                                        ?>

                                    </td>
                                    <?php endforeach; ?>
                                    <?php } ?>
                                    <td>
                                        <div class="btn-group" style="position:relative">
                                            <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> <?php echo $translate->_("Edit/Delete"); ?>
                                                <i class="fa fa-angle-down"></i>
                                            </button>
                                            <ul class="dropdown-menu" role="menu">

                                                <li>
                                                    <a href="<?= $this->url->get('content/edit/') ?><?php echo $content->Offers->ID ?>" data-toggle="modal">
                                                        <i class="icon-tag"></i> <?php echo $translate->_("Edit"); ?></a>
                                                </li>

                                                <li>
                                                    <a href="<?= $this->url->get('content/delete/') ?><?php echo $content->Offers->ID ?>" class="">
                                                        <i class="icon-user"></i> <?php echo $translate->_("Delete"); ?> </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            <?php endforeach; ?>

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

            </div>

            <!-- <div class="row">
                <div class="col-md-5 col-sm-5">
                    <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                        <?php echo $page->current, "/", $page->total_pages ?>
                    </div>
                </div>
                <div class="col-md-7 col-sm-7"><div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                        <ul class="pagination" style="visibility: visible;">
                            <li><?php echo $this->tag->linkTo("content/index/{$Module_ID}", $translate->_("First")) ?></li>
                            <li><?php echo $this->tag->linkTo("content/index/{$Module_ID}?page=" . $page->before, $translate->_("Back")) ?></li>
                            <li><?php echo $this->tag->linkTo("content/index/{$Module_ID}?page=" . $page->next, $translate->_("Next")) ?></li>
                            <li><?php echo $this->tag->linkTo("content/index/{$Module_ID}?page=" . $page->last, $translate->_("Last")) ?></li>
                        </ul>
                    </div>
                </div>
            </div> -->

        </div>
        <style>
            .contentImg {
                height: 100px;
                width: 100px;
            }
        </style>
    </div>
    <script>var module_id=<?= $Module_ID ?></script>

    <?= $this->tag->javascriptInclude('js/filters/content.js') ?>
    <style>
        #sample_1 tfoot th.filter input{
            width:100px;
            height:25px;
        }
    </style>
<?php endif; ?>
<!------ End OF List ------->


<script type="text/javascript">
    $( document ).ready(function() {
        $('#date_from').datepicker({
            format: "yyyy-mm-dd"
        });
        $('#date_to').datepicker({
            format: "yyyy-mm-dd"
        });
    });

</script>








