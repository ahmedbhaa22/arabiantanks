<!-- BEGIN HEAD -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Tanks | Dashboard</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>

    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <?= $this->tag->stylesheetLink('ropo_app/lib/font-awesome-4.7.0/css/font-awesome.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/simple-line-icons.min.css') ?>

    <?= $this->tag->stylesheetLink('ropo_app/css/custom-pentavalue.css') ?>

    <!-- Add Language Check for LTR AND RTL -->
    <!-- Check Language is not Arabic -->
    <?php if (($this->session->get('auth-identity')['Lang'] !== 'ar')) { ?>

    <?= $this->tag->stylesheetLink('ropo_app/css/ltr/bootstrap.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/ltr/bootstrap-switch.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/ltr/components-md.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/ltr/layout.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/ltr/plugins-md.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/ltr/custom-pentavalue-en.css') ?>

    <!-- else for the ar language -->
    <?php } else { ?>

    <?= $this->tag->stylesheetLink('ropo_app/css/bootstrap-rtl.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/bootstrap-switch-rtl.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/components-md-rtl.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/layout-rtl.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/plugins-md-rtl.min.css') ?>
    <?php } ?>
    <!-- END Language Check for LTR AND RTL -->


    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <?= $this->tag->stylesheetLink('ropo_app/css/bootstrap-fileinput.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/daterangepicker.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/bootstrap-datepicker.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/jquery.datetimepicker.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/fullcalendar/fullcalendar.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/swiper.min.css') ?>
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN THEME GLOBAL STYLES -->


    <!-- END THEME GLOBAL STYLES -->

    <!-- BEGIN THEME LAYOUT STYLES -->


    <!-- END THEME LAYOUT STYLES -->

    <!----BEGIN color-- scheme------>
    <?php
    $scheme_file = $this->session->get('auth-identity')['Scheme'].".css";
    ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/schemes/' . $scheme_file) ?>



    <!----END color-- scheme------->
    <?= $this->tag->stylesheetLink('css/jquery-filer/jquery.filer.css') ?>
    <?= $this->tag->stylesheetLink('css/jquery-filer/themes/jquery.filer-dragdropbox-theme.css') ?>

    <?= $this->tag->stylesheetLink('css/custom-css.css') ?>
    <?= $this->tag->javascriptInclude('ropo_app/js/jquery.min.js') ?>
    <script>
        <?php  ?>
        var main_url = "<?php echo $this->config->application->baseUri; ?>";
    </script>

    <!------favicon---------->
    <link rel="apple-touch-icon" sizes="57x57" href="<?php echo $this->url_shared->get('/img/favicon/apple-touch-icon-57x57.png')?>">
    <link rel="apple-touch-icon" sizes="60x60" href="<?php echo $this->url_shared->get('img/favicon/apple-touch-icon-60x60.png')?>">
    <link rel="apple-touch-icon" sizes="72x72" href="<?php echo $this->url_shared->get('img/favicon/apple-touch-icon-72x72.png')?>">
    <link rel="apple-touch-icon" sizes="76x76" href="<?php echo $this->url_shared->get('img/favicon/apple-touch-icon-76x76.png')?>">
    <link rel="apple-touch-icon" sizes="114x114" href="<?php echo $this->url_shared->get('img/favicon/apple-touch-icon-114x114.png')?>">
    <link rel="apple-touch-icon" sizes="120x120" href="<?php echo $this->url_shared->get('img/favicon/apple-touch-icon-120x120.png')?>">
    <link rel="apple-touch-icon" sizes="144x144" href="<?php echo $this->url_shared->get('img/favicon/apple-touch-icon-144x144.png')?>">
    <link rel="apple-touch-icon" sizes="152x152" href="<?php echo $this->url_shared->get('img/favicon/apple-touch-icon-152x152.png')?>">
    <link rel="apple-touch-icon" sizes="180x180" href="<?php echo $this->url_shared->get('img/favicon/apple-touch-icon-180x180.png')?>">
    <link rel="icon" type="image/png" href="<?php echo $this->url_shared->get('img/favicon/favicon-32x32.png')?>" sizes="32x32">
    <link rel="icon" type="image/png" href="<?php echo $this->url_shared->get('img/favicon/android-chrome-192x192.png')?>" sizes="192x192">
    <link rel="icon" type="image/png" href="<?php echo $this->url_shared->get('img/favicon/favicon-96x96.png')?>" sizes="96x96">
    <link rel="icon" type="image/png" href="<?php echo $this->url_shared->get('img/favicon/favicon-16x16.png')?>" sizes="16x16">
    <link rel="manifest" href="<?php echo $this->url_shared->get('img/favicon/manifest.json')?>">
    <link rel="mask-icon" href="<?php echo $this->url_shared->get('img/favicon/safari-pinned-tab.svg')?>" color="#673ab7">
    <link rel="shortcut icon" href="<?php echo $this->url_shared->get('img/favicon/favicon.ico')?>">

    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.4/css/selectize.default.min.css">
    <!--    <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">-->

    <script type="text/javascript" src="<?php echo $this->url_shared->get("ropo_app/js/bower_components/moment/min/moment.min.js")?>"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.7.1/js/bootstrap-datepicker.min.js"></script>


    <script type="text/javascript">
        $(function () {
            $('#datetimepicker3').datetimepicker({
                format: 'LT'
            });
            $('#datetimepicker4').datetimepicker({
                format: 'LT'
            });
        });
    </script>

    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-TileImage" content="img/favicon/mstile-144x144.png">
    <meta name="msapplication-config" content="img/favicon/browserconfig.xml">
    <meta name="theme-color" content="#673ab7">
