<!DOCTYPE html>
<html lang="en">

<head>
   <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
   <meta name="description" content="Bootstrap Admin App + jQuery">
   <meta name="keywords" content="app, responsive, jquery, bootstrap, dashboard, admin">
   <title>Geography</title>
   <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <!--<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet"  type="text/css"/>-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
    {{style_sheet_link('ropo_app/css/simple-line-icons.min.css')}}
    {{style_sheet_link('ropo_app/css/ltr/bootstrap.min.css')}}
    {{style_sheet_link('ropo_app/css/ltr/bootstrap-switch.min.css')}}
    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    {{style_sheet_link('ropo_app/css/bootstrap-fileinput.css')}}
    {{style_sheet_link('ropo_app/css/datatables/datatables.min.css')}}
    {{style_sheet_link('ropo_app/css/datatables/datatables.bootstrap-rtl.css')}}
    {{style_sheet_link('ropo_app/css/bootstrap-tagsinput.css')}}
    {{style_sheet_link('ropo_app/css/todo-2.min.css')}}

    {{style_sheet_link('ropo_app/css/select2.min.css')}}
    {{style_sheet_link('ropo_app/css/select2-bootstrap.min.css')}}
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN THiE GLOBAL STYLES -->
    {{style_sheet_link('ropo_app/css/ltr/components-md.min.css')}}
    {{style_sheet_link('ropo_app/css/ltr/plugins-md.min.css')}}
    <!-- END THiE GLOBAL STYLES -->

    <!-- BEGIN THiE LAYOUT STYLES -->
    {{style_sheet_link('ropo_app/css/ltr/layout.min.css')}}
    {{style_sheet_link('ropo_app/css/custom-pentavalue.css')}}
    {{style_sheet_link('ropo_app/css/ltr/custom-pentavalue-en.css')}}
    <!-- END THiE LAYOUT STYLES -->

    <!----BEGIN color-- schie------>
    {{style_sheet_link('ropo_app/css/schies/schie_1.css')}}
    <!----END color schie-->

   <link rel="apple-touch-icon" sizes="57x57" href="img/favicon/apple-icon-57x57.png">
   <link rel="apple-touch-icon" sizes="60x60" href="img/favicon/apple-icon-60x60.png">
   <link rel="apple-touch-icon" sizes="72x72" href="img/favicon/apple-icon-72x72.png">
   <link rel="apple-touch-icon" sizes="76x76" href="img/favicon/apple-icon-76x76.png">
   <link rel="apple-touch-icon" sizes="114x114" href="img/favicon/apple-icon-114x114.png">
   <link rel="apple-touch-icon" sizes="120x120" href="img/favicon/apple-icon-120x120.png">
   <link rel="apple-touch-icon" sizes="144x144" href="img/favicon/apple-icon-144x144.png">
   <link rel="apple-touch-icon" sizes="152x152" href="img/favicon/apple-icon-152x152.png">
   <link rel="apple-touch-icon" sizes="180x180" href="img/favicon/apple-icon-180x180.png">
   <link rel="icon" type="image/png" sizes="192x192"  href="/android-icon-192x192.png">
   <link rel="icon" type="image/png" sizes="32x32" href="img/favicon/favicon-32x32.png">
   <link rel="icon" type="image/png" sizes="96x96" href="img/favicon/favicon-96x96.png">
   <link rel="icon" type="image/png" sizes="16x16" href="img/favicon/favicon-16x16.png">
   <link rel="manifest" href="/manifest.json">
   <meta name="msapplication-TileColor" content="#ffffff">
   <meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
   <meta name="thie-color" content="#ffffff">

</head>

<body class="page-header-fixed page-sidebar-closed-hide-logo page-content-white page-md page-sidebar-closed page-container-bg-solid">
      <!-- BEGIN HEADER -->
        <div class="page-header navbar navbar-fixed-top">
            <!-- BEGIN HEADER INNER -->
            <div class="page-header-inner ">
                <!-- BEGIN LOGO -->
                <div class="page-logo">
                    <a href="index.html">
                        <img src="img/logo.png" alt="logo" height="25" class="logo-default"/>
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
                        <li class="dropdown dropdown-extended dropdown-notification " id="header_notification_bar">
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
                        </li>
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
      

      <!-- Main section-->
      <div class="page-container">
         <!-- BEGIN SIDEBAR -->
            <div class="page-sidebar-wrapper" >
                <!-- BEGIN SIDEBAR -->
                {{menus.getMenu()}}
                <!-- END SIDEBAR -->
            </div>
            <!-- END SIDEBAR -->
         <!-- Page content-->
         <div class="page-content-wrapper">
            <div class="page-content">
                {{ content() }}
            </div>
         </div>
      </div>
      <!-- BEGIN FOOTER -->
        <div class="page-footer text-center">
            <div class="page-footer-inner text-center"> 2017 &copy; Robo App
                <img src="img/logo_small.png " width="40">
                <a href="" title="Pentavalue" target="_blank">pentavalue</a>
            </div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div>
        <!-- END FOOTER -->



   <!-- BEGIN CORE PLUGINS -->
{{javascript_include('ropo_app/js/jquery.min.js')}}
{{javascript_include('ropo_app/js/bootstrap.min.js')}}
{{javascript_include('ropo_app/js/js.cookie.min.js')}}
{{javascript_include('ropo_app/js/bootstrap-hover-dropdown.min.js')}}
{{javascript_include('ropo_app/js/jquery.slimscroll.min.js')}}
{{javascript_include('ropo_app/js/jquery.blockui.min.js')}}
{{javascript_include('ropo_app/js/bootstrap-switch.min.js')}}
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->

{{javascript_include('ropo_app/js/bootstrap-fileinput.js')}}
{{javascript_include('ropo_app/js/jquery.sparkline.min.js')}}
{{javascript_include('ropo_app/js/datatable.js')}}
{{javascript_include('ropo_app/js/datatables/datatables.min.js')}}
{{javascript_include('ropo_app/js/datatables/datatables.bootstrap.js')}}

{{javascript_include('ropo_app/js/swiper.min.js')}}
{{javascript_include('ropo_app/js/bootbox.min.js')}}
{{javascript_include('ropo_app/js/auto_complete.js')}}
<!-- END PAGE LEVEL PLUGINS -->


<!-- BEGIN THiE LAYOUT SCRIPTS -->
{{javascript_include('ropo_app/js/custom-pentavalue.js')}}
<!-- END THiE LAYOUT SCRIPTS -->

</body>

</html>