<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <a href="{{url('content/main/8')}}"><span> المنتجات </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <a href="{{url('sales/index')}}"><span> المبيعات </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <span>الزيارات</span>
            </li>
        </ul>
    </div>
    <div class="clearfix"></div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
    <div class="portlet light clearfix">
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-users font-dark"></i>
                <span class="caption-subject bold uppercase"> الزيارات</span>
            </div>

            <div class="actions">

            </div>

        </div>
        <div class="portlet-body">
            <div class="col-md-12 no-padding">
                <form role="form" method="get" action="" id="">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label class=" control-label">تاريخ من</label>
                                <input type="date" class="form-control" name="date_from" value="{{date['from']}}">
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="form-group">
                                <label class=" control-label">تاريخ الى</label>
                                <input type="date" class="form-control" name="date_to" value="{{date['to']}}">
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-primary" type="submit">فلتر</button>
                    <br><br><br><br><br><br>
                </form>
            </div>

            <div class="  col-xs-12  widget-cont no-padding">

                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-battery-empty fa-2x" aria-hidden="true"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{missions_sale}}</div>
                                <div class="text-uppercase"> بيع </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-battery-half fa-2x" aria-hidden="true"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{missions_product_view}}</div>
                                <div class="text-uppercase">عرض منتج </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-battery-full  fa-2x" aria-hidden="true"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{missions_expected_client}}</div>
                                <div class="text-uppercase"> عميل متوقع </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                                <i class="fa fa-ban fa-2x"></i>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{missions_cash_collect}}</div>
                                <div class="text-uppercase"> تحصيل مالي </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>

<script type="text/javascript">
    $('.delete-visit').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد زيارات المبيعات، إستكمال العملية؟'))
       {
            $.ajax({
                type: 'post',
                url: "{{url('sales_visits/delete/')}}" + $(this).data('visit_id'),
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('sales_visits/index')}}";
                        break;
                    }
                }
            });
       } 
    });
</script>