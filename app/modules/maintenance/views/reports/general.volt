<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href=""><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href=""> <span>الصيانة</span> </a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href=""> <span> تقارير الصيانة</span> </a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> تقارير عامة </span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url("img")}}/banners/banner-maint.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>
<div class="clearfix"></div>

<!--end mt-element-step -->

<div class="clearfix"></div>

<div class="portlet light gap clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-pencil-square-o font-dark"></i>
            <span class="caption-subject bold uppercase"> تقارير عامة</span>
        </div>

    </div>
    <div class="portlet-body">
        <div class="panel-group accordion hide-print" id="accordion1">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">
                            <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                        </a>
                    </h4>
                </div>

                {{ partial("reports/partials/filter_general", ['main_cats': main_cats,'regions':regions,'problem_statuses':problem_statuses,'all_problems':all_problems]) }}
            </div>
        </div>
        <div class="printable-area" id="general_req_report">

                   </div>

        <div class="col-xs-12 no-padding hide-print">
            <button class="btn btn-info btn-md">
                <i class="fa fa-print"></i> طباعة
            </button>
            <button class="delete-btn btn btn-danger btn-md">
                <i class="fa fa-trash"></i>حذف المحدد
            </button>
        </div>
    </div>
</div>
<!-- END EXAMPLE TABLE PORTLET-->
<script>

    var general_url="{{url('maintenance_module/reports/general_table')}}";
    $("#general_req_report").load(general_url);
    $("#general_reports_filter").submit(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/reports/general_table')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#general_reports_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#general_req_report").html(response);
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $("#general_reports_export").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/reports/export_excel')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#general_reports_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                var obj = jQuery.parseJSON(response);
                window.location.href ="{{this.url_shared.get('uploads/')}}"+obj.file_name;
            }
        });

        // avoid to execute the actual submit of the form.
    });

</script>