<div class="page-bar " style="position: relative" xmlns="http://www.w3.org/1999/html">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="{{url('maintenance_module/requests/index')}}"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <a href="{{url('maintenance_module/requests/index')}}">
                <span> الصيانة</span>
            </a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <a href="{{url('maintenance_module/requests/index') }}">
                <span>محتوى الصيانة</span>
            </a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <span>معاينة التذكرة</span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url("img/banners/")}}banner.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-ticket font-dark"></i>
            <span class="caption-subject bold uppercase"> معاينة التذكرة</span>
        </div>

        <div class="actions">
            <a  class="btn btn-md btn-info" href="{{url('maintenance_module/requests/edit/') ~content['id']}}">
                <i class="fa fa-pencil"></i>تحديث التذكرة
            </a>
            <a  onclick="return confirm('هل أنت متأكد من حذف هذا الطلب ؟')" class="btn btn-md btn-danger" href="{{url('maintenance_module/requests/deleteRequest/') ~content['id']}}">
                <i class="fa fa-trash"></i> حذف
            </a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="row"><p><?php $this->flashSession->output() ?></p></div>
        <div class="row clearfix">
            <div class="bold">
                <b> تغيير حالة الطلب</b>
            </div>
            {%for problem_status in problem_statuses%}
            {%if(problem_status.id!=ticket_status_id)%}
            {%continue%}
            {%endif%}
            <div class="col-md-2 col-sm-3 col-xs-4 nopadding-r">
                {{ radio_field('problem_status',"id":"icon"~problem_status.id,"class":"icon","value":problem_status.id,"readonly":"readonly") }}
                <!--                    <input type="radio" name="icon" class="icon" id="icon{{problem_status.id}}">-->
                <label for="icon{{problem_status.id}}">	{{problem_status.status_name}} </label>
            </div>
            {%endfor%}
        </div>
        <div class="one-log one-ticket gap">
            <div class="floating-tag {{content['view_status_class']}}" >
                {{content['ticket_status_name']}}
            </div>
            <div class="row clearfix">
                <div class="log-profile text-primary col-xs-6 no-padding">
                    <span>#</span>
                    <span>
                                            رقم الطلب :
                        {{content['ticket_number']}}
                                        </span>
                </div>

                <div class="log-profile text-primary col-xs-6 no-padding text-right">

                    <span>{{content['created_at']}}<span>
                            <span></span>
                </div>
            </div>
            <div class="row clearfix">
                <div class="divider log-title col-xs-12">
                    <b> بيانات العميل : </b>
                </div>
                <div class="  col-xs-4 form-group">
                    <b> اسم العميل : </b> {{content['client_name']}}
                </div>
                <div class="  col-xs-4 form-group">
                    <b>  رقم الهاتف :  </b> <a href="tel:01234567890">{{content['client_mobile']}}</a>
                </div>
                <div class="  col-xs-4 form-group">
                    <b>  العنوان : </b> {{content['client_address']}}
                </div>
                <div class="  col-xs-4 form-group">
                    <b> البريد الالكترونى : </b> <a href="mailto:a@gmail.com">{{content['client_mail']}}</a>
                </div>

                <div class="divider log-title col-xs-12">
                    <b> بيانات المنتج : </b>
                </div>
                <div class="  col-xs-4 form-group">
                    <b> تصنيف المنتج : </b>{{content['product_main_cat']}}
                </div>
                <div class="  col-xs-4 form-group">
                    <b>  نوع المنتج  :  </b>{{content['product_sub_cat']}}
                    <!-- here this info depends on the type of product-->
                </div>
                <div class="  col-xs-4 form-group">
                    <b>  سعة الخزان : </b> {{content['category_attribute_value']}}
                    <!-- here this info depends on the type of product-->
                </div>
                <div class="  col-xs-4 form-group text-danger">
                    <b>  نوع المشكلة  : </b> {{content['problem_name']}}
                </div>
                <div class="col-xs-4 form-group">
<!--                    <a type="button" href="" class="btn btn-xs btn-success" data-toggle="modal" data-target="#workerModal">-->
<!--                        <i class="fa fa-wrench" aria-hidden="true"></i>  تعيين عامل صيانة-->
<!--                    </a>-->
                </div>
                {%if(content['assigned_technician_id']!=0)%}
                <div class="  col-xs-4 form-group">
                    <b> عامل الصيانة المسؤال : </b>
                    {{content['assigned_technician_name']}}
                </div>
                {%endif%}

            </div>
        </div>

    </div>

    <!-- show only if there is a report

    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-file font-dark"></i>
            <span class="caption-subject bold uppercase"> التقرير الفني </span>
        </div>
    </div>
    -->

    <div class="portlet-body">
        <div class="row">

            <!-- put here the report-->

        </div>

