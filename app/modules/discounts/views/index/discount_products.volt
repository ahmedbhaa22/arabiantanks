<div class="panel panel-success gap" id="add-products">
    <div class="panel-heading">
        <div class="panel-title">
            منتجات تم تطبيق عليها الخصم
        </div>
    </div>
    <div class="panel-body">
        <div class="panel panel-info">
            <div class="panel-body">
                <form role="form" id="products_discount_filter" method="post">
                    <div class="row">

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label">اسم المنتج</label>
                                <input type="text" class="form-control" name="product_name" value="{{filter['product_name']}}">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label"> اسم الشركة المصنعة </label>
                                <?php
                                echo $this->tag->select(
                                    [
                                        "product_company",
                                        $manufacturers,
                                        "using" => [
                                            "ID",
                                            "Title",
                                        ],
                                        "useEmpty"   => true,
                                        "emptyText"  => "الكل",
                                        "emptyValue" => "0",
                                        "class"=>"form-control"
                                    ]
                                );
                                ?>
                            </div>
                        </div>

<!--                        <div class="col-sm-4">-->
<!--                            <div class="form-group">-->
<!--                                <label class=" control-label">  المنطقة</label>-->
<!--                                <select class="form-control">-->
<!--                                    <option>جميع</option>-->
<!--                                    <option> مكة </option>-->
<!--                                    <option>الرياض</option>-->
<!--                                    <option>المدينة</option>-->
<!--                                </select>-->
<!--                            </div>-->
<!--                        </div>-->
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class="col-xs-2 no-padding control-label"> سعر المنتج </label>
                                <div class="col-xs-10 no-padding">
                                    <label class="col-xs-2 control-label"> من </label>
                                    <div class="col-xs-4 no-padding">
                                        <input type="number" class="form-control"  name="product_price_from" value="{{filter['product_price_from']}}">
                                    </div>
                                    <label class="col-xs-2 control-label"> الي </label>
                                    <div class="col-xs-4 no-padding">
                                        <input type="number" class="form-control"  name="product_price_to"  value="{{filter['product_price_to']}}">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 text-left">
                            <button class="btn btn-success">عرض المنتجات </button>
                        </div>
                    </div>

                </form>
            </div>
        </div>

        <div class="row">
            <div id="LoadingImage" style="display: none">
                Wait ...
            </div>
        </div>

        <form action="">
            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
                <thead>
                <tr>
                    <th rowspan="2">
                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" class="group-checkable"
                                   data-set="#sample_1 .checkboxes" id="select_all"/>
                            <span></span>
                        </label>
                    </th>
                    <th rowspan="2">صورة المنتج</th>
                    <th rowspan="2">اسم المنتج</th>
                    <th rowspan="2">الشركة المصنعة</th>
                    <th rowspan="2">السعر <br>الاصلي</th>
                    <th colspan="2">  فترة الخصم </th>
                    <th rowspan="2">السعر <br>بعد الخصم</th>
                    <th rowspan="2">إجراءات </th>
                </tr>
                <tr>
                    <th>من</th>
                    <th>الي</th>
                </tr>
                </thead>
                <tbody>
                {%for item in discount_items['items']%}
                <tr class="odd gradeX">
                    <td>
                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" class="checkboxes" value="{{item.data_cms_id}}"/>
                            <span></span>
                        </label>
                    </td>
                    <td><img src="{{url('uploads/') ~item.Content.Img}}" height="60px" width="100px" /></td>
                    <td><a href="{{url('cms_module/content/productView/') ~item.data_cms_id}}"> {{item.Content.Title}}</a></td>
                    <td>

                    </td>

                    <td>{{item.Content.extraFields.price}} </td>
                    <td>{{ date('d-m-Y', discount.start_date) }}</td>
                    <td>{{ date('d-m-Y', discount.end_date) }}</td>

                    <td><?php echo $item->Content->extraFields->price - $item->Content->extraFields->price * $discount->percentage / 100 ?></td>

                    <td>
                        <a target="_blank" href="{{url('cms_module/content/productView/') ~item.data_cms_id}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" ></i> مشاهدة </a>
                        <a href="{{url('discounts_module/index/deleteFromDiscount/') ~item.id}}" class="btn btn-xs btn-danger deleteFromDiscount"> <i class="fa fa-trash" ></i> خذف من الخصم </a>
                    </td>
                </tr>
                {%endfor%}

                </tbody>
            </table>

            <div class="row">
                <div class="col-md-5 col-sm-5">
                    <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                        {{pagination['num_of_pages']}}/{{pagination['current_page']}}                    </div>
                </div>
                <div class="col-md-7 col-sm-7">
                    <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                        <ul class="pagination" style="visibility: visible;">
                            <li class='discount_page'><a href="{{pagination['first_page']}}">الأول</a></li>
                            <li class='discount_page'><a href="{{pagination['back_page']}}">السابق</a></li>
                            <li class='discount_page'><a href="{{pagination['next_page']}}">التالي</a></li>
                            <li class='discount_page'><a href="{{pagination['last_page']}}">الأخير</a></li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-xs-12">
                <a class="btn btn-md btn-danger" id="delete_checked"> <i class="fa fa-trash" ></i> خذف المنتجات المحددة من الخصم </a>
            </div>
        </form>
    </div>
</div>
<script>
    $('.deleteFromDiscount').click(function(e) {
        e.preventDefault();
        var url = $(this).attr('href');
        $.ajax({
            type: "POST",
            url: url,
            success: function (response)
            {
                alert (response);
                location.reload();
            }
        });
        //alert(href);
    });

    $("#products_discount_filter").submit(function(e) {
        e.preventDefault();
        $("#products_table").hide();
        $("#LoadingImage").show();
        var url = "{{url('discounts_module/index/discount_products/' ~discount.id)}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#products_discount_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#discount_products_view").html(response);
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $(".discount_page a").click(function(e) {
        e.preventDefault();
        //$("#products_table").hide();
        $("#LoadingImage").show();
        var url = "{{url('discounts_module/index/discount_products/' ~discount.id)}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#products_discount_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#discount_products_view").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });


    $("#select_all").change(function(){  //"select all" change
        $(".checkboxes").prop('checked', $(this).prop("checked")); //change all ".checkbox" checked status
    });

    //".checkbox" change
    $('.checkboxes').change(function(){
        //uncheck "select all", if one of the listed checkbox item is unchecked
        if(false == $(this).prop("checked")){ //if this item is unchecked
            $("#select_all").prop('checked', false); //change "select all" checked status to false
        }
        //check "select all" if all checkbox items are checked
        if ($('.checkboxes:checked').length == $('.checkboxes').length ){
            $("#select_all").prop('checked', true);
        }
    });

    $("#delete_checked").click(function(e){
        e.preventDefault();
        var discount_id = "{{discount.id}}";
        var data = { 'discount_products[]' : [],'discount_id':discount_id};

        $(".checkboxes:checked").each(function() {
            data['discount_products[]'].push($(this).val());
        });
        console.log(data);
        var delete_url="{{url('discounts_module/index/delete_discount_products')}}";
        $.ajax({
            type: "POST",
            url: delete_url,
            data: data,
            success: function (response)
            {
                alert("Deleted Successfully");
                location.reload();
            }
        });

    });
</script>