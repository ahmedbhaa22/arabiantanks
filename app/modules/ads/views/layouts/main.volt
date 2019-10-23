<!-- BEGIN HEAD -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>ROBO APP | Dashboard</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>

    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    {{stylesheet_link('ropo_app/lib/font-awesome-4.7.0/css/font-awesome.min.css')}}
    {{ stylesheet_link('ropo_app/css/simple-line-icons.min.css') }}

    <!-- Add Language Check for LTR AND RTL -->
    <!-- Check Language is not Arabic -->
    {% if(this.session.get('auth-identity')['Lang']!=='ar') %}

    {{ stylesheet_link('ropo_app/css/ltr/bootstrap.min.css') }}
    {{ stylesheet_link('ropo_app/css/ltr/bootstrap-switch.min.css') }}
    {{ stylesheet_link('ropo_app/css/ltr/components-md.min.css') }}
    {{ stylesheet_link('ropo_app/css/ltr/layout.min.css') }}
    {{ stylesheet_link('ropo_app/css/ltr/plugins-md.min.css') }}
 {{ stylesheet_link('ropo_app/css/ltr/custom-pentavalue-en.css') }}

    <!-- else for the ar language -->
    {% else %}

    {{ stylesheet_link('ropo_app/css/bootstrap-rtl.min.css') }}
    {{ stylesheet_link('ropo_app/css/bootstrap-switch-rtl.min.css') }}
    {{ stylesheet_link('ropo_app/css/components-md-rtl.min.css') }}
    {{ stylesheet_link('ropo_app/css/layout-rtl.min.css') }}
    {{ stylesheet_link('ropo_app/css/plugins-md-rtl.min.css') }}
 {{ stylesheet_link('ropo_app/css/custom-pentavalue.css') }}
    {% endif %}
    <!-- END Language Check for LTR AND RTL -->

    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    {{ stylesheet_link('ropo_app/css/bootstrap-fileinput.css') }}
    {{ stylesheet_link('ropo_app/css/daterangepicker.min.css') }}
    {{ stylesheet_link('ropo_app/css/bootstrap-datepicker.min.css') }}
    {{ stylesheet_link('ropo_app/css/jquery.datetimepicker.css') }}
    {{ stylesheet_link('ropo_app/css/fullcalendar/fullcalendar.min.css') }}
    {{ stylesheet_link('ropo_app/css/swiper.min.css') }}
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN THEME GLOBAL STYLES -->


    <!-- END THEME GLOBAL STYLES -->

    <!-- BEGIN THEME LAYOUT STYLES -->

   
    <!-- END THEME LAYOUT STYLES -->

    <!----BEGIN color-- scheme------>
    <?php
    $scheme_file = $this->session->get('auth-identity')['Scheme'].".css";
   ?>
    {{ stylesheet_link('ropo_app/css/schemes/'~scheme_file)  }}



    <!----END color-- scheme------->
    {{ stylesheet_link("css/jquery-filer/jquery.filer.css") }}
    {{ stylesheet_link("css/jquery-filer/themes/jquery.filer-dragdropbox-theme.css") }}

    {{ stylesheet_link("css/custom-css.css") }}
    {{ javascript_include("ropo_app/js/jquery.min.js") }}
    <script>
        <?php  ?>
        var main_url = "<?php echo $this->config->application->baseUri; ?>";
    </script>

    <!------favicon---------->
    <link rel="apple-touch-icon" sizes="57x57" href="{{url('/img/favicon/apple-touch-icon-57x57.png')}}">
    <link rel="apple-touch-icon" sizes="60x60" href="{{url('img/favicon/apple-touch-icon-60x60.png')}}">
    <link rel="apple-touch-icon" sizes="72x72" href="{{url('img/favicon/apple-touch-icon-72x72.png')}}">
    <link rel="apple-touch-icon" sizes="76x76" href="{{url('img/favicon/apple-touch-icon-76x76.png')}}">
    <link rel="apple-touch-icon" sizes="114x114" href="{{url('img/favicon/apple-touch-icon-114x114.png')}}">
    <link rel="apple-touch-icon" sizes="120x120" href="{{url('img/favicon/apple-touch-icon-120x120.png')}}">
    <link rel="apple-touch-icon" sizes="144x144" href="{{url('img/favicon/apple-touch-icon-144x144.png')}}">
    <link rel="apple-touch-icon" sizes="152x152" href="{{url('img/favicon/apple-touch-icon-152x152.png')}}">
    <link rel="apple-touch-icon" sizes="180x180" href="{{url('img/favicon/apple-touch-icon-180x180.png')}}">
    <link rel="icon" type="image/png" href="{{url('img/favicon/favicon-32x32.png')}}" sizes="32x32">
    <link rel="icon" type="image/png" href="{{url('img/favicon/android-chrome-192x192.png')}}" sizes="192x192">
    <link rel="icon" type="image/png" href="{{url('img/favicon/favicon-96x96.png')}}" sizes="96x96">
    <link rel="icon" type="image/png" href="{{url('img/favicon/favicon-16x16.png')}}" sizes="16x16">
    <link rel="manifest" href="{{url('img/favicon/manifest.json')}}">
    <link rel="mask-icon" href="{{url('img/favicon/safari-pinned-tab.svg')}}" color="#673ab7">
    <link rel="shortcut icon" href="{{url('img/favicon/favicon.ico')}}">
    
    <link rel="stylesheet" type="text/css"
          href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.4/css/selectize.default.min.css">
    <link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <script type="text/javascript" src="{{url()}}ropo_app/js/bower_components/moment/min/moment.min.js"></script>
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
            <a href="index.php">
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

                <li class="dropdown dropdown-user">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                       data-close-others="true">
                        <i class="fa fa-key fa-2x" aria-hidden="true"></i>
                        <span
                            class="username username-hide-on-mobile"> <?php echo $translate->_("Control Panel"); ?> </span>


                    </a>
                    <ul class="dropdown-menu dropdown-menu-default">
                        <li>
                            <a href="{{ url('cp_users/index')}}">
                                <i class="icon-user"></i><?php echo $translate->_("Control Panel Users"); ?></a>
                        </li>

                        <li class="divider"></li>

                        <li>
                            <a href="{{ url('permissions/index')}}">
                                <i class="icon-key"></i> <?php echo $translate->_("System Permissions"); ?></a>
                        </li>

                        <li>
                            <a href="{{ url('log/index')}}">
                                <i class="icon-key"></i> <?php echo $translate->_("Logs"); ?> </a>
                        </li>
                        <li>
                            <a href="{{ url('menus')}}">
                                <i class="icon-key"></i> <?php echo $translate->_("Menu"); ?> </a>
                        </li>
                        <li>
                            <a href="{{ url('users_application_module')}}">
                                <i class="icon-key"></i> <?php echo $translate->_("Modules"); ?> </a>

                        </li>


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
                            <a href="{{ url('session/logout')}}">
                                <i class="icon-key"></i> <?php echo $translate->_("Logout"); ?> </a>
                        </li>
                    </ul>
                </li>
                <!-- END USER LOGIN DROPDOWN -->
                <!-- BEGIN QUICK SIDEBAR TOGGLER -->
                <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->

                <?php if($this->session->get('auth-identity')['Lang']=="en"): ?>
                <li class="dropdown dropdown-user">
                    <a href="{{url('cp_users/lang')}}?lang=ar" class="dropdown-toggle">
                        <i class="icon-flag"></i>
                        <span class="username username-hide-on-mobile">العربية</span>
                    </a>
                </li>
                <?php endif; ?>
                <?php if($this->session->get('auth-identity')['Lang']=="ar"): ?>
                <li class="dropdown dropdown-user">
                    <a href="{{url('cp_users/lang')}}?lang=en" class="dropdown-toggle">
                        <i class="icon-flag"></i>
                        <span class="username username-hide-on-mobile">English</span>
                    </a>
                </li>
                <?php endif; ?>

                <li class="dropdown dropdown-user">
                    <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown"
                       data-close-others="true">
                        

                        <span class="username username-hide-on-mobile"><?php echo $translate->_("Colors"); ?></span>
                        <i class="fa fa-angle-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-default">
                       <li>
                            <a href="{{url('cp_users/scheme')}}?scheme=scheme_1" class="theme1">
                                <?php echo $translate->_("Theme 1"); ?>
                            </a>
                        </li>
                        <li>
                            <a href="{{url('cp_users/scheme')}}?scheme=scheme_2" class="theme2">
                                <?php echo $translate->_("Theme 2"); ?>
                            </a>
                        </li>
                        <li>
                            <a href="{{url('cp_users/scheme')}}?scheme=scheme_3" class="theme3">
                                <?php echo $translate->_("Theme 3"); ?>
                            </a>
                        </li>
                        <li>
                            <a href="{{url('cp_users/scheme')}}?scheme=scheme_4" class="theme4">
                                <?php echo $translate->_("Theme 4"); ?>
                            </a>
                        </li>
                        <li>
                            <a href="{{url('cp_users/scheme')}}?scheme=scheme_5" class="theme5">
                                <?php echo $translate->_("Theme 5"); ?>
                            </a>
                        </li>
