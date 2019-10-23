<div class="">
       <div class="page-bar " style="position: relative">
         <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <a href="{{url('content/main/8')}}"><span> المنتجات </span></a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <a href="{{url('sales/index')}}"><span>المبيعات</span></a>
            <i class="fa fa-angle-left"></i>
        </li>
		<li>
			<a href="{{url('sales_visits/index')}}"><span>الزيارات</span></a>
                    <i class="fa fa-angle-left"></i>
		</li>
		<li>
			<span>تفاصيل الزيارة</span>
		</li>
            </ul>
      </div>
      <div class="clearfix"></div>

      <div class="col-lg-12">
          <div class="row">
              <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                  <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner.png')}}') center center no-repeat ; background-size: contain"></div>
              </div>
          </div>
      </div> <div class="portlet light clearfix">
        <div class="portlet-title">
              <div class="caption font-dark">
                  <h4 class="caption-subject bold uppercase">
			<i class="fa fa-user" aria-hidden="true"></i>
                    تفاصيل الزيارة
                  </h4>
              </div>

            <div class="actions">


              </div>
          </div>
	<div class="portlet-body">
	<div class="col-xs-12 no-padding ">
		<div class="col-xs-12 no-padding ">
                    <div class="profile-userpic col-md-2 col-sm-3 col-xs-4 no-padding">
                              <img src="{{url.getStatic('uploads/users/'~visit.client.Img)}}" class="img-responsive" alt="">
                              {% if visit.client.Active == 1%}
                                <h5 class="text-center bold"><i class="fa fa-check-circle-o text-success"></i> مفعل </h5>
                              {% else %}
                                 <h5 class="text-center bold"><i class="fa fa-times text-danger"></i>غير مفعل </h5>
                              {% endif %}
                        </div>

                    <div class="col-md-10 col-sm-9 col-xs-8 no-padding">

                     <div class="panel">
                         <div class="panel-body">

                                <div class="form-group col-md-6 col-xs-12 no-padding">
                                    <div class="col-lg-4 col-xs-6 bold">تاريخ الزيارة :</div>
                                    <div class="col-lg-8 col-xs-6">{{visit.formattedDate('d/m/Y')}}</div>
                                </div>
                                <div class="form-group col-md-6 col-xs-12 no-padding">
                                    <div class="col-lg-4 col-xs-6 bold">نوع المهمة :</div>
                                    <div class="col-lg-8 col-xs-6">{{visit.missionType.name_ar}}</div>
                                </div>
                                <div class="form-group col-md-6 col-xs-12 no-padding">
                                    <div class="col-lg-4 col-xs-6 bold">اسم العميل :</div>
                                    <div class="col-lg-8 col-xs-6">{{visit.client.Title}}</div>
                                </div>
                                <div class="form-group col-md-6 col-xs-12 no-padding">
                                    <div class="col-lg-4 col-xs-6 bold">عنوان العميل :</div>
                                    <div class="col-lg-8 col-xs-6">
                                      {% if visit.client.mainAddress != null %}
                                        {{visit.client.mainAddress.details}}
                                      {% endif %}
                                    </div>
                                </div>
                                <div class="form-group col-md-6 col-xs-12 no-padding">
                                    <div class="col-lg-4 col-xs-6 bold">البريد الالكترونى :</div>
                                    <div class="col-lg-8 col-xs-6"><a href="mailto:{{visit.client.Mail}}">{{visit.client.Mail}}</a></div>
                                </div>

                                <div class=" col-md-6 col-xs-12 no-padding ">
                                    <div class="col-lg-4 col-xs-6 bold">تصنيف العميل : </div>
                                    <div class="col-lg-8 col-xs-3 text-info bold">
                                      {% if visit.client.category != null %}
                                        {{visit.client.category.name}}
                                      {% endif %}
                                    </div>
                                </div>
                        </div>
			</div>
		</div>
		<div class="panel clearfix">
		<div class="panel-heading">ملاحظات المندوب :</div>
         <div class="panel-body">{{visit.representitve_comment}}</div>
	</div>
    </div>
</div>
        </div>
</div>