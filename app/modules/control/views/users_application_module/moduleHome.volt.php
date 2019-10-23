<div class="col-lg-12  col-md-12 col-xs-12 ">
    <div class="building-header-container">
        <div class="building-header-container-img"
             style=" background: url('<?= $this->url_shared->get() ?>img/login-bg.png') center center no-repeat;"></div>
        <div class="fade-bg"></div>
        <div class="building-img">
            <div style="width: 100%; min-height: 175px; overflow: hidden ; background: url('<?= $this->url_shared->get() ?>img/sections/7-samples.png') center center no-repeat ; background-size: cover ; "></div>
        </div>
        <h4 class="building-titles">
            <?= $Module->Title ?>
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
                    <a class="imgandtext" href="<?= $this->url->get('main_departments/index/' . $Module_ID) ?>">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>img/sections/15-devision.png') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4> <?= $translate->_('Main Departments') ?></h4>
                    </a>

                    <div class="  button-over-block-2">
                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                            <i class="fa fa-angle-down"></i>
                        </a>

                    </div>
                </div>
                <!---slide---->
                <div class="swiper-slide">
                    <a class="imgandtext" href="<?= $this->url->get('users_application_module/settings/' . $Module_ID) ?>">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>img/sections/list.png') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4><?= $translate->_('Module Options') ?> </h4>
                    </a>

                    <div class="  button-over-block-2">
                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                            <i class="fa fa-angle-down"></i>
                        </a>

                    </div>
                </div>
                <!---slide---->
                <div class="swiper-slide">
                    <a class="imgandtext" href="<?= $this->url->get('keyvalue/index/' . $Module_ID) ?>">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>img/sections/key.png') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4><?= $translate->_('KeyValue') ?></h4>
                    </a>

                    <div class="  button-over-block-2">
                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                            <i class="fa fa-angle-down"></i>
                        </a>

                    </div>
                </div>
                <!---slide---->
                <div class="swiper-slide">
                    <a class="imgandtext" href="<?= $this->url->get('users_application_module/strings/' . $Module_ID) ?>">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>img/sections/lang.png') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4><?= $translate->_('Languages') ?></h4>
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
<div class="col-xs-12">
                <a href="<?= $this->url->get('users_application_module/edit/') . $Module_ID ?>" data-toggle="modal" style="display:inline-block;" class="btn  green-jungle btn-sm gap">
                                   <?= $translate->_('Edit Module') ?>                </a>
            </div>