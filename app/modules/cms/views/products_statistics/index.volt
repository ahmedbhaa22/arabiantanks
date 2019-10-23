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
            <li><span>احصائيات</span></li>
        </ul>
    </div>
    <div class="clearfix"></div>
    <div class="col-lg-12  col-md-12 col-xs-12 ">
            <div class="building-header-container">
                <div class="building-header-container-img"
                     style=" background: url('{{url.getStatic('images/products/Statistics-section.jpg')}}') center center no-repeat ; background-size: cover"></div>
                <div class="fade-bg"></div>
                <div class="building-img">
                    <div style="width: 100%; min-height: 175px; overflow: hidden ; background: url('{{url.getStatic('images/products/graph.png')}}') center center no-repeat ; background-size: cover ; "></div>
                </div>
                <h4 class="building-titles">
                     احصائيات المنتجات
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
                        {% for section_name, section_data in sections %}
                            <div class="swiper-slide">
                            <a class="imgandtext" href="{{url(section_data['url'])}}">
                                <div class="img-section-container">
                                    <div class="img-section" style="background: url('{{url.getStatic(section_data['img'])}}') center center no-repeat ; background-size: cover; "></div>
                                </div>
                                <h4>{{translate._(section_name)}}</h4>
                            </a>

                            <div class="  button-over-block-2">
                                <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                                    <i class="fa fa-angle-down"></i>
                                </a>
                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <a href="{{url(section_data['url'])}}"> عرض </a>
                                    </li>

                                </ul>
                            </div>
                        </div>
                        {% endfor %}
                        <!---slide---->
                        <div class="swiper-slide maintenance_stat_swipe">
                            <a class="imgandtext" href="{{this.url_shared.get('maintenance_module/statistics')}}">
                                <div class="img-section-container">
                                    <div class="img-section" style="background: url('{{this.url_shared.get('img')}}/sections/graph.png') center center no-repeat ; background-size: cover; "></div>
                                </div>
                                <h4> احصائيات الصيانة </h4>
                            </a>

                            <div class="  button-over-block-2">
                                <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                                    <i class="fa fa-angle-down"></i>
                                </a>
                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <a href="{{this.url_shared.get('maintenance_module/statistics')}}"> عرض </a>
                                    </li>

                                </ul>
                            </div>
                        </div>

                        <!-- Add Pagination -->
                    <div class="swiper-pagination"></div>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>
        <!-- END DASHBOARD -->

</div>