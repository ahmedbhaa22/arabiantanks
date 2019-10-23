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
            <span class="caption-subject bold uppercase">{{ translate._("Logs") }}</span>
        </div>

        <div class="actions">

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

                        <th class="sorting">{{ translate._("User") }}</th>
                        <th class="sorting">{{ translate._("Module") }}</th>
                        <th class="sorting">{{ translate._("Link") }}</th>
<!--                        <th class="sorting">{{ translate._("Item") }}</th>-->
                        <th class="sorting">{{ translate._("Action") }}</th>
                        <th class="sorting">{{ translate._("Date") }}</th>
                        <th class="sorting">{{ translate._("Edit Type") }}</th>
                        <!--                        --><?php
                        //                        foreach ($main_depts as $main_dept):
                        //                            ?>
                        <!--                            <th class="sorting">--><?php //echo $main_dept->Title; ?><!--</th>-->
                        <!--                            --><?php
                        //                        endforeach;
                        //                        ?>



                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($page->items as $content): ?>
                        <tr class="gradeX">

                            <td><a href="{{url('log/user/')}}<?php echo $content->user_id ?>"><?php echo $content->Users->User ?></a></td>
                            <td><a href="{{url('content/main/')}}<?php echo $content->module_id ?>"><?php echo $content->Module->Title ?></a></td>
                            <td><a href="{{ url() }}<?php echo $content->link ?><?php echo $content->item_id?>">{{ translate._("View Content") }}</a></td>
<!--                            <td>--><?php //echo $content->item_id ?><!--</td>-->
                            <td><?php echo $content->action ?></td>
                            <td><?php echo $content->date ?></td>
                            <td><?php echo $content->Model ?></td>

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
                            <li><?php echo $this->tag->linkTo("log/index/", "First") ?></li>
                            <li><?php echo $this->tag->linkTo("log/index/?page=" . $page->before, "Previous") ?></li>
                            <li><?php echo $this->tag->linkTo("log/index/?page=" . $page->next, "Next") ?></li>
                            <li><?php echo $this->tag->linkTo("log/index/?page=" . $page->last, "Last") ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <style>
        .contentImg{
            height:100px;
            width:100px;
        }
    </style>