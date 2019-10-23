
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <a href="<?= $this->url->get() ?>"><?= $translate->_('Control Panel') ?></a>
            </li>
        </ul>

    </div>

    <div class="col-lg-12  col-md-12 col-xs-12 ">
        <div class="building-header-container">
            <div class="building-header-container-img"
                 style=" background: url('<?= $this->url_shared->get() ?>img/login-bg.png') center center no-repeat;"></div>
            <div class="fade-bg"></div>
            <div class="building-img">
                <div style="width: 100%; min-height: 175px; overflow: hidden ; background: url('<?= $this->url_shared->get() ?>img/sections/settings.png') center center no-repeat ; background-size: cover ; "></div>
            </div>
            <h4 class="building-titles">
               <?= $translate->_('Control Panel') ?>
                <br>
                <!--<span>-->
                <!--<i class=" icon-list font-green-jungle"></i>-->
                <!--3 موديول-->
                <!--<i class=" icon-cloud-download font-green-jungle"></i>-->
                <!--5000 تحميل-->
                <!--</span>-->

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
                        <a class="imgandtext" href="<?= $this->url->get('menus/main') ?>">
                            <div class="img-section-container">
                                <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>img/sections/12-pages.png') center center no-repeat ; background-size: cover; "></div>
                            </div>
                            <h4> <?= $translate->_('Menus') ?> </h4>
                        </a>

                        <div class="  button-over-block-2">
                            <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                                <i class="fa fa-angle-down"></i>
                            </a>

                        </div>
                    </div>
                    <!---slide---->
                    <div class="swiper-slide">
                        <a class="imgandtext" href="<?= $this->url->get('users_application_module') ?>">
                            <div class="img-section-container">
                                <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>img/sections/7-samples.png') center center no-repeat ; background-size: cover; "></div>
                            </div>
                            <h4><?= $translate->_('Modules') ?></h4>
                        </a>

                        <div class="  button-over-block-2">
                            <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                                <i class="fa fa-angle-down"></i>
                            </a>
                        </div>
                    </div>
                    <!---slide---->
                    <!-- <div class="swiper-slide">
                        <a class="imgandtext" href="<?= $this->url->get('application_localization') ?>">
                            <div class="img-section-container">
                                <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>img/sections/lang.png') center center no-repeat ; background-size: cover; "></div>
                            </div>
                            <h4> اللغات</h4>
                        </a>

                        <div class="  button-over-block-2">
                            <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                                <i class="fa fa-angle-down"></i>
                            </a>

                        </div>
                    </div> -->
                    <!---slide---->
                    <div class="swiper-slide">
                        <a class="imgandtext" href="<?= $this->url->get('application_settings') ?>">
                            <div class="img-section-container">
                                <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>img/sections/directions.png') center center no-repeat ; background-size: cover; "></div>
                            </div>
                            <h4><?= $translate->_('Application Options') ?></h4>
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

    <div class="clearfix"></div>
    <!-- END DASHBOARD -->

