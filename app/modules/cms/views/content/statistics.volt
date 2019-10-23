<div class="row widget-row">
    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">{{translate._("Active Content")}} </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">{{translate._("Content")}} </span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{this.url_shared.get('cms_module/content/search')}}&Module_ID={{Module_ID}}&Active=1">{{content_active}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>

    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading"> {{translate._("Non Active Content")}} </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">{{translate._("Content")}} </span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{this.url_shared.get('cms_module/content/search')}}&Module_ID={{Module_ID}}&Active=0">{{content_nonActive}}</a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>

        <?php
        foreach ($depts_stats as $key=>$value):

        ?>

    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading"> <?php echo $key ?></h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">{{translate._("Content")}} </span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="{{url('content/filterByDept/')}}<?php echo $value["Dept_ID"] ?>"><?php echo count($value)-1 ?></a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>
    <?php endforeach; ?>

</div>