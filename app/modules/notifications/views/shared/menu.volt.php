<div class="page-sidebar-wrapper" >
                <!-- BEGIN SIDEBAR -->
                <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
                <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
                <div class="page-sidebar navbar-collapse collapse">
                    <!-- BEGIN SIDEBAR MENU -->

                    <ul class="page-sidebar-menu  page-header-fixed page-sidebar-menu-closed " data-keep-expanded="false"
                        data-auto-scroll="true" data-slide-speed="200" style="padding-top: 20px  ; ">
                        <!-- DOC: To remove the sidebar toggler from the sidebar you just need to completely remove the below "sidebar-toggler-wrapper" LI element -->
                        <li class="sidebar-toggler-wrapper hide">
                            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
                            <div class="sidebar-toggler">
                                <span></span>
                            </div>
                            <!-- END SIDEBAR TOGGLER BUTTON -->
                        </li>
                        <!-- DOC: To remove the search box from the sidebar you just need to completely remove the below "sidebar-search-wrapper" LI element -->
                        <li class="sidebar-search-wrapper">
                            <!-- BEGIN RESPONSIVE QUICK SEARCH FORM -->
                            <!-- DOC: Apply "sidebar-search-bordered" class the below search form to have bordered search box -->
                            <!-- DOC: Apply "sidebar-search-bordered sidebar-search-solid" class the below search form to have bordered & solid search box -->
<!--                            <form class="sidebar-search  " action="#" method="POST">-->
<!--                                <a href="javascript:;" class="remove">-->
<!--                                    <i class="icon-close"></i>-->
<!--                                </a>-->
<!---->
<!--                                <div class="input-group">-->
<!--                                    <input type="text" class="form-control" placeholder="البحث..">-->
<!--                                    <span class="input-group-btn">-->
<!--                                        <a href="javascript:;" class="btn submit">-->
<!--                                            <i class="icon-magnifier"></i>-->
<!--                                        </a>-->
<!--                                    </span>-->
<!--                                </div>-->
<!--                            </form>-->
                            <!-- END RESPONSIVE QUICK SEARCH FORM -->
                        </li>
<?php foreach ($result as $i => $r) { ?>
                        <?php $active = ''; ?>
                        <?php if (($this->router->getControllerName() == 'content' && $r['id'] == 1)) { ?>
                        <?php $active = 'active'; ?>
                        <?php } elseif (($this->router->getControllerName() == 'content' && $r['id'] == 10)) { ?>
                        <?php $active = ''; ?>
                        <?php } elseif (($this->router->getControllerName() == 'notifications' && $r['id'] == 4)) { ?>
                        <?php $active = 'active'; ?>
                        <?php } elseif (($this->router->getControllerName() == 'users_application_statistics' && $r['id'] == 5)) { ?>
                        <?php $active = 'active'; ?>
                        <?php } elseif (($this->router->getControllerName() == 'ads' && $r['id'] == 6)) { ?>
                        <?php $active = 'active'; ?>
                        <?php } elseif (($this->router->getControllerName() == 'users_application_module' && $r['id'] == 7)) { ?>
                        <?php $active = 'active'; ?>
                        <?php } elseif (($this->router->getControllerName() == 'mobile_users' && $r['id'] == 8)) { ?>
                        <?php $active = 'active'; ?>
                        <?php } elseif (($this->router->getControllerName() == 'data_forms' && $r['id'] == 11)) { ?>
                        <?php $active = 'active'; ?>
                        <?php } ?>
<li class=" start <?= $active ?>">
                            <a href="<?= $this->url_shared->get('') ?><?= $r['href'] ?>" class="nav-link ">
                                <i class="<?= $r['icon'] ?>"></i>
                                <span class="title"> <?= $r['name'] ?></span>
                                <span class="selected"></span>
                            </a>
                        </li>
<?php } ?>

</ul>
                    <!-- END SIDEBAR MENU -->
                </div>
                <!-- END SIDEBAR -->
            </div>