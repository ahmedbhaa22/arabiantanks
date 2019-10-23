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
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Orders"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('orders/index/') ~Module_ID}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Back"); ?>
            </a>
        </div>

    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">
<!--            <div class="row col-sm-2"><button id="filter-toggle-btn" class="btn btn-default col-sm-12">--><?php //echo $translate->_("Filter"); ?><!--</button></div>-->
            <div class="clear"></div>
<!--            <div class="row col-sm-12" id="filter-toggle">-->
<!--                <form method="POST" action="{{ url('orders/filter/') ~Module_ID}}" enctype="multipart/form-data">-->
<!--                    <div class="col-md-6 col-xs-12">-->
<!--                        <div class="form-group">-->
<!--                            <div class="col-md-12">-->
<!--                                <label class="control-label col-md-2 bg-info col-sm-2">Status</label>-->
<!--                                <div class="col-md-10 col-sm-10">-->
<!--                                    --><?php
//                                    echo $this->tag->select(
//                                        [
//                                            "status",
//                                            $statuses,
//                                            "using" => [
//                                                "ID",
//                                                "Status_Name",
//                                            ]
//                                        ]
//                                    );
//                                    ?>
<!--                                </div>-->
<!--                            </div>-->
<!---->
<!--                        </div>-->
<!--                    </div>-->
<!--                    <div class="form-group">-->
<!--                        <div class="col-md-12 col-xs-12">-->
<!--                            <input type="hidden" value="{{ Module_ID}}"/>-->
<!--                            <input type="submit" value="--><?php //echo $translate->_("Apply Filter"); ?><!--" class="btn btn-default">-->
<!--                        </div>-->
<!--                    </div>-->
<!--                </form>-->
<!--            </div>-->
            <div class="table-scrollable">
                <table
                    class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                    id="sample_or" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting"><?php echo $translate->_("Order_ID"); ?></th>
                        <th class="sorting"><?php echo $translate->_("User"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Date"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Time"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Status"); ?></th>

                        <th class="sorting"><?php echo $translate->_("Action"); ?></th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($page->items as $content): ?>
                        <tr class="gradeX">
                            <td><?php echo $content->ID ?></td>
                            <td><?php echo $content->UsersMobile->Title ?></td>
                            <td><?php echo date('m/d/Y', $content->Date) ?></td>
                            <td><?php echo date('H:i:s', $content->Date) ?></td>
                            <td><?php echo $content->OrderStatus->Status_Name ?></td>
                            <td>
                                <a href="{{url('orders/vieworder/') ~ content.ID }}" class="btn btn-xs btn-success">
                                    <i class="fa fa-eye" aria-hidden="true"></i>
                                </a>
                                <!--<div class="btn-group" style="position:relative">
                                    <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown"
                                            aria-expanded="false"> إجراء
                                        <i class="fa fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">

                                        <li>
                                            <a href="{{url('orders/vieworder') }}/<?php echo $content->ID ?>"
                                               data-toggle="modal">
                                                <i class="icon-tag"></i>عرض</a>
                                        </li>


                                    </ul>
                                </div>-->
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
                            <li><?php echo $this->tag->linkTo("orders/ordersuser/{$Module_ID}"."?id={$User_ID}", "First") ?></li>
                            <li><?php echo $this->tag->linkTo("orders/ordersuser/{$Module_ID}?page=" . $page->before."&id={$User_ID}", "Previous") ?></li>
                            <li><?php echo $this->tag->linkTo("orders/ordersuser/{$Module_ID}?page=" . $page->next."&id={$User_ID}", "Next") ?></li>
                            <li><?php echo $this->tag->linkTo("orders/ordersuser/{$Module_ID}?page=" . $page->last."&id={$User_ID}", "Last") ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
