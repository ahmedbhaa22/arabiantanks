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
<!--                                <div class="col-sm-10 dept_tree">-->
<!--                                    <ul>-->
<!--                                        <li>-->
<!--                                            <div class="main-cat">-->
<!--                                                <input type="checkbox" name="Depts_ID[]" value=""> الخزانات-->
<!--                                            </div>-->
<!--                                            <ul class="child">-->
<!--                                                <li><input type="checkbox" name="Depts_ID[]" value="114">خزانات رأسية-->
<!--                                                    <ul class="child">-->
<!--                                                        <li><input type="checkbox" name="Depts_ID[]" value="126">خزانات دائرية-->
<!--                                                            <ul class="child"></ul>-->
<!--                                                        </li>-->
<!--                                                        <li><input type="checkbox" name="Depts_ID[]" value="126">خزانات مربعة-->
<!--                                                            <ul class="child"></ul>-->
<!--                                                        </li>-->
<!--                                                    </ul>-->
<!--                                                </li>-->
<!--                                                <li><input type="checkbox" name="Depts_ID[]" value="116">  خزانات أفقية-->
<!--                                                    <ul class="child"></ul>-->
<!--                                                </li>-->
<!--                                            </ul>-->
<!--                                        </li>-->
<!---->
<!--                                        <li>-->
<!--                                            <div class="main-cat">-->
<!--                                                <input type="checkbox" name="Depts_ID[]" value=""> أغطية أرضية-->
<!--                                            </div>-->
<!--                                            <ul class="child">-->
<!--                                                <li><input type="checkbox" name="Depts_ID[]" value="114">أغطية أرضية-->
<!--                                                    <ul class="child">-->
<!---->
<!--                                                    </ul>-->
<!--                                                </li>-->
<!--                                            </ul>-->
<!--                                        <li>-->
<!--                                            <div class="main-cat">-->
<!--                                                <input type="checkbox" name="Depts_ID[]" value=""> بوابات ميكانيكية-->
<!--                                            </div>-->
<!--                                            <ul class="child">-->
<!--                                                <li><input type="checkbox" name="Depts_ID[]" value="114"> بوابات ميكانيكية-->
<!--                                                    <ul class="child">-->
<!---->
<!--                                                    </ul>-->
<!--                                                </li>-->
<!--                                            </ul>-->
<!--                                        </li>-->
<!---->
<!--                                        <li>-->
<!--                                            <div class="main-cat">-->
<!--                                                <input type="checkbox" name="Depts_ID[]" value=""> مضخات-->
<!--                                            </div>-->
<!--                                            <ul class="child">-->
<!--                                                <li><input type="checkbox" name="Depts_ID[]" value="114"> مضخات هايدروليكية-->
<!--                                                    <ul class="child">-->
<!---->
<!--                                                    </ul>-->
<!--                                                </li>-->
<!--                                                <li><input type="checkbox" name="Depts_ID[]" value="114"> مضخات يديوية-->
<!--                                                    <ul class="child">-->
<!---->
<!--                                                    </ul>-->
<!--                                                </li>-->
<!--                                            </ul>-->
<!--                                        </li>-->
<!--                                    </ul>-->
<!--                                </div>-->
                            </div>
                        </div>
                        <div class="col-sm-12" style="vertical-align: bottom">
                            <button class="btn btn-primary">فلتر</button>
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
            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="products_table">
                <thead>
                <tr>
                    <th>صورة المنتج</th>
                    <th style="width: 50%">اسم المنتج</th>
                    <th>السعر </th>

                    <th>إجراءات</th>
                </tr>
                </thead>
                <tbody>
                {%for product in products['content']%}
                <?php ?>
                <tr class="odd gradeX">
                    <td><img src="{{product['image']}}" height="60px" width="100px" /></td>
                    <td style="width: 50%"><a href=""> {{product['name']}}</a></td>
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
                    <td>{{price}}</td>
                    <td>
                        <a class="btn btn-xs btn-success" href="{{this.url_shared.get('offers_module/index/addProductToOffer/')~product['id']}}/{{offer.id}}"> <i class="fa fa-plus" aria-hidden="true"></i> إضافة </a>
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

        </form>
    </div>
</div>


<div class="col-sm-12">
    <button class="btn btn-success add_products_to_discount"> اضافة الخصم للمنتجات المحددة </button>

</div>

<script>



    $("#products_filter").submit(function(e) {
        e.preventDefault();
        $("#products_table").hide();
        $("#LoadingImage").show();
        var url = "{{url('offers_module/index/products/' ~offer.id)}}"; // the script where you handle the form input.

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
        var url = "{{url('offers_module/index/products/' ~offer.id)}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

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
