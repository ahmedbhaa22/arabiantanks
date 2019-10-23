<div class="">
               <div class="page-bar " style="position: relative">
                  <ul class="page-breadcrumb">
                      <li>
						<i class="fa fa-home" aria-hidden="true"></i>
                          <a href="{{url('clients/index')}}"><span> الرئيسية </span></a>
                          <i class="icon-arrow-left"></i>
                      </li>
                      <li>
						<a href="{{url('clients/list')}}"><span>العملاء</span></a>
                          <i class="icon-arrow-left"></i>
                      </li>
                      <li>
						<span>تفاصيل العميل</span>
                      </li>
                  </ul>
              </div>
              <div class="clearfix"></div>
              <div>
				<?php $this->flashSession->output(); ?>
				{% if session.get('error_msgs')|length %}
                <ul style="color:red;float:left;">
                    {% for msg in session.get('error_msgs') %}
                        <li style="float:left;">{{msg['field']}} : {{msg['message']}}</li><br>
                        <?php $this->session->set('error_msgs', []) ?>
                    {% endfor %}
                </ul>
                {% endif %}
              </div>

              <div class="col-lg-12">
                  <div class="row">
                      <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                          <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('img/banners/banner-clients.png')}}') center center no-repeat ; background-size: contain"></div>
                      </div>
                  </div>
              </div> <div class="portlet light clearfix">
                <div class="portlet-title">
                      <div class="caption font-dark">
                          <h4 class="caption-subject bold uppercase">
							<i class="fa fa-user" aria-hidden="true"></i>
                             {{client.Title}}
                          </h4>
                      </div>

                    <div class="actions">

                          <a type="button" href="" class="btn btn-xs btn-success" data-toggle="modal" data-target="#msgModal">
                            <i class="fa fa-envelope-o" aria-hidden="true"></i> إرسال رسالة
                          </a>

 					      <a href="{{url('clients/edit/'~client.ID)}}" type="button" class="btn btn-xs btn-info">
                            <i class="fa fa-pencil-square-o" aria-hidden="true"></i> تعديل بيانات العميل
                          </a>

                          <button data-client_id="{{client.ID}}" id="delete_client" type="button" class="btn btn-xs btn-danger">
                            <i class="fa fa-trash-o" aria-hidden="true"></i> حذف العميل
                          </button>
                      </div>
                  </div>
					<div class="portlet-body">
					<div class="col-xs-12 no-padding ">
						<div class="col-xs-12 no-padding ">
                            <div class="profile-userpic col-md-2 col-sm-3 col-xs-4 no-padding">
                                      <img 
                                      {% if client.Img != null %}
                                      src="{{url.getStatic(client.Img)}}"
                                      {% else %}
                                      src="{{url.getStatic('img/default-avatar.jpg')}}"
                                      {% endif %}
                                       class="img-responsive" alt="">
                                       {% if client.Active == 1%}
                                       <h5 class="text-center bold"><i class="fa fa-check-circle-o text-success"></i> مفعل </h5>
                                       {% else %}
                                       <h5 class="text-center bold"><i class="fa fa-times text-danger"></i>غير مفعل </h5>
                                       {% endif %}
                                </div>

                            <div class="col-md-10 col-sm-9 col-xs-8 no-padding">

                             <div class="panel">
                                 <div class="panel-body">

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
                                        <div class="form-group col-md-6 col-xs-12 no-padding">
                                            <div class="col-lg-3 col-xs-6 bold">كلمة المرور :</div>
                                            <!-- <div class="col-lg-3 col-xs-6">*******</div> -->
                                            <div class="col-lg-5 col-xs-6"><a data-toggle="modal" data-target="#changePasswordModal"><i class="fa fa-pencil-square-o"></i> تعديل كلمة المرور </a></div>
                                        </div>

									 <div class="form-group col-md-6 col-xs-12 no-padding">
										 <div class="col-lg-3 col-xs-6 bold">فرع العميل</div>
										 <!-- <div class="col-lg-3 col-xs-6">*******</div> -->
										 <div class="col-lg-5 col-xs-6"></div>
									 </div>

									 <div class="form-group col-md-6 col-xs-12 no-padding">
										 <div class="col-lg-3 col-xs-6 bold">أضيف بواسطة </div>
										 <!-- <div class="col-lg-3 col-xs-6">*******</div> -->
										 <div class="col-lg-5 col-xs-6">{{added_by}}</div>
									 </div>

                                        <div class=" col-md-6 col-xs-12 no-padding ">
                                            <div class="col-lg-4 col-xs-6 bold">تصنيف العميل : </div>
                                            <div class="col-lg-3 col-xs-3 text-info bold">
                                            	{% if client.category %}
                                            		{{client.category.name}}
                                            	{% endif %}
                                            </div>
                                            <div class="col-lg-5 col-xs-3 pull-right">
                                                <a data-toggle="modal" data-target="#changeroleModal"><i class="fa fa-pencil-square-o"></i> تعديل تصنيف العميل </a></div>
                                        </div>
                                </div>
							</div>
						</div>
						</div>

				 <div class="col-md-9 no-padding">
				  <ul class="nav nav-tabs nav-justified ">
					<li class="active"><a data-toggle="tab" href="#info"><i class="fa fa-info" aria-hidden="true"></i> معلومات العميل </a></li>
					<li class=""><a data-toggle="tab" href="#cart"><i class="fa fa-shopping-cart" aria-hidden="true"></i> عربة التسوق </a></li>
				  </ul>
				  </div>
				  <div class="clearfix"></div>
			         <div class="tab-content col-md-12 no-padding">
				            <div id="info" class="tab-pane fade in active">
						        <div class="col-xs-12 no-padding ">
                                 <div class="panel">
                                     <div class="panel-body">
                                                <div class="sub-title">عناوين العميل </div>
                                                <div class="row">
                                                	{% if addresses is defined %}
                                                		{% for address in addresses %}
                                                			<div class="form-group col-xs-12 no-padding">
	                                                        <div class="col-lg-2 col-xs-6 bold">عنوان : {{loop.index}}</div>
	                                                        <div class="col-lg-10 col-xs-6">{{address.details}}


                                                        	{% if address.is_main == 1 %}
                                                        	<span class="label label-success pull-right"> <i class="fa fa-check" aria-hidden="true"></i> العنوان الرئيسي</span>
                                                        	{% endif %}
	                                                        </div>
                                                    </div>
                                                		{% endfor%}
                                                	{% endif %}
                                                </div>
                                                <div class="form-group col-xs-12 no-padding">
                                                    <span><a class="btn btn-sm btn-default btn-outline" data-toggle="modal" data-target="#addAddress"><i class="fa fa-plus"></i> قم باضافة عنوان جديد </a></span>
                                                </div>
                                            </div>
                                        </div>
									</div>

								<div class="col-xs-12 no-padding ">
								 <div class="panel">
									 <div class="panel-body">

									<div class="sub-title">معلومات اخرى عن العميل</div>

										<div class="form-group col-md-6 col-xs-12 no-padding">
											<div class="col-lg-4 col-xs-6 bold">الشركة : </div>
											<div class="col-lg-8 col-xs-6"><a href="#" 
												{% if client_data is defined %}
													title="{{client_data.company_name}}"
												{% endif %}
												>
													{% if client_data is defined %}
														{{client_data.company_name}}
													{% endif %}
												</a></div>
										</div>
										<div class="form-group col-md-6 col-xs-12 no-padding">
											<div class="col-lg-4 col-xs-6 bold">البلد : </div>
											<div class="col-lg-8 col-xs-6">
												{% if country is defined %}
												{{country}}
												{% endif %}
											</div>
										</div>
										<div class="form-group col-md-6 col-xs-12 no-padding">
											<div class="col-lg-4 col-xs-6 bold">المدينة : </div>
											<div class="col-lg-8 col-xs-6">
												{% if city is defined %}
													{{city}}
												{% endif %}
											</div>
										</div>
										<div class="form-group col-md-6 col-xs-12 no-padding">
											<div class="col-lg-4 col-xs-6 bold">الهاتف : </div>
											<div class="col-lg-8 col-xs-6"><a href="tel:{{client.Mobiel}}">{{client.Mobile}}</a></div>
										</div>
										<div class="form-group col-md-6 col-xs-12 no-padding">
											<div class="col-lg-4 col-xs-6 bold">الرمز البريدى :</div>
											<div class="col-lg-8 col-xs-6">
												{% if client_data is defined %}
												{{client_data.postal_code}}
												{% endif %}
											</div>
										</div>
										<div class="form-group col-md-6 col-xs-12 no-padding">
											<div class="col-lg-4 col-xs-6 bold">تعليق المشرف :</div>
											<div class="col-lg-8 col-xs-6">
												{% if client_data is defined %}
												{{client_data.supervisor_comment}}
												{% endif %}
											</div>
										</div>
                                </div>
								</div>
								</div>
							 </div>
							 <div id="cart" class="tab-pane fade in">
								 <div class="col-md-2 no-padding">
								  <ul class="nav nav-tabs tabs-left gap">
									<li class="active"><a data-toggle="tab" href="#demands">طلبات العميل</a></li>
									<li><a data-toggle="tab" href="#shopping-cart">   عربة التسوق الحالية للعميل</a></li>
									<li><a data-toggle="tab" href="#fav">القوائم المفضلة</a></li>
								  </ul>
								</div>
								 <div class="col-md-10 no-padding">
									   <div class="tab-content col-md-12">
											<div id="demands" class="tab-pane fade in active no-padding">
											  <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
													<thead>
													<tr>
														<th>رقم الطلب</th>
														<th>حالة طلب الشراء</th>
														<!-- <th>مركز الشحن</th> -->
														<th>تاريخ النشر</th>
														<th>اجمالى الطلبية </th>
														<th>اجراءات</th>
													</tr>
													</thead>
													<tbody>
														{% for order in orders %}
														<tr class="odd gradeX">
															<td>{{order.id}}</td>
															<td>{{order.statusDetails.status_name}}</td>
															<!-- <td></td> -->
															<td><?php echo date('d/m/Y', $order->date); ?></td>
															<!-- <td><?php $order_details = orderDetails($order->id); 
															echo $order_details['total_price'] + $order_details['total_shipping_fee'];
															 ?></td> -->
															 <td>{{order.itemsCount()}}</td>
															<td>
																<a href="{{url('orders/viewClientOrder/'~order.id)}}"  class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

																<button class="btn btn-xs btn-danger delete_order" data-order_id="{{order.id}}"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
															</td>
														</tr>
														{% endfor %}
													</tbody>
												</table>
											</div>
											<div id="shopping-cart" class="tab-pane fade in  no-padding" >
											  <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_2">
													<thead>
													<tr>
														<th>صورة المنتج</th>
														<th>اسم المنتج</th>
														<th>الكمية</th>
														<th>سعر المنتج</th>
													</tr>
													</thead>
													<tbody>
														{% for item in cart.items %}
															{% if item.item_type_id == 1 %}
															<tr class="odd gradeX">
																<td><img src="{{url.getStatic('uploads/'~item.cmsDetails.Img)}}" height="60"></td>
																<td><a href="#">{{item.cmsDetails.Title}}</a></td>
																<td>{{item.count}}</td>
																<td>{{item.cmsDetails.extraFields.price}}</td>
															</tr>
															{% else %}
															<tr class="odd gradeX">
																<td><img src="{{url.getStatic(item.offerDetails.image)}}" height="60"></td>
																<td><a href="#">{{item.offerDetails.name}}</a></td>
																<td>{{item.count}}</td>
																<td>{{item.offerDetails.price}}</td>
															</tr>
															{% endif %}
														{% endfor %}
													</tbody>
												</table>
											</div>
											<div id="fav" class="tab-pane fade in  no-padding">
											  <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_3">
													<thead>
													<tr>
														<th>صورة المنتج</th>
														<th>اسم المنتج</th>
														<th>الكمية</th>
														<th>سعر المنتج</th>
													</tr>
													</thead>
													<tbody>
														{% for item in wishlist.items %}
															{% if item.item_type_id == 1 %}
															<tr class="odd gradeX">
																<td><img src="{{url.getStatic('uploads/'~item.cmsDetails.Img)}}" height="60"></td>
																<td><a href="#">{{item.cmsDetails.Title}}</a></td>
																<td>{{item.count}}</td>
																<td>{{item.cmsDetails.extraFields.price}}</td>
															</tr>
															{% else %}
															<tr class="odd gradeX">
																<td><img src="{{url.getStatic('uploads/'~item.cmsDetails.Img)}}" height="60"></td>
																<td><a href="#">{{item.offerDetails.name}}</a></td>
																<td>{{item.count}}</td>
																<td>{{item.offerDetails.price}}</td>
															</tr>
															{% endif %}
														{% endfor %}
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
                        </div>
				    </div>
					</div>
				</div>
				</div>

	<!-- change category modal -->
	<div class=" static modal fade" id="changeroleModal" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header hidden-xs">
                <div class=" col-xs-12 ">
                    <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{url.getStatic('img/banners/banner.png')}}') center center no-repeat ; background-size: contain"></div>
                </div>
            </div>
            <form role="form" action="{{url('clients/changeCategory')}}" enctype="multipart/form-data" method="post" id="1_add_pop_up_1">
            	<input type="hidden" name="client_id" value="{{client.ID}}">
                <div class="modal-body" style="max-height:60vh" >
                    <div class="portlet-body" style=" padding: 15px;">
                        <div class="row">
                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
                                   تعديل دور العميل
                                </h4>
                            </div>

                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class=" control-label">تصنيف العميل</label>
                                    <select name="category_id" class="form-control" id="modal_cat_id">
                                    	<option></option>
                                    	{% for category in categories %}
                                    	{% if category.id == client.category_id %}
                                    	<option selected value="{{category.id}}">{{category.name}}</option>
                                    	{% else %}
                                    	<option value="{{category.id}}">{{category.name}}</option>
                                    	{% endif %}
                                    	{% endfor %}
                                      </select>
                                </div>
                            </div>
					</div>
                </div>
				</div>
                <div class="modal-footer">
                    <input type="button" data-dismiss="modal" class="btn dark " value="إلغاء">
                    <input type="submit" class="btn green-jungle " value="حفظ التعديلات">
                </div>
            </form>
        </div>
    </div>
