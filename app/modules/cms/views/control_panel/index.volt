<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase"> لوحة التحكم  </span>
        </div>

    </div>
    <div class="portlet-body">
        <div class="row">
            <div class="col-sm-2">
                <ul class="nav nav-tabs tabs-left gap">
                    <li class="active"><a data-toggle="tab" href="#areas">المناطق والفروع</a></li>
                    <li><a data-toggle="tab" href="#roles"> تصنيفات العملاء </a></li>
                    <li><a data-toggle="tab" href="#reasons"> أسباب تعليق طلبات الصيانة </a></li>
                </ul>
            </div>
            <div class="tab-content col-sm-10 no-padding">
                <div id="areas" class="tab-pane fade in active no-padding">

                </div>

                <div id="roles" class="tab-pane fade in no-padding">

                </div>

                <div id="reasons" class="tab-pane fade in no-padding">

                </div>

            </div>
        </div>
    </div>

</div>

<script>
    var url= "{{url('control_panel/branches_table')}}";
    $("#areas").load(url);
    var url_rules= "{{url('control_panel/clients_cats_table')}}";
    $("#rols").load(url_rules);
    var url_reasons= "{{url('control_panel/reasons_table')}}";
    $("#reasons").load(url_reasons);




        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            var url= "{{url('control_panel/branches_table')}}";
            $("#areas").load(url);
            var url_rules= "{{url('control_panel/clients_cats_table')}}";
            $("#roles").load(url_rules);
            var url_reasons= "{{url('control_panel/reasons_table')}}";
            $("#reasons").load(url_reasons);
        });

</script>