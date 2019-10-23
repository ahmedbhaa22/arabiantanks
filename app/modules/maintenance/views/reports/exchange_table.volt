<div class="printable-header">
    <div class="col-xs-4">
        <img src="{{url('img')}}/logo-original.png" height="50">
    </div>
    <div class="col-xs-4 text-center">
        <h4>تقرير عام لطلبات الصيانة </h4>
        <h5>1/6/2017 الى 8/6/2017 في الفترة من </h5>
    </div>
    <div class="col-xs-4"></div>
</div>
<table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
    <thead>
    <tr>
        <th class="hide-print">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="group-checkable"
                       data-set="#sample_1 .checkboxes"/>
                <span></span>
            </label>
        </th>
        <th> ID</th>
        <th> رقم الطلب</th>
        <th>المنطقة/الفرع</th>
        <th> اسم العميل  </th>
        <th>رقم العميل </th>
        <th>تاريخ الاضافة  </th>
        <th> حالة الإستبدال </th>
        <th>تاريخ الإستبدال</th>
        <th>ملاحظات </th>
        <th class="hide-print">الاجراءات</th>
    </tr>
    </thead>
    <tbody>
    {%for item in content['items']%}
    <tr class="odd gradeX">
        <td class="hide-print">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="checkboxes" value="1"/>
                <span></span>
            </label>
        </td>
        <td>{{item['id']}}</td>
        <td>{{item['ticket_number']}} </td>
        <td>{{item["tech_report"]["region_name"]}}/{{item["tech_report"]["branch_name"]}}</td></td>
        <td>{{item['client_name']}} </td>
        <td>{{item['client_mobile']}} </td>
        <td> {{item['created_at']}}</td>
        <td>{{item['ticket_exchange_reason_name']}}</td>
        <td>{{item["modified_at"]}}</td>
        <td> </td>
        <td>
            <a href="{{url('maintenance_module/requests/view/') ~item['id']}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

            <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
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
                <li class='exchange_reports_page'><a href="1">الأول</a></li>
                <li class='exchange_reports_page'><a href="{{content['before']}}">السابق</a></li>
                <li class='exchange_reports_page'><a href="{{content['next']}}">التالي</a></li>
                <li class='exchange_reports_page'><a href="{{content['last']}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>
<script>
    $(".exchange_reports_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/reports/exchange_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.
        console.log("logged");
        $.ajax({
            type: "POST",
            url: url,
            data: $("#exchange_reports_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#exchange_req_report").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>