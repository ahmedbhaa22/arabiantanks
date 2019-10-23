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
    <title>Messages</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>

    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <!--<link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet"  type="text/css"/>-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
    {{stylesheet_link('msg/css/simple-line-icons.min.css')}}
    {{stylesheet_link('msg/css/bootstrap-rtl.min.css')}}
    {{stylesheet_link('msg/css/bootstrap-switch-rtl.min.css')}}
    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    {{stylesheet_link('msg/css/bootstrap-fileinput.css')}}
    {{stylesheet_link('msg/css/datatables/datatables.min.css')}}
    {{stylesheet_link('msg/css/datatables/datatables.bootstrap-rtl.css')}}
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN THEME GLOBAL STYLES -->
    {{stylesheet_link('msg/css/components-md-rtl.min.css')}}
    {{stylesheet_link('msg/css/plugins-md-rtl.min.css')}}
    <!-- END THEME GLOBAL STYLES -->

    <!-- BEGIN THEME LAYOUT STYLES -->
    {{stylesheet_link('msg/css/layout-rtl.min.css')}}
    {{stylesheet_link('msg/css/chat.css')}}
    {{stylesheet_link('msg/css/custom-pentavalue.css')}}
    {{stylesheet_link('msg/css/chat.css')}}
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.4/css/selectize.default.min.css">
    <!-- END THEME LAYOUT STYLES -->

    <!----BEGIN color-- scheme------>
    {{stylesheet_link('msg/css/schemes/scheme_1.css')}}
    <!----END color scheme-->

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
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN SIDEBAR -->
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
                        <li class="active">
                            <a href="form-creator.html" class="nav-link ">
                                <i class="fa fa-comments-o" aria-hidden="true"></i>
                                <span class="title">Message System</span>
                                <span class="selected"></span>
                            </a>
                        </li> 

                    </ul>
                    <!-- END SIDEBAR MENU -->
                    <!-- END SIDEBAR MENU -->
                </div>
                <!-- END SIDEBAR -->
            </div>
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            
            {{ content() }}
            <p><?php echo $this->flashSession->output() ?></p>
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
{{javascript_include('msg/js/jquery.min.js')}}
{{javascript_include('msg/js/bootstrap.min.js')}}
{{javascript_include('msg/js/js.cookie.min.js')}}
{{javascript_include('msg/js/bootstrap-hover-dropdown.min.js')}}
{{javascript_include('msg/js/jquery.slimscroll.min.js')}}
{{javascript_include('msg/js/jquery.blockui.min.js')}}
{{javascript_include('msg/js/bootstrap-switch.min.js')}}
<script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.4/js/standalone/selectize.js"></script>
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->

{{javascript_include('msg/js/bootstrap-fileinput.js')}}
{{javascript_include('msg/js/jquery.sparkline.min.js')}}
{{javascript_include('msg/js/datatable.js')}}
{{javascript_include('msg/js/datatables/datatables.min.js')}}
{{javascript_include('msg/js/datatables/datatables.bootstrap.js')}}
{{ javascript_include("ropo_app/js/messages.js") }}

{{javascript_include('msg/js/swiper.min.js')}}
{{javascript_include('msg/js/bootbox.min.js')}}
{{javascript_include('msg/js/auto_complete.js')}}
<!-- END PAGE LEVEL PLUGINS -->


<!-- BEGIN THEME LAYOUT SCRIPTS -->
{{javascript_include('msg/js/custom-pentavalue.js')}}
<!-- END THEME LAYOUT SCRIPTS -->



    </body>

</html>
