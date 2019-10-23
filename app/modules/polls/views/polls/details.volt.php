<!-- BEGIN PAGE HEADER-->
<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="<?= $this->url->get('index') ?>"> الإستفتاءات </a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <a href="<?= $this->url->get('polls/view/') . $question->poll->id ?>">عرض الاستفتاء </a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <a href="<?= $this->url->get('polls/details/') . $question->id ?>">نتائج عنوان الإستفتاء</a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            تفصيل النتائج
        </li>
    </ul>
</div>

<div class="col-lg-12">
    <div class=" ">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('<?= $this->url->getStatic('polls/img/banners/poll.png') ?>') center center no-repeat ; background-size: contain"></div>
            </div>

        </div>
    </div>

</div>
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-list-ul"></i>
            <span class="caption-subject bold uppercase">
               <?= $question->poll->name ?>
            </span>
        </div>
        
    </div>


    <div class="portlet-body">
        <div class="row gap">
            <table class="table poll-result">
                <thead>
                    <tr>
                        <th colspan="2">
                            <?= $question->text ?>   
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($question->answers as $answer) { ?>
                    <tr>
                        <td>
                            <img class="thumb circle" src="https://x1.xingassets.com/assets/frontend_minified/img/users/nobody_m.original.jpg">
                            <?= $answer->text ?>
                        </td>
                        <td>
                            <?= $answer->getPercentage() ?>%
                            <div class="progress poll-progress">
                                <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="<?= $answer->getPercentage() ?>" aria-valuemin="0" aria-valuemax="100" style="width:<?= $answer->getPercentage() ?>%">
                                <?= $answer->getPercentage() ?>%
                                </div>
                            </div>
                        </td>
                    </tr>
                    <?php } ?>
                </tbody>
            </table>
            <!-------- pie char -->
            <!-- There is a 2 js in the header -->
                <div id="container" style="min-width: 310px; min-height: 400px; max-width: 100%; margin: 0 auto; background-color: #f9f9f9"></div>

                <script type="text/javascript">

                    Highcharts.chart('container', {
                        chart: {
                            plotBackgroundColor: null,
                            plotBorderWidth: null,
                            plotShadow: false,
                            type: 'pie'
                        },
                        title: {
                            text: '<?= $this->escaper->escapeHtml($question->text) ?>'
                        },
                        tooltip: {
                            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                        },
                        plotOptions: {
                            pie: {
                                allowPointSelect: true,
                                cursor: 'pointer',
                                dataLabels: {
                                    enabled: true,
                                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                                    style: {
                                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                                    }
                                }
                            }
                        },
                        series: [{
                            name: 'Answers',
                            colorByPoint: true,
                            data: <?= $question->getAnswersJson() ?>
                        }]
                    });
                </script>
            <!-------- end pie chart-->


        </div>

        
        <div class="clearfix"></div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->