</head>
<!-- END HEAD -->

<body
    class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-md page-sidebar-closed page-container-bg-solid">
<!-- BEGIN HEADER -->
<div class="page-header navbar navbar-fixed-top">
    <!-- BEGIN HEADER INNER -->
    <div class="page-header-inner ">
        <!-- BEGIN LOGO -->
        <div class="page-logo">
<!--            <a href="index.php">-->
<!--                <img src="img/logo.png" alt="logo" height="25" class="logo-default"/>-->
<!--            </a>-->

            <div class="menu-toggler sidebar-toggler">
                <span></span>
            </div>
        </div>
        <!-- END LOGO -->

        <!-- BEGIN RESPONSIVE MENU TOGGLER -->
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse"
           data-target=".navbar-collapse">
            <span></span>
        </a>
        <!-- END RESPONSIVE MENU TOGGLER -->

        <!-- BEGIN TOP NAVIGATION MENU -->
        <div class="top-menu">
            <ul class="nav navbar-nav pull-right">
<!--                <li class="dropdown dropdown-extended dropdown-notification " id="header_notification_bar">-->
<!--                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"-->
<!--                       data-close-others="true">-->
<!--                        <i class="icon-bell"></i>-->
<!--                        <span class="badge badge-default"><?= $not_unread_count ?></span>-->
<!--                    </a>-->
<!--                    <ul class="dropdown-menu">-->
<!--                        <li class="external">-->
<!--                            <h3>-->
<!--                                <span class="bold"><?= $translate->_('You Have') ?> <?= $not_unread_count ?> <?= $translate->_('Pending Notifications') ?></span></h3>-->
<!--                            <a href="<?= $this->url_shared->get('cms_module/system_notifications/index') ?>"><?= $translate->_('Show All') ?></a>-->
<!--                        </li>-->
<!--                        <li>-->
<!--                            <ul class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">-->
<!--                                <?php $v5795283181iterator = $not_unread; $v5795283181incr = 0; $v5795283181loop = new stdClass(); $v5795283181loop->self = &$v5795283181loop; $v5795283181loop->length = count($v5795283181iterator); $v5795283181loop->index = 1; $v5795283181loop->index0 = 1; $v5795283181loop->revindex = $v5795283181loop->length; $v5795283181loop->revindex0 = $v5795283181loop->length - 1; ?><?php foreach ($v5795283181iterator as $item_not) { ?><?php $v5795283181loop->first = ($v5795283181incr == 0); $v5795283181loop->index = $v5795283181incr + 1; $v5795283181loop->index0 = $v5795283181incr; $v5795283181loop->revindex = $v5795283181loop->length - $v5795283181incr; $v5795283181loop->revindex0 = $v5795283181loop->length - ($v5795283181incr + 1); $v5795283181loop->last = ($v5795283181incr == ($v5795283181loop->length - 1)); ?>-->
<!--                                <li>-->
<!--                                    <a href="javascript:;">-->
<!--                                        <span class="time">--><?php //echo date('Y-m-d G:i:s', $item_not->time) ?><!--</span>-->
<!--                                        <span class="details">-->
<!--                                                    <span class="label label-sm label-icon label-success">-->
<!--                                                        <i class="fa fa-money "></i>-->
<!--                                                    </span><?= $item_not->content ?></span>-->
<!--                                    </a>-->
<!--                                </li>-->
<!--                                <?php if (($v5795283181loop->index == 5)) { ?>-->
<!--                                <?php break; ?>-->
<!--                                <?php } ?>-->
<!--                                <?php $v5795283181incr++; } ?>-->
<!---->
<!--                            </ul>-->
<!--                        </li>-->
<!--                    </ul>-->
<!--                </li>-->
                <li class="dropdown dropdown-user">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                       data-close-others="true">
                        <i class="fa fa-key fa-2x" aria-hidden="true"></i>
                        <span
                            class="username username-hide-on-mobile"> <?php echo $translate->_("Control Panel"); ?> </span>


                    </a>
                    <ul class="dropdown-menu dropdown-menu-default">
                        <?php if (($this->router->getModuleName() == 'cms')) { ?>

                        <li>
                            <a href="<?= $this->url->get('cp_users/profile') ?>">
                                <i class="icon-user"></i><?= $translate->_('My Profile') ?></a>
                        </li>

                        <!-- <li>
                            <a href="<?php echo $this->url_shared->get('cms_module/cp_users/index') ?>">
                                <i class="icon-user"></i><?php echo $translate->_("Control Panel Users"); ?></a>
                        </li> -->

                        <li>
                            <a href="<?= $this->url->get('cp_users/usersList') ?>">
                                <i class="icon-user"></i><?php echo $translate->_("Company Employees"); ?></a>
                        </li>


                        <li class="divider"></li>
                        <?php if ($this->session->get('auth-identity')['Application_ID'] != 593): ?>
                            <li>
                                <a href="<?php echo $this->url_shared->get(('cms_module/log/index')) ?>">
                                    <i class="icon-key"></i> <?php echo $translate->_("Logs"); ?> </a>
                            </li>
                        <?php endif ?>
                        <?php } ?>
                        <li>
                            <a href="<?php echo $this->url_shared->get('cms_module/control_panel/index') ?>">
                                <i class="icon-user"></i><?php echo $translate->_("Control Panel"); ?></a>
                        </li>
                        <?php if (($this->router->getModuleName() == 'control')) { ?>
                        <li>
                            <a href="<?php echo $this->url->get('permissions/index')?>">
                                <i class="icon-key"></i> <?php echo $translate->_("System Permissions"); ?></a>
                        </li>


                        <li>
                            <a href="<?php echo $this->url->get('menus')?>">
                                <i class="icon-key"></i> <?php echo $translate->_("Menu"); ?> </a>
                        </li>
                        <li>
                            <a href="<?php echo $this->url->get('users_application_module')?>">
                                <i class="icon-key"></i> <?php echo $translate->_("Modules"); ?></a>

                        </li>
                        <li>
                            <a href="<?php echo $this->url->get('application_localization')?>">
                                <i class="icon-key"></i> <?php echo $translate->_("Content Localization"); ?></a>

                        </li>
                        <?php } ?>


                    </ul>
                </li>


                <!-- BEGIN NOTIFICATION DROPDOWN -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                <!--                        <li class="dropdown dropdown-extended dropdown-notification " id="header_notification_bar">-->
                <!--                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">-->
                <!--                                <i class="icon-bell"></i>-->
                <!--                                <span class="badge badge-default"> 2 </span>-->
                <!--                            </a>-->
                <!--                            <ul class="dropdown-menu">-->
                <!--                                <li class="external">-->
                <!--                                    <h3>-->
                <!--                                        <span class="bold">5 إشعار قيد الانتظار</span> الإشعارات </h3>-->
                <!--                                    <a href="_notification.html"> عرض الكل</a>-->
                <!--                                </li>-->
                <!--                                <li>-->
                <!--                                    <ul class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">-->
                <!--                                        <li>-->
                <!--                                            <a href="javascript:;">-->
                <!--                                                <span class="time">الآن </span>-->
                <!--                                                <span class="details">-->
                <!--                                                <span class="label label-sm label-icon label-success">-->
                <!--                                                    <i class="fa fa-money "></i>-->
                <!--                                                </span> يتوجب عليك تجديد الاشتراك</span>-->
                <!--                                            </a>-->
                <!--                                        </li>-->
                <!---->
                <!--                                    </ul>-->
                <!--                                </li>-->
                <!--                            </ul>-->
                <!--                        </li>-->
                <!-- END NOTIFICATION DROPDOWN -->


                <!-- BEGIN USER LOGIN DROPDOWN -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->

                <li class="dropdown dropdown-user">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                       data-close-others="true">
                        <i class="fa fa-user-circle fa-2x" aria-hidden="true"></i>

                        <span class="username username-hide-on-mobile"> <?php echo $translate->_("Hello"); ?>
                            : Admin </span>
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-default">
                        <!--                                <li>-->
                        <!--                                    <a href="#">-->
                        <!--                                        <i class="icon-user"></i> صفحتى الشخصية </a>-->
                        <!--                                </li>-->

                        <li class="divider"></li>

                        <li>
                            <a href="<?= $this->url_shared->get('session/logout') ?>">
                                <i class="icon-key"></i> <?php echo $translate->_("Logout"); ?> </a>
                        </li>
                    </ul>
                </li>
                <!-- END USER LOGIN DROPDOWN -->
                <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->

