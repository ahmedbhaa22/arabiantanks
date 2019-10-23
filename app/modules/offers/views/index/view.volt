<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="{{url('cms_module/home/index/1')}}"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="{{url('cms_module/home/index/2')}}"><span> المنتجات </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="{{url('offers_module/index')}}"><span> العروض </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span>تفاصيل العرض</span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>
<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class=""
                 style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get()}}img/alarabiatanks.png') center center no-repeat ; background-size: contain"></div>
        </div>
        </div>
    </div>

<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-tag font-dark"></i>
            <span class="caption-subject bold uppercase">{{offer.name}}</span>
        </div>
        <div class="actions">

            <!--
                                            <a href="#add-products" class="btn btn-xs btn-success">
                                                <i class="fa fa-shopping-cart" aria-hidden="true"></i> إضافة منتجات
                                            </a>
            -->
            <a href="{{this.url_shared.get('offers_module/index/edit/' ~offer.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-pencil-square-o" aria-hidden="true"></i> </a>
            <a href="{{this.url_shared.get('offers_module/index/delete/' ~offer.id)}}" class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </a>


        </div>
    </div>
    <div class="portlet-body">
        <div class="col-xs-6">
            <table class="table">
                <tbody>
                <tr>
                    <td class="bold">نسبة الخصم</td>
                    <td><i class="fa fa-tag" aria-hidden="true"></i> {{offer.discount_percent}}% </td>
                </tr>
                <tr>
                    <td class=" bold"><i class="fa fa-calendar" aria-hidden="true"></i> مدة العرض </td>
                    <td>
                        {{translate._("From")}}
                        {{ date('d-m-Y', offer_rel_type.start_date) }}
                        {{translate._("To")}}
                        {{ date('d-m-Y', offer_rel_type.end_date) }}

                    </td>
                </tr>
                <tr >
                    <td class="bold" > وصف العرض  </td>
                    <td>{{offer.description}}</td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="col-xs-6">
            <table class="table">
                <tbody>
                <tr >
                    <td class="bold">عدد المنتجات في العرض</td>
                    <td><label class="label label-danger circle"> {{offer.products_number}} </label></td>
                </tr>

                <tr>
                    <td class="bold"> ترتيب الظهور في الصفحة الرئيسية </td>
                    <td>
                        <div class="col-xs-9 no-padding">
                            <label class="label label-success circle"> {{offer.show_in_homepage}} </label>
                        </div>
                        <div class="col-xs-3 no-padding">
                            <a type="button" href="{{this.url_shared.get('offers_module/index/edit/' ~offer.id)}}" class="btn btn-xs btn-success pull-right" data-toggle="" data-target="">
                                <i class="fa fa-edit" aria-hidden="true"></i> تعديل
                            </a>
                        </div>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

    </div><!-- end portlet-->
</div>
<!-- END EXAMPLE TABLE PORTLET-->

<div id="products_container">
<div id="products_view">

</div>
</div>
<script>
    var url = "{{url('offers_module/index/products/' ~offer.id)}}"; // the script where you handle the form input.
    $("#products_view").load(url);
</script>

<div class="clearfix"></div>