<li>
                            <a href="{{url('cp_users/scheme')}}?scheme=scheme_6" class="theme6">
                                <?php echo $translate->_("Theme 6"); ?>
                            </a>
                        </li>
                    </ul>
                </li>
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
        {{menus.getMenu()}}

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

            <div class="row">
                <div class="col-md-12">
                    {{ content() }}
                    <p><?php echo $this->flashSession->output() ?></p>
                </div>
            </div>

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
    <div class="page-footer-inner text-center"> 2016 &copy; Robo CMS by

        <a href="http://www.pentavalue.com" title="Pentavalue" target="_blank">Pentavalue</a>
    </div>
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
    var base_url = "{{url('')}}";
</script>

{{ javascript_include("ropo_app/js/bootstrap.min.js") }}
{{ javascript_include('ropo_app/js/jquery.datetimepicker.full.js') }}
{{ javascript_include("ropo_app/js/bootstrap-datepicker.min.js") }}
{{ javascript_include("ropo_app/js/js.cookie.min.js") }}
{{ javascript_include("ropo_app/js/bootstrap-hover-dropdown.min.js") }}
{{ javascript_include("ropo_app/js/jquery.slimscroll.min.js") }}
{{ javascript_include("ropo_app/js/jquery.blockui.min.js") }}
{{ javascript_include("ropo_app/js/bootstrap-switch.min.js") }}
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->