<!--                --><?php //if($this->session->get('auth-identity')['Lang']=="en"): ?>
<!--                    <li class="dropdown dropdown-user">-->
<!--                        <a href="<?= $this->url_shared->get('cp_users/lang') ?>?lang=ar" class="dropdown-toggle">-->
<!--                            <i class="icon-flag"></i>-->
<!--                            <span class="username username-hide-on-mobile">العربية</span>-->
<!--                        </a>-->
<!--                    </li>-->
<!--                --><?php //endif; ?>
<!--                --><?php //if($this->session->get('auth-identity')['Lang']=="ar"): ?>
<!--                    <li class="dropdown dropdown-user">-->
<!--                        <a href="<?= $this->url_shared->get('cp_users/lang') ?>?lang=en" class="dropdown-toggle">-->
<!--                            <i class="icon-flag"></i>-->
<!--                            <span class="username username-hide-on-mobile">English</span>-->
<!--                        </a>-->
<!--                    </li>-->
<!--                --><?php //endif; ?>


                <!-- END QUICK SIDEBAR TOGGLER -->
            </ul>
        </div>
        <!-- END TOP NAVIGATION MENU -->
    </div>
    <!-- END HEADER INNER -->
</div>
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"></div>
<!-- END HEADER & CONTENT DIVIDER -->
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN SIDEBAR -->
    <div class="page-sidebar-wrapper">
        <?= $this->menus->getMenu() ?>

        <!-- BEGIN SIDEBAR -->
        <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
        <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->

        <!-- END SIDEBAR -->
    </div>
    <!-- END SIDEBAR -->
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">


                    <?= $this->getContent() ?>
                    <p><?php echo $this->flashSession->output() ?></p>


        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
    <!-- BEGIN QUICK SIDEBAR -->


    <!-- END QUICK SIDEBAR -->