<!--        <div class="col-md-12 col-xs-12 no-padding">-->
<!---->
<!--            <a type="button" href="" class="btn btn-md btn-info" data-toggle="modal" data-target="#reportModal">-->
<!--                <i class="fa fa-file" aria-hidden="true"></i>إضافة تقرير فني-->
<!--            </a>-->
<!---->
<!---->
<!---->
<!--        </div>-->
    </div>
    {%if(content["has_tech_report"]!= 0)%}
    {{ partial("requests/partials/tech_report") }}
    {%endif%}
    {{ javascript_include("js/printThis.js") }}
    <a class="btn btn-md btn-warning" id="print_ticket">
        <i class="fa fa-print"> </i> طباعة
    </a>
    <script>
        $("#print_ticket").click(function () {
            $(".portlet").printThis();
        });
    </script>
    <div id="workerModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <form method="post" action="{{url('maintenance_module/requests/assign_tech')}}" enctype="multipart/form-data">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title"> تعيين عامل صيانة</h4>
                </div>
                <div class="modal-body">

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label">  المنطقة  </label>
                                <select id="cities" name="city">
                                    <option>اختار منطقة :</option>
                                    {%for city in cities%}
                                    <option value="{{city.id}}">{{city.name}}</option>
                                    {%endfor%}
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label class=" control-label">  المدينة  </label>
                               <select id="filter_regions" name="filter_regions">

                               </select>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div id="branches_container">
                                    <label class=" control-label">  الفرع  </label>
                                    <select class=" form-control" name="order_branch" id="order_branch">

                                   </select>
                                </div>

                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group" id="tech_choose_container">
                                <label class="control-label"> اختر فني </label>
                                <select class="form-control" id="tech_choose" name="tech_choose">

                                </select>
                            </div>
                        </div>

                </div>
                <div class="modal-footer">
                    <input type="hidden" name="ticket_id" value="{{content['id']}}"/>
                    <button type="submit" class="btn btn-success">حفظ</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
                </div>
            </div>
            </form>

        </div>
        <script>
            $( document ).ready(function() {

            });
            var regions_url="{{url('maintenance_module/requests/getRegionsAjax/')}}";

            $("#cities").change(function() {
                var value = $(this).val();
                $("#filter_regions").html("");
                $("#order_branch").html("");
                $("#tech_choose").html("");
                $("#filter_regions").load(regions_url+value);

            });
            $("#filter_regions").change(function() {
                $("#order_branch").html("");
                $("#tech_choose").html("");
                var branches_url="{{url('maintenance_module/requests/branches_by_city_region/')}}";
                var filter_cities= $("#cities").val();
                var filter_regions = $("#filter_regions").val();
                $.ajax({
                    type: "POST",
                    url: branches_url,
                    data: {
                        "filter_cities": filter_cities,
                        "filter_regions": filter_regions
                    }, // serializes the form's elements.
                    success: function (response)
                    {

                        $("#branches_container").html(response);
                        //$('#collapse-clients-filter').collapse('toggle');
                    }
                });

            });

            $("#order_branch").change(function() {
                $("#tech_choose").html("");
                var value = $("#order_branch").val();
                alert("ssadasdd");
                var tech_url = "{{url('maintenance_module/requests/tech_by_branch/')}}";
                $("#tech_choose_container").load(tech_url+value);
            });



        </script>

    </div>

    <div id="reportModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">×</button>
                    <h4 class="modal-title"> إضافة تقرير فني </h4>
                </div>
                <form role="form" action="{{url('maintenance_module/requests/add_tech_report')}}" id="msg" enctype="multipart/form-data" method="post">

                <div class="modal-body">

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">سنة الصنع</label>
                                <input type="number" min="1900" class="form-control" name="manuf_year"/>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">رقم المنتج </label>
                                <input type="number" min="" class="form-control" name="product_number"/>
                            </div>
                        </div>

                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label"> سبب التركيب </label>
                                <input type="text" min="" class="form-control" name="install_reason"/>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label">حالة الضمان </label>
                                <div class="funkyradio col-xs-12 no-padding">
                                    <div class="col-xs-6">
                                        <div class="funkyradio-info">
                                            <input type="radio" name="in_wara" id="radio1" value="in_wara">
                                            <label for="radio1">داخل الضمان</label>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="funkyradio-info">
                                            <input type="radio" name="out_wara" id="radio2"  value="out_wara">
                                            <label for="radio2">خارج الضمان</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label"> ملاحظات  </label>
                                <textarea class="form-control" name="note"></textarea>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label"> الصور  </label>
                                <input type="file" class="form-control custom-file-input" multiple name="report_pics[]">
                            </div>
                        </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" name="ticket_id" value="{{content['id']}}" />
                    <input type="hidden" name="data_cms_id" value="{{content['data_cms_id']}}" />
                    <button type="submit" class="btn btn-success"> حفظ</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
                </div>
            </form>

            </div>

        </div>
    </div>




</div>