{{ javascript_include("ropo_app/js/datatable.js") }}
{{ javascript_include("ropo_app/js/datatables/datatables.min.js") }}
{{ javascript_include("ropo_app/js/datatables/datatables.bootstrap.js") }}

{{ javascript_include("ropo_app/js/bootstrap-fileinput.js") }}
{{ javascript_include("ropo_app/js/swiper.min.js") }}
{{ javascript_include("ropo_app/js/bootbox.min.js") }}
{{ javascript_include("ropo_app/js/select2/select2.js") }}
{{ javascript_include("ropo_app/js/auto_complete.js") }}
<!-- END PAGE LEVEL PLUGINS -->


{{ javascript_include("js/jquery-filer/jquery.filer.min.js") }}
{{ javascript_include("js/bootstrap-toggle.min.js") }}

{{ javascript_include("js/jquery.validate.min.js") }}
{{ javascript_include("js/dynamicvideofields.js") }}


<!-- Testing Assests Management -->
{{ assets.outputJs() }}
<!-- -->
{{ javascript_include("js/custom_cms.js") }}

<script type="text/javascript"
    src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.4/js/standalone/selectize.js"></script>

<!-- BEGIN THEME LAYOUT SCRIPTS -->
{{ javascript_include("ropo_app/js/custom-pentavalue.js") }}
{{ javascript_include("ropo_app/js/angular/angular.js") }}
{{ javascript_include("ropo_app/js/notifications.js") }}
{{ javascript_include("ropo_app/js/ads.js") }}
{{ javascript_include("ropo_app/js/companies.js") }}
{{ javascript_include("ropo_app/js/projects.js") }}
{{ javascript_include("ropo_app/js/places.js") }}
{{ javascript_include("ropo_app/js/procedures.js") }}
{{ javascript_include("ropo_app/js/events.js") }}
{{ javascript_include("ropo_app/js/messages.js") }}
{{ javascript_include("ropo_app/js/comments.js") }}
<!-- END THEME LAYOUT SCRIPTS -->

{{ javascript_include("js/jquery.autocomplete.js") }}

<script
    src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAYiz5FAz_hNkhw9-CypVwth1_F4cng_LY">
</script>
<!---->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    var fast_search_str="{{ translate._('Quick Search') }}";
    var records_str="{{ translate._('Records') }}";
    var got_total_str="{{ translate._('Got a total of')  }}";
    var to_show_str="{{ translate._('to show')  }}";
    var to_str="{{ translate._('to')  }}";
</script>
<script type="text/javascript">
$(".date-picker").datepicker();
</script>
<script>
  $( function() {
    $( "#sortable" ).sortable();
    $( "#sortable" ).disableSelection();
  } );
  </script>

  
<script type="text/javascript">
// if ('serviceWorker' in navigator) {
//   navigator.serviceWorker.register("{{url('service-worker.js')}}").then(function(reg) {
//     console.log('Yey!', reg);
//   }).catch(function(err) {
//     console.log('Boo!', err);
//   });
// }
</script>

</body>
</html>