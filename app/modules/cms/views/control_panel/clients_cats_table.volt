<div class="panel-group accordion" id="accordion2">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-clients" href="#collapse-clients-classes">
                    <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                </a>
            </h4>
        </div>
        <div id="collapse-clients-classes" class="panel-collapse collapse">
            <div class="panel-body">
                <form role="form" method="post" id="clients_cats_filter">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label"> تصنيفات العملاء </label>
                                <select class="form-control" id="class" name="client_cat_id">
                                    {%set selected_value=""%}
                                    {%if(selected =="all")%}
                                    {%set selected_value="selected"%}
                                    {%endif%}
                                    <option value="all" {{selected_value}}>All</option>
                                    {%for client_cat  in clients_cats_all%}
                                    {%set selected_value=""%}
                                    {%if(selected ==client_cat["id"])%}
                                    {%set selected_value="selected"%}
                                    {%endif%}
                                    <option value="{{client_cat['id']}}" {{selected_value}}>{{client_cat["name"]}}</option>
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

<table class="table table-striped table-bordered table-hover table-checkable order-column" id="clients_rules_table">
    <thead>
    <tr>
        <th class="small-col">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="group-checkable" id="cats_select_all" />
                <span></span>
            </label>
        </th>
        <th> تصنيفات العملاء </th>
        <th> عدد العملاء في هذا التصنيف </th>
        <th>الاجراءات</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd gradeX">
        <td class="small-col"> <i class="fa fa-plus"></i> </td>
        <td> <input type="text" name="rule_name" id="rule_name" /> </td>
        <td> 0 </td>
        <td>
            <a class="btn btn-xs btn-success" id="create_rule">
                <i class="fa fa-plus" aria-hidden="true"></i>
                إضافة
            </a>
        </td>
    </tr>

    {%for item in content['items']%}

    <tr class="odd gradeX">
        <td class="small-col">
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="checkboxes cat_check" value="{{item['id']}}" name="cat_check_delete[]"/>
                <span></span>
            </label>
        </td>
        <td> {{item["name"]}} </td>
        <td> 100 </td>
        <td>
            <a class="btn btn-xs btn-danger delete_cat" href="{{url('control_panel/deleteCat')}}?cat_id={{item['id']}}">
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
                <li class='clients_rules_page'><a href="1">الأول</a></li>
                <li class='clients_rules_page'><a href="{{content['before']}}">السابق</a></li>
                <li class='clients_rules_page'><a href="{{content['next']}}">التالي</a></li>
                <li class='clients_rules_page'><a href="{{content['last']}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>

<div class="col-xs-12">
    <a class="delete-btn btn btn-danger btn-sm"  id="cats_delete">
        <i class="fa fa-trash"></i>حذف المحدد
    </a>
</div>

<script>
    $(".clients_rules_page a").click(function(e) {
        e.preventDefault();
        var url_client_cats = "{{url('control_panel/clients_cats_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.
        var filter_client_cats= $("#class").val();
        $.ajax({
            type: "POST",
            url: url_client_cats,
            data: {
                "client_cat_id": filter_client_cats
            }, // serializes the form's elements.
            success: function (response)
            {

                $("#roles").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $("#create_rule").click(function(e) {
        e.preventDefault();
        var rule_name = $("#rule_name").val();
       // alert(rule_name);return;
        $.ajax({
            type: "POST",
            url: "{{url('control_panel/createCat')}}&cat="+rule_name,
            data: {
                'cat': rule_name,
            },
            success: function(data) {

                var url_client_cats= "{{url('control_panel/clients_cats_table')}}";
                $("#roles").load(url_client_cats);
            }
        });
    });

    $(".delete_cat").click(function(e) {
        e.preventDefault();
        var confirm_delete = confirm('Are you sure you want to delete this item?');
        if(confirm_delete){
            var delete_cat_url = $(this).attr("href");

            $.ajax({
                type: "POST",
                url: delete_cat_url,
                success: function(data) {
                    var url_client_cats= "{{url('control_panel/clients_cats_table')}}";
                    $("#roles").load(url_client_cats);
                }
            });
        }else{
            return;
        }

    });

    $("#clients_cats_filter").submit(function(e) {
        e.preventDefault();
        var url = "{{url('control_panel/clients_cats_table')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#clients_cats_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#roles").html(response);
                $('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
    $("#cats_select_all").change(function(){  //"select all" change
        $(".cat_check").prop('checked', $(this).prop("checked")); //change all ".checkbox" checked status
    });
    //".checkbox" change
    $('.cat_check').change(function(){
        //uncheck "select all", if one of the listed checkbox item is unchecked
        if(false == $(this).prop("checked")){ //if this item is unchecked
            $("#cats_select_all").prop('checked', false); //change "select all" checked status to false
        }
        //check "select all" if all checkbox items are checked
        if ($('.cat_check:checked').length == $('.cat_check').length ){
            $("#cats_select_all").prop('checked', true);
        }
    });

    $("#cats_delete").click(function(){
        var cats_checked = [];
        $.each($(".cat_check:checked"), function(){
            cats_checked.push($(this).val());
        });
        var url_delete_cats = "{{url('control_panel/deleteCat')}}";
        console.log(url_delete_cats);
        $.ajax({
            type: "POST",
            url: url_delete_cats,
            data:{
                "cats_checked" :cats_checked
            }, // serializes the form's elements.
            success: function (response)
            {

                $("#roles").load("{{url('control_panel/clients_cats_table')}}");
                $('#collapse-clients-filter').collapse('toggle');
            }
        });

    });
</script>