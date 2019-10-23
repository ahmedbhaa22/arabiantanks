<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="#"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <a href="{{url('maintenance_module/index')}}">
                <span>الصيانة</span>
            </a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <a href="{{url('maintenance_module/requests/index')}}">
                <span> طلبات الصيانة</span>
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

<form method="post" action="{{url('maintenance_module/requests/saveRequest')}}" enctype="multipart/form-data">
    <div class="portlet light clearfix">

        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-ticket font-dark"></i>
                <span class="caption-subject bold uppercase"> تعديل التذكرة</span>
            </div>
        </div>
        <div class="portlet-body">
            <div class="row"><p><?php $this->flashSession->output() ?></p></div>
            <div class="row clearfix">
                <div class="bold">
                    <b> تغيير حالة الطلب</b>
                </div>
                {%for problem_status in problem_statuses%}
                {%if(problem_status.id==8)%}
                <?php
                if(!array_key_exists(1,$user_rules) && !array_key_exists(5,$user_rules)){
                    continue;
                }
                ?>
                {%endif%}
                <div class="col-md-2 col-sm-3 col-xs-4 nopadding-r">
                    {{ radio_field('problem_status', "id":"icon"~problem_status.id,"class":"icon","value":problem_status.id) }}
<!--                    <input type="radio" name="icon" class="icon" id="icon{{problem_status.id}}">-->
                    <label for="icon{{problem_status.id}}">	{{problem_status.status_name}} </label>
                </div>
                {%endfor%}

            </div>

            <div class="one-log one-ticket no-padding gap">
                <div class="row clearfix">
                    <div class="log-profile text-info col-xs-6 no-padding">
                        <span>#</span>
                        <span>
                                                رقم الطلب :
                            {{content["ticket_number"]}}
                                            </span>
                    </div>

                    <div class="log-profile text-info col-xs-6 no-padding text-right">
                        <span>26/2/2017</span>
                        <span>
                                                11:45 am
                                            </span>
                    </div>
                </div>
                <div class>
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

                    <div class="divider log-title col-xs-12 text-info"> بيانات المنتج
                    </div>
                    <div id="product-information" class="row">
                    <div class="col-xs-4 form-group">
                        <label class="control-label"> تصنيف المنتج </label>

                            {%for item in main_cats['items']%}
                            {% set selected =""%}
                            {%if(content['product_main_cat_id']==item['ID'])%}
                        {{item['Title']}}
                            {%endif%}
                            {%endfor%}



                    </div>
                    <div class=" col-xs-4 form-group">
                        <label class="control-label">  نوع المنتج   </label>
                        {{content['product_sub_cat']}}


                    </div>

                    <div class="col-xs-4 form-group">
                        <label class="control-label">  نوع المشكلة  </label>

                        {{content['problem_name']}}
                    </div>

                        <div class="row"></div>

                    <div class="col-xs-4 form-group">

                        <div id="products_container">
                            <label>{{translate._("Product")}}</label>
                            {{content['product_name']}}

                        </div>

                    </div>

                        <div class="col-xs-4 form-group">

                            <div id="capacity_container">


                            </div>

                        </div>

                    </div>

                    

                    {%if(ticket_status_id==1)%}
                    {% set display="none"%}
                    {%else%}
                    {% set display="block"%}
                    {%endif%}

                    <div id="maintenance_person_container" style="display: {{display}}">
                        <div class="divider log-title col-xs-12 text-info"> اختار عامل الصيانة
                        </div>
                        <div class="col-sm-12">
                            {{ select('maintenace_persons', maintenace_persons,
                            'useEmpty': true, 'emptyValue': '0') }}
                        </div>
                    </div>



                    
                    {%if(ticket_status_id==1 or ticket_status_id==2 or ticket_status_id==4)%}
                    {% set display="none"%}
                    {%else%}
                    {% set display="block"%}
                    {%endif%}
                    <div class="divider gap col-xs-6" id="next_act_conatiner" style="display:{{display}}">
                        <label class="control-label"> تعديل تاريخ الزيارة القادمه  </label>
                        {{date_field('next_activation_date','class':'form-control')}}
                    </div>
                    

                    <!-- this section will be in the Pending case only-->
                    {%if(ticket_status_id==1 or ticket_status_id==2)%}
                    {% set display="none"%}
                    {%else%}
                    {% set display="block"%}
                    {%endif%}
                    <div class="divider gap col-xs-6" id="pend_reas_container" style="display: {{display}}">
                        <label class="control-label"> اختر سبب تعليق الطلب : </label>
                        {{ select('pending_reason', pending_reasons, 'using': ['id', 'title'],
                        'useEmpty': true, 'emptyValue': '0') }}
                    </div>

                    <?php if(array_key_exists(1,$user_rules) || array_key_exists(5,$user_rules)):?>
                    <div class="divider gap col-xs-6" id="exchange_reasons_container" style="display: {{display}}">
                        <label class="control-label"> حالة التعميد : </label>
                        {{ select('exchange_reasons', exchange_reasons, 'using': ['id', 'title'],
                        'useEmpty': true, 'emptyValue': '0') }}
                    </div>
                    <?php endif; ?>





                    {%if(ticket_status_id==1)%}
                    {% set display="none"%}
                    {%else%}
                    {% set display="block"%}
                    {%endif%}
                    <div class="divider gap col-xs-6" id="visit_date_container" style="display: {{display}};">
                        <label class="control-label">تاريخ الزيارة</label>
                        {{date_field('visit_date','class':'form-control')}}
                    </div>




                </div>
            </div>
        </div>


        <div class="portlet-body">
            <div class="row">




            </div>

            <div class="col-md-12 col-xs-12 no-padding">
                <input type="hidden" name="<?php echo $this->security->getTokenKey() ?>"
                       value="<?php echo $this->security->getToken() ?>"/>
                <input type="hidden" name="ticket_id"
                       value="{{content['id']}}"/>
                <button type="submit" class="btn btn-md btn-primary">
                    <i class="fa fa-save"></i>حفظ
                </button>

            </div>
        </div>

    </div>
