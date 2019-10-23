<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">

        <li>
            <span> أستبيان الزيارات </span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>
<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get("img")}}/banners/poll.png') center center no-repeat ; background-size: contain"></div>
    </div>
</div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-file" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase">
                                أستبيان عميل
                          </span>
        </div>
    </div>
    <div class="portlet-body">
        <div class="col-md-10 col-sm-9 col-xs-8 no-padding">

            <div class="panel">
                <div class="panel-body">
                    <div class=" col-md-6 col-xs-12 no-padding ">
                        <div class="col-lg-4 col-xs-6 bold">الهاتف </div>
                        <div class="col-lg-3 col-xs-3 text-info bold">
                            {{client.Mobile}}
                        </div>
                    </div>

                    <div class="form-group col-md-6 col-xs-12 no-padding">
                        <div class="col-lg-4 col-xs-6 bold">تاريخ الميلاد :</div>
                        <div class="col-lg-8 col-xs-6">
                            {% if client_data is defined and client_data.birthdate != null and client_data.birthdate|length > 0 %}
                            <?php echo date('d/m/Y', $client_data->birthdate); ?>
                            {% endif %}
                        </div>
                    </div>
                    <div class="form-group col-md-6 col-xs-12 no-padding">
                        <div class="col-lg-4 col-xs-6 bold">النوع :</div>
                        <div class="col-lg-8 col-xs-6">
                            {% if client_data is defined %}
                            {% if client_data.gender_id == 1 %}
                            ذكر
                            {% elseif client_data.gender_id == 2 %}
                            أنثى
                            {% endif %}
                            {% endif %}
                        </div>
                    </div>
                    <div class="form-group col-md-6 col-xs-12 no-padding">
                        <div class="col-lg-4 col-xs-6 bold">البريد الالكترونى :</div>
                        <div class="col-lg-8 col-xs-6">
                            <div class="col-lg-6 col-xs-6">
                                <a href="mailto:{{client.Mail}}">{{client.Mail}}</a>
                            </div>
                            <div class="col-lg-3 col-xs-6 pull-right">
                                {% if client.Active == 1 %}
                                <span class="text-info bold">Active</span>
                                {% elseif client.Active == 0 %}
                                <span class="text-danger bold">Inactive</span>
                                {% endif %}
                            </div>
                        </div>
                    </div>


                    <div class=" col-md-6 col-xs-12 no-padding ">
                        <div class="col-lg-4 col-xs-6 bold">تصنيف العميل : </div>
                        <div class="col-lg-3 col-xs-3 text-info bold">
                            {% if client.category %}
                            {{client.category.name}}
                            {% endif %}
                        </div>
                       </div>

                    <div class=" col-md-6 col-xs-12 no-padding ">
                        <div class="col-lg-4 col-xs-6 bold">الاسم </div>
                        <div class="col-lg-3 col-xs-3 text-info bold">
                            {{client.Title}}
                        </div>
                    </div>



                </div>
            </div>
        </div>
        <div class="clearfix"></div>

        <div class="panel">
            <div class="panel-body">
                <div class=" col-md-6 col-xs-12 no-padding ">
                    <div class="col-lg-4 col-xs-6 bold">نوع الزيارة</div>
                    <div class="col-lg-3 col-xs-3 text-info bold">
                        {{visit.missionType.name_ar}}
                    </div>
                </div>

                <div class="form-group col-md-6 col-xs-12 no-padding">
                    <div class="col-lg-4 col-xs-6 bold">تاريخ الزياره :</div>
                    <div class="col-lg-8 col-xs-6">
                        <?php echo date('d/m/Y', $visit->date); ?>
                    </div>
                </div>
                <div class="form-group col-md-6 col-xs-12 no-padding">
                    <div class="col-lg-4 col-xs-6 bold">المندوب صاحب الزياره :</div>
                    <div class="col-lg-8 col-xs-6">
                        {{visit.salesPerson.Title}}
                    </div>
                </div>
                <div class="form-group col-md-12 no-padding">
                    <div class="col-md-12  bold">ملاحظات الزيارة</div>
                    <div class="col-md-12 ">
                        {{visit.representitve_comment}}
                    </div>
                </div>






            </div>
        </div>
        <div class="clearfix"></div>

        <hr>

        <div id="poll_choose">

        </div>

        <hr>
        <form method="post" action="{{this.url_shared.get('polls_module/polls/create_poll_user')}}">

            <div id="poll_details">

            </div>

            <div class="col-sm-12">
                <input type="hidden" name="client_id" id="client_val" value="{{client.ID}}" />
                <input type="hidden" name="visit_id" id="visit_id" value="{{visit.id}}" />
                <input type="hidden" name="poll_id" id="poll_val" />
                <button type="submit" class="btn btn-success">  إستبيان العميل المختار  </button>
                <!--                <button type="reset" class="btn dark">إلغاء</button>-->


            </div>
        </form>
    </div> <!-- end portlet-->




</div>


<script>

    var polls_url= "{{this.url_shared.get('polls_module/polls/polls_table')}}";
    $("#poll_choose").load(polls_url);



</script>