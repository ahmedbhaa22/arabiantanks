<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url(/pcms/public/ropo_app/img/statistics.png) center no-repeat;">
        </div>
    </div>
</div>
<div class="page-title space clearfix">
    <div class="caption font-dark">
        <span class="caption-subject bold uppercase"><?php echo $translate->_("Users Statistics"); ?> </span>
    </div>
</div>

<div class="row widget-row">
    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">عدد المستخدمين </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">مستخدم</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{ url("mobile_users/statisticsByFilter/") ~203}}">{{users_count}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>
    
    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">عدد المستخدمين المفعلين </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">مستخدم</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{ url("mobile_users/statisticsByFilter/") ~1}}">{{users_active}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>
    

    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">عدد المستخدمين الغير مفعلين </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users-square"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">مستخدم</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{ url("mobile_users/statisticsByFilter/") ~205}}">{{users_nonActive}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>

    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">عدد المستخدمين عن فيسبوك </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-facebook-square"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">مستخدم</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{ url("mobile_users/statisticsByFilter/") ~206}}">{{users_fb}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>

    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">عدد المستخدمين المسجلين عبر انستقرام </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-instagram"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">مستخدم</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{ url("mobile_users/statisticsByFilter/") ~209}}">{{users_instegram}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>    
    
    
    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">عدد المستخدمين المسجلين عبر تويتر </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-twitter-square"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">مستخدم</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{ url("mobile_users/statisticsByFilter/") ~208}}">{{users_twitter}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>
    
    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">عدد المستخدمين الذكور </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-male"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">مستخدم</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{ url("mobile_users/statisticsByFilter/") ~202}}">{{users_males}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>
    
    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">عدد المستخدمين الإناث </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-female"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">مستخدم</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{ url("mobile_users/statisticsByFilter/") ~201}}">{{users_females}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>

</div>