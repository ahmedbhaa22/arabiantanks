<div class="">
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
                    <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/polls/poll.png')}}') center center no-repeat ; background-size: contain"></div>
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
<!--                    <a type="button" href="{{url('polls/ask')}}" class="btn green-jungle "><i class="fa fa-user" aria-hidden="true"></i> إستبيان عميل جديد</a>-->
<!---->
<!--                    <a type="button" href="{{url('polls/create')}}" class="btn btn-edit-my-data green-jungle btn-outline btn-block">-->
<!--                       <i class="fa fa-question-circle" aria-hidden="true"></i> إنشاء إستبيان</a>-->
                </div>

            </div>

            <div class="portlet-body">
                     <table class="table table-striped table-bordered table-hover table-checkable order-column"
                           id="">
                        <thead>
                        <tr>
                            <th style="width: 2%;">
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable"
                                           data-set="#sample_1 .checkboxes"/>
                                    <span></span>
                                </label>
                            </th>
                            <th> اسم العميل </th>
                            <th> عنوان الإسنبيان</th>
                            <th style="width: 5%;"> تاريخ الإستبيان </th>
                            <th style="width: 15%;"> إجراءات</th>
                        </tr>
                        </thead>
                        <tbody>
                            {% for user in users %}
                                <tr>
                                <td>
                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                        <input type="checkbox" class="checkboxes" value="{{user.ID}}"/>
                                        <span></span>
                                    </label>
                                </td>
                                <td> <a href="{{url.getStatic('cms_module/clients/view/'~user.ID)}}">{{user.Title}}</a>  </td>
                                <td>{{poll.name}}</td>
                                <td>{{poll.formattedDate()}}</td>
                                <td>
                                    <a href="{{url('polls/userAnswers?poll_id='~poll.id~'&user_id='~user.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i>مشاهدة</a>

                                    <button type="button" data-poll_id="{{poll.id}}" data-user_id="{{user.ID}}" class="btn btn-xs btn-danger delete_user_poll"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                </td>
                            </tr>
        
                            {% endfor %}
                        </tbody>
                    </table>

                <div class="row">
                    <div class="col-md-5 col-sm-5">
                        <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                            <?php echo $page->current, "/", $page->total_pages ?>
                        </div>
                    </div>
                    <div class="col-md-7 col-sm-7">
                        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                            <ul class="pagination" style="visibility: visible;">
                                <li><a href="{{url('polls/viewPollResponses/' ~poll.id)}}/?page=1">الأول</a></li>
                                <li><a href="{{url('polls/viewPollResponses/' ~poll.id)}}/?page={{page.before}}">السابق</a></li>
                                <li><a href="{{url('polls/viewPollResponses/' ~poll.id)}}/?page={{page.next}}">التالي</a></li>
                                <li><a href="{{url('polls/viewPollResponses/' ~poll.id)}}/?page={{page.last}}">الأخير</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="clearfix"></div>
            </div>
    </div>
</div>
<script type="text/javascript">
    $('.delete_user_poll').on('click', function()
    {
       if(confirm('أنت على وشك حذف تقرير إستبيان لعميل، إستكمال العملية؟'))
       {
            $.ajax({
            type: 'post',
            url: "{{url('polls/deleteUserAnswers')}}",
            data:{
                user_id: $(this).data('user_id'),
                poll_id: $(this).data('poll_id')
            },
            success: function(response)
            {
                response = JSON.parse(response);


                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('polls/viewPollResponses/'~poll.id)}}";
                    break;
                }
            }
           }); 
       } 
    });
</script>