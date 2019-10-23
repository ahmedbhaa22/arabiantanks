<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="<?= $this->url->get() ?>">لوحة التحكم</a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <span>المنيو </span>
        </li>
    </ul>

</div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('<?= $this->url_shared->get('ropo_app/') ?>img/banners/banner.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>
<div class="clearfix"></div>
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-tag font-dark"></i>
            <span class="caption-subject bold uppercase">
                                   المنيو
                                </span>
        </div>

        <div class="actions btn-group btn-group-lg btn-group-solid margin-bottom-10 ">
            <a type="button" href="<?= $this->url->get('menus/new/') . $menu_cms_id ?>" data-toggle="modal" class="btn btn-edit-my-data dark" data-target=".new-menu">
                أضافة عنصر في المنيو
            </a>
        </div>
    </div>
    <div class="portlet-body">
        <!--Swiper-->
        <div class="col-xs-12">
            <div class="slider-one-row">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <?php foreach ($menu as $item) { ?>
                        <!---slide---->
                        <div class="swiper-slide small">
                            <a class="imgandtext">
                                <div class="img-section-container">
                                    <i class="<?= $item->icon ?> icons"></i>
                                </div>
                                <h4><?= $item->name ?></h4>
                            </a>

                            <div class="  button-over-block-2">
                                <a type="button" class=" dropdown-toggle button-no-bg" data-toggle="dropdown">
                                    <i class="fa fa-angle-down"></i>
                                </a>
                                <ul class="dropdown-menu" role="menu">
                                    <li>
                                        <a href="<?= $this->url->get('menus/edit/') . $item->id ?>" data-toggle="modal" data-target=".edit-menu"> تعديل</a>
                                    </li>
                                    <li>
                                        <a class="" href="<?= $this->url->get('menus/delete/') . $item->id ?>" onclick="return confirmDelete()" > حذف العنصر </a>
                                    </li>

                                </ul>
                            </div>
                        </div>
                        <!-- swiper slide end-->
                        <?php } ?>
                    </div>
                    <!-- Add Pagination -->
                    <div class="swiper-pagination"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</div>

<!-- Modal New Menu Item -->
<div class="new-menu modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">

        </div>
    </div>
</div>
<!---- end modal new --->

<!-- Modal Edit Menu Item -->
<div class="edit-menu modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">

        </div>
    </div>
</div>
<!---- end modal new --->
<script>
    function confirmDelete() {
        return confirm('are you sure?');
    }
</script>