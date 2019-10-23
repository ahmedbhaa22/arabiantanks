<div class="panel-group accordion" id="accordion1">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-areas" href="#collapse-clients-areas">
                    <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                </a>
            </h4>
        </div>
        <div id="collapse-clients-areas" class="panel-collapse collapse">
            <div class="panel-body">
                <form role="form" method="post" action="" id="branches_filter">
                <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label"> المنطقة </label>
                                <select class="form-control" id="filter_regions" name="filter_regions">
                                    <option value="0">All</option>
                                    {%for region in regions%}
                                    {%set selected_region=""%}
                                    {%if(filter["filter_regions"]==region.id)%}
                                    {%set selected_region="selected"%}
                                    {%endif%}
                                    <option value="{{region.id}}" {{selected_region}}>{{region.name}}</option>

                                    {%endfor%}
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label"> المدينة </label>
                                <select class="form-control" id="filter_cities" name="filter_cities">

                                </select>
                            </div>
                        </div>
<!--                        <div class="col-sm-4">-->
<!--                            <div class="form-group">-->
<!--                                <label class=" control-label"> الفرع </label>-->
<!--                                <select class="form-control" id="">-->
<!--                                    <option>كل</option>-->
<!--                                    <option> المدينة </option>-->
<!--                                    <option> مكة </option>-->
<!--                                </select>-->
<!--                            </div>-->
<!--                        </div>-->

                    </div>
                    <button class="btn btn-primary" type="submit">فلتر</button>
                    <a class="btn btn-primary" id="clear_filter">مسح الفلتر</a>
                </form>
            </div>
        </div>
    </div>
</div>

<table class="table table-striped table-bordered table-hover table-checkable order-column" id="branches_table">
    <thead>
    <tr>
        <th class="small-col">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="group-checkable" id="branches_select_all" />
                <span></span>
            </label>
        </th>
        <th> المنطقة</th>
        <th> المدينة </th>
        <th> الفرع </th>
        <th> Branch</th>
        <th>الاجراءات</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd gradeX">
        <td class="small-col"> <i class="fa fa-plus"></i> </td>
        <td>
            <select id="regions" name="region">
                <option></option>
                {%for region in regions%}
                <option value="{{region.id}}">{{region.name}}</option>
                {%endfor%}
            </select>
        </td>
        <td> <select id="cities" name="city">

            </select>
        </td>
        <td> <input type="text" name="branch_name" id="branch_name"> </td>
        <td> <input type="text" name="branch_name_eng" id="branch_name_eng"> </td>
        <td>
            <a class="btn btn-xs btn-success" id="create_branch">
                <i class="fa fa-plus" aria-hidden="true"></i>
                إضافة
            </a>
        </td>
    </tr>
    {%for item in content['items']%}
    <tr class="odd gradeX">
        <td class="small-col">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="checkboxes branch_check" value="{{item['id']}}" name="branch_check_delete[]"/>
                <span></span>
            </label>
        </td>
        <td> {{item["branch_region_name"]}}</td>
        <td>{{item["branch_city_name"]}}</td>
        <td>  {{item["name"]}}</td>
        <td>  {{item["name_eng"]}}</td>
        <td>
            <a class="btn btn-xs btn-danger delete_branch" href="{{url('control_panel/deleteBranch')}}?branch_id={{item['id']}}">
                <i class="fa fa-trash-o" aria-hidden="true"></i> حذف </a>

            <a class="btn btn-xs btn-info" href="{{url('control_panel/edit_branch/') ~item['id']}}">
                <i class="fa fa-trash-o" aria-hidden="true"></i>Edit </a>
        </td>
    </tr>
    {%endfor%}




    </tbody>
