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
                {% if session.get('auth-identity')['Lang_ID'] == 1 %}
                    إلغاء الفلتر
                {% else %}
                    Reset Filter
                {% endif %}
            </a>
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
                                            <?php
                                            echo $this->tag->select(
                                                [
                                                    "status",
                                                    $statuses,
                                                    "using" => [
                                                        "ID",
                                                        "display_name",
                                                    ]
                                                ]
                                            );
                                            ?>
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
                    id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting"><?php echo $translate->_("Order_ID"); ?></th>
                        <th class="sorting"><?php echo $translate->_("User"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Date"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Time"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Status"); ?></th>

                        <th class="sorting"><?php echo $translate->_("Edit/Delete"); ?></th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($items as $content): ?>
                        <tr class="gradeX">
                            <td><?php echo $content->ID ?></td>
                            <td><?php echo $content->UsersMobile->Title ?></td>
                            <td><?php echo date('m/d/Y', $content->Date) ?></td>
                            <td><?php echo date('H:i:s', $content->Date) ?></td>
                            <td><?php echo $content->OrderStatus->Status_Name ?></td>
                            <td>
                                <div class="btn-group" style="position:relative">
                                    <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown"
                                            aria-expanded="false"> {{translate._("Action")}}
                                        <i class="fa fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">

                                        <li>
                                            <a href="{{url('orders/vieworder') }}/<?php echo $content->ID ?>"
                                               data-toggle="modal">
                                                <i class="icon-tag"></i>{{translate._("View")}}</a>
                                        </li>


                                    </ul>
                                </div>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                    </tbody>
                </table>
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