<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="maintenance.html"> <span>الصيانة</span> </a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> تقارير الصيانة </span>
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
<div class="portlet light gap clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-pencil-square-o font-dark"></i>
            <span class="caption-subject bold uppercase">تقارير الصيانة</span>
        </div>

    </div>
    <div class="portlet-body">
        <div class="row">
            <div class="  col-xs-12  widget-cont no-padding">
                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-4 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-hourglass-start fa-3x"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{open_count|length}}</div>
                                <div class="text-uppercase">طلب مفتوح</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-4 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-hourglass-start fa-3x"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{assign_count|length}}</div>
                                <div class="text-uppercase"> تعيين فني صيانة</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-4 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-hourglass-start fa-3x"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{approve_count|length}}</div>
                                <div class="text-uppercase"> ارسل للتعميد </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-4 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-hourglass-start fa-3x"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{approved_count|length}}</div>
                                <div class="text-uppercase">تم التعميد</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-4 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-hourglass-start fa-3x"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{closed_count|length}}</div>
                                <div class="text-uppercase"> اغلاق الطلب - تم الحل </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            {{ partial("reports/partials/partial_menu") }}
        </div>
        </div>
    </div>


<!--end mt-element-step -->