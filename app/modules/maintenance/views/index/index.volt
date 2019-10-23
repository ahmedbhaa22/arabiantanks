<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href=""><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> الصيانة </span>
        </li>
    </ul>

    <a href="{{url("maintenance_module/requests/new")}}" style="position: absolute; left: 38px; top: 6px;" class="btn green-jungle btn-sm ">
        <i class="fa fa-ticket" aria-hidden="true"></i> طلب صيانة جديد
    </a>
</div>
<div class="clearfix"></div>

<div class="col-lg-12  col-md-12 col-xs-12 ">
    <div class="building-header-container">
        <div class="building-header-container-img"
             style=" background: url('http://imagehomeimprovements.com/images/stories/renovations/home%20maintenance%202.jpg') center center no-repeat ; background-size: cover"></div>
        <div class="fade-bg"></div>
        <div class="building-img">
            <div style="width: 100%; min-height: 175px; overflow: hidden ; background: url('{{url("img")}}/sections/maint.png') center center no-repeat ; background-size: cover ; "></div>
        </div>
        <h4 class="building-titles">
            الصيانة
        </h4>

    </div>


</div>
<div class="clearfix"></div>

<!--Swiper-->
<div class="col-xs-12">
    <div class="slider-one-row">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <!---slide---->
                <div class="swiper-slide">
                    <a class="imgandtext" href="{{url('maintenance_module/requests')}}">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('{{url("img")}}/sections/content.png') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4> طلبات الصيانة</h4>
                    </a>

                    <div class="  button-over-block-2">
                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="{{url('maintenance_module/requests')}}"> عرض </a>
                            </li>

                        </ul>
                    </div>
                </div>

                <!---slide---->
                <div class="swiper-slide">
                    <a class="imgandtext" href="{{url('maintenance_module/reports')}}">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('{{url("img")}}/sections/edit.png') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4> تقارير الصيانة  </h4>
                    </a>

                    <div class="  button-over-block-2">
                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="{{url('maintenance_module/reports')}}"> عرض </a>
                            </li>

                        </ul>
                    </div>
                </div>

                <!---slide---->
<!--                <div class="swiper-slide">-->
<!--                    <a class="imgandtext" href="{{url('maintenance_module/statistics')}}">-->
<!--                        <div class="img-section-container">-->
<!--                            <div class="img-section" style="background: url('{{url('img')}}/sections/graph.png') center center no-repeat ; background-size: cover; "></div>-->
<!--                        </div>-->
<!--                        <h4> احصائيات الصيانة </h4>-->
<!--                    </a>-->
<!---->
<!--                    <div class="  button-over-block-2">-->
<!--                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">-->
<!--                            <i class="fa fa-angle-down"></i>-->
<!--                        </a>-->
<!--                        <ul class="dropdown-menu" role="menu">-->
<!--                            <li>-->
<!--                                <a href="{{url('maintenance_module/statistics')}}"> عرض </a>-->
<!--                            </li>-->
<!---->
<!--                        </ul>-->
<!--                    </div>-->
<!--                </div>-->

                <!---slide---->
                <div class="swiper-slide">
                    <a class="imgandtext" href="{{url('maintenance_module/problems')}}">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('{{url("img")}}/sections/problems.png') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4> مشاكل الصيانة</h4>
                    </a>

                    <div class="  button-over-block-2">
                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <a href="{{url('maintenance_module/problems')}}"> عرض </a>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
        </div>
    </div>
</div>

<div class="clearfix"></div>
