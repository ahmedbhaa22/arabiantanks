<div class="">
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
                <a href="sales-reports.html"><span>تقارير المبيعات </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <span> أستبيان </span>
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
    <div id="printable" class="portlet light clearfix">
        <div class="portlet-title">
            <div id="print_head" class="caption font-dark">
                <span class="caption-subject bold uppercase">
                    نتائج أستبيان العميل: {{user.Title}}
              </span>
               &nbsp; <small class="text-info"><i class="fa fa-calendar" aria-hidden="true"></i> {{poll.formattedDate()}}</small>
            </div>
            
            <div class="actions bold ">
                <a type="button" id="delete_user_answers" class="btn btn-edit-my-data btn-danger btn-outline  btn-block">
				<i class="fa fa-trash" aria-hidden="true"></i>  حذف التقرير </a>
                
            </div>
        </div>
           <div class="portlet-body">
                {% for question in poll.questions %}
                    <div class="row gap">
                        <div class="print_question col-md-12 no-padding bold">
                              {{question.text}}
                        </div>
                        <div class="col-md-12 no-padding gap funkyradio">
                            {% for answer in question.answers %}
                                {% if question.userAnswer(user.ID) == answer.id %}
                                <div class="funkyradio-primary">
                                    <input disabled type="radio" name="q{{answer.id}}" id="{{answer.id}}" checked />
                                    <label for="{{answer.id}}"> {{answer.text}} </label>
                                </div>
                                {% else %}
                                <div class="funkyradio-primary">
                                    <input disabled type="radio" name="q{{answer.id}}" id="{{answer.id}}"/>
                                    <label for="{{answer.id}}"> {{answer.text}} </label>
                                </div>
                                {% endif %}
                            {% endfor  %}
                        </div>
                    </div>
                {% endfor %}
                <div class="row gap">
                    <div class="col-xs-12 no-padding hide-print">
                        <button id="print_poll" class="btn btn-info btn-md">
                            <i class="fa fa-print"></i> طباعة
                        </button>
                    </div>

                </div>
                <div class="clearfix"></div>
            </div>

    </div>

</div>
<script type="text/javascript">
    $('#print_poll').on('click', function()
    {
        var print_div = $('#printable').clone();
        print_div.find('#delete_user_answers').remove();
        print_div.find('#print_poll').remove();
        print_div.find('#print_head').append('<hr><br>');
        print_div.find('.print_question').css({
            'border-style' : 'solid',
            'border-width' : '1px',
            'padding'      : '5px',
            'margin-top'   : '5px'
        });

        var print_window = window.open('', 'PRINT', 'height=800, width=1000');
        print_window.document.write('<html><body style="direction:rtl;">'+print_div.html()+'</body></html>');

        print_window.document.close();
        print_window.focus();

        print_window.print();
        print_window.close();

        return true;

    });

    $('#delete_user_answers').on('click', function()
    {
       if(confirm('أنت على وشك حذف تقرير إستبيان لعميل، إستكمال العملية؟'))
       {
            $.ajax({
            type: 'post',
            url: "{{url('polls/deleteUserAnswers')}}",
            data:{
                user_id: "{{user.ID}}",
                poll_id: "{{poll.id}}"
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