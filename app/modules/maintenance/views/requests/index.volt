<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="{{url('maintenance_module/requests/index')}}"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="{{url('maintenance_module/requests/index')}}"><span> الصيانة </span></a>
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
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url('img/banners/')}}banner-maint.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-wrench font-dark"></i>
            <span class="caption-subject bold uppercase"> الطلبات </span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('maintenance_module/requests/new')}}" class="btn btn-edit-my-data green-jungle btn-outline  btn-block">
                <i class="fa fa-ticket" aria-hidden="true"></i>  طلب صيانة جديد</a>
        </div>

    </div>
    <div class="portlet-body">


        <div class="col-md-9 no-padding">
            <ul class="nav nav-tabs ">
                <li class="active"><a data-toggle="tab" href="#branch">طلبات الصيانة للفروع</a></li>
                <li class=""><a data-toggle="tab" href="#total"> كل الطلبات  </a></li>
                <li class=""><a data-toggle="tab" href="#tanks"> الخزنات  </a></li>
                <li class=""><a data-toggle="tab" href="#coverings"> الاغطية الارضية  </a></li>
<!--                <li class=""><a data-toggle="tab" href="#door"> الابواب   </a></li>-->
                <li class=""><a data-toggle="tab" href="#pumps"> المضخات   </a></li>
            </ul>
        </div>
        <div class="clearfix"></div>

        <div class="tab-content col-md-12 no-padding">
            <div id="branch" class="tab-pane fade in active">
                <div class="panel">

                </div>
            </div>
            <div id="total" class="tab-pane fade in">
                <div class="panel">

                </div>
            </div>
            <div id="tanks" class="tab-pane fade in">
                <div class="panel">

                </div>
            </div>
            <div id="coverings" class="tab-pane fade in">
                <div class="panel">

                </div>
            </div>
            <div id="door" class="tab-pane fade in">
                <div class="panel">

                </div>
            </div>
            <div id="pumps" class="tab-pane fade in">
                <div class="panel">

                </div>
            </div>
        </div>


    </div>
    <!-- END EXAMPLE TABLE PORTLET-->

</div>

<script>
    var url= "{{url('maintenance_module/requests/requests_table')}}";
    $("#total").load(url);
    var url_tanks= "{{url('maintenance_module/requests/requests_table_tanks')}}";
    $("#tanks").load(url_tanks);
    var url_covering= "{{url('maintenance_module/requests/requests_table_covering')}}";
    $("#coverings").load(url_covering);
//    var url_doors= "{{url('maintenance_module/requests/requests_table_doors')}}";
//    $("#door").load(url_doors);
    var url_pumps= "{{url('maintenance_module/requests/requests_table_pumps')}}";
    $("#pumps").load(url_pumps);
    var url_branch= "{{url('maintenance_module/requests/requests_table_branch')}}";
    $("#branch").load(url_branch);
</script>