</div>


<!-- Modal _ new Data -->

<!---- end modal new --->

<!-- END CONTAINER -->
<!-- BEGIN FOOTER -->
<div class="page-footer text-center">
<!--    <div class="page-footer-inner text-center"> 2016 &copy; Robo CMS by-->
<!---->
<!--        <a href="http://www.pentavalue.com" title="Pentavalue" target="_blank">Pentavalue</a>-->
<!--    </div>-->
    <div class="scroll-to-top">
        <i class="icon-arrow-up"></i>
    </div>
</div>
<!-- END FOOTER -->
<!--[if lt IE 9]>
<script src="ropo_app/js/respond.min.js"></script>
<script src="ropo_app/js/excanvas.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script type="text/javascript">
    var base_url = "<?= $this->url->get('') ?>";
</script>

<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/jquery.datetimepicker.full.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap-datepicker.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/js.cookie.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap-hover-dropdown.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/jquery.slimscroll.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/jquery.blockui.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap-switch.min.js') ?>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->

<?= $this->tag->javascriptInclude('ropo_app/js/datatable.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/datatables/datatables.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/datatables/datatables.bootstrap.js') ?>

<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap-fileinput.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/swiper.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/bootbox.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/select2/select2.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/auto_complete.js') ?>
<!-- END PAGE LEVEL PLUGINS -->


