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
