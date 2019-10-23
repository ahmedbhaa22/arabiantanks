{{ stylesheet_link('css/bootstrap-tagsinput.css') }}
{{ javascript_include("js/bootstrap-tagsinput.min.js") }}
<div class="">
<div class="page-bar " style="position: relative">
<ul class="page-breadcrumb">
<li>
<i class="fa fa-home" aria-hidden="true"></i>
<a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
<i class="fa fa-angle-left" aria-hidden="true"></i>
</li>
<li>
<a href="{{url('content/main/8')}}"><span> المنتجات </span></a>
<i class="fa fa-angle-left" aria-hidden="true"></i>
</li>
<li>
<a href="{{url('content/productsList')}}"><span> محتوى المنتجات </span></a>
<i class="fa fa-angle-left" aria-hidden="true"></i>
</li>
<li>
<a href="{{url('content/productsList')}}"><span> المنتجات </span></a>
<i class="fa fa-angle-left" aria-hidden="true"></i>
</li>
<li>
<span>مشاهدة تفاصيل منتج</span>
</li>
</ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
<div class="row">
<div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
<div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('img/banners/banner-product.png')}}') center center no-repeat ; background-size: contain"></div>
</div>
</div>
</div>
<div class="portlet light clearfix">
<div class="portlet-title">
<div class="caption font-dark">
    <i class="fa fa-shopping-cart font-dark"></i>
    <span class="caption-subject bold uppercase"> {{product.Title}}
    </span>
    <small class="text-center text-info"> تاريخ الإضافة {{product.getDate() }}</small>
  </div>

<div class="actions">
    <button id="delete_product" class="btn btn-danger">
            <span aria-hidden="true" class="fa fa-trash"></span>
            حذف المنتج
    </button>
    <!--
    <a type="button" class="btn btn-edit-my-data green-jungle btn-block " href=".static" data-toggle="modal" style="display: inline">
        <span aria-hidden="true" class="icon-note"></span>
        تعديل بيانات المنتج
    </a>
-->
</div>


</div>
<div class="portlet-body">

<div class="col-lg-3 col-md-3 col-sm-4 col-xs-12 text-center">
<div id="myCarousel" class="carousel slide" data-ride="carousel">
<!-- Indicators -->
<ol class="carousel-indicators">
  <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
  <li data-target="#myCarousel" data-slide-to="1"></li>
</ol>
<!-- Wrapper for slides -->
<div class="carousel-inner">
  <div class="item active">
      <div class="img-holder img-thumbnail" style="height:215px; width: 100%; max-height: 215px; overflow: hidden ; background: url('{{url.getStatic('uploads/'~product.Img)}}') center center no-repeat ; background-size: cover"></div>
    
  </div>
  {% for img in product.images %}
      <divclass="item">
            <div class="img-holder img-thumbnail" style="height:215px; width: 100%; max-height: 215px; overflow: hidden ; background: url('{{url.getStatic('uploads/'~img.Img)}}') center center no-repeat ; background-size: cover"></div>
      </div>
  {% endfor %}
  
</div>
</div>
<span class="stars" data-rating="1" data-num-stars="5"></span>
</div>
<div class="col-lg-9 col-md-9 col-sm-8  col-xs-12">
<table class="table table-bordered">
<tbody>
    <tr>
        <td>تفعيل المنتج</td>
        <td class="funkyradio">
            <div class="funkyradio-success">
                <input disabled type="checkbox" name="checkbox" id="checkbox1" {% if product.Active == 1%}
                            checked
                            {% endif %} />
                <label for="checkbox1"> مفعل</label>
            </div>
        </td>
    </tr>
<!--
    <tr>
        <td> يظهر في المتجر </td>
        <td class="funkyradio">
            <div class="funkyradio-success">
                <input type="checkbox" name="checkbox" id="checkbox2"  />
                <label for="checkbox2"> إظهار</label>
            </div>
        </td>
    </tr>
-->
    <tr>
        <td>سعر المنتج </td>
        <td> <strike> {{product.extraFields.old_price}} ريال سعودي</strike> <span class="text-danger"> {{product.extraFields.price}} ريال سعودي </span> </td>
    </tr>
    <tr>
        <td>شركة التصنيع</td>
        <td>
            {% for manfct in product.manufacturers %}
            <a href="#" >{{manfct.Title}} , </a>
            {% endfor %}
        </td>
    </tr>
    <tr>
        <td>وصف المنتج</td>
        <td>{{product.Des}}</td>
    </tr>
	<tr>
        <td> تاجات المنتج</td>
        <td>
			<div class="col-xs-9 no-padding">
				{% for ptag in product.tags %}
                    <span class="label label-info">{{ptag.name}}</span>
                {% endfor %}
			</div>
			<div class="col-xs-3 no-padding">
				<a type="button" href="" class="btn btn-xs btn-success pull-right" data-toggle="modal" data-target="#tagModal">
					<i class="fa fa-plus" aria-hidden="true"></i> إضافة تاجات
				  </a>
			</div>
		</td>
    </tr>
    <tr>
        <td> الكمية المسموحة للعميل <br>  لطلب الشراء الواحد </td>
        <td>
			<div class="col-xs-9 no-padding">
				{{product.extraFields.maximum_in_cart}}
			</div>
			<div class="col-xs-3 no-padding">
				<a type="button" href="" class="btn btn-xs btn-success pull-right" data-toggle="modal" data-target="#numModal">
					<i class="fa fa-edit" aria-hidden="true"></i> تعديل
				  </a>
			</div>
		</td>
    </tr>
