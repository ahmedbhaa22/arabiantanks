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
                <a href="{{url('content/main/8')}}"><span> محتوى </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <a href="{{url('categories/index')}}"><span> التصنيفات </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <span>مشاهدة التصنيف </span>
            </li>
        </ul>
    </div>
    <div class="clearfix"></div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner-product.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
    <div class="portlet light clearfix">
             <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="fa fa-shopping-cart font-dark"></i>
                    <span class="caption-subject bold uppercase"> 
                    {% if lang == 1 %}
                        {% if category.ar != null %}
                            {{category.ar.title}}
                        {% else %}
                            {{category.Title}}
                        {% endif %}
                    {% else %}
                        {% if category.en != null %}
                            {{category.en.title}}
                        {% else %}
                            {{category.Title}}
                        {% endif %}
                    {% endif %} 
                    </span>
                    <small class="text-center text-info"> تاريخ الإضافة {{category.formattedDate()}}</small>
                  </div>

                <div class="actions">
                    <button data-cat_id="{{category.ID}}" id="delete-category" class="btn btn-danger">
                            <span aria-hidden="true" class="fa fa-trash"></span>
                            حذف التصنيف
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
                            {% if category.images|length > 0 %}
                                {% for img in category.images %}
                                    {% if loop.index == 1 %}
                                        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                                    {% else %}
                                    <li data-target="#myCarousel" data-slide-to="{{loop.index - 1}}"></li>
                                    {% endif %}
                                {% endfor %}
                            {% endif %}
                          <!-- <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                          <li data-target="#myCarousel" data-slide-to="1"></li> -->
                        </ol>
                        <!-- Wrapper for slides -->
                        <div class="carousel-inner">
                           <!--  <div class="item active">
                            <div class="img-holder img-thumbnail" style="width: 100%; max-height: 215px; height:215px; overflow: hidden ; background: url('{{url.getStatic('uploads/'~category.Img)}}') center center no-repeat ; background-size: cover">
                            </div>
                          </div> -->
                            {% if category.images|length > 0 %}
                                {% for img in category.images %}
                                    {% if loop.index == 1%}
                                        <div class="item active">
                                    {% else %}
                                        <div class="item">
                                    {% endif %}
                                    <div class="img-holder img-thumbnail" style="width: 100%; max-height: 215px; height:215px; overflow: hidden ; background: url('{{url.getStatic(img.Img)}}') center center no-repeat ; background-size: cover"></div>
                                  </div>
                                {% endfor %}
                            {% else %}
                             <div class="item active">
                            <div class="img-holder img-thumbnail" style="width: 100%; max-height: 215px; height:215px; overflow: hidden ; background: url('{{url.getStatic('images/No_Image_Available.png')}}') center center no-repeat ; background-size: cover">
                            </div>
                          </div>
                            {% endif %}
                        </div>
                      </div>
                </div>
                <div class="col-lg-9 col-md-9 col-sm-8  col-xs-12">
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <td> التصنيف الأصلي</td>
                                <td> <a {% if category.Parent != null %}
                                            href="{{url('categories/view/'~category.Parent.ID)}}"
                                        {% else %}
                                            href="#"
                                        {% endif %}
                                    target="_blank"
                                     class="bold text-info">
                                    {% if category.Parent != null %}
                                        {% if lang == 1%}
                                            {% if category.Parent.ar != null %}
                                                {{category.Parent.ar.title}}
                                            {% else %}
                                                {{category.Parent.Title}}
                                            {% endif %}
                                        {% else %}
                                            {% if category.Parent.en != null %}
                                                {{category.Parent.en.title}}
                                            {% else %}
                                                {{category.Parent.Title}}
                                            {% endif %}
                                        {% endif %}
                                    {% else %}
                                        لا يوجد
                                    {% endif %}
                                </a> </td>
                            </tr>
                            <tr>
                                <td>تفعيل التصنيف</td>
                                <td class="funkyradio">
                                    <div class="funkyradio-success">
                                        <input type="checkbox" name="checkbox" id="is_active" 
                                        {% if category.Active == 1 %}
                                            checked
                                        {% endif %}
                                         />
                                        <label for="is_active"> مفعل</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td> ترتيب العرض</td>
                                <td>{{category.Orders}}</td>
                            </tr>
<!--
                            <tr>
                                <td> ظهور التصنيف في الصفحة الرئيسية </td>
                                <td class="funkyradio">
                                    <div class="funkyradio-success">
                                        <input type="checkbox" name="checkbox" id="checkbox2"  />
                                        <label for="checkbox2"> إظهار</label>
                                    </div>
                                </td>
                            </tr>
