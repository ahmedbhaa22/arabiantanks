<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li> </li>
        <!--        <li>-->
        <!--            <a href="index.html">محتويات التطبيق </a>-->
        <!--            <!--<i class="icon-arrow-left"></i>-->
        <!--        </li>-->
        <!--        <!--<li>-->
        <!--        <!--<span>عمارة أول مكرم عبيد</span>-->
        <!--        <!--</li>-->
    </ul>

    
</div>
<div class="clearfix"></div>


<div class="col-xs-12">
    <div class=" statistics-titles bg-blue-chambray">
        <div class="caption font-white">
            <i class="fa fa-layers font-white"></i>
            <span class="caption-subject bold uppercase"> <?php echo $translate->_("Modules"); ?> </span>
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
                            {% for module in Modules %}
                            <div class="swiper-slide swiper-slide" style="width: 227.8px; margin-left: 10px;">
                                <a class="imgandtext" href="{{url("users_application_module/moduleHome/" ~module.ID)}}">
                                    <div class="img-section-container">
                                        <div class="img-section" style="background: url('{{this.url_shared.get()}}uploads/modules_pics/{{module.Settings.Img}}') center center no-repeat ; background-size: cover; "></div>
                                    </div>
                                    <h4> {{module.Title}}</h4>
                                </a>

                                <div class="button-over-block-2">
                                    <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="dropdown-menu" role="menu">
                                        <li>
                                            <a href="{{url('users_application_module/settings/') ~ module.ID}}"> <?php echo $translate->_("Edit"); ?> </a>
                                        </li>


                                        <li>
                                            <a href="{{url('users_application_module/additionalSettings/') ~ module.ID}}">{{ translate._("Edit Additional Information")}}</a>
                                        </li>

                                        <li>
                                            <a href="{{url('users_application_module/delete/') ~ module.ID}}"  onclick="return confirm('Are you sure you want to delete this Module?');">{{ translate._("Delete")}}</a>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                            {% endfor %}
                            
                        </div>
                        <!-- Add Pagination -->
                        <!--            <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span></div>-->
                        
                    </div>
                </div>
            </div>
            <div class="clearfix"></div> <br>
            <div class="col-xs-12">
                <a href="{{url('users_application_module/new/')}}" data-toggle="modal" style="display:inline-block;" class="btn  green-jungle btn-sm gap">
                                    {{ translate._("Add New Module")}}
                </a>
            </div>
        </div>
    </div>

<div class="clearfix"></div>