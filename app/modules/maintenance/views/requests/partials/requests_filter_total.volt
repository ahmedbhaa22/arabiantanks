<div class="panel-body">
    <form role="form" method="post" action="" id="requests_filter_total">
        <div class="row">
            <div class="col-sm-2">
                <div class="form-group">
                    <label class=" control-label">  رقم الطلب </label>
                    <input type="number" class="form-control" min="1" name="ticket_number" value="{{filter['ticket_number']}}">
                </div>
            </div>
            <div class="col-sm-2">
                <div class="form-group">
                    <label class=" control-label">تاريخ من</label>
                    <input type="date" class="form-control" name="date_from" value="{{filter['date_from']}}">
                </div>
            </div>
            <div class="col-sm-2">
                <div class="form-group">
                    <label class=" control-label">تاريخ الى</label>
                    <input type="date" class="form-control" name="date_to" value="{{filter['date_to']}}">
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label"> حالة الطلب </label>
                    {{ select('ticket_status_id', problem_statuses, 'using': ['id', 'status_name'],
                    'useEmpty': true, 'emptyText': '', 'emptyValue': '','class':'form-control') }}
                </div>
            </div>

            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label">  اسم المنتج  </label>
                    <input type="text" class="form-control" name="product_name" value="{{filter['product_name']}}">
                </div>
            </div>

            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label"> اسم العميل  </label>
                    <input type="text" class="form-control" name="client_name" value="{{filter['client_name']}}">
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label">  تليفون  </label>
                    <input type="number" class="form-control" min="1" name="client_mobile" value="{{filter['client_mobile']}}">
                </div>
            </div>

            <div class="col-sm-6">
                <div class="form-group">
                    <label class=" control-label"> الصياانة المطلوبة </label>

                        {{ select('ticket_problem_id', all_problems, 'using': ['id', 'name'],
                        'useEmpty': true, 'emptyText': '', 'emptyValue': '') }}


                </div>
            </div>

            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label">  المنطقة  </label>
                    <select id="cities" name="city">
                        {%for city in cities%}
                        <option value="{{city.id}}">{{city.name}}</option>
                        {%endfor%}
                    </select>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label">  المدينة  </label>
                    {%if(filter["regions"]|length > 0 )%}
                    {{ select('filter_regions', filter["regions"], 'using': ['id', 'name'],
                    'useEmpty': true, 'emptyValue': '0','id':'filter_regions') }}
                    {%else%}
                    <select name="filter_regions" id="filter_regions">

                    </select>

                    {%endif%}


                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <div id="branches_container">
                        <label class=" control-label">  الفرع  </label>
                        {%if(filter["branches"]|length > 0 )%}
                        <select class=" form-control" name="order_branch" id="order_branch">
                            {%for item in filter["branches"]["items"]%}
                            <option value="{{item['id']}}">{{item['name']}}</option>
                            {%endfor%}
                        </select>
                        {%else%}
                        <select name="order_branch" id="order_branch" class=" form-control">

                        </select>

                        {%endif%}

                    </div>

                </div>
            </div>
        </div>
        <button class="btn btn-primary" type="submit">فلتر</button>
    </form>
</div>

<script>
    var regions_url="{{url('maintenance_module/requests/getRegionsAjax/')}}";

    $("#cities").change(function() {
        var value = $(this).val();
        $("#filter_regions").html("");
        $("#order_branch").html("");
        $("#tech_choose").html("");
        $("#filter_regions").load(regions_url+value);

    });
    $("#filter_regions").change(function() {
        $("#order_branch").html("");
        $("#tech_choose").html("");
        var branches_url="{{url('maintenance_module/requests/branches_by_city_region/')}}";
        var filter_cities= $("#cities").val();
        var filter_regions = $("#filter_regions").val();
        $.ajax({
            type: "POST",
            url: branches_url,
            data: {
                "filter_cities": filter_cities,
                "filter_regions": filter_regions
            }, // serializes the form's elements.
            success: function (response)
            {

                $("#branches_container").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

    });

    $("#order_branch").change(function() {
        $("#tech_choose").html("");
        var value = $("#order_branch").val();
        alert("ssadasdd");
        var tech_url = "{{url('maintenance_module/requests/tech_by_branch/')}}";
        $("#tech_choose_container").load(tech_url+value);
    });
</script>