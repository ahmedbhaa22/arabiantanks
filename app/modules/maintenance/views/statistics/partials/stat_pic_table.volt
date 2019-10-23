{%for item in content["items"]["result"]%}
<div class="col-md-4 ">
    <div class="product-img-div">
        <img src="{{url('uploads/') ~item['photo']}}" style="width:100%" />
    </div>
</div>
<div class="col-md-8 ">
    <table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
        <thead>
        <tr>
            <th> النسبة</th>
            <th>إجمالي طلبات الصيانة</th>
            <th>رقم المشكله على الصورة</th>
            <th>اسم المشكلة</th>
        </tr>
        </thead>
        <tbody>
        {%for problem in item["problems"]%}
        <tr class="odd gradeX">
            <td> {{(problem["count_group"]/content["total_requests"]*100)|round}}%</td>
            <td>{{problem["count_group"]}}</td>
            <td>{{problem["problem_spot"]}}</td>
            <td>{{problem["problem_name"]}}</td>
        </tr>
        {%endfor%}
        </tbody>
    </table>

</div>
<div class="clearfix" ></div>
{%endfor%}