<?= $this->tag->javascriptInclude('js/jquery-filer/jquery.filer.min.js') ?>
<?= $this->tag->javascriptInclude('js/bootstrap-toggle.min.js') ?>

<?= $this->tag->javascriptInclude('js/jquery.validate.min.js') ?>
<?= $this->tag->javascriptInclude('js/dynamicvideofields.js') ?>


<!-- Testing Assests Management -->
<?= $this->assets->outputJs() ?>
<!-- -->
<?= $this->tag->javascriptInclude('js/custom_cms.js') ?>

<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.4/js/standalone/selectize.js"></script>

<!-- BEGIN THEME LAYOUT SCRIPTS -->
<?= $this->tag->javascriptInclude('ropo_app/js/custom-pentavalue.js') ?>
<!--<?= $this->tag->javascriptInclude('ropo_app/js/angular/angular.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/notifications.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/ads.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/companies.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/projects.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/places.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/procedures.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/events.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/messages.js') ?>-->
<!--<?= $this->tag->javascriptInclude('ropo_app/js/comments.js') ?>-->
<!-- END THEME LAYOUT SCRIPTS -->

<?= $this->tag->javascriptInclude('js/jquery.autocomplete.js') ?>

<script type="text/javascript" src='http://maps.google.com/maps/api/js?sensor=false&libraries=places'></script>

<?= $this->tag->javascriptInclude('js/locationpicker.jquery.js') ?>
<!---->
<!-- <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> --><script>
    var fast_search_str="<?= $translate->_('Quick Search') ?>";
    var records_str="<?= $translate->_('Records') ?>";
    var got_total_str="<?= $translate->_('Got a total of') ?>";
    var to_show_str="<?= $translate->_('to show') ?>";
    var to_str="<?= $translate->_('to') ?>";
    var operation_str="<?= $translate->_('Operation') ?>";
    var edit_str="<?= $translate->_('Edit') ?>";
    var delete_str="<?= $translate->_('Delete') ?>";

</script>
<script>

</script>


<script type="text/javascript">
    // if ('serviceWorker' in navigator) {
    //   navigator.serviceWorker.register("<?= $this->url->get('service-worker.js') ?>").then(function(reg) {
    //     console.log('Yey!', reg);
    //   }).catch(function(err) {
    //     console.log('Boo!', err);
    //   });
    // }
</script>
<script>

</script>

</body>
</html>