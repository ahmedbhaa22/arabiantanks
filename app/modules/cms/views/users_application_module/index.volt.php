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
        <div class="text-center banner" style=" background: url('<?= $this->url_shared->get('uploads/modules_pics/') . $application_settings->App_Banner ?>')  center no-repeat ; background-size: contain;">
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
                <?php foreach ($modules_array as $module) { ?>
                    <?php if($module['mod_id']==20197){continue;} ?>
                    <?php if($module['mod_id']==20198){
                    		if($this->session->get('auth-identity')['is_admin']==0){
                    			continue;
                    		}
                    	
					} ?>
                <div class="swiper-slide swiper-slide" style="width: 227.8px; margin-left: 10px;">
                    <a class="imgandtext" href="<?= $this->url->get('content/main/') . $module['mod_id'] ?>">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>uploads/modules_pics/<?= $module['mod_img'] ?>') center center no-repeat ; background-size: cover; "></div>
                        </div>
                        <h4> <?= $module['mod_title'] ?></h4>
                    </a>

                    <div class="button-over-block-2">
                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-angle-down"></i>
                        </a>
                        <ul class="dropdown-menu" role="menu">
                                                        <!-- <li>
                                                            <a href="<?= $this->url->get('users_application_module/settings/') . $module->ID ?>"> <?php echo $translate->_("Edit"); ?> </a>
                                                        </li> -->
                           
                            <li>
                                <a href="<?= $this->url->get('content/statistics/') . $module['mod_id'] ?>"><?= $translate->_('Statistics') ?></a>
                            </li>
                            <li>
                                <a href="<?= $this->url->get('content/main/') . $module['mod_id'] ?>"><?= $translate->_('Show Module') ?></a>
                            </li>
                            <!-- <li>
                                <a href="<?= $this->url->get('users_application_module/additionalSettings/') . $module->ID ?>"><?= $translate->_('Edit Additional Information') ?></a>
                            </li> -->

                        </ul>
                    </div>
                </div>
                <?php } ?>




            </div>
            <!-- Add Pagination -->
            <!--            <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets"><span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span></div>-->
        </div>
    </div>
</div>
            <div class="clearfix"></div>
            </div>
        </div>
    </div>
