
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
            <span class="caption-subject bold uppercase">الرسائل</span>
        </div>

        <div class="actions">

        </div>

    </div>



    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">

                        <th class="sorting"><?= $translate->_('Form Name') ?></th>
                        <!-- GET FORM FIELDS-->
                        <?php foreach (json_decode($fields->Response) as $key=>$v):?>
                            <th class="sorting"><?php echo $key ?></th>
                        <?php endforeach; ?>
                        <th class="sorting"><?= $translate->_('IP') ?></th>
                        <th class="sorting"><?= $translate->_('Date') ?></th>
                        <th class="sorting"><?= $translate->_('Replied or Not') ?></th>

                        <th class="sorting">إجراءات</th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($page->items as $content): ?>
                        <tr class="gradeX">

                            <td><?php echo $content->Lang->Title; ?></td>
                            <?php foreach (json_decode($content->Response) as $value): ?>
                                <td><?php echo $value ?></td>
                            <?php endforeach; ?>
                            <td><?php echo $content->IP ?></td>

                            <td><?php echo date('m/d/Y H:i:s', $content->Date); ?></td>
                            <td>
                                <?php
                                if(CpFormsReplies::findFirst(
                                    array(
                                        "Forms_Response = {$content->ID}"
                                    )
                                )){
                                    echo "نعم";
                                }
                                else{
                                    echo "لا";
                                }
                                ?>
                            </td>
                            <td>
                                <div class="btn-group" style="position:relative">
                                    <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> إجراء
                                        <i class="fa fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">

                                        <li>
                                            <a href="<?= $this->url->get('data_forms_response/view/') ?><?php echo $content->ID ?>" data-toggle="">
                                                <i class="icon-tag"></i>عرض الرسالة </a>
                                        </li>

<!--                                        <li>-->
<!--                                            <a href="<?= $this->url->get('data_forms_response/delete/') ?>--><?php //echo $content->ID ?><!--" class="delete-general" onclick="return confirm('هل أنت متأكد من حذف هذا القسم الرئيسي ؟');">-->
<!--                                                <i class="icon-user"></i> حذف </a>-->
<!--                                        </li>-->
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    <?php endforeach; ?>
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
                            <li><?php echo $this->tag->linkTo("data_forms_response/index/$Form_ID", "First") ?></li>
                            <li><?php echo $this->tag->linkTo("data_forms_response/index/$Form_ID?page=" . $page->before, "Previous") ?></li>
                            <li><?php echo $this->tag->linkTo("data_forms_response/index/$Form_ID?page=" . $page->next, "Next") ?></li>
                            <li><?php echo $this->tag->linkTo("data_forms_response/index/$Form_ID?page=" . $page->last, "Last") ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