</tbody>
</table>
</div>

<div class="  col-xs-12 gap widget-cont no-padding">

<div class="col-lg-3 col-sm-4 col-xs-6">
<!-- START widget-->
<div class="panel widget bg-gray">
    <div class="row row-table">
        <div class="col-xs-2 text-center bg-gray-dark pv-lg">
            <i class="fa fa-money fa-2x"></i>
        </div>
        <div class="col-xs-12 pv-lg">
            <div class="h2 mt0">{{product.purchaseNumber()}}</div>
            <div class="text-uppercase"> عدد مرات شراء المنتج </div>
        </div>
    </div>
</div>
</div>
<div class="col-lg-3 col-sm-4 col-xs-6">
<!-- START widget-->
<div class="panel widget bg-gray">
    <div class="row row-table">
        <div class="col-xs-2 text-center bg-gray-dark pv-lg">
            <i class="fa fa-wrench fa-2x"></i>
        </div>
        <div class="col-xs-12 pv-lg">
            <div class="h2 mt0">
                {% if product.maintenanceTickets != null %}
                    {{product.maintenanceTickets|length}}
                {% else %}
                    0
                {% endif %}
            </div>
            <div class="text-uppercase"> عدد طلبات الصيانة للمنتج </div>
        </div>
    </div>
</div>
</div>
<div class="col-lg-3 col-sm-4 col-xs-6">
<!-- START widget-->
<div class="panel widget bg-gray">
    <div class="row row-table">
        <div class="col-xs-2 text-center bg-gray-dark pv-lg">
            <i class="fa fa-exchange fa-2x"></i>
        </div>
        <div class="col-xs-12 pv-lg">
            <div class="h2 mt0">
                {% if product.replaceTickets != null %}
                    {{product.replaceTickets|length}}
                {% else %}
                    0
                {% endif %}
            </div>
            <div class="text-uppercase"> عدد طلبات الإستبدال للمنتج </div>
        </div>
    </div>
</div>
</div>
<!-- START widget-->
<!-- <div class="col-lg-3 col-sm-4 col-xs-6">
<div class="panel widget bg-gray">
    <div class="row row-table">
        <div class="col-xs-2 text-center bg-gray-dark pv-lg">
            <i class="fa fa-exchange fa-2x"></i>
        </div>
        <div class="col-xs-12 pv-lg">
            <div class="h2 mt0">{{product.returnedNumber()}}</div>
            <div class="text-uppercase"> عدد طلبات الإرجاع للمنتج </div>
        </div>
    </div>
</div>
</div> -->


</div>

</div>
</div>

<div class="portlet light clearfix">
<div class="portlet-title">
<div class="caption font-dark">
<i class="fa fa-shopping-cart font-dark"></i>
<span class="caption-subject bold uppercase"> معلومات عن المنتج
</span>
</div>
</div>
<div class="portlet-body">
<ul class="nav nav-tabs ">
<li class="active"><a data-toggle="tab" href="#offers"> عروض على المنتج  </a></li>
<li class=""><a data-toggle="tab" href="#discounts"> خصومات على المنتج  </a></li>
<li class=""><a data-toggle="tab" href="#maintenance"> طلبات الصيانة </a></li>
<li class=""><a data-toggle="tab" href="#exchange"> طلبات الإستبدال </a></li>
<!-- <li class=""><a data-toggle="tab" href="#return"> طلبات الإرجاع   </a></li> -->
<li class=""><a data-toggle="tab" href="#seo">  إعدادات SEO </a></li>
</ul>
<div class="tab-content col-md-12 no-padding">
<div id="offers" class="tab-pane fade in active">
<div class="panel panel-success">
<div class="panel-heading">
    <div class="panel-title">
        إضافة عرض للمنتج
    </div>
</div>
<div class="panel-body">
	<div class="row">
		<form role="form" action="{{url('content/addProductToOffer')}}" method="post" enctype="multipart/form-data">
            <input type="hidden" name="product_id" value="{{product.ID}}">
			<div class="col-sm-3">
				<div class="form-group">
					<label class=" control-label"> اسم العرض</label>
                    <select class="form-control" name="offer_id">
                        {% for offer in offers %}
                            <option value="{{offer.id}}">{{offer.name}}</option>
                        {% endfor %}
                    </select>
				</div>
			</div>

			
			<div class="col-sm-12">
				<button type="submit" class="btn btn-primary">إضافة المنتج في العرض </button>
			</div>
	</form>
	</div>

