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



        </div>

    </div>
    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <p><?php $this->flashSession->output() ?></p>

            <div class="clearfix"></div>
            <div class="row">

            </div>
            <div class="table-scrollable">

                <table
                    class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                    id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>

                        <th class="sorting_asc" tabindex="0" aria-controls="sample_1" rowspan="1" colspan="1"
                            aria-sort="ascending" aria-label=" Project Name: activate to sort column descending"
                            style="width: 209px;"> Project Name
                        </th>
                        <th class="sorting" tabindex="0" aria-controls="sample_1" rowspan="1" colspan="1"
                            aria-label=" Description: activate to sort column ascending" style="width: 310px;">
                            Description
                        </th>
                        <th class="sorting" tabindex="0" aria-controls="sample_1" rowspan="1" colspan="1"
                            aria-label=" Num of Modules: activate to sort column ascending" style="width: 247px;"> Num
                            of Modules
                        </th>
                    </tr>
                    </thead>
                    <tbody>

                    {% for row in projects %}
                    <tr role="row" class="odd">

                        <td class="sorting_1"><a href="{{url('api_manager/group')}}?project_id={{row.id}}">{{ row.name }}</a></td>
                        <td>{{ row.description }}</td>
                        <td> 10</td>

                    </tr>
                    {% endfor %}

                    </tbody>
                </table>


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
    #sample_1 tfoot th.filter input {
        width: 100px;
        height: 25px;
    }
</style>

<!------ End OF List ------->

<script type="text/javascript">
    $(document).ready(function () {
        $('#date_from').datepicker({
            format: "yyyy-mm-dd"
        });
        $('#date_to').datepicker({
            format: "yyyy-mm-dd"
        });
    });

</script>








