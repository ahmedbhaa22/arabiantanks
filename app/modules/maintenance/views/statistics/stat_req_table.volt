<table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
    <thead>
    <tr>
        <th>النسبة التقريبة</th>
        <th>إجمالي طلبات الصيانة</th>
        <th>سعة الخزان  </th>
        <th>الاجراءات</th>
    </tr>
    </thead>
    <tbody>
    {%for item in content['items']%}
    <tr class="odd gradeX">
        <td>{{(item["count_group"]/content["total_requests"]*100)|round}}%</td>
        <td>{{item["count_group"]}} </td>
        <td>{{item["category_attribute_value"]}} </td>
        <td>
            <a href="{{url('maintenance_module/statistics/stat_report')}}&val={{item['category_attribute_value']}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i>مشاهدة </a>
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
                <li class='stat_req__page'><a href="1">الأول</a></li>
                <li class='stat_req__page'><a href="{{content['before']}}">السابق</a></li>
                <li class='stat_req__page'><a href="{{content['next']}}">التالي</a></li>
                <li class='stat_req__page'><a href="{{content['last']}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>

<script>
    $(".stat_req__page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/statistics/stat_req_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.
        console.log("logged");
        $.ajax({
            type: "POST",
            url: url,
            //data: $("#exchange_reports_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#stat_req").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>
