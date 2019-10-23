<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="maintenance.html"><span> الصيانة </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> عرض تقرير إحصائيات   </span>
        </li>

    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('img/banners/banner-maint.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

<div class="clearfix"></div>
<div class="portlet light gap clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-pencil-square-o font-dark"></i>
            <span class="caption-subject bold uppercase"> عرض تقرير إحصائيات  </span>
        </div>

    </div>
    <div class="portlet-body">
        <div class="panel panel-info">
            <div class="panel-heading clearfix">
                <div class=" col-md-4">
                    <div class="col-lg-5 col-xs-6"> نسبة طلبات الصيانة   </div>
                    <div class="col-lg-7 text-info col-xs-6 bold">
                        10%
                    </div>
                </div>

                <div class=" col-md-4">
                    <div class="col-lg-5 col-xs-6">  إجمالي طلبات الصيانة </div>
                    <div class="col-lg-7 col-xs-6 text-info bold">
                        12
                    </div>
                </div>
                <div class=" col-md-4">
                    <div class="col-lg-5 col-xs-6">  سعة الخزان </div>
                    <div class="col-lg-7 col-xs-6 text-info bold">
                        2500 لتر
                    </div>
                </div>

            </div>

            <div class="panel-body" id="report">


            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
    <input type="hidden" name="date_from" value="{{date_from}}" id="date_from" />
    <input type="hidden" name="date_to" value="{{date_to}}" id="date_to"/>
    <input type="hidden" name="dept_id" value="{{dept}}" id="dept_id"/>
    <input type="hidden" name="category_attribute_value" value="{{val}}" id="category_attribute_value"/>
</div>
<script>

    var date_from = ("#date_from").val;
    var date_to = ("#date_to").val;
    var dept_id = ("#dept_id").val;
    var category_attribute_value = ("#category_attribute_value").val;
    var url="{{url('maintenance_module/statistics/stat_report_table')}}";

        $.ajax({
            type: "POST",
            url: url,
            data: {
                "date_from":date_from,
                "date_to":date_to,
                "dept_id":dept_id,
                "category_attribute_value":category_attribute_value
            }, // serializes the form's elements.
            success: function (response)
            {

                $("#report").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });



</script>