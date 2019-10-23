<div class="panel-body">
    {%if(fast_search==0)%}
    <div class="panel-group accordion" id="accordion1">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#total-filter">
                        <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                    </a>
                </h4>
            </div>

            <div id="total-filter" class="panel-collapse collapse">
                {{ partial("requests/partials/requests_filter_total") }}
            </div>
        </div>
    </div>


    {{ partial("requests/partials/requests_count") }}
    {%endif%}
    <div class="  col-xs-12 no-padding space">

        {{ partial("requests/partials/requests_table_partial") }}
        <div class="row">
            <div class="col-md-5 col-sm-5">
                <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                    {{content['total_pages']}}/{{content['current']}}                    </div>
            </div>
            <div class="col-md-7 col-sm-7">
                <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                    <ul class="pagination" style="visibility: visible;">
                        <li class='total_requests_page'><a href="1">الأول</a></li>
                        <li class='total_requests_page'><a href="{{content['before']}}">السابق</a></li>
                        <li class='total_requests_page'><a href="{{content['next']}}">التالي</a></li>
                        <li class='total_requests_page'><a href="{{content['last']}}">الأخير</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(".total_requests_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/requests/requests_table')}}"+"&page="+$(this).attr("href")+"&fast={{fast_search}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#requests_filter_total").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#total").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $("#requests_filter_total").submit(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/requests/requests_table')}}"+"&fast={{fast_search}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#requests_filter_total").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#total").html(response);
            }
        });

        // avoid to execute the actual submit of the form.
    });

</script>