-->
                            <tr>
                                <td>وصف التصنيف</td>
                                <td>
                                    {% if lang == 1 %}
                                        {% if category.ar != null %}
                                            {{category.ar.des}}
                                        {% else %}
                                            {{category.Des}}
                                        {% endif %}
                                    {% else %}
                                        {% if category.en != null %}
                                            {{category.en.des}}
                                        {% else %}
                                            {{category.Des}}
                                        {% endif %}
                                    {% endif %}
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

               <!--  <div class="  col-xs-12 gap widget-cont no-padding">
                    <div class="col-lg-3 col-sm-4 col-xs-6">
                        <div class="panel widget bg-gray">
                            <div class="row row-table">
                                <div class="col-xs-2 text-center bg-gray-dark pv-lg">
                                    <i class="fa fa-money fa-2x"></i>
                                </div>
                                <div class="col-xs-12 pv-lg">
                                    <div class="h2 mt0">50</div>
                                    <div class="text-uppercase"> عدد مرات شراء المنتج </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-4 col-xs-6">
                        <div class="panel widget bg-gray">
                            <div class="row row-table">
                                <div class="col-xs-2 text-center bg-gray-dark pv-lg">
                                    <i class="fa fa-wrench fa-2x"></i>
                                </div>
                                <div class="col-xs-12 pv-lg">
                                    <div class="h2 mt0">20</div>
                                    <div class="text-uppercase"> عدد طلبات الصيانة للمنتج </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-4 col-xs-6">
                        <div class="panel widget bg-gray">
                            <div class="row row-table">
                                <div class="col-xs-2 text-center bg-gray-dark pv-lg">
                                    <i class="fa fa-exchange fa-2x"></i>
                                </div>
                                <div class="col-xs-12 pv-lg">
                                    <div class="h2 mt0">20</div>
                                    <div class="text-uppercase"> عدد طلبات الإستبدال للمنتج </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-sm-4 col-xs-6">
                        <div class="panel widget bg-gray">
                            <div class="row row-table">
                                <div class="col-xs-2 text-center bg-gray-dark pv-lg">
                                    <i class="fa fa-exchange fa-2x"></i>
                                </div>
                                <div class="col-xs-12 pv-lg">
                                    <div class="h2 mt0">10</div>
                                    <div class="text-uppercase"> عدد طلبات الإرجاع للمنتج </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> -->

            </div>
        </div>

    <div class="portlet light clearfix">
         <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-shopping-cart font-dark"></i>
                <span class="caption-subject bold uppercase"> معلومات عن التصنيف
                </span>
              </div>
        </div>
        <div class="portlet-body">
            <ul class="nav nav-tabs ">
                    <li class="active"><a data-toggle="tab" href="#products"> المنتجات في التصنيف  </a></li>
                    <li class=""><a data-toggle="tab" href="#discounts">    خصومات على التصنيف  </a></li>
                    <li class=""><a data-toggle="tab" href="#seo">  إعدادات SEO </a></li>
                </ul>
            <div class="tab-content col-md-12 no-padding">
                <div id="products" class="tab-pane fade in active">
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
                                <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label class=" control-label">اسم المنتج</label>
                                                <input id="name" type="text" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label class=" control-label"> اسم الشركة المصنعة </label>
                                                <select id="manfct" class="form-control">
                                                    <option></option>
                                                    {% for manfct in manufacturers %}
                                                        <option value="{{manfct.ID}}">{{manfct.Title}}</option>
                                                    {% endfor %}
                                                </select>
                                            </div>
                                        </div>

                                      <!--   <div class="col-sm-6">
                                            <div class="form-group">
                                                <label class=" control-label">  المنطقة</label>
                                                <select class="form-control">
                                                    <option>جميع</option>
                                                    <option> مكة </option>
                                                    <option>الرياض</option>
                                                    <option>المدينة</option>
                                                </select>
                                            </div>
                                        </div> -->
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label class="control-label"> سعر المنتج </label>
                                                <div class="col-xs-12 no-padding">
                                                    <label class="col-xs-2 control-label"> من </label>
                                                    <div class="col-xs-4 no-padding">
                                                        <input id="price_from" type="number" class="form-control" min="1">
                                                    </div>
                                                     <label class="col-xs-2 control-label"> الي </label>
                                                    <div class="col-xs-4 no-padding">
                                                        <input id="price_to" type="number" class="form-control" min="1">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    <div class="col-sm-12" style="vertical-align: bottom">
                                        <button id="filter-cat-products" class="btn btn-primary">فلتر</button>
                                    </div>

                        </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="table-container">
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
                        <th style="width: 20px;"> ID</th>
                        <th>الصورة</th>
                        <th> اسم المنتج </th>
                        <th> السعر</th>
                        <th> الوصف </th>
                        <th> شركة التصنيع </th>
                        <th style="width: 20px;"> عدد مرات الشراء</th>
                        <th> التاريخ </th>
                        <th> مفعل </th>
                        <th>الاجراءات</th>
                    </tr>
                </thead>
                <tbody>
                    {% for item in category.items %}
                        <tr class="odd gradeX">
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="checkboxes" value="{{item.ID}}"/>
                                    <span></span>
                                </label>
                        </td>
                        <td style="width: 20px;">{{item.ID}}</td>
                        <td> <img src="{{url.getStatic('uploads/'~item.Img)}}" height="60px">  </td>
                        <td>
                            {% if item.ar != null %}
                                {{item.ar.title}}
                            {% else %}
                                {{item.Title}}
                            {% endif %}
                        </td>
                        <td>
                            {% if item.extraFields != null %}
                                {{item.extraFields.price}} SAR
                            {% endif %}
                        </td>
                        <td>
                            {% if item.ar != null %}
                                {{item.ar.des}}
                            {% else %}
                                {{item.Des}}
                            {% endif %}
                        </td>
                        <td>
                            {% for manfct in item.manufacturers %}
                            <a href="{{url('manufacturers/view/'~manfct.ID)}}">{{manfct.Title}}</a> ,
                            {% endfor %}
                        </td>

                        <td style="width: 20px;">{{item.purchaseNumber()}}</td>
                        <td>{{item.getDate()}}</td>
                        <td>
                            {% if item.Active == 1 %}
                                 <i class="text-success fa fa-check" aria-hidden="true"></i> 
                            {% else %}
                                 <i class="text-danger fa fa-close" aria-hidden="true"></i> 
                            {% endif %}
                        </td>
                        <td>
                            <a href="{{url('content/productView/'~item.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                            <a href="{{url('content/edit/'~item.ID)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                            <button data-product_id="{{item.ID}}" class="detach-product btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
            </div>
                </div><!-- end of product-->

                <div id="discounts" class="tab-pane fade in">
					 <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="panel-title">
                                خصومات سابقة على التصنيف
                            </div>
                        </div>
                        <div class="panel-body">
							<div class="panel-group accordion" id="accordion1">
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-discounts-filter">
                                              <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="collapse-discounts-filter" class="panel-collapse collapse">
                                        <div class="panel-body">
                                                <div class="row">

                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label">اسم الخصم</label>
                                                            <input id="f_discount_name" type="text" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class="col-xs-12 no-padding control-label"> النسبة المئوية</label>
                                                            <div class="col-xs-8 no-padding">
                                                                <input id="f_discount_percent" type="text" class="form-control">
                                                            </div>
                                                            <div class="col-xs-2"> % </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label"> كود الكوبون </label>
                                                            <input id="f_discount_coupon" type="text" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label"> تاريخ البدء </label>
                                                            <input id="f_start_date" type="date" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label"> تاريخ النهاية</label>
                                                            <input id="f_end_date" type="date" class="form-control">
                                                        </div>
                                                    </div>
                                                </div>
                                                <button id="filter_cat_discounts" class="btn btn-primary">فلتر</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="filtered_discounts_container">
                                <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_12">
                                <thead>
                                    <tr>
                                        <th>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="group-checkable"
                                                       data-set="#sample_12 .checkboxes"/>
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
                                    {% for discount in category.discounts %}
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
                    
                    <div class="panel panel-success">
                        <div class="panel-heading">
                            <div class="panel-title">
                                إضافة خصم للتصنيف
                            </div>
                        </div>
                        <div class="panel-body">
							<div class="row">
                                <form role="form" action="{{url('categories/addCategoryDiscount')}}" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="category_id" value="{{category.ID}}">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class=" control-label">اسم الخصم</label>
                                                    <input name="discount_name" type="text" class="form-control" 
                                                    {% if session.has('discount_name') %}
                                                        style="border-color:red;" 
                                                    {% endif %}
                                                    >

                                                    <!-- {% if session.has('discount_name') %}
                                                        <span class="help-block">أسم الخصم مطلوب</span>
                                                    {% endif %} -->
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class="col-xs-12 no-padding control-label"> النسبة المئوية</label>
                                                    <div class="col-xs-8 no-padding">
                                                        <input name="discount_percent" type="text" class="form-control" 
                                                        {% if session.has('discount_percent') %}
                                                            style="border-color:red;" 
                                                        {% endif %}
                                                        >
                                                    </div>
                                                    <div class="col-xs-2"> % </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class=" control-label"> كود الكوبون </label>
                                                    <input name="discount_coupon" type="text" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class=" control-label"> تاريخ البدء </label>
                                                    <input name="start_date" type="date" class="form-control" 
                                                    {% if session.has('start_date') %}
                                                        style="border-color:red;" 
                                                    {% endif %}
                                                    >
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class=" control-label"> تاريخ النهاية</label>
                                                    <input name="end_date" type="date" class="form-control" 
                                                    {% if session.has('end_date') %}
                                                        style="border-color:red;" 
                                                    {% endif %}
                                                    >
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <button type="submit" class="btn btn-success"> اضافة الخصم للتصنيف  </button>
                                        </div>
                                </form>
							</div>
						</div>
                    </div>
                </div><!-- end of discounts-->

                <div id="maintenance" class="tab-pane fade in">
					    <div class="panel-group accordion" id="accordion1">
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
															<option>جميع</option>
															<option> Opened  </option>
															<option>Closed</option>
															<option>Under Approve</option>
															<option> Assign to worker </option>
															<option>pending</option>
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
						</div>

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
									<tr>
										<td>
											<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
												<input type="checkbox" class="checkboxes" name="" value="1"/>
												<span></span>
											</label>
										</td>
										<td>1</td>
										<td>2080</td>
										<td>أنور فاروق أشرف</td>
										<td> 0123456789 </td>
										<td> 4 ش مصر و السودان الدقى القاهرة</td>
										<td> عطل في مضخة الخزان</td>
										<td> <span class="label label-danger">Opened</span> </td>
										<td>12/5/2017</td>
										<td>
											<a href="ticket-view-opened.html" class="btn btn-primary btn-xs view-btn">
											<i class="fa fa-eye"></i> مشاهدة
										</a>
										</td>
									</tr>
									<tr>
										<td>
											<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
											<input type="checkbox" class="checkboxes" name="" value="1"/>
											<span></span>
										</label>
										</td>
										<td>2</td>
										<td>2450</td>
										<td>ابراهيم علي الحسين </td>
										<td> 01546846845 </td>
										<td>
											1511 الرياض - الممكلكة العربية السعودية
										</td>
										<td>تقشير أرضية الخزان </td>
										<td> <span class="label label-success">Closed</span> </td>
										<td>5/6/2017</td>
										<td>
											<a href="ticket-view-closed.html" class="btn btn-primary btn-xs view-btn">
											<i class="fa fa-eye"></i> مشاهدة
										</a>
										</td>
									</tr>
								</tbody>
							</table>
							<a type="button" href="create-ticket.html" class="btn btn-edit-my-data green-jungle btn-outline  btn-md">
								<i class="fa fa-ticket" aria-hidden="true"></i>  طلب صيانة جديد</a>
						</div>


                </div><!--end of maintenance-->

                <div id="exchange" class="tab-pane fade in">
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
                        </div>
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
                                <tr class="odd gradeX">
                                    <td>
                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                            <input type="checkbox" class="checkboxes" value="1"/>
                                            <span></span>
                                        </label>
                                    </td>
                                    <td>1</td>
									<td> <a class="text-info bold" href="product-view.html">خزان رأسي مربع</a> </td>
                                    <td> 5 </td>
                                    <td><a href="one-client-view.html">أحمد على النحاس</a></td>
									<td> example@gmail.com </td>
                                    <td>7</td>
                                    <td>في الطريق</td>
                                    <td>
                                        <a href="order-view-exchange.html" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                                        <a href="order-new.html" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>

                                        <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

				</div><!--end of exchange-->

                <div id="return" class="tab-pane fade in">
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

                </div><!--endof return-->

                <div id="seo" class="tab-pane fade in">
					<div class="col-sm-2 gap">
                        <ul class="nav nav-tabs tabs-left">
                          <li class="active"><a data-toggle="tab" href="#standared">Standared</a></li>
                          <li><a data-toggle="tab" href="#arabic"> Arabic</a></li>
                          <li><a data-toggle="tab" href="#english">English</a></li>
                        </ul>
                    </div>


                    <div class="tab-content col-sm-10">
                      <div id="standared" class="tab-pane fade in active">
                        <table class="table ">
                            <tbody><tr>
                               <td style="width: 20%" class="adminTitle">
                                    <label for="MetaKeywords" title="ميتا الكلمات الرئيسية المراد إضافتها إلى رأس صفحة المنتج">ميتا الكلمات الرئيسية</label>:
                               </td>
                               <td class="adminData">
                                    <input {% if category.seo != null %}
                                                value="{{category.seo.meta}}" 
                                            {% endif %}
                                    readonly 
                                     class="text-box single-line" id="MetaKeywords" name="MetaKeywords" type="text" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
                               </td>
                           </tr>
                           <tr>
                               <td style="width: 20%" class="adminTitle">
                                   <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
                               </td>
                               <td class="adminData">
                                    <textarea readonly cols="20" id="MetaDescription" name="MetaDescription" rows="2">{% if category.seo != null %}{{category.seo.meta_description}}{% endif %}</textarea>
                                    <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
                               </td>
                           </tr>
                           <tr>
                               <td style="width: 20%" class="adminTitle">
                                    <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                                           </td>
                                                           <td class="adminData">
                                    <input {% if category.seo != null %}
                                                value="{{category.seo.title_description}}" 
                                            {% endif %}
                                    readonly
                                     class="text-box single-line" id="MetaTitle" name="MetaTitle" type="text">
                                    <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
                               </td>
                           </tr>
                           <tr>
                               <td style="width: 20%"  class="adminTitle">
                                    <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                                           </td>
                                                           <td class="adminData">
                                    <input {% if category.seo != null %}
                                                value="{{category.seo.page_title}}" 
                                            {% endif %}
                                    readonly
                                     class="text-box single-line" id="SeName" name="SeName" type="text">
                                    <span class="field-validation-valid" data-valmsg-for="SeName" data-valmsg-replace="true"></span>
                                       </td>
                                   </tr>
                               </tbody></table>
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

<?php 

if($this->session->has('discount_name'))
{
    $this->session->remove('discount_name');
}

if($this->session->has('discount_percent'))
{
    $this->session->remove('discount_percent');
}

if($this->session->has('start_date'))
{
    $this->session->remove('start_date');
}

if($this->session->has('end_date'))
{
    $this->session->remove('end_date');
}

?>

<script type="text/javascript">
    $('#delete-category').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد الأقسام، إستكمال العملية؟'))
       {
        $.ajax({
            type: 'post',
            url: "{{url('categories/delete/')}}" + $(this).data('cat_id'),
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('categories/index')}}";
                    break;
                }
            }
        });
       } 
    });

    $('#is_active').on('change', function()
    {
       var checked = $(this).is(':checked');

       switch(checked)
       {
        case true:
        $.ajax({
                type: 'post',
                url: "{{url('categories/activateSelected')}}",
                data: {ids: ["{{category.ID}}"]},
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('categories/view/'~category.ID)}}";
                        break;
                    }
                }
            });
        break;
        case false:
        $.ajax({
                type: 'post',
                url: "{{url('categories/deactivateSelected')}}",
                data: {ids: ["{{category.ID}}"]},
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('categories/view/'~category.ID)}}";
                        break;
                    }
                }
            });
        break;
       }
    });

    $('.detach-product').on('click', function()
    {
       if(confirm('أنت على وشك إخراج المنتج من التصنيف، إستكمال العملية؟'))
       {
            $.ajax({
                type: 'post',
                url: "{{url('categories/detachProductFromCategory')}}",
                data: {product_id: $(this).data('product_id')},
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('categories/view/'~category.ID)}}";
                        break;
                    }
                }
            });
       } 
    });

    $('#filter-cat-products').on('click', function()
    {
        $.ajax({
            type: 'post',
            url: "{{url('categories/filterCategoryProducts')}}",
            data: {
                name       : $('#name').val(),
                manfct     : $('#manfct').val(),
                price_from : $('#price_from').val(),
                price_to   : $('#price_to').val(),
                category_id: "{{category.ID}}"
            },
            success: function(response)
            {
                response = JSON.parse(response);

                $('#table-container').html("");
                $('#table-container').append(response.content);
            }
        }); 
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
                    window.location.href = "{{url('categories/view/'~category.ID)}}";
                    break;
                }
            }
        });
       } 
    });

    $('#filter_cat_discounts').on('click', function()
    {
       var discount_name    = $('#f_discount_name').val();
       var discount_percent = $('#f_discount_percent').val();
       var discount_coupon  = $('#f_discount_coupon').val();
       var start_date       = $('#f_start_date').val();
       var end_date         = $('#f_end_date').val();

       $.ajax({
        type: 'post',
        url: "{{url('categories/filterCategoryDiscounts')}}",
        data:{
            discount_name: discount_name,
            discount_percent: discount_percent,
            discount_coupon: discount_coupon,
            start_date: start_date,
            end_date: end_date,
            category_id: "{{category.ID}}"
        },
        success: function(response)
        {
            response = JSON.parse(response);

            $('#filtered_discounts_container').html('');
            $('#filtered_discounts_container').html(response.content);
        }
       });
    });
</script>