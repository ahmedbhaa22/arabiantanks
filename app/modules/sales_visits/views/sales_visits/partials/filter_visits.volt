<div id="collapse-clients-filter" class="panel-collapse collapse">
    <div class="panel-body">
        <form role="form" id="sales_visits_filter">

            <div class="row">



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

                <div class="clearfix"></div>
<!--                <div class="col-sm-4">-->
<!--                    <div class="form-group">-->
<!--                        <label class=" control-label"> المنطقة</label>-->
<!--                        <select class="form-control" id="regions" name="regions">-->
<!--                            <option></option>-->
<!--                            {%for region in regions%}-->
<!--                            <option value="{{region.id}}">{{region.name}}</option>-->
<!--                            {%endfor%}-->
<!--                        </select>-->
<!--                    </div>-->
<!--                </div>-->
<!---->
<!--                <div class="col-sm-4">-->
<!--                    <div class="form-group">-->
<!--                        <label class=" control-label"> الفرع</label>-->
<!--                        <select id="branch" name="branch" class="bs-select form-control select-custom">-->
<!--                            <option></option>-->
<!--                        </select>-->
<!--                    </div>-->
<!--                </div>-->
                <div class="clearfix"></div>




            </div>

            <button class="btn btn-primary">فلتر</button>
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
