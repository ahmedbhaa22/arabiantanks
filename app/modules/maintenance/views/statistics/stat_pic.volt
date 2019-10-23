<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="maintenance.html"><span> الصيانة </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span>إحصائيات   </span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url('img')}}/banners/banner-maint.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

<div class="clearfix"></div>
{{ partial("statistics/partials/partial_menu") }}
<!--end mt-element-step -->

<div class="clearfix"></div>


<div class="portlet light gap clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-pencil-square-o font-dark"></i>
            <span class="caption-subject bold uppercase">احصائية المشاكل على صور الخزانات</span>
        </div>

    </div>
    <div class="portlet-body">
        <div class="panel-group accordion" id="accordion1">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">
                            <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                        </a>
                    </h4>
                </div>
                <div id="collapse-clients-filter" class="panel-collapse collapse">
                    <div class="panel-body">
                        <form role="form">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label">التاريخ من </label>
                                        <input type="date" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="form-group">
                                        <label class=" control-label">التاريخ الى </label>
                                        <input type="date" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group col-sm-4">
                                    <label>تصنيف المنتج</label>
                                    <select class=" form-control">
                                        <option>خزان</option>
                                        <option>اغطية ارضية</option>
                                        <option>ابواب اتوماتيكية</option>
                                        <option>مضخات</option>
                                    </select>
                                </div>
                                <div class="form-group col-sm-4">
                                    <label>نوع المنتج</label>
                                    <select class=" form-control">
                                        <option selected="selected" value=""></option>
                                        <option value="1">خزان افقى</option>
                                        <option value="2">خزان عامودى</option>
                                        <option value="3">خزان الدفان  </option>
                                        <option value="5">خزان ممرات</option>
                                        <option value="4">خزان بيت الدرج</option>
                                    </select>
                                </div>
                                <div class="form-group col-sm-4">
                                    <label>سعة الخزان</label>
                                    <select class=" form-control">
                                        <option selected="selected" value=""></option>
                                        <option value="4">300 لتر</option>
                                        <option value="5">400 لتر</option>
                                        <option value="6">500 لتر</option>
                                        <option value="1">1000 لتر</option>
                                        <option value="2"> 1500 لتر </option>
                                        <option value="3">2000 لتر</option>
                                        <option value="7">2500 لتر</option>
                                        <option value="8">3000 لتر</option>
                                        <option value="9">4000 لتر</option>
                                        <option value="10">4500 لتر</option>
                                        <option value="11">5000 لتر</option>
                                        <option value="12">6000 لتر</option>
                                        <option value="13">7000 لتر</option>
                                        <option value="14">8000 لتر</option>
                                        <option value="15">9000 لتر</option>
                                        <option value="16">10000 لتر</option>
                                    </select>
                                </div>
                            </div>
                            <button class="btn btn-primary">فلتر</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        {{ partial("statistics/partials/stat_pic_table") }}
    </div>
</div>