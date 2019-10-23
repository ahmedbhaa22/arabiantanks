
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
            <span class="caption-subject bold uppercase"> المحتوى</span>
        </div>

        <div class="actions">
            <a type="button" href="<?= $this->url->get('main_departments/new/') ?>" data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                إضافة قسم رئيسي
            </a>
        </div>

    </div>



    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting">ID</th>
                        <th class="sorting">Title</th>
                        <th class="sorting">Des</th>

                        <th class="sorting">إجراءات</th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($page->items as $content): ?>
                        <tr class="gradeX">
                            <td><?php echo $content->ID ?></td>
                            <td><?php echo $content->Title ?></td>
                            <td><?php echo $content->Des ?></td>
                              <td>
                                <div class="btn-group" style="position:relative">
                                    <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> إجراء
                                        <i class="fa fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">

                                        <li>
                                            <a href="<?= $this->url->get('main_departments/edit/') ?><?php echo $content->ID ?>" data-toggle="modal">
                                                <i class="icon-tag"></i> تعديل </a>
                                        </li>

                                        <li>
                                            <a href="<?= $this->url->get('main_departments/delete/') ?><?php echo $content->ID ?>" class="delete-general">
                                                <i class="icon-user"></i> حذف </a>
                                        </li>
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
                            <li><?php echo $this->tag->linkTo("main_departments/index/{$Module_ID}", "First") ?></li>
                            <li><?php echo $this->tag->linkTo("main_departments/index/{$Module_ID}?page=" . $page->before, "Previous") ?></li>
                            <li><?php echo $this->tag->linkTo("main_departments/index/{$Module_ID}?page=" . $page->next, "Next") ?></li>
                            <li><?php echo $this->tag->linkTo("main_departments/index/{$Module_ID}?page=" . $page->last, "Last") ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
