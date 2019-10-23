<div class="panel-group accordion" id="accordion3">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-clients" href="#collapse-reasons">
                    <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                </a>
            </h4>
        </div>
        <div id="collapse-reasons" class="panel-collapse collapse">
            <div class="panel-body">
                <form role="form" method="post" id="reasons_filter">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label">  أسباب تعليق طلبات الصيانة  </label>
                                <select class=" form-control"  id="filter_reason" name="filter_reason">
                                    {%set selected_value=""%}
                                    {%if(selected =="all")%}
                                    {%set selected_value="selected"%}
                                    {%endif%}
                                    <option value="all" {{selected_value}}>All</option>
                                {%for reason in all_reasons%}
                                    {%set selected_value=""%}
                                    {%if(selected ==reason["id"])%}
                                    {%set selected_value="selected"%}
                                    {%endif%}
                                    <option value="{{reason['id']}}" {{selected_value}}>{{reason['reason_title']}}</option>
                                {%endfor%}
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-2 gap">
                            <button class="btn btn-primary">فلتر</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
    <thead>
    <tr>
        <th class="small-col">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="group-checkable" id="reasons_select_all"/>
                <span></span>
            </label>
        </th>
        <th>  مشكلة الصيانة </th>
        <th> عدد مرات تكرار المشكلة </th>
        <th>الاجراءات</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd gradeX">
        <td class="small-col"> <i class="fa fa-plus"></i> </td>
        <td> <input type="text" name="reason_name" id="reason_name"> </td>
        <td> 0 </td>
        <td>
            <a class="btn btn-xs btn-success" id="create_reason">
                <i class="fa fa-plus" aria-hidden="true"></i>
                إضافة
            </a>
        </td>
    </tr>
    {%for item in content['items']%}
    <tr class="odd gradeX">
        <td class="small-col">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="checkboxes reason_check" value="{{item['id']}}"/>
                <span></span>
            </label>
        </td>
        <td>{{item["reason_title"]}}</td>
        <td> 0 </td>
        <td>
            <a class="btn btn-xs btn-danger delete_reason" href="{{url('control_panel/deleteReason')}}?reason_id={{item['id']}}">
                <i class="fa fa-trash-o" aria-hidden="true"></i> حذف </a>
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
                <li class='reason_page'><a href="1">الأول</a></li>
                <li class='reason_page'><a href="{{content['before']}}">السابق</a></li>
                <li class='reason_page'><a href="{{content['next']}}">التالي</a></li>
                <li class='reason_page'><a href="{{content['last']}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="col-xs-12">
    <a class="delete-btn btn btn-danger btn-sm" id="reasons_delete">
        <i class="fa fa-trash"></i>حذف المحدد
    </a>
</div>

<script>

    $(".reason_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('control_panel/reasons_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.
        var filter_reason= $("#filter_reason").val();
        $.ajax({
            type: "POST",
            url: url,
            data: {
                "filter_reason":filter_reason
            }, // serializes the form's elements.
            success: function (response)
            {

                $("#reasons").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
    $("#create_reason").click(function(e) {
        e.preventDefault();
        var reason_name = $("#reason_name").val();
        $.ajax({
            type: "POST",
            url: "{{url('control_panel/createReason')}}&reason_name="+reason_name,
            success: function(data) {
                var url= "{{url('control_panel/reasons_table')}}";
                $("#reasons").load(url);
            }
        });
    });

    $(".delete_reason").click(function(e) {
        e.preventDefault();
        var confirm_delete = confirm('Are you sure you want to delete this item?');
        if(confirm_delete){
            var delete_reason_url = $(this).attr("href");

            $.ajax({
                type: "POST",
                url: delete_reason_url,
                success: function(data) {
                    var url_reasons= "{{url('control_panel/reasons_table')}}";
                    $("#reasons").load(url_reasons);
                }
            });
        }else{
            return;
        }

    });

    $("#reasons_filter").submit(function(e) {
        e.preventDefault();
        var url = "{{url('control_panel/reasons_table')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#reasons_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#reasons").html(response);
                $('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $("#reasons_select_all").change(function(){  //"select all" change
        $(".reason_check").prop('checked', $(this).prop("checked")); //change all ".checkbox" checked status
    });
    //".checkbox" change
    $('.reason_check').change(function(){
        //uncheck "select all", if one of the listed checkbox item is unchecked
        if(false == $(this).prop("checked")){ //if this item is unchecked
            $("#reasons_select_all").prop('checked', false); //change "select all" checked status to false
        }
        //check "select all" if all checkbox items are checked
        if ($('.reason_check:checked').length == $('.reason_check').length ){
            $("#reasons_select_all").prop('checked', true);
        }
    });

    $("#reasons_delete").click(function(){
        var reasons_checked = [];
        $.each($(".reason_check:checked"), function(){
            reasons_checked.push($(this).val());
        });
        var url_delete_reasons = "{{url('control_panel/deleteReason')}}";
        console.log(url_delete_reasons);
        $.ajax({
            type: "POST",
            url: url_delete_reasons,
            data:{
                "reasons_checked" :reasons_checked
            }, // serializes the form's elements.
            success: function (response)
            {

                $("#reasons").load("{{url('control_panel/reasons_table')}}");
                $('#collapse-reasons-filter').collapse('toggle');
            }
        });

    });
</script>