</div>
</div>

<div class="panel panel-default">
<div class="panel-heading">
    <div class="panel-title">
        عروض سابقة على المنتج
    </div>
</div>
<div class="panel-body" id="offers_filter_container">
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
					<!-- <form role="form" method="post" action="{{url('content/filterProductOffers')}}" enctype="multipart/form-data"> -->
                        <!-- <input type="hidden" name="product_id" value="{{product.ID}}"> -->
						<div class="row">
							<div class="col-sm-3">
								<div class="form-group">
									<label class=" control-label"> اسم العرض</label>
									<input id="offer_name" name="offer_name" type="text" class="form-control">
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label class=" control-label"> منطقة تطبيق العرض</label>
									<select id="offer_region" name="offer_region" class="form-control">
                                        <option></option>
											{% for region in regions %}
                                            <option value="{{region.id}}">{{region.name}}</option>
                                            {% endfor %}
									</select>
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label class=" control-label"> تاريخ تطبيق للعرض من</label>
									<input id="offer_from" name="offer_from" type="date" class="form-control">
								</div>
							</div>
							<div class="col-sm-3">
								<div class="form-group">
									<label class=" control-label"> الى</label>
									<input id="offer_to" name="offer_to" type="date" class="form-control">
								</div>
							</div>

						</div>
						<button type="button" data-product_id="{{product.ID}}" id="filter_product_offers" class="btn btn-primary">فلتر</button>
					<!-- </form> -->
				</div>
			</div>
		</div>
	</div>
    <div id="offers_table_container">
