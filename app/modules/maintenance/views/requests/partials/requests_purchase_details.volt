<div class="panel-body">
    <div class="col-xs-12">
        <h4>بيانات الشراء</h4>
    </div>
    <div class="form-group col-md-4">
        <label>فرع الشراء</label>
        <select class=" form-control" name="purchase_branch" id="purchase_branch">
            {%for item in all_branches["items"]%}
            <option value="{{item['id']}}">{{item['name']}}</option>
            {%endfor%}
        </select>
    </div>
    <div class="form-group col-md-4">
        <label>رقم فاتورة الشراء</label>
        <input type="text" class="form-control" name="purhcase_invoice_number" id="purhcase_invoice_number" />
    </div>
    <div class="form-group col-md-4">
        <label>عدد المنتجات</label>
        <input type="text" class="form-control" name="product_count" id="product_count" />
    </div>

    <div class="row">
        <div class="col-xs-12 col-md-12">
            <h4 class="text-center inside-titles">
                معلومات عن الطلب
            </h4>
        </div>
        <div class="form-group col-md-4">
            <label>المنطقة /تعيين مكان طلب الصيانة </label>
            <select id="cities" name="city">
                <option></option>
                {%for city in cities%}
                <option value="{{city.id}}">{{city.name}}</option>
                {%endfor%}
            </select>
        </div>
        <div class="form-group col-md-4">
            <label>الفرع /تعيين مكان طلب الصيانة </label>
            <div id="branches_city_container">

            </div>

        </div>
        <div class="form-group col-md-4">
            <label>ارفاق مستندات </label>
            <input type="file" name="attached_file">
        </div>
    </div>

    <div class="row">
        <div class="form-group col-md-12">
            <label>ملاحظات على الطلب </label>
            <textarea type="text" class="form-control" name="order_notes"></textarea>
        </div>
    </div>
</div>

<script>
    var branches_city_url ="{{url('maintenance_module/requests/branches_by_city/')}}";
    $("#cities").change(function() {
        var value = $(this).val();
        $("#branches_city_container").load(branches_city_url+value);
    });
    $("#purchase_branch").change(function() {
        var value = $(this).val();
        var branch = $("#purchase_branch option:selected").text();
        $('#revise_purchase_branch').text(branch);
    });
    $("#purhcase_invoice_number").change(function() {
        var value = $(this).val();
        $('#revise_purchase_invoice_number').text(value);
    });
    $("#product_count").change(function() {
        var value = $(this).val();
        $('#revise_product_count').text(value);
    });
</script>