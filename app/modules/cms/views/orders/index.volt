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

        </div>

    </div>


    <div class="portlet-body">
        <div class="panel-group accordion" id="accordion1">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">
                            <i class="fa fa-filter" aria-hidden="true"></i> <?php echo $translate->_("Filter"); ?> <i class="fa fa-angle-down" aria-hidden="true"></i>
                        </a>
                    </h4>
                </div>
                <div id="collapse-clients-filter" class="panel-collapse collapse">
                    <div class="panel-body">
                        <form method="POST" action="{{ url('orders/filter/') ~Module_ID}}" enctype="multipart/form-data">
                            <div class="col-md-6 col-xs-12">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Status"); ?></label>
                                        <div class="col-md-10 col-sm-10">
                                            <select name="status" id="status">
                                                {% for status in statuses %}
                                                    <option value="{{ status.ID }}">
                                                        {% if session.get('auth-identity')['Lang_ID'] == 1 %}
                                                            {{ status.display_name_ar }}
                                                        {% else %}
                                                            {{ status.display_name }}
                                                        {% endif %}
                                                    </option>
                                                {% endfor %}
                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Date From"); ?></label>
                                        <div class="col-md-10 col-sm-10">
                                            <input type="text" name="date_from" id="date_from" />
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Date To"); ?></label>
                                        <div class="col-md-10 col-sm-10">
                                            <input type="text" name="date_to" id="date_to" />
                                        </div>
                                    </div>

                                </div>

                            </div>
                            <div class="form-group">
                                <div class="col-md-12 col-xs-12">
                                    <input type="hidden" value="{{ Module_ID}}"/>
                                    <input type="submit" value="<?php echo $translate->_("Apply Filter"); ?>" class="btn btn-danger">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="sample_1_wrapper">

            <div class="table-scrollable">
                <table
                    class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                    id="sample_orders" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting"><?php echo $translate->_("Order_ID"); ?></th>
                        <th class="sorting"><?php echo $translate->_("User"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Date Created"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Date Updated"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Status"); ?></th>

                        <th class="sorting"><?php echo $translate->_("Action"); ?></th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($page->items as $content): ?>
                        <?php
                        $user_check=\Models\UsersMobile::findFirst(["ID={$content->User_ID}"]);
                        if(!$user_check){
                            $content->delete();
                            continue;
                        }
                        $get_notification_id = \Models\GeneralNotifications::findFirst(["order_id={$content->ID}"]);


                        ?>
                        <tr class="gradeX">
                            <td><?php echo $content->ID ?></td>
                            <td><a href="{{ url('orders/ordersuser/') ~Module_ID }}?id=<?php echo $content->User_ID ?>"><?php echo $content->UsersMobile->Title ?></a></td>
                            <td><?php echo date('Y-m-d h:i:s', $content->Date) ?></td>
                            <td><?php if($content->updated_at==1){echo"";}else{echo date('Y-m-d h:i:s', $content->updated_at);} ?></td>
                            <td><?php echo $content->OrderStatus->display_name ?></td>
                            <td>
                                <a href="{{url('orders/vieworder') }}/<?php echo $content->ID ?>{%if(get_notification_id)%}&notifi={{get_notification_id.id}}{%endif%}" class="btn btn-xs btn-success"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

<!--                                            <a href="{{url('orders/vieworder') }}/--><?php //echo $content->ID ?><!--{%if(get_notification_id)%}&notifi={{get_notification_id.id}}{%endif%}"-->
<!--                                               class="btn btn-xs btn-success">-->


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
                            <li><?php echo $this->tag->linkTo("orders/index/{$Module_ID}",  $translate->_("First")) ?></li>
                            <li><?php echo $this->tag->linkTo("orders/index/{$Module_ID}?page=" . $page->before,  $translate->_("Back")) ?></li>
                            <li><?php echo $this->tag->linkTo("orders/index/{$Module_ID}?page=" . $page->next,  $translate->_("Next")) ?></li>
                            <li><?php echo $this->tag->linkTo("orders/index/{$Module_ID}?page=" . $page->last,  $translate->_("Last")) ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.0/themes/smoothness/jquery-ui.css">
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