</form>


<div class="portlet light clearfix">

<div class="portlet-body">
    <div class="row">

        <!-- put here the report-->

    </div>

    <div class="col-md-12 col-xs-12 no-padding">

        <a type="button" href="" class="btn btn-md btn-info" data-toggle="modal" data-target="#reportModal">
            <i class="fa fa-file" aria-hidden="true"></i>إضافة تقرير فني
        </a>



    </div>
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
                            <label>حالة الطلب</label>
                            <select name="request_status" class="form-control">
                                {%for problem_status in problem_statuses%}
                                {%if(problem_status.id==8)%}
                                {%continue%}
                                {%endif%}
                                <option value="{{problem_status.id}}">{{problem_status.status_name}}</option>
                                {%endfor%}
                            </select>

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

<script>

    var product_type_url="{{url('maintenance_module/problems/product_type/')}}";
    $( document ).ready(function() {
        $("#main_dept").change(function() {
            var value = $(this).val();
            $("#product_type").load(product_type_url+value);
            var product_type = $("#main_dept option:selected").text();
            $("#capacity_container").html("");
            $("#products_container").html("");
           $("#problems_in_cat").html("");

        });


        $("#product_type").change(function() {
            $("#products_container").html("");
            $("#problems_in_cat").html("");
            var dept_id=$(this).val();
            var products_url ="{{url('maintenance_module/problems/products_in_cat/')}}"+dept_id;
            $("#products_container").load(products_url);
            var capacity_url="{{url('maintenance_module/problems/product_capacity/')}}";
            var value = $(this).val();
            $("#capacity_container").load(capacity_url+value);

            var tank_type = $("#product_type option:selected").text();
            $('#revise_tank_type').text(tank_type);
        });


    });



// For Status :

    $("input[name='problem_status']").change(function(){
        selected_value = $("input[name='problem_status']:checked").val();
        if(selected_value == 2){
            $("#next_act_conatiner").hide();
            $("#maintenance_person_container").show();
            $("#visit_date_container").show();
            $("#install_status_container").hide();
            $("#pending_reas_conatiner").hide();
        }
        else if(selected_value == 4){
            $("#next_act_conatiner").hide();
            $("#maintenance_person_container").show();
            $("#visit_date_container").show();
            $("#install_status_container").show();
            $("#pend_reas_container").show();
        }
        else if(selected_value == 1){
            $("#next_act_conatiner").hide();
            $("#maintenance_person_container").hide();
            $("#visit_date_container").hide();
            $("#install_status_container").hide();
            $("#pend_reas_container").hide();
        }
        else{
            $("#maintenance_person_container").show();
            $("#visit_date_container").show();
            $("#install_status_container").show();
            $("#pend_reas_container").show();
            $("#next_act_conatiner").show();
        }
    });

</script>

