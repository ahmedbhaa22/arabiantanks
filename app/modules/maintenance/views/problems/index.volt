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
            <span>محتوى</span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url('img/banners/banner-maint.png')}}') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-times font-dark"></i>
            <span class="caption-subject bold uppercase"> مشاكل الصيانة</span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('maintenance_module/problems/new')}}" class="btn green-jungle btn-outline  btn-block">
                <i class="fa fa-plus" aria-hidden="true"></i>  مشكلة صيانة جديدة</a>
        </div>

    </div>
    <div class="portlet-body">

    </div>


</div>

<script>
    var url= "{{url('maintenance_module/problems/problems_table')}}";
    $(".portlet-body").load(url);
</script>