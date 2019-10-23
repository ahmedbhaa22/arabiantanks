<!DOCTYPE html>
<!--------------------------------------------*
*-------------Company: PentaValue-------------*
*-----------Template Name: Metronic-----------*
*----------Designer : George Samuel-----------*
*----Devlopers : Ahmed Farag , Salma Omar-----*
-->

<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]>&lt;!&ndash;>
<html lang="en" dir="rtl" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title>Poll System</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>

    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <!--<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet"  type="text/css"/>-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
    <?= $this->tag->styleSheetLink('polls/css/simple-line-icons.min.css') ?>
    <?= $this->tag->styleSheetLink('polls/css/bootstrap-rtl.min.css') ?>
    <?= $this->tag->styleSheetLink('polls/css/bootstrap-switch-rtl.min.css') ?>
    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <?= $this->tag->styleSheetLink('polls/css/bootstrap-fileinput.css') ?>
    <?= $this->tag->styleSheetLink('polls/css/datatables/datatables.min.css') ?>
    <?= $this->tag->styleSheetLink('polls/css/datatables/datatables.bootstrap-rtl.css') ?>
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN THEME GLOBAL STYLES -->
    <?= $this->tag->styleSheetLink('polls/css/components-md-rtl.min.css') ?>
    <?= $this->tag->styleSheetLink('polls/css/plugins-md-rtl.min.css') ?>
    <!-- END THEME GLOBAL STYLES -->

    <!-- BEGIN THEME LAYOUT STYLES -->
    <?= $this->tag->styleSheetLink('polls/css/layout-rtl.min.css') ?>
    <?= $this->tag->styleSheetLink('polls/css/custom-pentavalue.css') ?>
    <!-- END THEME LAYOUT STYLES -->

    <!----BEGIN color-- scheme------>
    <?= $this->tag->styleSheetLink('polls/css/schemes/scheme_1.css') ?>
    <!----END color scheme-->
    <?= $this->tag->javascriptInclude('polls/js/jquery.min.js') ?>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.6/handlebars.min.js"></script>
    <link rel="shortcut icon" href="img/favicon.png"/>
</head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-md page-sidebar-closed page-container-bg-solid">
        <!-- BEGIN HEADER -->
        <div class="page-header navbar navbar-fixed-top">
            <!-- BEGIN HEADER INNER -->
            <div class="page-header-inner ">
                <!-- BEGIN LOGO -->
                <div class="page-logo">
                    <a href="<?= $this->url->get('index') ?>">
                        <img src="<?= $this->url->getStatic('polls/img/logo.png') ?>" alt="logo" height="25" class="logo-default"/>
                    </a>

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
                        <!-- BEGIN NOTIFICATION DROPDOWN -->
                        <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                        <!-- <li class="dropdown dropdown-extended dropdown-notification " id="header_notification_bar">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
                                <i class="icon-bell"></i>
                                <span class="badge badge-default"> 2 </span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="external">
                                    <h3>
                                        <span class="bold">5 إشعار قيد الانتظار</span> الإشعارات </h3>
                                    <a href="_notification.html"> عرض الكل</a>
                                </li>
                                <li>
                                    <ul class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="#637283">
                                        <li>
                                            <a href="javascript:;">
                                                <span class="time">الآن </span>
                                                <span class="details">
                                                <span class="label label-sm label-icon label-success">
                                                    <i class="fa fa-money "></i>
                                                </span> يتوجب عليك تجديد الاشتراك</span>
                                            </a>
                                        </li>

                                    </ul>
                                </li>
                            </ul>
                        </li> -->
                        <!-- END NOTIFICATION DROPDOWN -->


                        <!-- BEGIN USER LOGIN DROPDOWN -->
                        <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                        <li class="dropdown dropdown-user">
                            <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                               data-close-others="true">
                                <img alt="" class="img-circle" src="img/default-avatar.jpg"/>
                                <span class="username username-hide-on-mobile"> مرحباً : أدمن </span>
                                <i class="fa fa-angle-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-default">
                                <li>
                                    <a href="_profile.html">
                                        <i class="icon-user"></i> صفحتى الشخصية </a>
                                </li>

                                <li class="divider"></li>

                                <li>
                                    <a href="login.html">
                                        <i class="icon-key"></i> تسجيل الخروج </a>
                                </li>
                            </ul>
                        </li>
                        <!-- END USER LOGIN DROPDOWN -->
                        <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                        <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->

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
            <div class="page-sidebar-wrapper" >
                
                <?= $this->menus->getMenu() ?>
                
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    
                    <?= $this->getContent() ?>

                </div>
                <!-- END CONTENT BODY -->
            </div>
            <!-- END CONTENT -->
            <!-- BEGIN QUICK SIDEBAR -->


            <!-- END QUICK SIDEBAR -->
        </div>



        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="page-footer text-center">
            <div class="page-footer-inner text-center"> 2016 &copy; Real Estate System by
                <img src="img/logo_small.png " width="40">
                <a href="" title="Pentavalue" target="_blank">pentavalue</a>
            </div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div>
        <!-- END FOOTER -->
        <!--[if lt IE 9]>
        <script src="js/respond.min.js"></script>
        <script src="js/excanvas.min.js"></script>
        <![endif]-->
<!-- BEGIN CORE PLUGINS -->

<?= $this->tag->javascriptInclude('polls/js/bootstrap.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/js.cookie.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/bootstrap-hover-dropdown.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/jquery.slimscroll.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/jquery.blockui.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/bootstrap-switch.min.js') ?>
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->

<?= $this->tag->javascriptInclude('polls/js/bootstrap-fileinput.js') ?>
<?= $this->tag->javascriptInclude('polls/js/jquery.sparkline.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/datatable.js') ?>
<?= $this->tag->javascriptInclude('polls/js/datatables/datatables.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/datatables/datatables.bootstrap.js') ?>

<?= $this->tag->javascriptInclude('polls/js/swiper.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/bootbox.min.js') ?>
<?= $this->tag->javascriptInclude('polls/js/auto_complete.js') ?>
<!-- END PAGE LEVEL PLUGINS -->

<!-- form Creator - -->
<!-- End form creator -->


<!-- BEGIN THEME LAYOUT SCRIPTS -->
<?= $this->tag->javascriptInclude('polls/js/custom-pentavalue.js') ?>
<!-- END THEME LAYOUT SCRIPTS -->
</body>

</html>
