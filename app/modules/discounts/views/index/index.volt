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
            <span class="caption-subject bold uppercase"> الخصومات</span>
        </div>

        <div class="actions">
            <a type="button" href="{{this.url_shared.get('discounts_module/index/new')}}" class="btn btn-edit-my-data green-jungle btn-outline  btn-block">
                <i class="fa fa-plus"></i>
                اضافة خصم</a>
        </div>

    </div>
    <div class="portlet-body">

    </div>
</div>

<script>
    var url= "{{url('discounts_module/index/discounts_table')}}";
    $(".portlet-body").load(url);
</script>