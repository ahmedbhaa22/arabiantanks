<div class="col-md-12">
    <div class="col-md-12">
        <h4>تحديد المنتج</h4>
    </div>
    <div class="form-group col-md-4">
        <label>تصنيف المنتج</label>
        <select class=" form-control" name="main_dept" id="main_dept">
            <option></option>
            {%for item in main_cats['items']%}
            <option value="{{item['ID']}}">{{item['Title']}}</option>
            {%endfor%}

        </select>
    </div>
    <div class="form-group col-md-4">
        <label>نوع المنتج</label>
        <select class=" form-control" name="product_type" id="product_type">

        </select>
    </div>


    <div class="form-group col-md-4">
        <div id="products_container">
            <label>المنتجات</label>
            <select class=" form-control" name="data_cms_id" id="data_cms_id">
                </select>
        </div>

    </div>

</div>
<script>
    var product_type_url="{{url('maintenance_module/problems/product_type/')}}";
    $( document ).ready(function() {
        $("#main_dept").change(function() {
            $("#capacity_container").html("");
            $("#data_cms_id").html("");
            var value = $(this).val();
            $("#product_type").load(product_type_url+value);
            var product_type = $("#main_dept option:selected").text();
        });
    });


    $( document ).ready(function() {
        $("#main_dept").change(function() {
            $("#data_cms_id").html("");

            var dept_id=$(this).val();


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