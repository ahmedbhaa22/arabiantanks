<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="index.html"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <a href="production.html"><span> المنتجات </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <span>المبيعات</span>
            </li>
        </ul>
    </div>
    <div class="clearfix"></div>
    <div class="col-lg-12  col-md-12 col-xs-12 ">
            <div class="building-header-container">
                <div class="building-header-container-img"
                     style=" background: url('https://www.incimages.com/uploaded_files/image/970x450/handshake-pano_19966.jpg') center center no-repeat ; background-size: cover"></div>
                <div class="fade-bg"></div>
                <div class="building-img">
                    <div style="width: 100%; min-height: 175px; overflow: hidden ; background: url('{{url.getStatic('images/products/sales.png')}}') center center no-repeat ; background-size: cover ; "></div>
                </div>
                <h4 class="building-titles">
                    {{translate._('Sales')}}
                    <br>
                    <span>
                        <i class="{{url('users_application_module')}}"></i> الصفحة الرئيسية
                    </span>
            </div>


        </div>
        <div class="clearfix"></div>

        <!--Swiper-->
        <div class="col-xs-12">
            <div class="slider-one-row">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <!---slide---->
                        {% for section_name,section_data in sections %}
                            <div class="swiper-slide">
                            <a class="imgandtext" href="{{url(section_data['link'])}}">
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
                                        <a href="{{url(section_data['link'])}}"> عرض </a>
                                    </li>

                                </ul>
                            </div>
                        </div>
                        {% endfor %}
                    </div>
                    <!-- Add Pagination -->
                    <div class="swiper-pagination"></div>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>
        <!-- END DASHBOARD -->

</div>