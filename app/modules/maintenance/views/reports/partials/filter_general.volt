<div id="collapse-clients-filter" class="panel-collapse collapse">
    <div class="panel-body">
        <form role="form" id="general_reports_filter">

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
                <div class="clearfix"></div>
                <div class="col-sm-4">
                    <div class="form-group">
                        <label class=" control-label"> المنطقة</label>
                        <select class="form-control" id="regions" name="regions">
                            <option></option>
                            {%for region in regions%}
                            <option value="{{region.id}}">{{region.name}}</option>
                            {%endfor%}
                        </select>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="form-group">
                        <label class=" control-label"> الفرع</label>
                        <select id="branch" name="branch" class="bs-select form-control select-custom">
                            <option></option>
                        </select>
                    </div>
                </div>
                <div class="clearfix"></div>

                {{ partial("reports/partials/report_product_select", ['main_cats': main_cats]) }}



            </div>

            <button class="btn btn-primary">فلتر</button>
            <a class="btn btn-danger" id="general_reports_export">Export</a>
        </form>
    </div>
</div>


<script>
    $('#regions').on('change', function()
    {
        $.ajax({
            type: 'get',
            url: "{{this.url_shared.get('cms_module/cp_users/getRegionCitiesAndBranches/')}}" + $(this).val(),
            success: function(response)
            {
                response = JSON.parse(response);


                $('#branch').html('');
                $('#branch').append("<option></option>");


                for(var j = 0; j < response.branches.length; j++)
                {

                    var option = "<option value='"+response.branches[j].id+"'>"+response.branches[j].name+"</option>";
                    $('#branch').append(option);

                }
            }
        });
    });
</script>