</table>
<div class="row">
    <div class="col-md-5 col-sm-5">
        <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
            {{content['total_pages']}}/{{content['current']}}                    </div>
    </div>
    <div class="col-md-7 col-sm-7">
        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
            <ul class="pagination" style="visibility: visible;">
                <li class='discount_page'><a href="1">الأول</a></li>
                <li class='discount_page'><a href="{{content['before']}}">السابق</a></li>
                <li class='discount_page'><a href="{{content['next']}}">التالي</a></li>
                <li class='discount_page'><a href="{{content['last']}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>
<div class="col-xs-12">
    <a class="delete-btn btn btn-danger btn-sm" id="branches_delete">
        <i class="fa fa-trash"></i>حذف المحدد
    </a>
</div>


<script>
    $(".discount_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('control_panel/branches_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.
        var filter_cities= $("#filter_cities").val();
        var filter_regions = $("#filter_regions").val();
        $.ajax({
            type: "POST",
            url: url,
            data: {
                "filter_cities": filter_cities,
                "filter_regions": filter_regions
            }, // serializes the form's elements.
            success: function (response)
            {

                $("#areas").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });

    var tanks_cities_url = "{{url('control_panel/getCitiesAjax/')}}";
    $("#regions").change(function() {
        var value = $(this).val();
        $("#cities").load(tanks_cities_url+value);
    });

    $("#filter_regions").change(function() {
        var value = $(this).val();
        $("#filter_cities").load(tanks_cities_url+value);
    });


    $("#create_branch").click(function(e) {
        e.preventDefault();
        var region = $("#regions").val();
        var city = $("#cities").val();
        var branch_name = $("#branch_name").val();
        var branch_name_eng = $("#branch_name_eng").val();
        $.ajax({
            type: "POST",
            url: "{{url('control_panel/createBranch')}}&region="+region+"&city="+city+"&branch_name="+branch_name+"&branch_name_eng="+branch_name_eng,
            success: function(data) {

                var url= "{{url('control_panel/branches_table')}}";
                $("#areas").load(url);
            }
        });
    });

    $(".delete_branch").click(function(e) {
        e.preventDefault();
        var confirm_delete = confirm('Are you sure you want to delete this item?');
        if(confirm_delete){
            var delete_branch_url = $(this).attr("href");

            $.ajax({
                type: "POST",
                url: delete_branch_url,
                success: function(data) {
                    var url_branches= "{{url('control_panel/branches_table')}}";
                    $("#areas").load(url_branches);
                }
            });
        }else{
            return;
        }

    });
    $("#branches_filter").submit(function(e) {
        e.preventDefault();
        var url = "{{url('control_panel/branches_table')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#branches_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#areas").html(response);
                $('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
    $("#clear_filter").click(function(e) {
        e.preventDefault();
        var url= "{{url('control_panel/branches_table')}}";
        $("#areas").load(url);
    });
    $("#branches_select_all").change(function(){  //"select all" change
        $(".branch_check").prop('checked', $(this).prop("checked")); //change all ".checkbox" checked status
    });
    //".checkbox" change
    $('.branch_check').change(function(){
        //uncheck "select all", if one of the listed checkbox item is unchecked
        if(false == $(this).prop("checked")){ //if this item is unchecked
            $("#branches_select_all").prop('checked', false); //change "select all" checked status to false
        }
        //check "select all" if all checkbox items are checked
        if ($('.branch_check:checked').length == $('.branch_check').length ){
            $("#branches_select_all").prop('checked', true);
        }
    });

    $("#branches_delete").click(function(){
        var branches_checked = [];
        $.each($(".branch_check:checked"), function(){
            branches_checked.push($(this).val());
        });
        var url_delete_branches = "{{url('control_panel/deleteBranch')}}";
        console.log(url_delete_branches);
        $.ajax({
            type: "POST",
            url: url_delete_branches,
            data:{
                "branches_checked" :branches_checked
            }, // serializes the form's elements.
            success: function (response)
            {

                $("#areas").load("{{url('control_panel/branches_table')}}");
                $('#collapse-clients-filter').collapse('toggle');
            }
        });

    });



</script>