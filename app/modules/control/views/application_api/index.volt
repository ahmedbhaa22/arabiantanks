<div class="col-xs-12">
    <div class="slider-one-row">
        <div class="swiper-container">
            <div class="swiper-wrapper">
               <div class="swiper-slide">
                    <a class="imgandtext" href="{{url('application_api/newaction')}}">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('{{this.url_shared.get()}}img/sections/directions.png') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4>{{translate._("New Action")}}</h4>
                    </a>

                    <div class="  button-over-block-2">
                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                            <i class="fa fa-angle-down"></i>
                        </a>

                    </div>
                </div>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
        </div>
    </div>
</div>