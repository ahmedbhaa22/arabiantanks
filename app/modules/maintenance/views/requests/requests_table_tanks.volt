<div class="panel-body">
    <div class="panel-group accordion" id="accordion1">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#tanks-filter">
                        <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                    </a>
                </h4>
            </div>
            <div id="tanks-filter" class="panel-collapse collapse">
                {{ partial("requests/partials/requests_filter_tanks") }}
            </div>
        </div>
    </div>


    {{ partial("requests/partials/requests_count") }}
    <div class="  col-xs-12 no-padding space">

        {{ partial("requests/partials/requests_table_partial") }}        <div class="row">
            <div class="col-md-5 col-sm-5">
                <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                    {{content['total_pages']}}/{{content['current']}}                    </div>
            </div>
            <div class="col-md-7 col-sm-7">
                <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                    <ul class="pagination" style="visibility: visible;">
                        <li class='total_requests_tanks'><a href="1">الأول</a></li>
                        <li class='total_requests_tanks'><a href="{{content['before']}}">السابق</a></li>
                        <li class='total_requests_tanks'><a href="{{content['next']}}">التالي</a></li>
                        <li class='total_requests_tanks'><a href="{{content['last']}}">الأخير</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(".total_requests_tanks a").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/requests/requests_table_tanks')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: [], // serializes the form's elements.
            success: function (response)
            {

                $("#tanks").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $("#requests_filter_tanks").submit(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/requests/requests_table_tanks')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#requests_filter_tanks").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#tanks").html(response);
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>