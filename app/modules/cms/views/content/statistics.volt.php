<div class="row widget-row">
    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">المحتوى المفعل </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">محتوى</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="#"><?= $content_active ?></a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>

    <div class="col-md-3 col-sm-6">
        <!-- BEGIN WIDGET THUMB -->
        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
            <h4 class="widget-thumb-heading">المحتوى الغير مفعل </h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">محتوى</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="#"><?= $content_nonActive ?></a></span>
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
            <h4 class="widget-thumb-heading">عدد المحتوى في قسم <?php echo $key ?></h4>

            <div class="widget-thumb-wrap">
                <i class="widget-thumb-icon circle bg-red-sunglo fa fa-users"></i>

                <div class="widget-thumb-body">
                    <span class="widget-thumb-subtitle">محتوى</span>
                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="15"><a href="<?= $this->url->get('content/filterByDept/') ?><?php echo $value["Dept_ID"] ?>"><?php echo count($value)-1 ?></a></span>
                </div>
            </div>
        </div>
        <!-- END WIDGET THUMB -->
    </div>
    <?php endforeach; ?>

</div>