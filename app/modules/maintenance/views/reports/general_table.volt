<div class="printable-header">
    <div class="col-xs-4">
        <img src="{{url('img')}}/logo-original.png" height="50">
    </div>
    <div class="col-xs-4 text-center">
        <h4>تقرير عام لطلبات الصيانة </h4>

    </div>
    <div class="col-xs-4"></div>
</div>
<table class="table table-striped table-bordered table-hover table-checkable order-column table-condensed" id="">
    <thead>
    <tr>
        <th class="small-col">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="group-checkable"
                       data-set="#sample_1 .checkboxes"/>
                <span></span>
            </label>
        </th>
        <th class="small-col">ID</th>
        <th class="small-col">رقم الطلب</th>
        <th>اسم العميل</th>
        <th> تليفون </th>
        <th>العنوان</th>
        <th>فرع الصيانة</th>

        <th>اسم المنتج</th>
        <th> الصياانة المطلوبة </th>
        <th>حالة الطلب</th>
        <th>تاريخ </th>
        <th>الاجراءات </th>
    </tr>
    </thead>
    <tbody>
    {%for item in content['items']%}
    <tr>
        <td>
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="checkboxes" name="" value="{{item['id']}}"/>
                <span></span>
            </label>
        </td>
        <td>{{item['id']}}</td>
        <td>{{item['ticket_number']}}</td>
        <td>{{item['client_name']}}</td>
        <td>{{item['client_mobile']}} </td>
        <td>{{item['client_address']}}</td>
        <td>{{item['maintenance_branch']}}</td>

        <td><a href="#">{{item['product_name']}}</a></td>
        <td>{{item['problem_name']}}</td>
        <td> <span class="label {{item['list_status_class']}}">{{item['ticket_status_name']}}</span> </td>
        <td>{{item['created_at']}}</td>
        <td>
            <a href="{{url('maintenance_module/requests/view/') ~item['id']}}" class="btn btn-primary btn-xs view-btn">
                <i class="fa fa-eye"></i> مشاهدة
            </a>
        </td>

    </tr>
    {%endfor%}
    </tbody>
</table>
<div class="row">
    <div class="col-md-5 col-sm-5">
        <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
            {{content['total_pages']}}/{{content['current']}}                    </div>
    </div>
    <div class="col-md-7 col-sm-7">
        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
            <ul class="pagination" style="visibility: visible;">
                <li class='general_reports_page'><a href="1">الأول</a></li>
                <li class='general_reports_page'><a href="{{content['before']}}">السابق</a></li>
                <li class='general_reports_page'><a href="{{content['next']}}">التالي</a></li>
                <li class='general_reports_page'><a href="{{content['last']}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="portlet-body">
    <div class="panel panel-info">
        <div class="panel-heading clearfix">

            <div class=" col-md-4">
                <div class="col-lg-5 col-xs-6"> عدد الطلبات </div>
                <div class="col-lg-7 col-xs-6 text-info bold">
                    {{content["total_items"]}}
                </div>
            </div>


        </div>

        <div class="panel-body" id="report">


        </div>
    </div>
</div>

<script>
    $(".general_reports_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/reports/general_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.
        console.log("logged");
        $.ajax({
            type: "POST",
            url: url,
            data: $("#general_reports_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#general_req_report").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>