<div class="panel-group accordion" id="accordion1">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls"
                   href="#collapse-clients-filter">
                    <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down"
                                                                            aria-hidden="true"></i>
                </a>
            </h4>
        </div>
        <div id="collapse-clients-filter" class="panel-collapse collapse">
            <div class="panel-body">
                <form role="form" id="offers_filter" action="{{url('offers_module/index/offers_table')}}" method="post">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> اسم العرض</label>
                                <input type="text" class="form-control" name="offer_filter_name" value="{{filter['offer_filter_name']}}">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                            <label class=" control-label">{{translate._("Regions")}}</label>
                            <select class="form-control"  name="offer_filter_region">
                                <option value="0">الكل</option>
                                {%for region in regions%}
                                <option value="{{region.id}}"
                                <?php if($region->id==$filter["offer_filter_region"]):?>
                                    selected
                                 <?php endif;?>
                                >{{region.name}}</option>
                                {%endfor%}
                            </select>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> تاريخ من</label>
                                <input type="date" class="form-control"  name="offer_filter_start_date" value="{{filter['offer_filter_start_date']}}">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> تاريخ الى</label>
                                <input type="date" class="form-control"  name="offer_filter_end_date" value="{{filter['offer_filter_end_date']}}">
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-primary" type="submit">فلتر</button>
                </form>
            </div>
        </div>
    </div>
</div>

<table class="table table-striped table-bordered table-hover table-checkable order-column" id="offers_filter_ajax">
    <thead>
    <tr>
        <th>
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="group-checkable"
                       data-set="#offers_filter_ajax .checkboxes" id="select_all"/>
                <span></span>
            </label>
        </th>
        <th>{{translate._("ID")}}</th>
        <th>{{translate._("Offer Title")}}</th>
        <th>{{translate._("Offer Length")}}</th>
        <th>{{translate._("Offer Description")}}</th>
        <th>{{translate._("Offer Start")}}</th>
        <th>{{translate._("Offer End")}}</th>
        <th>{{translate._("Active")}}</th>
        <th>{{translate._("Actions")}}</th>
    </tr>
    </thead>
    <tbody>
    {%for offer in offers%}
    <tr class="odd gradeX">
        <td>
            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                <input type="checkbox" class="checkboxes" value="{{offer.id}}"/>
                <span></span>
            </label>
        </td>
        <td>{{offer.id}}</td>
        <td> {{offer.name}}</td>
        <td>#</td>
        <td>{{offer.description}}</td>
        {%if(offer.getOffer_types('type_id=2')|length == 0)%}
        <td></td>
        <td></td>
        {%endif%}
        {%for rel_type in offer.getOffer_types('type_id=2')%}
        <td>{{ date('d-m-Y', rel_type.start_date) }}</td>
        <td>{{ date('d-m-Y', rel_type.end_date) }}</td>
        {%endfor%}
        <td>
            {%if(offer.active==1)%}
            <i class="fa fa-check text-success" aria-hidden="true"></i>
            {%else%}
            <i class="fa fa-close text-error" aria-hidden="true"></i>
            {%endif%}


        </td>
        <td>
            <a href="{{this.url_shared.get('offers_module/index/new/' ~offer.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i>
            </a>
            <a href="{{this.url_shared.get('offers_module/index/edit/' ~offer.id)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
            <a href="{{this.url_shared.get('offers_module/index/delete/' ~offer.id)}}" class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </a>


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
    $("#offers_filter").submit(function(e) {
        e.preventDefault();
        var url = "{{url('offers_module/index/offers_table')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#offers_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $(".portlet-body").html(response);
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $(".discount_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('offers_module/index/offers_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#offers_filter").serialize(), // serializes the form's elements.
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
        var data = { 'offers[]' : []};
        $(".checkboxes:checked").each(function() {
            data['offers[]'].push($(this).val());
        });
        var delete_url="{{url('offers_module/index/delete_offers')}}";
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