<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="maintenance.html"><span> الصيانة </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span>محتوى</span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url('img/banners/banner-maint.png')}}') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-times font-dark"></i>
            <span class="caption-subject bold uppercase"> مشكلة صيانة جديدة </span>
        </div>

    </div>
    <div class="portlet-body">
        <div class="row space">
            <form action="{{url('maintenance_module/problems/create')}}" method="post" enctype="multipart/form-data" id="newProblem">
            <div class="col-md-8">
                <div class="col-xs-12">
                    <h4>تحديد المنتج</h4>
                </div>
                <div class="form-group col-sm-4">
                    <label>تصنيف المنتج</label>
                    <select class=" form-control" name="main_dept" id="main_dept">
                        <option></option>
                        {%for item in main_cats['items']%}
                        <option value="{{item['ID']}}">{{item['Title']}}</option>
                        {%endfor%}

                    </select>
                </div>

                <div class="col-xs-12 divider">
                    <h4>تحديد المشكلة</h4>
                </div>
                <div class="form-group col-md-12 no-padding">
                    <div class="col-xs-10 form-group no-padding" id="repeatTHIS">
                        <div class="col-xs-4 form-group" >
                            <label class="control-label">رقم مكان المشكلة على الصورة</label>
                            <input type="number" name="problem_spot[]" min="1" class="form-control">
                        </div>
                        <div class="col-xs-8 form-group" >
                            <label class="control-label"> إسم المشكلة </label>
                            <input type="text" name="problem_name[]" class="form-control">
                        </div>
                    </div>
                    <div class="col-xs-2 gap">
                        <a class="btn btn-xs btn-info" onclick="repeat()">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i> اضافة المزيد</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 bordered">
                <div class="row" >
                    <label class="control-label"> صورة المنتج </label>
                    <input type="file"  class="form-control" name="problem_pic">
                </div>
                <hr>

            </div>

            <div class="col-xs-12">
                <button class="btn btn-success btn-md">
                    <i class="fa fa-save" aria-hidden="true"></i>
                    حفظ
                </button>

                <button class="btn btn-warning btn-md">
                    <i class="fa fa-save" aria-hidden="true"></i>
                    حفظ وإضافة مشاكل لمنتج آخر
                </button>

                <button class="delete-btn btn dark btn-md">
                    ألغاء
                </button>
            </div>
            </form>
        </div>
    </div>


</div>
<script>
    var product_type_url="{{url('maintenance_module/problems/product_type/')}}";
    $( document ).ready(function() {
        $("#main_dept").change(function() {
            var value = $(this).val();
            $("#product_type").load(product_type_url+value);
        });
    });
    var capacity_url="{{url('maintenance_module/problems/product_capacity/')}}";
    $( document ).ready(function() {
        $("#product_type").change(function() {
            var value = $(this).val();
            var products_url="{{url('maintenance_module/problems/products_in_cat/')}}";
            $("#capacity_container").load(products_url+value);
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

    $('#newProblem').submit(function () {


    });

</script>