<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
        <thead>
            <tr>
                <th>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="group-checkable"
                               data-set="#sample_1 .checkboxes"/>
                        <span></span>
                    </label>
                </th>
                <th> ID</th>
                <th>اسم العرض</th>
                <th> منطقة تطبيق العرض </th>
                <th>مدة العرض</th>
                <th>وصف العرض</th>
                <th>رابط العرض</th>
                <th>الاجراءات</th>
            </tr>
        </thead>
        <tbody>
            {% if product_offers != null and product_offers|length > 0 %}
                {% for poffer in product_offers %}
                <tr class="odd gradeX">
                <td>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" class="checkboxes" value="{{offer.id}}"/>
                            <span></span>
                        </label>
                </td>
                <td>{{poffer.id}}</td>
                <td>{{poffer.name}}</td>
                <td>
                    {% for region in poffer.regions %}
                    {{region.name}} , 
                    {% endfor %}
                </td>
                <td style="text-align:left;">
                    {% for type in poffer.types %}
                        {% if type.id == 1%}
                        {{type.name}} <br>
                        {% else %}
                        {{type.name ~ poffer.getStartEndDates()}}
                        {% endif %}
                    {% endfor %}
                </td>
                <td>{{offer.description}}</td>
                <td>
                    <a href="{{url.getStatic('offers_module/index/new/'~poffer.id)}}" class="btn btn-xs btn-info">   رابط العرض</a>
                </td>
                <td>
                    <a href="{{url.getStatic('offers_module/index/new/'~poffer.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                    <a href="{{url.getStatic('offers_module/index/edit/'~poffer.id)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                    <button data-offer_id="{{poffer.id}}" class="delete_offer btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                </td>
            </tr>
            {% endfor %}
            {% endif %}
        </tbody>
    </table>
    </div>
</div>
</div>
</div><!-- end of offers-->

<div id="discounts" class="tab-pane fade in">
<div class="panel panel-success">
<div class="panel-heading">
    <div class="panel-title">
        إضافة خصم للمنتج
    </div>
</div>
<div class="panel-body">
	<div class="row">
        <form role="form" action="{{url('content/addProductToDiscount')}}" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="product_id" value="{{product.ID}}">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">اسم الخصم</label>
                                <input name="discount_name" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="col-xs-12 no-padding control-label"> النسبة المئوية</label>
                                <div class="col-xs-8 no-padding">
                                    <input name="discount_percent" type="text" class="form-control">
                                </div>
                                <div class="col-xs-2"> % </div>
                            </div>
                        </div>
                        <!-- <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">مبلغ الخصم </label>
                                <input type="text" class="form-control">
                            </div>
                        </div> -->
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> كود الكوبون </label>
                                <input name="discount_coupon" type="text" class="form-control">
                            </div>
                        </div>
                        
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> تاريخ البدء </label>
                                <input name="discount_start_date" type="date" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> تاريخ النهاية</label>
                                <input name="discount_end_date" type="date" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <button type="submit" class="btn btn-success"> اضافة الخصم للمنتج  </button>
                    </div>
            </form>
	</div>
</div>
</div>

<div class="panel panel-default">
<div class="panel-heading">
    <div class="panel-title">
        خصومات سابقة على المنتج
    </div>
</div>
<div class="panel-body">
	<div class="panel-group accordion" id="accordion1">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#discounts-filter">
                      <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                    </a>
                </h4>
            </div>
            <div id="discounts-filter" class="panel-collapse collapse">
                <div class="panel-body">
                    <!-- <form role="form" method="post" action="{{url('content/filterProductDiscounts')}}" enctype="multipart/form-data"> -->
                        <div class="row">
                            <input type="hidden" name="product_id" value="{{product.ID}}">
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class=" control-label">اسم الخصم</label>
                                    <input id="discount_name" type="text" class="form-control">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class="col-xs-12 no-padding control-label"> النسبة المئوية</label>
                                    <div class="col-xs-8 no-padding">
                                        <input id="discount_percent" type="text" class="form-control">
                                    </div>
                                    <div class="col-xs-2"> % </div>
                                </div>
                            </div>
                           <!--  <div class="col-sm-3">
                                <div class="form-group">
                                    <label class=" control-label">مبلغ الخصم </label>
                                    <input type="text" class="form-control">
                                </div>
                            </div> -->
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class=" control-label"> كود الكوبون </label>
                                    <input id="discount_coupon" type="text" class="form-control">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class=" control-label"> تاريخ البدء </label>
                                    <input id="start_date" type="date" class="form-control">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group">
                                    <label class=" control-label"> تاريخ النهاية</label>
                                    <input id="end_date" type="date" class="form-control">
                                </div>
                            </div>
                        </div>
                        <button id="filter_discounts" type="button" class="btn btn-primary">فلتر</button>
                    <!-- </form> -->
                </div>
            </div>
        </div>
    </div>
    <div id="discounts_table_container">
        <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_2">
        <thead>
            <tr>
                <th>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="group-checkable"
                               data-set="#sample_2 .checkboxes"/>
                        <span></span>
                    </label>
                </th>
                <th> ID</th>
                <th>اسم الخصم</th>
                <th> النسبة المئوية </th>
                <th>كود الكوبون</th>
                <th>تاريخ البدء </th>
                <th>تاريخ الإنتهاء</th>
                <th> عدد المنتجات تم تطبيق عليها الخصم </th>
                <th>الاجراءات</th>
            </tr>
        </thead>
        <tbody>
            {% for discount in product.discounts %}
                <tr class="odd gradeX">
                <td>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" class="checkboxes" value="{{discount.id}}"/>
                            <span></span>
                        </label>
                </td>
                <td>{{discount.id}}</td>
                <td>{{discount.name}}</td>
                <td>{{discount.percentage}}%</td>
                <td>{{discount.coupon}}</td>
                <td>{{discount.getStartDate()}}</td>
                <td>{{discount.getEndDate()}}</td>
                <td>{{discount.products.count()}}</td>
                <td>
                    <a href="{{url.getStatic('discounts_module/index/view/'~discount.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                    <a href="{{url.getStatic('discounts_module/index/edit/'~discount.id)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                    <button data-discount_id="{{discount.id}}" class="delete_discount btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                </td>
            </tr>
            {% endfor %}
        </tbody>
    </table>
    </div>
</div>
</div>
</div><!-- end of discounts-->

<div id="maintenance" class="tab-pane fade in">
<!-- <div class="panel-group accordion" id="accordion1">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h4 class="panel-title">
				<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#total-filter">
					  <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
					</a>
			</h4>
		</div>
		<div id="total-filter" class="panel-collapse collapse">
			<div class="panel-body">
				<form role="form">
					<div class="row">
						<div class="col-sm-2">
							<div class="form-group">
								<label class=" control-label">  رقم الطلب </label>
								<input type="number" class="form-control" min="1">
							</div>
						</div>
						<div class="col-sm-2">
							<div class="form-group">
								<label class=" control-label">تاريخ من</label>
								<input type="date" class="form-control">
							</div>
						</div>
						<div class="col-sm-2">
							<div class="form-group">
								<label class=" control-label">تاريخ الى</label>
								<input type="date" class="form-control">
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class=" control-label"> حالة الطلب </label>
								<select class="form-control">
                                    <option></option>
                                    {% for status in ticket_statuses %}
                                        <option value="{{status.id}}">{{status.status_name}}</option>
                                    {% endfor %}
								</select>
							</div>
						</div>

						<div class="col-sm-3">
							<div class="form-group">
								<label class=" control-label"> اسم العميل  </label>
								<input type="text" class="form-control">
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class=" control-label">  تليفون  </label>
								<input type="number" class="form-control" min="1">
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class=" control-label">  العنوان  </label>
								<input type="text" class="form-control">
							</div>
						</div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class=" control-label"> الصياانة المطلوبة </label>
								<select class=" form-control">
									<option selected="selected" value=""></option>
									<option value="22">طحالب -فطريات</option>
									<option value="1">تشقق </option>
									<option value="4">تسريب في نبل نحاس ١ بوصه داخلي</option>
									<option value="5">تسريب في نبل نحاس ٢ بوصه داخلي</option>
									<option value="6">تسريب في نبل نحاس ٣ بوصه داخلي</option>
									<option value="7">تسريب في نبل نحاس ١ بوصه خارجي</option>
									<option value="8">تسريب في نبل نحاس ٢ بوصه خارجي</option>
									<option value="9">تسريب في نبل نحاس٣  بوصه خارجي</option>
									<option value="10">تسريب في نبل بلاستيك ١ بوصه خارجي</option>
									<option value="11">تسريب في نبل بلاستيك ٢ بوصه خارجي</option>
									<option value="12">تسريب في نبل بلاستيك ٣ بوصه خارجي</option>
									<option value="13">تسريب في نبل بلاستيك ١ بوصه داخلي</option>
									<option value="14">تسريب في نبل بلاستيك ٢ بوصه داخلي</option>
									<option value="15">تسريب في نبل بلاستيك٣ بوصه داخلي</option>
									<option value="18">قاعدة الخزان</option>
									<option value="19">غطاء الخزان لا يركب</option>
									<option value="16">تسريب في وصله خزان الدفان</option>
									<option value="17">صداء في البراغي او الفلنجه</option>
								</select>
							</div>
						</div>
					</div>
					<button class="btn btn-primary">فلتر</button>
				</form>
			</div>
		</div>
	</div>
</div> -->

<div class="col-xs-12 no-padding space">
	 <table class="table table-striped table-bordered table-hover table-checkable order-column table-condensed" id="sample_3">
		<thead>
			<tr>
				<th class="small-col">
					<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
						<input type="checkbox" class="group-checkable"
							   data-set="#sample_3 .checkboxes"/>
						<span></span>
					</label>
				</th>
				<th class="small-col">ID</th>
				<th class="small-col">رقم الطلب</th>
				<th>اسم العميل</th>
				<th> تليفون </th>
				<th>العنوان</th>
				<th> الصياانة المطلوبة </th>
				<th>حالة الطلب</th>
				<th>تاريخ </th>
				<th>الاجراءات </th>
			</tr>
		</thead>
		<tbody>
            {% for m_ticket in product.maintenanceTickets %}
                <tr>
                <td>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="checkboxes" name="" value="{{m_ticket.id}}"/>
                        <span></span>
                    </label>
                </td>
                <td>{{m_ticket.id}}</td>
                <td>{{m_ticket.ticket_number}}</td>
                <td>
                    {% if m_ticket.client != null %}
                        {{m_ticket.client.Title}}
                    {% endif %}
                </td>
                <td>
                    {% if m_ticket.client != null %}
                        {{m_tickert.client.Mobile}}
                    {% endif %}
                </td>
                <td>
                    {% if m_ticket.client.mainAddress != null %}
                        {{m_ticket.client.mainAddress.details}}
                    {% endif %}
                </td>
                <td>
                    {% if m_ticket.problem_details != null %}
                        {{m_ticket.problem_details.name}}
                    {% endif %}
                </td>
                <td>
                    {% if m_ticket.ticket_status_id == 1 %}
                        <span class="label label-danger">{{m_ticket.problem_status.status_name}}</span>
                    {% else %}
                    <span class="label label-success">{{m_ticket.problem_status.status_name}}</span>
                    {% endif %}
                </td>
                <td>{{m_ticket.formattedDate()}}</td>
                <td>
                    <a href="{{url.getStatic('maintenance_module/requests/view/'~m_ticket.id)}}" class="btn btn-primary btn-xs view-btn">
                    <i class="fa fa-eye"></i> مشاهدة
                </a>
                </td>
            </tr>
            {% endfor %}
		</tbody>
	</table>
	<!-- <a type="button" href="create-ticket.html" class="btn btn-edit-my-data green-jungle btn-outline  btn-md">
		<i class="fa fa-ticket" aria-hidden="true"></i>  طلب صيانة جديد</a> -->
</div>


</div><!--end of maintenance-->

<div id="exchange" class="tab-pane fade in">
<!-- <div class="panel-group accordion" id="accordion2">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#return-filter">
                  <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                </a>
            </h4>
        </div>
        <div id="return-filter" class="panel-collapse collapse">
            <div class="panel-body">
                <form role="form">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">تاريخ من</label>
                                <input type="date" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">تاريخ الى</label>
                                <input type="date" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">  حالة طلب الإستبدال </label>
                                <select class="form-control">
                                    <option>جميع</option>
                                    <option>قيد الإجراء</option>
                                    <option>قيد التنفيذ</option>
                                    <option>تم التنفيذ</option>
                                    <option>الغى</option>
                                    <option>تجهيز / تعبئة</option>
                                    <option>خارج للتوصيل</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> الكمية</label>
                                <input type="number" class="form-control" min="1" />
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">  اسم العميل</label>
                                <input type="text" class="form-control" placeholder="auto complete" />
                            </div>
                        </div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class=" control-label"> البريد الإلكتروني</label>
								<input type="email" class="form-control">
							</div>
						</div>
						<div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> المنتج المستبدل به </label>
                                <input type="text" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> رقم الطلب </label>
                                <input type="number" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="col-xs-12 control-label">  Tags </label>
                                <input type="text" data-role="tagsinput" value="الخزانات," class="form-control col-xs-12">
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-primary">فلتر</button>
                </form>
            </div>
        </div>
    </div>
</div> -->
<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_4">
    <thead>
        <tr>
            <th>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="group-checkable"
                           data-set="#sample_4 .checkboxes"/>
                    <span></span>
                </label>
            </th>
            <th>رقم الطلب</th>
			<th> المنتج المستبدل به </th>
            <th>  الكمية </th>
            <th>العميل</th>
			<th> البريد الإلكتروني </th>
            <th>ترتيب </th>
            <th>  حالة طلب الإستبدال </th>
            <th>الاجراءات</th>
        </tr>
    </thead>
    <tbody>
        {% for rep_ticket in product.replaceTickets %}
            <tr class="odd gradeX">
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="checkboxes" value="{{rep_ticket.id}}"/>
                    <span></span>
                </label>
            </td>
            <td>{{rep_ticket.id}}</td>
            <td> <a class="text-info bold" href="product-view.html">خزان رأسي مربع</a> </td>
            <td> 5 </td>
            <td>
                {% if rep_ticket.client != null %}
                    <a href="one-client-view.html">{{rep_ticket.client.Title}}</a>
                {% endif %}
            </td>
            <td>
                {% if rep_ticket.client != null %}
                    {{rep_ticket.client.Mail}}
                {% endif %}
            </td>
            <td>7</td>
            <td>في الطريق</td>
            <td>
                <a href="{{url.getStatic('maintenance_module/requests/view/'~rep_ticket.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                <a href="{{url.getStatic('maintenance_module/requests/edit/'~rep_ticket.id)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>

                <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
            </td>
        </tr>
        {% endfor %}
    </tbody>
</table>

</div><!--end of exchange-->

<!-- <div id="return" class="tab-pane fade in">
<div class="panel-group accordion" id="accordion2">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#return-filter">
                  <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                </a>
            </h4>
        </div>
        <div id="return-filter" class="panel-collapse collapse">
            <div class="panel-body">
                <form role="form">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">تاريخ من</label>
                                <input type="date" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">تاريخ الى</label>
                                <input type="date" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> حالة طلب الإرجاع</label>
                                <select class="form-control">
                                    <option>جميع</option>
                                    <option>قيد الإجراء</option>
                                    <option>قيد التنفيذ</option>
                                    <option>تم التنفيذ</option>
                                    <option>الغى</option>
                                    <option>تجهيز / تعبئة</option>
                                    <option>خارج للتوصيل</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> الكمية</label>
                                <input type="number" class="form-control" min="1" />
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label">  اسم العميل</label>
                                <input type="text" class="form-control" placeholder="auto complete" />
                            </div>
                        </div>
						<div class="col-sm-3">
							<div class="form-group">
								<label class=" control-label"> البريد الإلكتروني</label>
								<input type="email" class="form-control">
							</div>
						</div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class=" control-label"> رقم الطلب </label>
                                <input type="number" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="col-xs-12 control-label">  Tags </label>
                                <input type="text" data-role="tagsinput" value="الخزانات," class="form-control col-xs-12">
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-primary">فلتر</button>
                </form>
            </div>
        </div>
    </div>
</div>
<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_5">
    <thead>
        <tr>
            <th>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="group-checkable"
                           data-set="#sample_5 .checkboxes"/>
                    <span></span>
                </label>
            </th>
            <th>رقم الطلب</th>
            <th>  الكمية </th>
            <th>العميل</th>
			<th> البريد الإلكتروني </th>
            <th>ترتيب </th>
            <th> حالة طلب الإرجاع</th>
            <th>الاجراءات</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd gradeX">
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="checkboxes" value="1"/>
                    <span></span>
                </label>
            </td>
            <td>1</td>
            <td> 5 </td>
            <td><a href="one-client-view.html">علي أحمد </a></td>
			<td> example@gmail.com </td>
            <td>7</td>
            <td>في الطريق</td>
            <td>
                <a href="order-view-returned.html" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                <a href="order-new.html" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>

                <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
            </td>
        </tr>
    </tbody>
</table>

</div> -->
<!--endof return-->

<div id="seo" class="tab-pane fade in">
<div class="col-sm-2 gap">
<ul class="nav nav-tabs tabs-left">
  <li class="active"><a data-toggle="tab" href="#standared">Standard</a></li>
  <li><a data-toggle="tab" href="#arabic"> Arabic</a></li>
  <li><a data-toggle="tab" href="#english">English</a></li>
</ul>
</div>


<div class="tab-content col-sm-10">
<div id="standared" class="tab-pane fade in active">
<form method="post" action="{{url('content/addStandardSeoSettings')}}" role="form" enctype="multipart/form-data">
<input type="hidden" name="product_id" value="{{product.ID}}">
<table class="table ">
    <tbody>
        <tr>
       <td style="width: 20%" class="adminTitle">
            <label for="MetaKeywords" title="ميتا الكلمات الرئيسية المراد إضافتها إلى رأس صفحة المنتج">ميتا الكلمات الرئيسية</label>:
       </td>
       <td class="adminData">
            <input class="text-box single-line" id="MetaKeywords" name="meta" type="text" {% if product.seoSettings != null %}value="{{product.seoSettings.meta}}"{% endif %}>
            <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%" class="adminTitle">
           <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
       </td>
       <td class="adminData">
            <textarea cols="20" id="MetaDescription" name="meta_description" rows="2">{% if product.seoSettings != null %}{{product.seoSettings.meta_description}}{% endif %}</textarea>
            <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%" class="adminTitle">
            <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                   </td>
                                   <td class="adminData">
            <input class="text-box single-line" id="MetaTitle" name="title_description" type="text" {% if product.seoSettings != null %}value="{{product.seoSettings.title_description}}"{% endif %}>
            <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%"  class="adminTitle">
            <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                   </td>
                                   <td class="adminData">
            <input class="text-box single-line" id="SeName" name="page_description" type="text" {% if product.seoSettings != null %}value="{{product.seoSettings.page_title}}"{% endif %}>
            <span class="field-validation-valid" data-valmsg-for="SeName" data-valmsg-replace="true"></span>
               </td>
           </tr>
       </tbody></table>
   <button type="submit" class="btn btn-primary">حفظ</button>
   </form>
</div>
<div id="arabic" class="tab-pane fade">
<table class="table ">
    <tbody><tr>
       <td style="width: 20%" class="adminTitle">
            <label for="MetaKeywords" title="ميتا الكلمات الرئيسية المراد إضافتها إلى رأس صفحة المنتج">ميتا الكلمات الرئيسية</label>:
       </td>
       <td class="adminData">
            <input class="text-box single-line" id="MetaKeywords" name="MetaKeywords" type="text" value="water, watery, horizontal tanks, horizontal tank, plastic tanks, plastic tank, tanks insulation, tank insulation, polyetheleen, water, alzamil water tanks">
            <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%" class="adminTitle">
           <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
       </td>
       <td class="adminData">
            <textarea cols="20" id="MetaDescription" name="MetaDescription" rows="2"></textarea>
            <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%" class="adminTitle">
            <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                   </td>
                                   <td class="adminData">
            <input class="text-box single-line" id="MetaTitle" name="MetaTitle" type="text" value="">
            <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%"  class="adminTitle">
            <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                   </td>
                                   <td class="adminData">
            <input class="text-box single-line" id="SeName" name="SeName" type="text" value="vertical-tank-capacity-16000-ltr">
            <span class="field-validation-valid" data-valmsg-for="SeName" data-valmsg-replace="true"></span>
               </td>
           </tr>
       </tbody></table>
</div>
<div id="english" class="tab-pane fade">
<table class="table ">
    <tbody><tr>
       <td style="width: 20%" class="adminTitle">
            <label for="MetaKeywords" title="ميتا الكلمات الرئيسية المراد إضافتها إلى رأس صفحة المنتج">ميتا الكلمات الرئيسية</label>:
       </td>
       <td class="adminData">
            <input class="text-box single-line" id="MetaKeywords" name="MetaKeywords" type="text" value="water, watery, horizontal tanks, horizontal tank, plastic tanks, plastic tank, tanks insulation, tank insulation, polyetheleen, water, alzamil water tanks">
            <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%" class="adminTitle">
           <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
       </td>
       <td class="adminData">
            <textarea cols="20" id="MetaDescription" name="MetaDescription" rows="2"></textarea>
            <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%" class="adminTitle">
            <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                   </td>
                                   <td class="adminData">
            <input class="text-box single-line" id="MetaTitle" name="MetaTitle" type="text" value="">
            <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
       </td>
   </tr>
   <tr>
       <td style="width: 20%"  class="adminTitle">
            <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                   </td>
                                   <td class="adminData">
            <input class="text-box single-line" id="SeName" name="SeName" type="text" value="vertical-tank-capacity-16000-ltr">
            <span class="field-validation-valid" data-valmsg-for="SeName" data-valmsg-replace="true"></span>
               </td>
           </tr>
       </tbody></table>
</div>
</div>
</div><!--endof seo-->
</div>
</div>
</div>
</div>

<!-- tag modal -->
<div id="tagModal" class="modal fade" role="dialog" style="display: none;">
    <div class="modal-dialog">

    <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title"> إضافة تاجات للمنتج</h4>
            </div>
            <div class="modal-body">
                <div class="col-sm-12">
                    <div class="form-group">
                        <input type="text" data-role="tagsinput" value="">
                    </div>
                </div>
                 <div class="modal-footer">
                <button id="add_tags" data-product_id="{{product.ID}}" type="button" class="btn btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i> حفظ</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- change maximum purchase modal -->
<div id="numModal" class="modal fade" role="dialog" style="display: none;">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h4 class="modal-title"> تعديل الكمية المسموحة لطلب الشراء الواحد </h4>
      </div>
      <div class="modal-body">
        <form role="form" action="{{url('content/changeProductMaxPurchase')}}" method="post" enctype="multipart/form-data" id="tags">
            <input type="hidden" name="product_id" value="{{product.ID}}">
               <div class="row">
                  <div class="input-group">
                        <span class="input-group-btn">
                          <button type="button" class="btn btn-sm no-margin btn-number" data-type="plus" data-field="quant">
                              <span class="fa fa-plus"></span>
                          </button>
                      </span>
                      <input type="text" name="quant" class="form-control input-number" value="1" min="1" max="100">
                      <span class="input-group-btn">
                          <button type="button" class="btn btn-sm no-margin  btn-number" disabled="disabled" data-type="minus" data-field="quant">
                              <span class="fa fa-minus"></span>
                          </button>
                      </span>
                  </div>
                </div>
         <div class="modal-footer">
          <button type="submit" class="btn btn-success"><i class="fa fa-floppy-o" aria-hidden="true"></i> حفظ</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
      </div>
        </form>
      </div>
    </div>

  </div>
</div>

<script type="text/javascript">
    $("#add_tags").click(function()
    {
        var product_id = $(this).data('product_id');
        var tags = $('#tagModal .tag').map(function()
        {
            return $(this).text();   
        }).get();

        $.ajax({
            type: 'post',
            url: "{{url('content/addProductTags')}}",
            data:{product_id: product_id, tags: tags},
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('content/productView/'~product.ID)}}";
                    break;
                }
            }
        });
    });

    $('#filter_product_offers').on('click', function()
    {
        var offer_name   = $('#offer_name').val();
        var offer_region = $('#offer_region').val();
        var offer_from   = $('#offer_from').val();
        var offer_to     = $('#offer_to').val();

        $.ajax({
            type: 'post',
            url: "{{url('content/filterProductOffers')}}",
            data:{
                product_id   : $(this).data('product_id'),
                offer_name   : offer_name,
                offer_region : offer_region,
                offer_from   : offer_from,
                offer_to     : offer_to
            },
            success: function(response)
            {
                response = JSON.parse(response);

                $('#offers_table_container').html("");
                $('#offers_table_container').append(response.content);
            }
        });
    });

    $('#filter_discounts').on('click', function()
    {
        var discount_name    = $('#discount_name').val();
        var discount_percent = $('#discount_percent').val();
        var discount_coupon  = $('#discount_coupon').val();
        var start_date       = $('#start_date').val();
        var end_date         = $('#end_date').val();

        $.ajax({
            type: 'post',
            url: "{{url('content/filterProductDiscounts')}}",
            data:{
                product_id      : "{{product.ID}}",
                discount_name   : discount_name,
                discount_percent: discount_percent,
                discount_coupon : discount_coupon,
                start_date      : start_date,
                end_date        : end_date
            },
            success: function(response)
            {
                response = JSON.parse(response);

                $('#discounts_table_container').html("");
                $('#discounts_table_container').append(response.content);
            }
        });
    });

    $('#delete_product').on('click', function()
    {
        if(confirm('أنت على وشك حذف المنتج، إستكمال العملية؟'))
        {
            $.ajax({
                type: 'post',
                url: "{{url('content/deleteProduct/'~product.ID)}}",
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('content/productsList')}}";
                        break;
                    }
                }
            });
        }
    });

    $('.delete_offer').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد العروض، إستكمال العملية؟'))
       {
        $.ajax({
            type: 'post',
            url: "{{url.getStatic('offers_module/index/ajaxDeleteOffer/')}}" + $(this).data('offer_id'),
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('content/productView/'~product.ID)}}";
                    break;
                }
            }
        });
       } 
    });

    $('.delete_discount').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد الخصومات، إستكمال العملية؟'))
       {
        $.ajax({
            type: 'post',
            url: "{{url.getStatic('discounts_module/index/ajaxDeleteDiscount/')}}" + $(this).data('discount_id'),
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('content/productView/'~product.ID)}}";
                    break;
                }
            }
        });
       } 
    });
</script>