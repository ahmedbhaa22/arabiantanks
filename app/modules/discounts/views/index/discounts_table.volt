<div class="panel-group accordion" id="accordion1">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">
                    <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                </a>
            </h4>
        </div>
        <div id="collapse-clients-filter" class="panel-collapse collapse">
            <div class="panel-body">
                <form role="form" method="post" action="{{url('discounts_module/index/discounts_table')}}" id="discounts_filter">
                    <div class="row">

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">اسم الخصم</label>
                                <input type="text" class="form-control" name="discount_filter_name" value="{{filter['discount_filter_name']}}">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="col-xs-12 no-padding control-label"> النسبة المئوية</label>
                                <div class="col-xs-8 no-padding">
                                    <input type="text" class="form-control" name="discount_filter_percentage" value="{{filter['discount_filter_percentage']}}">
                                </div>
                                <div class="col-xs-2"> % </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> كود الكوبون </label>
                                <input type="text" class="form-control" name="discount_filter_coupon" value="{{filter['discount_filter_coupon']}}">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> تاريخ البدء </label>
                                <input type="date" class="form-control" name="discount_filter_start_date" value="{{filter['discount_filter_start_date']}}">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> تاريخ النهاية</label>
                                <input type="date" class="form-control" name="discount_filter_end_date" value="{{filter['discount_filter_end_date']}}">
                            </div>
                        </div>


                    </div>
                    <button class="btn btn-primary">فلتر</button>
                </form>
            </div>
        </div>
    </div>
</div>
<table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
    <thead>
    <tr>
        <th>
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="group-checkable"
                       data-set=".checkboxes" id="select_all"/>
                <span></span>
            </label>
        </th>
        <th> ID</th>
        <th>اسم الخصم</th>
        <th> النسبة المئوية </th>
        <th>كود الكوبون</th>
        <th>تاريخ البدء </th>
        <th>تاريخ الإنتهاء</th>
        <!--                                    <th> عدد المنتجات تم تطبيق عليها الخصم </th>-->
        <th>الاجراءات</th>
    </tr>
    </thead>
    <tbody>
    {%for discount in discounts%}
    <tr class="odd gradeX">
        <td>
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="checkboxes" value="{{discount.id}}"/>
                <span></span>
            </label>
        </td>
        <td>{{discount.id}}</td>
        <td>{{discount.name}}</td>
        <td>{{discount.percentage}}</td>
        <td>{{discount.coupon}}</td>
        <td>{{ date('d-m-Y', discount.start_date) }}</td>
        <td>{{ date('d-m-Y', discount.end_date) }}</td>
        <!--                                    <td>5</td>-->
        <td>
            <a href="{{url('discounts_module/index/view/') ~discount.id}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
            <a href="{{url('discounts_module/index/edit/') ~discount.id}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
            <a href="{{url('discounts_module/index/delete/') ~discount.id}}" class="btn btn-xs btn-danger"  onclick="return confirm('Are you sure you want to delete this item?');"> <i class="fa fa-trash-o" aria-hidden="true"></i> </a>
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
    <a class="delete-btn btn btn-danger btn-sm" id="delete_checked">
        <i class="fa fa-trash"></i>حذف المحدد
    </a>
</div>

<script>
    $("#discounts_filter").submit(function(e) {
        e.preventDefault();
        var url = "{{url('discounts_module/index/discounts_table')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#discounts_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $(".portlet-body").html(response);
                $('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $(".discount_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('discounts_module/index/discounts_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#discounts_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $(".portlet-body").html(response);
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
        var data = { 'discounts[]' : []};
        $(".checkboxes:checked").each(function() {
            data['discounts[]'].push($(this).val());
        });
        console.log(data);
        var delete_url="{{url('discounts_module/index/delete_discounts')}}";
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