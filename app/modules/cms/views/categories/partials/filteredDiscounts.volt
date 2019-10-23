<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_12">
    <thead>
        <tr>
            <th>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="group-checkable"
                           data-set="#sample_12 .checkboxes"/>
                    <span></span>
                </label>
            </th>
            <th> ID</th>
            <th>اسم الخصم</th>
            <th> النسبة المئوية </th>
            <th>كود الكوبون</th>
            <th>تاريخ البدء </th>
            <th>تاريخ الإنتهاء</th>
            <th> عدد المنتجات تم تطبيق عليها الخصم </th>
            <th>الاجراءات</th>
        </tr>
    </thead>
    <tbody>
        {% for discount in discounts %}
            <tr class="odd gradeX">
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="checkboxes" value="{{discount.id}}"/>
                        <span></span>
                    </label>
            </td>
            <td>{{discount.id}}</td>
            <td>{{discount.name}}</td>
            <td>{{discount.percentage}}%</td>
            <td>{{discount.coupon}}</td>
            <td>{{discount.getStartDate()}}</td>
            <td>{{discount.getEndDate()}}</td>
            <td>{{discount.products.count()}}</td>
            <td>
                <a href="{{url.getStatic('discounts_module/index/view/'~discount.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                <a href="{{url.getStatic('discounts_module/index/edit/'~discount.id)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                <button data-discount_id="{{discount.id}}" class="delete_discount btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
            </td>
        </tr>

        {% endfor %}
    </tbody>
</table>