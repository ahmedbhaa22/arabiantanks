<!DOCTYPE html>
<html>
    <head>
        <title>Tanks || Login</title>
        <link href="//netdna.bootstrapcdn.com/bootswatch/2.3.1/united/bootstrap.min.css" rel="stylesheet">
        {{ stylesheet_link('css/style.css') }}
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css">
        {{ stylesheet_link('ropo_app/css/simple-line-icons.min.css') }}
        {{ stylesheet_link('ropo_app/css/bootstrap-rtl.min.css') }}
        {{ stylesheet_link('ropo_app/css/bootstrap-switch-rtl.min.css') }}
        <!-- END GLOBAL MANDATORY STYLES -->

        <!-- BEGIN PAGE LEVEL PLUGINS -->
        {{ stylesheet_link('ropo_app/css/select2.min.css') }}
        {{ stylesheet_link('ropo_app/css/select2-bootstrap.min.css') }}
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        {{ stylesheet_link('ropo_app/css/components-md-rtl.min.css') }}
        {{ stylesheet_link('ropo_app/css/plugins-md-rtl.min.css') }}
        <!-- END THEME GLOBAL STYLES -->
        
        <!-- BEGIN PAGE LEVEL STYLES -->
        {{ stylesheet_link('ropo_app/css/custom-pentavalue.css') }}
        <!-- END PAGE LEVEL STYLES -->
        <!----BEGIN color-- scheme------>
        {{ stylesheet_link('ropo_app/css/schemes/scheme_6.css') }}
        <!----END color-- scheme------->
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
        <meta name="msapplication-TileColor" content="#da532c">
        <meta name="msapplication-TileImage" content="img/favicon/mstile-144x144.png">
        <meta name="msapplication-config" content="img/favicon/browserconfig.xml">
        <meta name="theme-color" content="#673ab7">
    </head>
    <body class=" login">
        <!-- BEGIN LOGO -->

        <!-- END LOGO -->
        <!-- BEGIN LOGIN -->
        <div class="content">
            {{content()}}
        </div>
        
        <div class="copyright">
<!--            2016 ©  Robo App System by-->
<!--            {{image('ropo_app/img/logo_small.png', 'width':'40')}}-->
<!--            -->
<!--            <a href="" title="Pentavalue" target="_blank">pentavalue</a>-->
        </div>
        <!-- BEGIN CORE PLUGINS -->
        {{ javascript_include("ropo_app/js/jquery.min.js") }}
        {{ javascript_include("ropo_app/js/bootstrap.min.js") }}
        {{ javascript_include("ropo_app/js/js.cookie.min.js") }}
        {{ javascript_include("ropo_app/js/bootstrap-hover-dropdown.min.js") }}
        {{ javascript_include("ropo_app/js/jquery.slimscroll.min.js") }}
        {{ javascript_include("ropo_app/js/jquery.blockui.min.js") }}
        {{ javascript_include("ropo_app/js/bootstrap-switch.min.js") }}
        <!-- END CORE PLUGINS -->
        
         <!-- BEGIN PAGE LEVEL PLUGINS -->
        {{ javascript_include("ropo_app/js/jquery-validation/jquery.validate.min.js") }}
        {{ javascript_include("ropo_app/js/jquery-validation/additional-methods.min.js") }}
        {{ javascript_include("ropo_app/js/select2/select2.full.min.js") }}
        {{ javascript_include("ropo_app/js/jquery.backstretch.min.js") }}
        {{ javascript_include("ropo_app/js/loginscript.js") }}

        {{ javascript_include("ropo_app/js/bootstrap-fileinput.js") }}
        {{ javascript_include("ropo_app/js/swiper.min.js") }}
        {{ javascript_include("ropo_app/js/bootbox.min.js") }}
        {{ javascript_include("ropo_app/js/auto_complete.js") }}
       <!-- END PAGE LEVEL PLUGINS -->

       <!-- BEGIN PAGE LEVEL SCRIPTS -->
       {{ javascript_include("ropo_app/js/custom-pentavalue.js") }}
       <!-- END PAGE LEVEL SCRIPTS -->
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.1/js/bootstrap.min.js"></script>
    </body>
</html>