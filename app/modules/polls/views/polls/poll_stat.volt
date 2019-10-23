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
            <a href="sales-polls.html"><span> أستبيان </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> إحصائيات نتائح إستبيان </span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>
<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/polls/poll.png')}}') center center no-repeat ; background-size: contain"></div>
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
                                  إحصائيات نتيجة أستبيان
                          </span>
        </div>
    </div>

    <div class="portlet-body">
        {%for question in content['questions']%}
        <div class="row gap">
            <table class="table poll-result">
                <thead>
                <tr>
                    <th colspan="2">
                      {{question["text"]}}
                    </th>
                </tr>
                </thead>
                <tbody>
                {% set vote_class_array = ['danger', 'success', 'warning'] %}
                {% set vote_class ="danger" %}
                {%for answer in question["answers"]%}
                <tr>
                    <td>
                        {{answer["text"]}}
                    </td>
                    <td>

                        {{(answer["count_answer"]/question["total_answers"]*100)|round}}%

                        <div class="progress poll-progress">
                            <div class="progress-bar progress-bar-{{vote_class}}" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:{{(answer["count_answer"]/question["total_answers"]*100)|round}}%">
                            {{(answer["count_answer"]/question["total_answers"]*100)|round}}%
                            </div>
                        </div>
                    </td>
                </tr>
                <?php $vote_class = next($vote_class_array);
                if(!$vote_class){
                    reset($vote_class_array);
                }
                ?>

                {%endfor%}







                <tr>
                    <td colspan="2">
                        <a href="{{url('polls/poll_question_stat/') ~question['id']}}" class="text-success bold">
                            <i class="fa fa-info-circle" aria-hidden="true"></i> تفاصيل الإجابات
                        </a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        {%endfor%}



        <div class="row">
            <table class="table poll-result">
                <thead>
                <tr>
                    <th colspan="2"> التقييم </th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <span class="stars" data-rating="1" data-num-stars="5"></span>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="clearfix"></div>
    </div>

</div>