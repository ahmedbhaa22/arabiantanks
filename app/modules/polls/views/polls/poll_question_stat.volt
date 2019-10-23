<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="production.html"><span> المنتجات </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="sales.html"><span> المبيعات </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="polls.html"><span>إستبيان  </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="poll-view.html"><span> إحصائيات إجابات إستبيان </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> تفاصيل أحصائيات سؤال إستبيان </span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>
<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('img/banners/poll.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-file" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase">
                               تفاصيل إحصائيات نتيجة أستبيان
                          </span>
        </div>
    </div>

    <div class="portlet-body">
        <div class="row gap">
            <table class="table poll-result">
                <thead>
                <tr>
                    <th colspan="2">
                        ما مدى رضائك عن العربية للخزانات
                    </th>
                </tr>
                </thead>
                <tbody>
                {%for answer in content["answers"]%}
                <tr>
                    <td>
{{answer['text']}}
                    </td>
                    <td>
                        {{(answer["count_answer"]/content["total_answers"]*100)|round}}%
                        <div class="progress poll-progress">
                            <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:{{(answer["count_answer"]/content["total_answers"]*100)|round}}%">
                                {{(answer["count_answer"]/content["total_answers"]*100)|round}}%
                            </div>
                        </div>
                    </td>
                </tr>
                {%endfor%}



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
                        text: 'سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء'
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
                        data: [{
                            name: 'Option One',
                            y: 50
                        }, {
                            name: 'Option Two',
                            y: 20
                        }, {
                            name: 'Option Three',
                            y: 30
                        }, {
                            name: 'Option Four',
                            y: 10
                        }]
                    }]
                });
            </script>
            <!-------- end pie chart-->


        </div>


        <div class="clearfix"></div>
    </div>

</div>