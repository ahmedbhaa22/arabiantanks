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
            <span>العروض</span>
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
            <span class="caption-subject bold uppercase"> العروض</span>
        </div>
        <div class="actions">
            <a type="button" href="{{this.url_shared.get('offers_module/index/new')}}" class="btn btn-edit-my-data green-jungle btn-outline  btn-block">
                <i class="fa fa-user-plus"></i>
                اضافة عرض جديد</a>
        </div>
    </div>
    <div class="portlet-body">



    </div>
</div>
<!-- END EXAMPLE TABLE PORTLET-->

<script>
    var url= "{{url('offers_module/index/offers_table')}}";
    $(".portlet-body").load(url);
</script>

<div class="clearfix"></div>
<!-- END DASHBOARD -->


