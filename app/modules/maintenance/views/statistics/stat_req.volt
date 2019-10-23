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
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('img/banners/banner-maint.png') center center no-repeat ; background-size: contain"></div>
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
            <i class="fa fa-pie-chart font-dark"></i>
            <span class="caption-subject bold uppercase">إحصائية طلبات الصيانة</span>
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
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">التاريخ من </label>
                                        <input type="date" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">التاريخ الى </label>
                                        <input type="date" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">الصنف</label>
                                        <select class="form-control" id="sel1">
                                            <option>صنف 1</option>
                                            <option>صنف 2 </option>
                                            <option>صنف 3 </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">نوع الصنف</label>
                                        <select class="form-control" id="sel2">
                                            <option>نوع 1</option>
                                            <option>نوع 2 </option>
                                            <option>نوع 3 </option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label class=" control-label"> سعة الخزان </label>
                                        <div class="col-sm-12 no-padding funkyradio">
                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="ckbCheckAll" >
                                                    <label for="ckbCheckAll"> كل</label>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox1" class="checkBoxClass">
                                                    <label for="checkbox1">300 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox2" class="checkBoxClass">
                                                    <label for="checkbox2">400 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox3" class="checkBoxClass">
                                                    <label for="checkbox3">500 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox4" class="checkBoxClass">
                                                    <label for="checkbox4">1000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox5" class="checkBoxClass">
                                                    <label for="checkbox5">1500 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox6" class="checkBoxClass">
                                                    <label for="checkbox6">300 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox7" class="checkBoxClass">
                                                    <label for="checkbox7">2000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox8" class="checkBoxClass">
                                                    <label for="checkbox8">2500 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox9" class="checkBoxClass">
                                                    <label for="checkbox9">3000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox10" class="checkBoxClass">
                                                    <label for="checkbox10">4000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox11" class="checkBoxClass">
                                                    <label for="checkbox11">5000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox12" class="checkBoxClass">
                                                    <label for="checkbox12">6000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox13" class="checkBoxClass">
                                                    <label for="checkbox13">7000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox14" class="checkBoxClass">
                                                    <label for="checkbox14">8000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox15" class="checkBoxClass">
                                                    <label for="checkbox15">9000 لتر</label>
                                                </div>
                                            </div>

                                            <div class="col-md-2 col-sm-4 col-xs-6">
                                                <div class="funkyradio-default">
                                                    <input type="checkbox" name="checkbox" id="checkbox16" class="checkBoxClass">
                                                    <label for="checkbox16">1000 لتر</label>
                                                </div>
                                            </div>

                                            <script>
                                                $(document).ready(function () {
                                                    $("#ckbCheckAll").click(function () {
                                                        $(".checkBoxClass").prop('checked', $(this).prop('checked'));
                                                    })
                                            </script>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-primary">فلتر</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div id="pie-chart"></div>
        </div>
        <div class="col-md-12" id="stat_req">
        </div>
    </div>
</div>

<script>

    var stat_req_url="{{url('maintenance_module/statistics/stat_req_table')}}";
    $("#stat_req").load(stat_req_url);

</script>