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


    <div class="portlet light bordered">

        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="icon-user font-dark"></i>
                <span class="caption-subject bold uppercase"> المحتوى</span>
            </div>

            <div class="actions">

            </div>

        </div>



            <div class="col-md-2 col-sm-2">

            </div>
        </div>
        <div class="portlet-body">
            <div id="sample_1_wrapper">
                <div class="table-scrollable">
                    <table
                        class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                        id="sample_1" role="grid" aria-describedby="sample_1_info">
                        <thead>
                        <tr role="row">
                            <th class="sorting">ID</th>
                            <th class="sorting">العنوان</th>
                            <th class="sorting">الوصف</th>
                            <th class="sorting">الترتيب</th>
                            <th class="sorting">الصورة الرئيسية</th>
                            <th class="sorting">عدد الزوار</th>
                            <th class="sorting">التاريخ</th>
                            <th class="sorting">نشطة أم لا</th>
                            <th class="sorting">رقم اللغة</th>
                            <!--                        --><?php
                            //                        foreach ($main_depts as $main_dept):
                            //                            ?>
                            <!--                            <th class="sorting">-->
                            <?php //echo $main_dept->Title; ?><!--</th>-->
                            <!--                            --><?php
                            //                        endforeach;
                            //                        ?>


                            <th class="sorting">إجراءات</th>

                        </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($page->items as $content): ?>
                            <tr class="gradeX">
                                <td><?php echo $content->Content->ID ?></td>
                                <td><img class="contentImg" src="{{url('uploads/')}}<?php echo $content->Content->Img ?>"/></td>
                                <td><?php echo $content->Content->Title ?></td>
                                <td><?php echo $content->Content->Des ?></td>
                                <td><?php echo $content->Content->Order ?></td>
                                <td><?php echo $content->Content->Visit_Num ?></td>
                                <td><?php echo date('m/d/Y H:i:s', $content->Content->DateTime); ?></td>
                                <td><?php echo $content->Content->Active ?></td>
                                <td><?php echo $content->Content->Lang_ID ?></td>
                                <!--                        --><?php
                                //
                                //                        foreach ($main_depts as $main_dept):
                                //                            ?>
                                <!--                            <td class="sorting">-->
                                <?php //echo $main_dept->Title; ?><!--</td>-->
                                <!--                        --><?php
                                //                            endforeach;
                                //                            ?>


                                <td>
                                    <div class="btn-group" style="position:relative">
                                        <button class="btn btn-xs dark dropdown-toggle" type="button"
                                                data-toggle="dropdown"
                                                aria-expanded="false"> إجراء
                                            <i class="fa fa-angle-down"></i>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">

                                            <li>
                                                <a href="{{url('content/edit/')}}<?php echo $content->Content->ID ?>"
                                                   data-toggle="modal">
                                                    <i class="icon-tag"></i> تعديل </a>
                                            </li>

                                            <li>
                                                <a href="{{url('content/delete/')}}<?php echo $content->Content->ID ?>"
                                                   class="delete-general">
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
                    <div class="col-md-7 col-sm-7">
                        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                            <ul class="pagination" style="visibility: visible;">
                                <li><?php echo $this->tag->linkTo("content/filterByDept/$Dept_ID", "First") ?></li>
                                <li><?php echo $this->tag->linkTo("content/filterByDept/$Dept_ID?page=" . $page->before, "Previous") ?></li>
                                <li><?php echo $this->tag->linkTo("content/filterByDept/$Dept_ID?page=" . $page->next, "Next") ?></li>
                                <li><?php echo $this->tag->linkTo("content/filterByDept/$Dept_ID?page=" . $page->last, "Last") ?></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <style>
            .contentImg {
                height: 100px;
                width: 100px;
            }
        </style>
    </div>


<!------ End OF List ------->




















