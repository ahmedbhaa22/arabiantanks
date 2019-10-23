<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href=""><?php echo $translate->_("Main Page"); ?></a>
            <i class="icon-arrow-left"></i>
        </li>

    </ul>
</div>
<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url('{{this.url_shared.get("img/")}}alarabiatanks.png')  center no-repeat ; background-size: contain;">
        </div>
    </div>
</div>
<div class="clearfix"></div>


<div class="portlet-body">
    <div id="sample_1_wrapper">
        <div class="col-xs-12">
            <div class="slider-one-row">
                <div class="swiper-container swiper-container-horizontal swiper-container-rtl">
                    <div class="swiper-wrapper" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
                        <!---slide---->
                        {% for item in content %}
                        <div class="swiper-slide swiper-slide" style="width: 227.8px; margin-left: 10px;">
                            <a class="imgandtext" href="{{this.url_shared.get()}}{{item['url']}}">
                                <div class="img-section-container">
                                    <div class="img-section" style="background: url('{{this.url_shared.get()}}img/sections/{{item["big_icon"]}}') center center no-repeat ; background-size: cover; "></div>
                                </div>
                                <h4> {{item['name']}}</h4>
                            </a>

                            <div class="button-over-block-2">
                                <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown" aria-expanded="false">
                                    <i class="fa fa-angle-down"></i>
                                </a>

                            </div>
                        </div>
                        {% endfor %}



                    </div>
                    <!-- Add Pagination -->
                    <!--            <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span></div>-->
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</div>