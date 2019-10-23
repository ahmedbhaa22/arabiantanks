<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
<!--        <li>-->
<!--            <i class="fa fa-home" aria-hidden="true"></i>-->
<!--            <a href="index.html"><span> الرئيسية </span></a>-->
<!--            <i class="fa fa-angle-left"></i>-->
<!--        </li>-->
<!--        <li>-->
<!--            <a href="production.html"><span> المنتجات </span></a>-->
<!--            <i class="fa fa-angle-left"></i>-->
<!--        </li>-->
<!--        <li>-->
<!--            <a href="production_content.html"><span> محتوى </span></a>-->
<!--            <i class="fa fa-angle-left"></i>-->
<!--        </li>-->
        <li>
            <a href="{{url('discounts_module/index/index')}}"><span> الخصومات </span></a>
        </li>
        <li>
            <span>تفاصيل الخصم</span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class=""
                 style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get()}}img/alarabiatanks.png') center center no-repeat ; background-size: contain"></div>        </div>
    </div>
</div>
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-money" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase">{{discount.name}}</span>
        </div>
        <div class="actions">
            <a type="button" href="{{this.url_shared.get('discounts_module/index/edit/') ~discount.id}}" class="btn btn-xs btn-info">
                <i class="fa fa-pencil-square-o" aria-hidden="true"></i> تعديل بيانات الخصم
            </a>
            <a type="button" href="{{url('discounts_module/index/delete/') ~discount.id}}" class="btn btn-xs btn-danger" onclick="return confirm('Are you sure you want to delete this item?');">
                <i class="fa fa-trash-o" aria-hidden="true"></i> حذف الخصم
            </a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="panel">
            <div class="panel-body">
                <div class="form-group col-md-4 col-xs-12 no-padding">
                    <div class="col-lg-3 col-xs-6 bold">نسبة الخصم</div>
                    <div class="col-lg-9 col-xs-6"><i class="fa fa-tag" aria-hidden="true"></i>{{discount.percentage}}</div>
                </div>


                <div class="form-group col-md-4 col-xs-12 no-padding">
                    <div class="col-lg-3 col-xs-6 bold">كود الكوبون </div>
                    <div class="col-lg-9 col-xs-6 bordered"> {{discount.coupon}} </div>
                </div>

                <!--
                                                    <div class="form-group col-md-4 col-xs-12 no-padding">
                                                        <div class="col-lg-3 col-xs-6 bold">نوع شرط الخصم </div>
                                                        <div class="col-lg-9 col-xs-6"></i> العميل لدية واحدة من تلك المنتجات في عربة التسوق </div>
                                                    </div>
                -->
                <div class="form-group col-md-4 col-xs-12 no-padding">
                    <div class="col-lg-3 col-xs-6 bold">مدة الخصم </div>
                    <div class="col-lg-9 col-xs-6"> من {{ date('d-m-Y', discount.start_date) }} الى {{ date('d-m-Y', discount.end_date) }}    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- END EXAMPLE TABLE PORTLET-->
    <div id="discount_products_view">

    </div>


    <script>

        var url= "{{url('discounts_module/index/discount_products/' ~discount.id)}}";
        $("#discount_products_view").load(url);


    </script>


</div>