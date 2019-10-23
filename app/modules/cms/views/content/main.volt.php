<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
                    <li>
                        <a href="<?= $this->url->get('users_application_module') ?>"><?php echo $translate->_("Main Page"); ?></a>
                        <i class="icon-arrow-left"></i>
                    </li>
                    <li>
                        <a href=""><?php echo $module['mod_title']; ?></a>
                        
                    </li>
                    
                </ul>
</div>
<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url('<?= $this->url_shared->get('uploads/modules_pics/') . $module_setting->Module_Banner ?>')  center no-repeat ; background-size: contain;">
        </div>
    </div>
</div>
<div class="portlet light bordered">



    <div class="clearfix"></div>
    <div class="portlet-title">
    	<div class="caption font-dark">
                                <i class="icon-settings font-dark"></i>
                                <span class="caption-subject bold uppercase"><?= $module['mod_title'] ?></span>
                            </div>
    <div class="actions">
    	<?php if (($content_settings->Import) == 1) { ?>
        <a type="button" href="<?= $this->url->get('import_data/index/') . $Module_ID ?>" data-toggle="modal"
           class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
            <?php echo $translate->_("Import Data"); ?>
        </a>
        <?php } ?>

    </div>
        <div class="actions">

        </div>
        </div>


<div class="clearfix"></div>
    <div class="portlet-body">
        <div id="sample_1_wrapper">
<div class="col-xs-12 row">
    <p><?php $this->flashSession->output() ?></p>
    <div class="slider-one-row">
        <div class="swiper-container swiper-container-horizontal swiper-container-rtl">
            <div class="swiper-wrapper" style="transition-duration: 0ms; transform: translate3d(0px, 0px, 0px);">
                <!---slide---->
                <?php if (($this->session->get('auth-identity')['is_admin'] == 1)) { ?>
                <?php foreach ($departments as $dept) { ?>
                <div class="swiper-slide swiper-slide" style="width: 227.8px; margin-left: 10px;">
                    <a class="imgandtext" href="<?= $this->url->get('departments/index/') . $dept['ID'] ?>&Module_ID=<?php echo $Module_ID ?>">
                        <div class="img-section-container">
                            <div class="img-section"
                                 style="background: url('<?= $this->url_shared->get() ?>uploads/<?= $dept->Img ?>') center center no-repeat ; background-size: cover; ">
                                <img src="<?= $this->url_shared->get('uploads/') . $dept['Img'] ?>"/></div>
                        </div>
                        <h4> <?= $dept['Title'] ?></h4>
                    </a>

                    <div class="button-over-block-2">
<!--                        <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown" aria-expanded="false">-->
<!--                        <i class="fa fa-angle-down"></i>-->
<!--                        </a>-->
                        <ul class="dropdown-menu" role="menu">
<!--                            <li>-->
<!--                                <a href="_building_details.html"> عرض </a>-->
<!--                            </li>-->
                            <li>
<!--                                <a href="<?= $this->url->get('main_departments/edit/') . $dept->ID ?>&Module_ID=--><?php //echo $Module_ID ?><!--"> تعديل بيانات القسم</a>-->
                            </li>
                            <li>
<!--                                <a class="" href="<?= $this->url->get('main_departments/delete/') . $dept->ID ?>"  onclick="return confirm('هل أنت متأكد من حذف هذا القسم الرئيسي ؟');"> حذف القسم-->
<!--                                    بالكامل </a>-->
                            </li>

                        </ul>
                    </div>
                </div>
                <?php } ?>
                <?php } ?>
                <div class="swiper-slide swiper-slide" style="width: 227.8px; margin-left: 10px;">
                    <a class="imgandtext" href="<?= $this->url->get('content/index/') . $Module_ID ?>">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>uploads/modules_pics/<?= $module_setting->Content_Img ?>') center center no-repeat ; background-size: cover; "> </div>
                        </div>
                        <h4> <?php echo $trans_Content; ?></h4>
                    </a>

                    <div class="button-over-block-2">


                    </div>
                </div>

                <!-- <div class="swiper-slide swiper-slide" style="width: 227.8px; margin-left: 10px;">
                    <a class="imgandtext" href="<?= $this->url->get('content/statistics/') . $Module_ID ?>">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('<?= $this->url_shared->get() ?>uploads/modules_pics/<?= $module_setting->Content_Stat_Img ?>') center center no-repeat ; background-size: cover; "> </div>
                        </div>
                        <h4><?php echo $trans_Content_Stat; ?></h4>
                    </a>

                    <div class="button-over-block-2">


                    </div>
                </div> -->
                <?php if ($module_setting->Has_Orders == 1) { ?>
                <div class="swiper-slide swiper-slide" style="width: 227.8px; margin-left: 10px;">
                    <a class="imgandtext" href="<?= $this->url->get('orders/index/') . $Module_ID ?>">
                        <div class="img-section-container">
                            <div class="img-section" style="background: url('img/15-devision.png') center center no-repeat ; background-size: cover; "><img src="<?= $this->url_shared->get('uploads/') . $dept->Img ?>" /> </div>
                        </div>
                        <h4><?php echo $translate->_("Orders"); ?></h4>
                    </a>

                    <div class="button-over-block-2">


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


<div id= "myModal"class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <?= $this->tag->javascriptInclude('ropo_app/js/jquery.min.js') ?>
    <?= $this->tag->javascriptInclude('js/custom_cms.js') ?>
<div class="modal-dialog ">
    <div class="modal-content">
        <div class="modal-header hidden-xs">
            <div class="   col-xs-12 ">
                <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/new-clients.png') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>

        <div class="portlet-body">
            <div id="sample_1_wrapper">


                <?php
                echo $this->tag->form(
                    [
                        "main_departments/create",
                        "autocomplete" => "off",
                        "class" => "form-horizontal paymentForm",
                        "role" => "form",
                        "style" => "display:block",
                        "enctype" => "multipart/form-data",
                        "id" => "form-new-maindept"
                    ]
                );
                ?>

                <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
                    <div class="col-md-6 col-xs-12"> <!--col right-->
                        <div class="col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-2">العنوان</label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-2">الوصف</label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField(["Des", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                                </div>
                            </div>
                        </div>





                    </div><!--end col right-->

                    <div class="col-md-6 col-xs-12"> <!--col left-->

                        <div class="col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="fieldImg" class="col-sm-2">الصوره</label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImgDept"]) ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fieldImg" class="col-sm-2">تارجت أكشن</label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField("Target_Action_ID"); ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="fieldImg" class="col-sm-2">تارجت لاي أوت</label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField("Target_Layout_ID"); ?>
                                </div>
                            </div>
                        </div>


                    </div><!--end col left-->
                </div>


                <?php
                echo $this->tag->hiddenField("ID");
                echo $this->tag->hiddenField(["Module_ID"," value" => $Module_ID]);


                ?>

                <div class="form-group">
                    <div class="col-sm-12 text-center">
                        <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-default"]) ?>
                        <input type="submit" data-dismiss="modal" class="btn dark " value="إلغاء">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-12 text-center">

                    </div>
                </div>


                <?php echo $this->tag->endForm(); ?>
            </div>
        </div>


    </div>
</div>
</div>
    </div>