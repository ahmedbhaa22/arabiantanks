<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="apple-touch-icon" sizes="180x180" href="{{url('/becatronics/img/favicons/apple-touch-icon.png')}}">
    <link rel="icon" type="image/png" href="{{url('/becatronics/img/favicons/favicon-32x32.png')}}" sizes="32x32">
    <link rel="icon" type="image/png" href="{{ url('/becatronics/img/favicons/favicon-16x16.png')}}" sizes="16x16">
    <link rel="manifest" href="{{ url('/becatronics/img/favicons/manifest.json')}}">
    <link rel="mask-icon" href="{{ url('/becatronics/img/favicons/safari-pinned-tab.svg')}}" color="#0d2e59">
    <meta name="theme-color" content="#0d2e59">

    <title>BECATRONICS | Home</title>

    <!-- Bootstrap core CSS -->
    {{ stylesheet_link("becatronics/css/bootstrap.css") }}

    <!-- Swiper's CSS -->
    {{ stylesheet_link("becatronics/css/swiper.min.css") }}

    <!-- Custom styles for this template -->
    {{ stylesheet_link("becatronics/css/custome-becatronics.css") }}

    <!--[if lt IE 9]>
    {{ javascript_include("becatronics/js/html5shiv.min.js") }}
    {{ javascript_include("becatronics/js/respond.min.js") }}
    <![endif]-->
</head>

<body>
<div class="logo-box"></div>
<nav class="navbar navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="logo" href="{{url('becatronics/index')}}">
                <img src="{{url()}}becatronics/img/logo.png">
            </a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="{{url('becatronics/index')}}">Home</a></li>
                <li><a href="{{url('becatronics/company')}}">company</a></li>
                <li><a href="{{url('becatronics/categories')}}">products</a></li>
                <li><a href="{{url('becatronics/contact')}}">Contact</a></li>
            </ul>
            <form class="navbar-form" role="search">
                <div class="input-group add-on">
                    <input class="form-control" placeholder="Search products, News..." name="srch-term" id="srch-term" type="text">

                    <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</nav>

<div class="container pad-top">

    {{ content()}}

</div>
<!-- /.container -->

<footer>
    <div class="container">
        <div class="col-md-6 col-sm-12">
            Becatronics: Lorem ipsum dolor sit amet, Cairo, Egypt
        </div>
        <div class="col-md-6 col-sm-12 text-right">
            2016 ALL RIGHTS © RESERVED BECATRONICS.COM
        </div>
    </div>
</footer>

<!-- NewsLetter Modal -->
<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content newsletter-bg">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title text-center">Subscribe to our newsletter</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group col-md-12">
                        <div class="col-md-3"><label>your name:</label></div>
                        <div class="col-md-9"><input type="text" name="name" class="form-control"></div>
                    </div>
                    <div class="form-group col-md-12">
                        <div class="col-md-3"><label>your email:</label></div>
                        <div class="col-md-9"><input type="email" name="email" class="form-control"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-default">Subscribe</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<!--==================================================
 ===================== JavaScript ====================
 ================================================== -->
{{ javascript_include("becatronics/js/jquery.min.js") }}
{{ javascript_include("becatronics/js/bootstrap.min.js") }}
{{ javascript_include("becatronics/js/matchHeight.min.js") }}
<script type="text/javascript" >
    $(function() {
        var byRow = $('body').hasClass('test-rows');

        $('.items-container').each(function() {
            $(this).children('.item').matchHeight({
                byRow: byRow
            });
        });

    });
</script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<!--<script src="js/ie10-viewport-bug-workaround.js"></script>-->

<!-- Swiper JS -->
{{ javascript_include("becatronics/js/swiper.js") }}
<!-- Initialize Swiper -->
<script type="text/javascript">
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        autoplay: 8000,
        paginationClickable: true
    });
</script>


</body>
</html>
