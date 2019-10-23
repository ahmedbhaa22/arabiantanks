
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
            <a type="button" href="#" id="filter-toggle-btn" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                {{ translate._("Filter") }}
            </a>
        </div>

    </div>



    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="row col-sm-12" id="filter-toggle">
                <form method="POST" action="{{ url('data_forms/search/') }}" enctype="multipart/form-data">
                    <div class="col-md-6 col-xs-12">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Module"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php
                                    echo $this->tag->select(
                                        [
                                            "Module",
                                            $Modules,
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
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Title"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <input type="text" name="Title" id="" />
                                </div>
                            </div>

                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Type"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <input type="text" name="Type" id="" />
                                </div>
                            </div>

                        </div>


                    </div>
                    <div class="form-group">
                        <div class="col-md-12 col-xs-12">

                            <input type="submit" value="<?php echo $translate->_("Apply Filter"); ?>" class="btn btn-default">
                        </div>
                    </div>
                </form>
            </div>
            <div class="table-scrollable">
                <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting">اسم الفورم</th>
                        <th class="sorting">النوع</th>
                        <th class="sorting">الموديول</th>


                        <th class="sorting">إجراءات</th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($page->items as $content): ?>

                        <a href="{{url('data_forms_response/index/')}}<?php $content->ID ?>">
                            <tr class="gradeX">
                                <td><?php echo $content->Lang->Title//echo $content->Lang->Title ?></td>

                                <td><?php echo $content->Forms->Type ?></td>
                                <td><?php echo $content->Forms->Module->Title ?></td>

                                <td>
                                    <div class="btn-group" style="position:relative">
                                        <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> إجراء
                                            <i class="fa fa-angle-down"></i>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">

                                            <li>
                                                <a href="{{url('data_forms_response/index/')}}<?php echo $content->ID ?>" data-toggle="">
                                                    <i class="icon-tag"></i> عرض الرسائل</a>
                                            </li>

                                            <!--                                        <li>-->
                                            <!--                                            <a href="{{url('data_forms/delete/')}}--><?php //echo $content->ID ?><!--" class="delete-general" onclick="return confirm('هل أنت متأكد من حذف هذا القسم الرئيسي ؟');">-->
                                            <!--                                                <i class="icon-user"></i> حذف الفورم </a>-->
                                            <!--                                        </li>-->

                                        </ul>
                                    </div>
                                </td>
                            </tr>
                        </a>
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
                            <li><?php echo $this->tag->linkTo("data_forms/search/?Type={$Type}&Module={$Module}&Title={$Title}", "First") ?></li>
                            <li><?php echo $this->tag->linkTo("data_forms/search/?Type={$Type}&Module={$Module}&Title={$Title}&page=" . $page->before, "Previous") ?></li>
                            <li><?php echo $this->tag->linkTo("data_forms/search/?Type={$Type}&Module={$Module}&Title={$Title}&page" . $page->next, "Next") ?></li>
                            <li><?php echo $this->tag->linkTo("data_forms/search/?Type={$Type}&Module={$Module}&Title={$Title}&page" . $page->last, "Last") ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
