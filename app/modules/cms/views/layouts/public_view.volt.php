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
    <?= $this->tag->stylesheetLink('https://maxcdn.bootstrapcdn.com/font-awesome/4.6.2/css/font-awesome.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/simple-line-icons.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/bootstrap-rtl.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/bootstrap-switch-rtl.min.css') ?>
    <!-- END GLOBAL MANDATORY STYLES -->

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <?= $this->tag->stylesheetLink('ropo_app/css/bootstrap-fileinput.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/daterangepicker.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/fullcalendar/fullcalendar.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/swiper.min.css') ?>
    <!-- END PAGE LEVEL PLUGINS -->

    <!-- BEGIN THEME GLOBAL STYLES -->
    <?= $this->tag->stylesheetLink('ropo_app/css/components-md-rtl.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/plugins-md-rtl.min.css') ?>
    <!-- END THEME GLOBAL STYLES -->

    <!-- BEGIN THEME LAYOUT STYLES -->
    <?= $this->tag->stylesheetLink('ropo_app/css/layout-rtl.min.css') ?>
    <?= $this->tag->stylesheetLink('ropo_app/css/custom-pentavalue.css') ?>
    <!-- END THEME LAYOUT STYLES -->

    <!----BEGIN color-- scheme------>
    <?= $this->tag->stylesheetLink('ropo_app/css/schemes/scheme_6.css') ?>


    <!----END color-- scheme------->
    <?= $this->tag->stylesheetLink('css/jquery-filer/jquery.filer.css') ?>
    <?= $this->tag->stylesheetLink('css/jquery-filer/themes/jquery.filer-dragdropbox-theme.css') ?>
    <?= $this->tag->stylesheetLink('css/custom-css.css') ?>
    <script>
        <?php  ?>
        var main_url = "<?php echo $this->config->application->baseUri; ?>";
    </script>

    <!------favicon---------->
    <link rel="apple-touch-icon" sizes="57x57" href="<?= $this->url->get('/img/favicon/apple-touch-icon-57x57.png') ?>">
    <link rel="apple-touch-icon" sizes="60x60" href="<?= $this->url->get('img/favicon/apple-touch-icon-60x60.png') ?>">
    <link rel="apple-touch-icon" sizes="72x72" href="<?= $this->url->get('img/favicon/apple-touch-icon-72x72.png') ?>">
    <link rel="apple-touch-icon" sizes="76x76" href="<?= $this->url->get('img/favicon/apple-touch-icon-76x76.png') ?>">
    <link rel="apple-touch-icon" sizes="114x114" href="<?= $this->url->get('img/favicon/apple-touch-icon-114x114.png') ?>">
    <link rel="apple-touch-icon" sizes="120x120" href="<?= $this->url->get('img/favicon/apple-touch-icon-120x120.png') ?>">
    <link rel="apple-touch-icon" sizes="144x144" href="<?= $this->url->get('img/favicon/apple-touch-icon-144x144.png') ?>">
    <link rel="apple-touch-icon" sizes="152x152" href="<?= $this->url->get('img/favicon/apple-touch-icon-152x152.png') ?>">
    <link rel="apple-touch-icon" sizes="180x180" href="<?= $this->url->get('img/favicon/apple-touch-icon-180x180.png') ?>">
    <link rel="icon" type="image/png" href="<?= $this->url->get('img/favicon/favicon-32x32.png') ?>" sizes="32x32">
    <link rel="icon" type="image/png" href="<?= $this->url->get('img/favicon/android-chrome-192x192.png') ?>" sizes="192x192">
    <link rel="icon" type="image/png" href="<?= $this->url->get('img/favicon/favicon-96x96.png') ?>" sizes="96x96">
    <link rel="icon" type="image/png" href="<?= $this->url->get('img/favicon/favicon-16x16.png') ?>" sizes="16x16">
    <link rel="manifest" href="<?= $this->url->get('img/favicon/manifest.json') ?>">
    <link rel="mask-icon" href="<?= $this->url->get('img/favicon/safari-pinned-tab.svg') ?>" color="#673ab7">
    <link rel="shortcut icon" href="<?= $this->url->get('img/favicon/favicon.ico') ?>">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="msapplication-TileImage" content="img/favicon/mstile-144x144.png">
    <meta name="msapplication-config" content="img/favicon/browserconfig.xml">
    <meta name="theme-color" content="#673ab7">
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

        <!-- END SIDEBAR -->
    </div>
    <!-- END SIDEBAR -->
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">

            <div class="row">
                <div class="col-md-12">
                    <?= $this->getContent() ?>
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
<?= $this->tag->javascriptInclude('ropo_app/js/jquery.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/js.cookie.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap-hover-dropdown.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/jquery.slimscroll.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/jquery.blockui.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap-switch.min.js') ?>
<!-- END CORE PLUGINS -->

<!-- BEGIN PAGE LEVEL PLUGINS -->
<?= $this->tag->javascriptInclude('ropo_app/js/bootstrap-fileinput.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/swiper.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/bootbox.min.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/select2/select2.js') ?>
<?= $this->tag->javascriptInclude('ropo_app/js/auto_complete.js') ?>
<!-- END PAGE LEVEL PLUGINS -->

<!-- BEGIN THEME LAYOUT SCRIPTS -->
<?= $this->tag->javascriptInclude('ropo_app/js/custom-pentavalue.js') ?>

<!-- END THEME LAYOUT SCRIPTS -->

<script>

</script>
</body>
</html>
