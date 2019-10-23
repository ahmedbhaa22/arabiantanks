<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to Ropo App</title>
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
            <div class="logo">
                <a href="#">
                    <!-- <img src="../assets/pages/img/logo-big.png" alt="" /> -->
                    <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                	 viewBox="0 0 2985.4 2985.4" width = "135px" style="enable-background:new 0 0 2985.4 2985.4;" xml:space="preserve">

                <circle class="st0-penta" cx="1492.7" cy="1492.7" r="1468.2"/>
                <path class="st1-penta" d="M1492.7,2985.4c-201.5,0-397-39.5-581-117.3c-88.5-37.4-173.8-83.7-253.6-137.6
                	c-79-53.4-153.4-114.7-220.9-182.3c-67.5-67.5-128.9-141.9-182.3-220.9c-53.9-79.8-100.2-165.1-137.6-253.6
                	C39.5,1889.7,0,1694.2,0,1492.7c0-201.5,39.5-397,117.3-581c37.4-88.5,83.7-173.8,137.6-253.6c53.4-79,114.7-153.4,182.3-220.9
                	c67.5-67.5,141.9-128.9,220.9-182.3c79.8-53.9,165.1-100.2,253.6-137.6C1095.7,39.5,1291.2,0,1492.7,0s397,39.5,581,117.3
                	c88.5,37.4,173.8,83.7,253.6,137.6c79,53.4,153.4,114.7,220.9,182.3c67.5,67.5,128.9,141.9,182.3,220.9
                	c53.9,79.8,100.2,165.1,137.6,253.6c77.8,184,117.3,379.5,117.3,581c0,201.5-39.5,397-117.3,581c-37.4,88.5-83.7,173.8-137.6,253.6
                	c-53.4,79-114.7,153.4-182.3,220.9c-67.5,67.5-141.9,128.9-220.9,182.3c-79.8,53.9-165.1,100.2-253.6,137.6
                	C1889.7,2945.9,1694.2,2985.4,1492.7,2985.4z M1492.7,49C696.6,49,49,696.6,49,1492.7c0,796.1,647.6,1443.7,1443.7,1443.7
                	s1443.7-647.6,1443.7-1443.7C2936.4,696.6,2288.8,49,1492.7,49z"/>
                <g>
                	<path class="st2-penta" d="M466.5,1604.9c1.4-4,3.1-8,4-12.1c11.1-49.2,40.1-83.1,86.9-101.8c2.7-1.1,5.5-1.6,9.1-2.6
                		c0,173.9,0,346.7,0,520.8c-4.1-1.3-7.5-2.1-10.8-3.4c-46.5-19.3-75.2-53.5-85.5-102.9c-0.7-3.5-2.5-6.7-3.8-10
                		C466.5,1796.9,466.5,1700.9,466.5,1604.9z"/>
                	<path class="st2-penta" d="M2466.5,1900.9c-0.8,3.4-1.6,6.9-2.5,10.3c-12.6,45.4-40.4,77.2-84.4,94.7c-0.6,0.2-1.3,0-1.9,0
                		c-1.9-7.1-2.5-501-0.5-515.2c3.2,1.2,6.3,2.2,9.2,3.6c37.6,17.1,62.6,45.5,75.5,84.6c1.9,5.9,3.1,12,4.6,18
                		C2466.5,1698.2,2466.5,1799.5,2466.5,1900.9z"/>
                	<path class="st3-penta" d="M750.2,851.9c19.7-18.5,38.1-37.4,47-64.7c3.4,3,6.1,5.3,8.7,7.7c58.1,55,116.1,110.1,174.4,164.8
                		c17.9,16.8,39.6,25.5,64.4,25.2c11.5-0.1,22.2-3.1,32.3-9.1c106.3-63.1,212.6-126,318.9-189.1c4.3-2.5,8.3-5.6,12.2-8.6
                		c12.4-9.7,25.9-17.4,41.1-22.2c12.5-4,24.8-3.9,37.3,0.1c15.1,4.9,28.6,12.5,41,22.3c4.2,3.3,8.5,6.4,13.1,9.1
                		c104.9,62.1,209.9,124,314.6,186.5c21.5,12.8,43.3,13.9,66.1,6c13.7-4.7,25.8-12,36.4-22.1c57.3-54.4,114.7-108.6,172.1-162.9
                		c2.4-2.3,4.9-4.4,7.1-6.5c7,11.6,13,23.5,20.9,34c8,10.6,17.8,19.7,27.4,30c-2.5,2.6-5,5.3-7.5,7.8
                		c-42.2,42.2-84.4,84.4-126.5,126.6c-10.6,10.6-20.5,21.9-27.8,35.2c-5.9,10.7-9.8,21.9-8.9,34.3c0.6,8.2,3.7,14.1,11.3,18.4
                		c78.5,45.2,157.2,90.2,235.1,136.4c20.4,12.1,39,27.4,52.1,48.2c12.8,20.4,21,42.3,23.9,66.1c1.2,9.6,1.9,19.2,1.9,28.9
                		c0.1,267,0,533.9,0.2,800.9c0,20.1-5.3,38.8-13.3,56.9c-15.3,34.8-39,63.4-66.7,88.9c-25.2,23.1-53.1,42.5-82.6,59.4
                		c-97.9,56.2-195.6,112.9-294.2,167.9c-123,68.7-246.8,135.9-370.2,203.9c-12.6,6.9-25.9,11.1-39.8,12.1c-16.2,1.1-31.7-3-46-10.9
                		c-80.9-44.3-162.1-88.1-242.6-133.1c-129.4-72.3-258.5-145.1-387.3-218.3c-29.8-16.9-58.7-35.6-86.9-55.1
                		c-31.4-21.8-58.4-48.6-79.7-80.6c-16.1-24.1-28.2-49.8-31.6-79c-0.5-4.3-0.7-8.6-0.7-13c0-266.3,0-532.6,0-798.9
                		c0-26.6,4.1-52.5,15.5-76.8c10.7-22.8,26.5-40.8,46.7-56.1c24.5-18.6,52-31.8,78-47.5c26.2-15.9,53.1-30.6,79.6-46
                		c31.1-18.1,62-36.5,93.2-54.3c7.3-4.2,10.4-9.7,11-17.5c0.9-10.6-1.6-20.5-6.1-30c-7.4-15.6-18.5-28.4-30.5-40.5
                		c-33.7-33.7-67.4-67.5-101-101.2c-8.7-8.7-17.4-17.4-26.1-26.2C755,857.1,752.8,854.7,750.2,851.9z M1091,2152.1
                		c0.2-16.8-5.4-31.4-17-43.5c-12.7-13.2-25.5-26.3-38.8-38.8c-24.6-22.9-61.4-22.9-86,0.2c-13.3,12.5-26.3,25.5-38.8,38.9
                		c-22.9,24.6-22.8,61.5,0.2,86.1c12.5,13.4,25.4,26.4,38.8,38.8c24.7,23,61.4,22.9,86-0.2c13.3-12.5,26.2-25.6,38.8-38.9
                		C1085.5,2182.8,1091,2168.5,1091,2152.1z M1844.3,2151c0,17.4,5.8,32.3,17.7,44.5c12.3,12.7,24.7,25.2,37.5,37.4
                		c24.7,23.6,61.9,23.9,86.8,0.6c13.4-12.5,26.3-25.5,38.8-38.9c23-24.6,23-61.5-0.1-86.1c-12.5-13.4-25.5-26.3-38.9-38.9
                		c-24.4-22.9-61.6-22.9-86,0.1c-13.3,12.5-26.2,25.6-38.9,38.8C1850,2120.5,1844.5,2134.9,1844.3,2151z"/>
                	<path id="electric-left" class="st2-penta" d="M1269,493.4c2.4-4.4,4.2-7.5,5.9-10.7c16.6-31.5,33.3-63,49.8-94.6c4.7-9,9.8-16.9,21.7-15.7
                		c11.8,1.2,15.4,9.8,18.2,19.7c13.9,50,28,100,42.1,150c0.8,2.8,1.7,5.6,4.2,8.4c1.2-10.2,2.5-20.3,3.6-30.5
                		c4.5-40.7,9-81.5,13.4-122.2c4.3-39.4,8.5-78.8,12.8-118.2c4.3-39.4,8.7-78.8,13-118.2c1-9.3,1.9-18.6,3-27.8
                		c0.4-3.6,0.7-7.3,1.7-10.8c2.3-8.8,9.8-14.2,18.4-13.9c8.9,0.4,16.3,6,17.8,14.7c2.4,13.4,4.1,27,5.9,40.5
                		c7.8,56.1,15.6,112.2,23.4,168.2c2.9,20.8,5.7,41.6,8.6,62.4c0.4,3.2,1,6.5,1.7,10.3c6,0,11.3,0,16.6,0c26.7,0,53.3-0.1,80,0.1
                		c10.8,0.1,18.1,5.6,20.1,14.5c2.6,11.8-5,22.1-17.2,23.2c-5,0.4-10,0.1-15,0.1c-32,0-64,0-96,0c-16.4,0-22.1-5-24.3-21.2
                		c-5.9-42.6-11.9-85.1-17.9-127.6c-0.2-1.1-0.6-2.2-2.7-3.4c-0.9,7.4-2,14.7-2.8,22.1c-6,54.3-11.9,108.6-17.8,162.9
                		c-5.6,51.7-11.1,103.3-16.7,155c-0.9,8.6-1.7,17.3-3.1,25.8c-1.7,10.2-8,16-17.1,16.6c-9.7,0.7-16.8-4.2-19.8-14.7
                		c-12.7-44.5-25.2-89.1-37.7-133.6c-6.8-24-13.5-48.1-20.2-72.1c-0.8-2.8-1.7-5.5-3.2-10.1c-2.6,4.6-4.4,7.6-6.1,10.7
                		c-16.9,32.1-33.8,64.3-50.7,96.4c-1.6,2.9-3,6-4.9,8.7c-8.8,12-26.6,10.1-32.5-3.6c-1.2-2.7-1.7-5.7-2.5-8.6
                		c-8.6-34.2-17.2-68.5-25.8-102.7c-0.6-2.6-1.4-5.1-2.4-8.7c-3.6,0-7.2,0-10.7,0c-41.3,0-82.7,0-124,0c-3.6,0-7.4,0.1-10.9-0.7
                		c-9.5-2.2-15.1-10.4-14.3-20c0.7-8.9,7.7-15.9,16.9-16.9c2.3-0.3,4.7-0.1,7-0.1c48.7,0,97.3,0,146,0c15.6,0,20.7,4.1,24.5,19.1
                		c5.9,23.2,11.7,46.5,17.6,69.7C1266.8,487.9,1267.7,489.9,1269,493.4z"/>
                	<path id="right-circle" class="st2-penta" d="M2171.4,727.2c-1.2-68.3,54.3-125.1,122.8-126.8c65.7-1.6,125.9,49.9,127.9,121.5c2,70.3-53,127.9-122.2,129.1
                		C2229.4,852.3,2172.7,797.8,2171.4,727.2z"/>
                	<path id="left-circle" class="st2-penta" d="M513.8,726.3c-0.2-69.5,55.2-125.5,124.5-125.8c69.8-0.3,126.1,55.7,126.1,125.3
                		c0,69.2-55.9,125.2-125.1,125.3C569.9,851.3,513.9,795.6,513.8,726.3z"/>
                	<path class="st2-penta" d="M1584.9,2713c0.5,3.9,1,6.4,1.1,9c0.1,30.6,0.5,61.3-0.1,91.9c-0.7,36.7-24.8,65.9-60.1,73.8
                		c-5.1,1.1-10.6,1.5-15.8,1.6c-28,0.2-56,0.3-83.9,0c-37.4-0.4-67-25-74.5-61.5c-0.9-4.2-1.2-8.6-1.3-12.9
                		c-0.1-30.6-0.1-61.3-0.1-91.9c0-2.9,0.5-5.8,0.9-10.6c9.3,5,17.4,9.2,25.4,13.6c15.2,8.3,29.8,17.7,45.5,24.8
                		c24.8,11.1,50.6,12.7,77,5c16.2-4.7,30-14.2,44.7-21.8c11.2-5.8,22.1-12.2,33.2-18.3C1579,2714.7,1581.3,2714.2,1584.9,2713z"/>
                	<path id= "electric-right" class="st2-penta" d="M1847.6,442.8c-10,0-20,0.2-30,0c-12.1-0.2-20.5-7.9-20.8-18.5c-0.3-10.9,8.5-19.1,21-19.3
                		c20-0.2,40-0.3,59.9,0c15.6,0.3,24.9,14.7,17.9,27.6c-3.6,6.7-9.5,10.1-17.2,10.1C1868.3,442.9,1858,442.8,1847.6,442.8z"/>
                	<path class="st2-penta" d="M1721.2,442.8c-9.3,0-18.6,0.1-27.9,0c-12.2-0.2-20.4-7.7-20.6-18.4c-0.2-11.1,8.2-19.2,20.8-19.3
                		c18.6-0.2,37.2-0.2,55.8,0c12,0.1,20.4,7.9,20.7,18.4c0.3,10.9-8.4,18.9-20.8,19.3c-0.3,0-0.7,0-1,0
                		C1739.1,442.8,1730.1,442.8,1721.2,442.8z"/>
                </g>
                <circle id="circles-round" class="st1-penta" cx="87.1" cy="1468.6" r="87.1"/>
                </svg>

                </a>
                {{ content() }}
            </div>
        </div>
        
        <div class="copyright">
            2016 ©  Robo App System by
            {{image('ropo_app/img/logo_small.png', 'width':'40')}}
            
            <a href="" title="Pentavalue" target="_blank">pentavalue</a>
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