<div class="  col-xs-12 no-padding space">
    <table class="table table-striped table-bordered table-hover table-checkable order-column table-condensed" id="">
        <thead>
        <tr>
            <th class="small-col">
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="group-checkable"
                           data-set=".checkboxes"/>
                    <span></span>
                </label>
            </th>
            <th class="small-col">ID</th>
            <th> تصنيف المنتج</th>
            <th> نوع المنتج </th>
            <th>تفصيل المشكلة</th>
            <th>الاجراءات </th>
        </tr>
        </thead>
        <tbody>
        {%for item in content['items']%}
        <tr>
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="checkboxes" name="" value="1"/>
                    <span></span>
                </label>
            </td>
            <td>{{item['id']}}</td>
            <td>{{item['department_name']}}</td>
            <th> <a href="">{{item['department_name']}}</a> </th>
            <td>{{item['name']}}</td>

            <td>
                <a href="{{url('maintenance_module/problems/view/') ~item['ticket_id']}}" class="btn btn-primary btn-xs view-btn">
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
                    <li class='discount_page'><a href="1">الأول</a></li>
                    <li class='discount_page'><a href="{{content['before']}}">السابق</a></li>
                    <li class='discount_page'><a href="{{content['next']}}">التالي</a></li>
                    <li class='discount_page'><a href="{{content['last']}}">الأخير</a></li>
                </ul>
            </div>
        </div>
    </div>

</div>

<script>
    $(".discount_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/problems/problems_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: [], // serializes the form's elements.
            success: function (response)
            {

                $(".portlet-body").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>