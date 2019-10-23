 <div class="">
                <div class="page-bar " style="position: relative">
                    <ul class="page-breadcrumb">
                        <li>
                            <i class="fa fa-home" aria-hidden="true"></i>
                            <a href="{{url('clients/index')}}"><span> الرئيسية </span></a>
                            <i class="fa fa-angle-left" aria-hidden="true"></i>
                        </li>
                        <li>
                            <span>العملاء</span>
                        </li>
                    </ul>

					<a href="{{url('clients/add')}}" style="position: absolute; left: 38px; top: 6px;" class="btn green-jungle btn-sm ">
                        <i class="fa fa-plus" aria-hidden="true"></i> إضافة عميل جديد
                    </a>
                </div>
                <div class="clearfix"></div>
                <div class="col-lg-12  col-md-12 col-xs-12 ">
                        <div class="building-header-container">
                            <div class="building-header-container-img"
                                 style=" background: url('http://www.air-worldwide.com/uploadedImages/About_AIR/our_clients.jpg') center center no-repeat ; background-size: cover"></div>
                            <div class="fade-bg"></div>
                            <div class="building-img">
                                <div style="width: 100%; min-height: 175px; overflow: hidden ; background: url('{{ url.getStatic('images/clients/clients.png') }}') center center no-repeat ; background-size: cover ; "></div>
                            </div>
                            <h4 class="building-titles">
                                العملاء
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
                                        <a class="imgandtext" href="{{url.get('clients/list')}}">
                                            <div class="img-section-container">
                                                <div class="img-section" style="background: url('{{url.getStatic('uploads/modules_pics/default_content.jpg')}}') center center no-repeat ; background-size: cover; "></div>
                                            </div>
                                            <h4> محتوى العملاء</h4>
                                        </a>

                                        <div class="  button-over-block-2">
                                            <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                            <ul class="dropdown-menu" role="menu">
                                                <li>
                                                    <a href="clients-content.html"> عرض </a>
                                                </li>

                                            </ul>
                                        </div>
                                    </div>
                                    <div class="swiper-slide">
                                        <a class="imgandtext" href="clients-reports.html">
                                            <div class="img-section-container">
                                                <div class="img-section" style="background: url('{{url.getStatic('uploads/modules_pics/default_content_stat.jpg')}}') center center no-repeat ; background-size: cover; "></div>
                                            </div>
                                            <h4> إحصائيات وتقارير  </h4>
                                        </a>

                                        <div class="  button-over-block-2">
                                            <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                            <ul class="dropdown-menu" role="menu">
                                                <li>
                                                    <a href="clients-reports.html"> عرض </a>
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
                    <!-- END DASHBOARD -->

            </div>