</div>

<!-- add address modal -->
<div class=" static modal fade" id="addAddress" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header hidden-xs">
                <div class=" col-xs-12 ">
                    <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{url.getStatic('img/banners/banner.png')}}') center center no-repeat ; background-size: contain"></div>
                </div>
            </div>
            <form role="form" action="{{url('clients/addAddress')}}" method="post" enctype="multipart/form-data" id="1_add_pop_up_1">
            	<input type="hidden" name="client_id" value="{{client.ID}}">
                <div class="modal-body" style="max-height:60vh" >
                    <div class="portlet-body " style=" padding: 15px;">
                        <div class="row">
                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
								<i calss="fa fa-plus"></i>
                                   إضافة عنوان جديد
                                </h4>
                            </div>

                            <div class="col-xs-12">
                            	<div class="form-group">
											<label for="country">البلد</label>
                                <select required name="country" class="form-control" id="country">
                                    {% for country in countries %}
                                    <option value="{{country.id}}">{{country.name}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="state">المنطقة</label>
                                <select name="region" required class="form-control" id="state">
                                    {% for region in regions %}
                                    <option value="{{region.id}}">{{region.name}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="city">مدينة</label>
                                <select name="city" required class="form-control" id="city">
                                   	{% for city in cities %}
                                   	<option value="{{city.id}}">{{city.name}}</option>
                                   	{% endfor %}
                                </select>
                            </div>
                            <div class="form-group float-label-control">
                                <label class="control-label">تفاصيل العنوان</label>
                                <input name="address" type="text" class="form-control" />
                            </div>
                            <div class="col-sm-2">
                                    <div class="form-group">
                                        <label class=" control-label checkbox-label">العنوان الرئيسي ؟</label>
                                        <div class="col-sm-12 no-padding">
                                            <input name="is_main" type="checkbox" class="make-switch" checked data-on-text="نعم" data-off-text="لا">
                                        </div>
                                    </div>
                                </div>
                        </div>
					</div>
                </div>
				</div>
                <div class="modal-footer">
                    <input type="submit" data-dismiss="modal" class="btn dark " value="إلغاء">
                    <input type="submit" class="btn green-jungle " value="حفظ التعديلات">
                </div>
            </form>
        </div>
    </div>
</div>

<!-- change password modal -->
<div class=" static modal fade" id="changePasswordModal" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header hidden-xs">
                <div class=" col-xs-12 ">
                    <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/banners/banner.png') center center no-repeat ; background-size: contain"></div>
                </div>
            </div>
            <form role="form" action="{{url('clients/changePassword')}}" method="post" enctype="multipart/form-data" id="1_add_pop_up_1">
            	<input type="hidden" name="client_id" value="{{client.ID}}">
                <div class="modal-body" style="max-height:60vh" >
                    <div class="portlet-body " style=" padding: 15px;">
                        <div class="row">
                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
                                   تعديل كلمة المرور
                                </h4>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label">كلمة المرور</label>
                                    <input id="password" name="password" type="password" class="form-control"/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label"> تكرار كلمة المرور </label>
                                    <input id="confirm_password" name="confirm_password" type="password" class="form-control"/>
                                </div>
                                <span id="err_span" hidden style="color:red;">
                                	{% if lang == 1%}
                                	كلمة المرور غير متطابقة
                                	{% else %}
                                	Passwords not matching
                                	{% endif %}
                                </span>
                            </div>
					</div>
                </div>
				</div>
                <div class="modal-footer">
                    <button type="button" data-dismiss="modal" class="btn dark ">إلغاء</button>
                    <button id="chng_pswd_submit"  type="submit" class="btn green-jungle">حفظ التعديلات</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- send message modal -->
<div id="msgModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">ارسال رسالة</h4>
      </div>
      <div class="modal-body">
        <form role="form" action="{{url('clients/sendMessage')}}" method="post" enctype="multipart/form-data" id="msg">
        	<input type="hidden" name="client_name" value="{{client.Title}}">
        	<input type="hidden" name="client_mobile" value="{{client.Mobile}}">
        	<input type="hidden" name="client_mail" value="{{client.Mail}}">
        	<input type="hidden" name="client_id" value="{{client.ID}}">
            <div class="col-sm-12">
                  <div class="form-group">
                        <label class=" control-label">نوع الرسالة</label>
                        <select name="type" class="form-control">
                        	{% if lang == 1%}
                        	<option value="1">رسالة نصية</option>
                            <option value="2">إشعار</option>
                            <option value="3">رسالة بريد إلكتروني</option>
                        	{% else %}
                        	<option value="1">sms</option>
                            <option value="2">Notification</option>
                            <option value="3">Email</option>
                        	{% endif %}
                        </select>
                  </div>
                </div>
               <div class="col-sm-12">
                  <div class="form-group">
                        <label class=" control-label">نص الرسالة</label>
                        <textarea name="msg" class="form-control"></textarea>
                  </div>
                </div>
            <div class="modal-footer">
          <button type="submit" class="btn btn-success">ارسال</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
      </div>
        </form>
      </div>
    </div>

  </div>
</div>

<script type="text/javascript">
$(document).ready(function()
{
	var password = $('#password');
    var password_confirm = $('#confirm_password');
    var submit_btn = $('#chng_pswd_submit');
    var err_span = $('#err_span');

    password_confirm.keyup(function()
    {
        if($(this).val() !== password.val())
        {
            err_span.fadeIn();
            submit_btn.attr("disabled",'disabled');
        }     
        else
        {
            err_span.fadeOut();
            submit_btn.removeAttr("disabled");
        }
    });
});

$("#delete_client").click(function()
{
    if(confirm('You are about to delete a client, continue?'))
    {
        $.ajax({
            'type':'post',
            'url': "{{url('clients/delete/')}}"+$(this).data('client_id'),
            'success': function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('clients/list')}}";
                    break;
                }
            }
        });
    }     
});

$('.delete_order').click(function()
	{
		if(confirm('You are about to delete an order, continue?'))
		{
			$.ajax({
				type: 'post',
				url: "{{url('orders/deleteOrder/')}}" + $(this).data('order_id'),
				success: function(response)
				{
					response = JSON.parse(response);

					switch(response.status)
					{
						case 0:
						alert(response.msg);
						break;
						case 1:
						window.location.href = "{{url('clients/view/'~client.ID)}}"
						break;
					}
				}
			});
		}
	});
</script>

