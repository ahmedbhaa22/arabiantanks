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
            <span class="caption-subject bold uppercase"> <?php echo $translate->_("APIs Manager"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('api_manager/new/')}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Api Add"); ?>
            </a>

        </div>

    </div>
    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <p><?php $this->flashSession->output() ?></p>

            <div class="clearfix"></div>
            <div class="table-scrollable">

                <!--                    <div><a href="{{url('content/index/' ~Module_ID)}}">--><?php //echo $translate->_("Search By Date"); ?><!--</a></div>-->


                <table
                    class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                    id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting"><?php echo $translate->_("View"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Title"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Des"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Project_ID"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Screen_ID"); ?></th>

                        <th class="sorting"><?php echo $translate->_("Succ. Response"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Fail Response"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Empty Response"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Type Method"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Api Link"); ?></th>
                        <th class="sorting"><?php echo $translate->_("Edit/Delete"); ?></th>

                    </tr>
                    </thead>
                    <tbody>
                    {% for row in content %}
                    <tr>
                        <td><a href="{{ url('api_manager/apiView/') ~row.id }}" target="_blank">View</a></td>
                        <td>{{ row.title }}</td>
                        <td>{{ row.des }}</td>
                        <td>{{row.project_id}}</td>
                        <td>{{row.screen_id}}</td>
                        <td>{{row.success_response}}</td>
                        <td>{{row.fail_response}}</td>
                        <td>{{row.empty_response}}</td>
                        <td>{{row.type_method}}</td>
                        <td>{{row.api_link}}</td>
                        <td></td>
                    </tr>
                    {% endfor %}

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

<style>
    #sample_1 tfoot th.filter input{
        width:100px;
        height:25px;
    }
</style>

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








