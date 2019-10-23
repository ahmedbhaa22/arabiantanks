<div class="portlet-body">
    <div class="row space">
        <div class="col-md-8">
            <div class="col-xs-12">
                <h4>تحديد المنتج</h4>
            </div>
            <div class="form-group col-xs-6">
                <label>تصنيف المنتج</label>
                <select class=" form-control" name="main_dept" id="main_dept">
                    <option></option>
                    {%for item in main_cats['items']%}
                    <option value="{{item['ID']}}">{{item['Title']}}</option>
                    {%endfor%}

                </select>
            </div>
            <div class="form-group col-xs-6">
                <label>نوع المنتج</label>
                <select class=" form-control" name="product_type" id="product_type">

                </select>
            </div>
            <div class="form-group col-xs-6">

                <div id="capacity_container">

                </div>

            </div>

            <div class="form-group col-sm-6">
                <div id="products_container">
                    <label>{{translate._("Products")}}</label>
                </div>

            </div>

            <div class="col-xs-12 divider">
                <h4>تحديد المشكلة</h4>
            </div>
            <div class="form-group col-md-12 no-padding">
                <div class="col-xs-8 form-group" id="repeatTHIS">
                    <div id="problems_in_cat">

                    </div>

                </div>
<!--                <div class="col-xs-4">-->
<!--                    <button class="btn btn-xs btn-info" onclick="repeat()">-->
<!--                        <i class="fa fa-plus-circle" aria-hidden="true"></i> اضافة المزيد</button>-->
<!--                </div>-->
            </div>

        </div>

        <div class="col-md-4 bordered">
            <div class="product-img-div">
                <img src="{{url('img/')}}tank.jpg" style="width:100%" />

            </div>


        </div>

    </div>
</div>


<script>
    var product_type_url="{{url('maintenance_module/problems/product_type/')}}";
    $( document ).ready(function() {
        $("#main_dept").change(function() {
            $("#capacity_container").html("");
            $("#products_container").html("");
            $("#problems_in_cat").html("");
            var value = $(this).val();
            $("#product_type").load(product_type_url+value);
            var product_type = $("#main_dept option:selected").text();
            $('#revise_product_type').text(product_type);
        });
    });


    $( document ).ready(function() {
        $("#main_dept").change(function() {
            $("#products_container").html("");
            $("#problems_in_cat").html("");
            var dept_id=$(this).val();
            var problems_in_cat_url="{{url('maintenance_module/requests/problems_in_cat/')}}"+dept_id;
            $("#problems_in_cat").load(problems_in_cat_url);

        });

        $("#product_type").change(function() {
            $("#products_container").html("");
            var dept_id=$(this).val();
            var products_url ="{{url('maintenance_module/problems/products_in_cat/')}}"+dept_id;
            $("#products_container").load(products_url);

            var tank_type = $("#product_type option:selected").text();
            $('#revise_tank_type').text(tank_type);
        });



    });
    // Repeat
    var i = 0;
    var original = document.getElementById('repeatTHIS');

    function repeat() {
        var clone = original.cloneNode(true);
        clone.id = "repeatTHIS" + ++i;
        original.parentNode.appendChild(clone);
    }







</script>