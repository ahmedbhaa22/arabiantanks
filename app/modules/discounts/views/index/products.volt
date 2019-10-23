<div class="panel panel-success gap" id="add-products">
    <div class="panel-heading">
        <div class="panel-title">
            <i class="fa fa-filter"></i>
            إختيار المنتجات
        </div>
    </div>
    <div class="panel-body">
        <div class="panel panel-info">
            <div class="panel-body">
                <form role="form" id="products_filter" method="post">
                    <div class="row">
                        <div class="col-sm-5 no-padding">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class=" control-label">اسم المنتج</label>
                                    <input type="text" class="form-control" name="product_name" value="{{filter['product_name']}}">
                                </div>
                            </div>
                            <div class="col-sm-12">
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

<!--                            <div class="col-sm-12">-->
<!--                                <div class="form-group">-->
<!--                                    <label class=" control-label">  المنطقة</label>-->
<!--                                    <select class="form-control" name="product_region">-->
<!--                                        <option>جميع</option>-->
<!--                                        <option> مكة </option>-->
<!--                                        <option>الرياض</option>-->
<!--                                        <option>المدينة</option>-->
<!--                                    </select>-->
<!--                                </div>-->
<!--                            </div>-->
                            <div class="col-sm-12">
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
                        </div>


                        <div class="col-sm-5">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">  </label>
                                <div class="dept_tree col-sm-10">
                                    <ul>
                                        <?php
                                        $cats = new \Models\Content();
                                        $main_depts = DataCmsDepts::find(array("Module_ID=8 AND ID=4"));
                                        foreach ($main_depts as $main_dept) {
                                            //if($main_dept->ID==30){continue;}
                                            ?>

                                                <?php

                                                $get_lang=\DataCmsDeptsLang::findFirst("core_dept_id={$main_dept->ID} AND lang_id={$this->session->get('auth-identity')['Lang_ID']}");
                                                if(!$get_lang){
                                                    echo '<div class="main-cat">
                                                <input type="checkbox" name="Depts_ID[]" value="">'.$main_dept->Title.'</div>';

                                                }else{
                                                    echo '<div class="main-cat">
                                                <input type="checkbox" name="Depts_ID[]" value="">'.$main_dept->Title.'</div>';
                                                }


                                                ?>

                                            <?php
                                            $cats->buildEditTree(\DataCmsDeptsRel::find([
                                                "Core_Depts_ID=" . $main_dept->ID
                                            ]), 0,$filter['departments'],$this->session->get('auth-identity')['Lang_ID']);
                                        }

                                        ?>
                                    </ul>
                                </div>

                            </div>
                        </div>
                        <div class="col-sm-12" style="vertical-align: bottom">
                            <button class="btn btn-primary">فلتر</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="panel panel-info">
            <form role="form" id="products_filter" method="post" action="{{this.url_shared.get('discounts_module/index/add_discount_cat') }}">
                <label class=" control-label">اضافة الخصم لتصنيف</label>

                <div class="dept_tree col-sm-10">
                    <ul>
                        <?php
                        $cats = new \Models\Content();
                        $main_depts = DataCmsDepts::find(array("Module_ID=8 AND ID=4"));
                        foreach ($main_depts as $main_dept) {


                            $get_lang=\DataCmsDeptsLang::findFirst("core_dept_id={$main_dept->ID} AND lang_id={$this->session->get('auth-identity')['Lang_ID']}");

                            $cats->buildEditTree(\DataCmsDeptsRel::find([
                                "Core_Depts_ID=" . $main_dept->ID
                            ]), 0,$filter['departments'],$this->session->get('auth-identity')['Lang_ID']);
                        }

                        ?>
                    </ul>
                </div>
                <input type="hidden" name="discount_id" value="{{discount.id}}"/>
               <div class="col-sm-12"><input type="submit" class="btn btn-primary" name="discount_name" value="{{translate._('Save')}}"></div>
            </form>
        </div>
        <div class="row">
            <div id="LoadingImage" style="display: none">
                Wait ...
            </div>
        </div>
        <form action="">
            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="products_table">
                <thead>
                <tr>
                    <th>صورة المنتج</th>
                    <th style="width: 50%">اسم المنتج</th>
                    <th>السعر </th>
                    <th style="width: 15%">
                        إختيار المنتج
                    </th>
                    <th>السعر بعد الخصم</th>
                </tr>
                </thead>
                <tbody>
                {%for product in products['content']%}
                <?php ?>
                <tr class="odd gradeX">
                    <td><img src="{{product['image']}}" height="60px" /></td>
                    <td style="width: 50%"><a href="{{url('cms_module/content/productView/') ~product['id']}}"> {{product['name']}}</a></td>
                    <?php
                    $price = "";
                    foreach ($product['more'] as $item){
                        if($item["key"] == "extra"){
                            foreach ($item["value"] as $row){
                                if($row["parameter"] == "price"){
                                     $price = $row["value"];
                                    break;
                                }
                            }
                        }
                    }
                    ?>
                    <td><input type="text" class="form-control" id="price{{product['id']}}" value="{{price}}" readonly
                       />
                    </td>
                    <td class="funkyradio" style="width: 15%">
                        <div class="funkyradio-info">
                            <input type="checkbox" name="product{{product['id']}}" id="product{{product['id']}}" class="product_add_checkbox" value="{{product['id']}}">
                            <label for="product{{product['id']}}"> إختيار المنتج </label>
                        </div>
                    </td>
                    <td><input type="text" class="form-control" id="priceAfter{{product['id']}}" readonly/></td>
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

        </form>
    </div>
</div>


<div class="col-sm-12">
    <button class="btn btn-success add_products_to_discount"> اضافة الخصم للمنتجات المحددة </button>
    <button class="btn dark">إلغاء</button>
</div>

<script>
    var arr = new Array();
    $('.product_add_checkbox').on('change', function() {
        var val = this.value ? this.value : '';
        if ( $(this).is(':checked') ) {
            if(val!=""){
                arr.push(val);
                var price = $('#price'+val).val();
                console.log("price="+price);
                var discount_percentage = {{discount.percentage}};
                console.log("discount="+discount_percentage);
                var priceAfter= price - price * discount_percentage /100;
                $('#priceAfter'+val).val(priceAfter);
            }
        }else {
            arr.pop(val);
            $('#priceAfter'+val).val("");
            console.log("updated"+val);
        }



    });
    $(".add_products_to_discount").click(function(){
        console.log(arr);
        var url = "{{url('discounts_module/index/addProuctToDiscount/') ~discount.id}}";
        $.ajax({
            type: "POST",
            url: url,
            data:{ productsArray: arr }, // serializes the form's elements.
            success: function (response)
            {

                alert (response);
            }
        });
    });

    $("#products_filter").submit(function(e) {
        e.preventDefault();
        $("#products_table").hide();
        $("#LoadingImage").show();
        var url = "{{url('discounts_module/index/products/' ~discount.id)}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#products_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#products_view").html(response);
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $(".discount_page a").click(function(e) {
        e.preventDefault();
        //$("#products_table").hide();
        $("#LoadingImage").show();
        var url = "{{url('discounts_module/index/products/' ~discount.id)}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#products_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#products_view").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>
