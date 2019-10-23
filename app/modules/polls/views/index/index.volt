<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> الإستبيان </span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>
<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get('img')}}/banners/poll.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-list-ul"></i>
            <span class="caption-subject bold uppercase">
                                    الإستبيان
                                </span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('polls/ask')}}" class="btn green-jungle "><i class="fa fa-user" aria-hidden="true"></i> إستبيان عميل جديد</a>

            <a type="button" href="{{url('polls/create')}}" class="btn green-jungle btn-outline">
                <i class="fa fa-question-circle" aria-hidden="true"></i> إنشاء إستبيان</a>
        </div>

    </div>

    <div class="portlet-body">
        <table class="table table-striped table-bordered table-hover table-checkable order-column"
               id="sample_1">
            <thead>
            <tr>
                <th style="width: 2%;">
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="group-checkable"
                               data-set="#sample_1 .checkboxes"/>
                        <span></span>
                    </label>
                </th>
                <th> عنوان الإسنبيان</th>
                <th style="width: 5%;"> عدد الإجابات</th>
                <th > إجراءات</th>
            </tr>
            </thead>
            <tbody>
            {%for item in content["items"]%}
            <tr>
                <td>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="checkboxes" value="1"/>
                        <span></span>
                    </label>
                </td>
                <td>{{item['name']}} </td>
                <td>  </td>
                <td>
                    <a href="{{url('polls/edit/'~item['id'])}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> تعديل</a>

                    <a href="{{url('polls/viewPollResponses/'~item['id'])}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> مشاهدة</a>

                    <a href="{{url('polls/poll_stat/') ~item['id']}}" class="btn btn-xs btn-success">  <i class="fa fa-pie-chart" aria-hidden="true"></i>إحصائيات </a>

                    <button data-poll_id="{{item['id']}}" class="btn btn-xs btn-danger delete_poll"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                </td>
            </tr>
            {%endfor%}


            </tbody>
        </table>
        <div class="clearfix"></div>
    </div>
</div>
<script type="text/javascript">
    $('.delete_poll').on('click', function()
    {
       if(confirm('أنت على وشك حذف إستبيان، إستكمال العملية؟'))
    {
        $.ajax({
            type: 'post',
            url: "{{url('polls/deletePoll')}}",
            data: {poll_id: $(this).data('poll_id')},
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('index')}}";
                    break;
                }
            }
        });
    } 
    });
</script>