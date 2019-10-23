<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">

            <li>
                <span>الزيارات</span>
            </li>
        </ul>
    </div>
    <div class="clearfix"></div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
    <div class="portlet light clearfix">
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-users font-dark"></i>
                <span class="caption-subject bold uppercase"> الزيارات</span>
            </div>



        </div>
        <div class="portlet-body">
            <div class="panel-group accordion hide-print" id="accordion1">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">
                                <i class="fa fa-filter" aria-hidden="true"></i> فلتر وتصدير لاكسل <i class="fa fa-angle-down" aria-hidden="true"></i>
                            </a>
                        </h4>
                    </div>

                    {{ partial("polls/partials/filter_polls",["sales_persons":sales_persons,"filter":filter,"client_categories":client_categories])}}
                </div>
            </div>
            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_11">
                <thead>
                <tr>
                    <th>
                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" class="group-checkable"
                                   data-set="#sample_11 .checkboxes"/>
                            <span></span>
                        </label>
                    </th>
                    <th> نوع المهمة</th>
                    <th> اسم العميل </th>
                    <th>البريد الإلكتروني</th>
                    <th>تم إضافة العميل بواسطة</th>
                    <th>رقم التليفون</th>
                    <th> تاريخ الزيارة</th>
                    <th> تصنيف العميل</th>
                    <th>المندوب صاحب الزيارة</th>
                    <th>تم استبيان العميل أم لا</th>
                    <th>الاجراءات</th>
                </tr>
                </thead>
                <tbody>
                {% for visit in page.items %}
                <?php if(!$visit->getVisitDetails()):continue;endif; ?>
                <tr class="odd gradeX">
                    <td>
                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" class="checkboxes" value="{{visit.id}}"/>
                            <span></span>
                        </label>
                    </td>
                    <td>{{visit.VisitDetails.missionType.name_ar}}</td>
                    <td>{{visit.VisitDetails.client.Title}}</td>
                    <td>{{visit.VisitDetails.client.Mail}}</td>
                    <td>{{visit.VisitDetails.client.CreatedBy.Title}}</td>
                    <td>{{visit.VisitDetails.client.Mobile}}</td>
                    <td>{{visit.VisitDetails.formattedDate('d/m/Y')}}</td>
                    <td>
                        {% if visit.VisitDetails.client.category != null %}
                        {{visit.VisitDetails.client.category.name}}
                        {% endif %}
                    </td>
                    <td>
                        {{visit.VisitDetails.salesPerson.Title}}
                    </td>
                    <td>
                        {% if visit.done != 0 %}
                        نعم
                        {%else%}
                        لا
                        {% endif %}
                    </td>
                    <td>
                        <a href="{{this.url_shared.get('polls_module/polls_visits/ask_visit/'~visit.visit_id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> استبيان العميل</a>

                        <?php if($this->session->get('auth-identity')['is_admin']=="1"):?>
                        <a href="{{this.url_shared.get('polls_module/polls_visits/delete_visit/'~visit.visit_id)}}" class="btn btn-xs btn-danger" onclick="return confirm('هل أنت متأكد ؟')"> <i class="fa fa-eye" aria-hidden="true"></i> حذف الزياره</a>

                        <?php endif;?>
                    </td>
                </tr>
                {% endfor %}
                </tbody>
            </table>
            <ul class="pagination" style="margin-right:40%;">
                <li class="click_page" ><a href="1">&laquo;&laquo;</a></li>
                <li class="click_page" ><a href="{{ page.before }}">&laquo;</a></li>
                <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
                    {% if i == page.current %}
                    <li class="active click_page"><span>{{i}}</span></li>
                    {% else %}
                    <li class="click_page"><a href="{{i}}">{{i}}</a></li>
                    {% endif %}
                <?php } ?>
                <li class="click_page"><a  href="{{page.next}}">&raquo;</a></li>
                <li class="click_page"><a ref="{{page.last}}">&raquo;&raquo;</a></li>
            </ul>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>

<script>
    $("#polls_reports_export").click(function(e) {
        e.preventDefault();
        var url = "{{url('polls_visits/export_excel')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#sales_reports_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                var obj = jQuery.parseJSON(response);
                window.location.href ="{{this.url_shared.get('uploads/')}}"+obj.file_name;
            }
        });

        // avoid to execute the actual submit of the form.
    });


    var sales_visits_url="{{url('polls_visits/index')}}";


    $("#sales_reports_filter").submit(function(e) {


        $.ajax({
            type: "GET",
            url: sales_visits_url,
            data: $("#sales_reports_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {


            }
        });

        // avoid to execute the actual submit of the form.
    });
    $(".click_page a").click(function(e) {
        e.preventDefault();
        location.href = sales_visits_url+"?"+$("#sales_reports_filter").serialize()+"&page="+$(this).attr("href");

    });



</script>