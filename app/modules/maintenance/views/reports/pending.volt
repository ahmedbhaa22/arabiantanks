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
{{ partial("reports/partials/partial_menu") }}
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
                <div id="collapse-clients-filter" class="panel-collapse collapse">
                    <div class="panel-body">
                        <form role="form" id="pending_reports_filter">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label">التاريخ من </label>
                                        <input type="date" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label">التاريخ الى </label>
                                        <input type="date" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label">الصنف</label>
                                        <select class="form-control" id="sel1">
                                            <option>صنف 1</option>
                                            <option>صنف 2 </option>
                                            <option>صنف 3 </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label">نوع الصنف</label>
                                        <select class="form-control" id="sel2">
                                            <option>نوع 1</option>
                                            <option>نوع 2 </option>
                                            <option>نوع 3 </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label">المشكلة</label>
                                        <input type="text" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label"> مكان المشكلة</label>
                                        <input type="text" class="form-control" />
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label"> المنطقة</label>
                                        <select class="form-control" id="sel3">
                                            <option>منطقة 1</option>
                                            <option>منطقة 2 </option>
                                            <option>منطقة 3 </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label">سعة الخزان </label>
                                        <select class="form-control" id="sel4">
                                            <option>سعة 1</option>
                                            <option>سعة 2 </option>
                                            <option>سعة 3 </option>
                                        </select>
                                    </div>
                                </div>
                                <div class=" col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label ">داخل الضمان</label>
                                        <div class="col-sm-12 no-padding">
                                            <input type="checkbox" class="make-switch" checked data-on-text="<i class='fa fa-check'></i> " data-off-text="<i class='fa fa-times'></i>"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-primary">فلتر</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="printable-area" id="pending_req_report">

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

    var pending_url="{{url('maintenance_module/reports/pending_table')}}";
    $("#pending_req_report").load(pending_url);

</script>