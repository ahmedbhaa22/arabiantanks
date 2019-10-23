<div class="">
                <div class="page-bar " style="position: relative">

                    <ul class="page-breadcrumb">
                        <li>
                            <i class="fa fa-home" aria-hidden="true"></i>
                            <a href="#"><span> الرئيسية </span></a>
                            <i class="fa fa-angle-left" aria-hidden="true"></i>
                        </li>
                        <li>
                            <a href="#"><span> المنتجات </span></a>
                            <i class="fa fa-angle-left" aria-hidden="true"></i>
                        </li>
                        <li>
                            <a href="#"><span> المبيعات </span></a>
                            <i class="fa fa-angle-left" aria-hidden="true"></i>
                        </li>
                        <li>
                            <a href="#"><span> الطلبات </span></a>
                            <i class="fa fa-angle-left" aria-hidden="true"></i>
                        </li>
                        <li>
                            <a href="#"><span> تفاصيل الطلب </span></a>
                            <i class="fa fa-angle-left" aria-hidden="true"></i>
                        </li>
                        <li>
                            <span> الفاتورة </span>
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
                            <i class="fa fa-pencil-square-o font-dark"></i>
                            <span class="caption-subject bold uppercase"> تفاصيل الطلب  </span>
                        </div>
                        <div class="actions">

                              <a type="button" href="" class="btn btn-xs btn-danger">
                                <i class="fa fa-trash-o" aria-hidden="true"></i> حذف الطلب
                              </a>
                          </div>
                    </div>
                    <div class="portlet-body">
                        <div class="panel clearfix">
                            <div class="panel-heading">
                                <div class="panel-title">
                                    <strong>رقم الطلب: </strong> {{order.id}}
                                    <div class="pull-right">
                                        <i class="fa fa-calendar"></i> <?php echo date('d/m/Y', $order->date) ?>
                                    </div>
                                </div>
                            </div>
                             <div class="panel-body">
                                <div class="col-sm-6">
                                      <table class="table">
                                         <tbody>

                                            <tr>
                                               <td style="width:130px;">
                                                  العميل
                                               </td>
                                               <td>
                                                {% if order.user != null %}
                                                   <a href="{{url('clients/view/'~order.user.ID)}}" class="bold text-info">{{order.user.Title}}</a> 
                                                {% endif %}
                                               </td>
                                            </tr>
                                             <tr>
                                               <td style="width:130px;">
                                                  الهاتف
                                               </td>
                                               <td>
                                                {% if order.user != null %}
                                                  {{order.user.Mobile}}
                                                {% endif %}
                                               </td>
                                            </tr>
                                             <tr>
                                               <td style="width:130px;">
                                                  العنوان
                                               </td>
                                               <td>
                                                {% if order.user != null %}
                                                  {% if order.user.mainAddress %}
                                                    {{order.user.mainAddress.details}}
                                                  {% endif %}
                                                {% endif %}
                                               </td>
                                            </tr>
                                             <tr class="bold">
                                               <td style="width:130px;">
                                                  طريقة الدفع
                                               </td>
                                               <td> التحويلات البنكية </td>
                                            </tr>

                                            
                                         </tbody>
                                       </table>
                                  </div>
                                 <div class="col-sm-6">
                                      <table class="table">
                                         <tbody>

                                         <tr>
                                             <td style="width:130px;">
                                                السعر
                                             </td>
                                             <td> {{total_price}} SAR </td>
                                         </tr>

                                         <tr>
                                             <td style="width:130px;">
                                                الخصم
                                             </td>
                                             <td> {{order_total_data['content'][0]['discount_amount']}} SAR </td>
                                         </tr>
                                         <tr>
                                               <td style="width:130px;">
                                                  اجمالي سعر المنتجات بعد الخصم
                                               </td>
                                               <td> {{total_price - order_total_data['content'][0]['discount_amount']}} SAR </td>
                                            </tr>
<!--                                             <tr>-->
<!--                                               <td style="width:130px;">-->
<!--                                                   مصاريف شحن الطلب-->
<!--                                               </td>-->
<!--                                               <td> {{total_shipping_fee}} SAR </td>-->
<!--                                            </tr>-->
                                         <tr>
                                             <td style="width:130px;">
                                                 نسبة الضريبة المضافة
                                             </td>
                                             <td> {{order_total_data['content'][0]['tax_amount'] }} SAR </td>
                                         </tr>
                                             <tr>
                                               <td style="width:130px;">
                                                  اجمالي الطلبية
                                               </td>
                                               <td>  {{total_price - order_total_data['content'][0]['discount_amount'] + order_total_data['content'][0]['tax_amount'] }} </td>
                                            </tr>
                                         </tbody>
                                       </table>
                                  </div>
                                 
                                 <div class="col-sm-12  bordered">
                                       <div class="col-sm-2 col-xs-4">
                                            حالة الطلب :
                                       </div>
                                       <div class="col-sm-10 col-xs-8">
                                            <span class="bold text-info"> {{order.statusDetails.display_name_ar}} </span>
                                            <!--  <span class="bold text-warning"> قيد التنفيذ </span>
                                            <span class="bold text-info"> تم التنفيذ </span>
                                            <span class="bold text-danger"> ألغي </span>

                                            <span class="bold text-info"> تجهيز وتعبئة </span>
                                            <span class="bold text-success"> خارج للتوصيل</span>
                                            <span class="bold text-danger"> إرجاع الطلب </span>
-->
                                           <div class=" pull-right">
                                                <a type="button" href="#" class="btn btn-xs btn-info" data-toggle="modal" data-target="#payModal">
                                                <i class="fa fa-pencil-square-o" aria-hidden="true"></i> تغيير حالة الطلب
                                                </a>
                                           </div>
                                           <div class=" pull-right">
                                               <a type="button" href="#" class="btn btn-xs btn-info" data-toggle="modal" data-target="#payment_prove">
                                                   <i class="fa fa-pencil-square-o" aria-hidden="true"></i>عرض اثبات الدفع
                                               </a>
                                           </div>
                                        </div>                              
                                 </div>
                                 <div class="clearfix"></div>

                                <table class="table gap table-bordered order-column ">
                                    <thead>
                                        <tr>
                                            <th rowspan="2">اسم المنتج</th>
                                            <th rowspan="2">السعر الاصلي</th>
                                            <th rowspan="2">الخصم</th>
                                            <th rowspan="2">الضريبة المضافة</th>
                                            <th rowspan="2">الكمية</th>
                                            <th rowspan="2"> المجموع </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                      {% for item in order.items %}
                                      {% if item.item_type_id == 1 %}
                                          <tr class="odd gradeX">
                                              <td>
                                                  <h5> {{item.cmsDetails.Title}} </h5>
                                                  <h5> اللون: {% if item.productColor %}{{item.productColor.name}}{% endif %} </h5>
                                                  <h5> مكان التسليم: {{item.deliveryPlace.name}} </h5>
                                              </td>
                                              <td>
                                                  {{item.cmsDetails.extraFields.price}} (SAR)
                                              </td>
                                              <td>
                                                  {{this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID)}} (SAR)
                                              </td>
                                              <td>
                                                  {{this.ApiFactory.getItemTaxAmount(item.cmsDetails.ID)}} (SAR)
                                              </td>
                                              <td>{{item.count}}</td>
                                              <td>{{item.count * (item.cmsDetails.extraFields.price - this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID) +this.ApiFactory.getItemTaxAmount(item.cmsDetails.ID))}} (SAR) </td>
                                          </tr>
                                      {% else %}
                                          <tr class="odd gradeX">
                                              <td>
                                                  <h5> {{item.offerDetails.name}} </h5>
                                                  <h5> اللون: </h5>
                                                  <h5> مكان التسليم: {{item.deliveryPlace.name}} </h5>
                                              </td>
                                              <td>{{item.offerDetails.price}} (SAR)</td>
                                              <td>
                                              </td>
                                              <td>
                                                  {{this.ApiFactory.getOfferTaxAmount(item.offerDetails.id)}} (SAR)
                                              </td>
                                              <td></td>
                                              <td>{{item.count * item.offerDetails.price}} (SAR) </td>
                                          </tr>
                                      {% endif %}
                                      {% endfor %}
                                    </tbody>
                                </table>

                                <div class="col-xs-12">
                                    <h5>المجموع: {{order.total_price}} (SAR)</h5>
<!--                                    <h5>الشحن: {{total_shipping_fee}} (SAR)</h5>-->
                                    <h5 class="bold">إجمالي الطلبية: {{order.total_price }} (SAR)</h5>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <a href="{{url('orders/bill/'~order.id)}}" class="btn btn-success btn-md">
                                <i class="fa fa-check" aria-hidden="true"></i>  معاينة الفاتورة 
                            </a>

                        </div>

                    </div><!-- end portlet-->
                </div>
                <!-- END EXAMPLE TABLE PORTLET-->


                    <div class="clearfix"></div>
                    <!-- END DASHBOARD -->

            </div>

<!-- Change Status Modal -->
<div id="payModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <div class=" col-xs-12 ">
                    <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/edit.png') center center no-repeat; background-size: contain"></div>
                </div>
            </div>
            <form role="form" action="{{this.url_shared.get('cms_module/orders/change_order_status')}}" id="msg" method="post">

            <div class="modal-body">
                    <div class="form-group">
                        <label class="col-xs-12 control-label"> حالة الطلب </label>

                        {%set checked="checked=''"%}
                        {%for order_status in purchase_order_statuses%}
                        {%if (order_status.id==order.status)%}
                        {% set checked="checked='checked'"%}
                        {%endif%}
                        <div class="col-md-3 col-sm-6 col-xs-6 nopadding-r">
                            <input type="radio" name="changed_status_id" class="icon" id="icon{{order_status.id}}" value="{{order_status.id}}">
                            <label for="icon{{order_status.id}}">{{order_status.display_name_ar}}</label>
                        </div>
                        {%endfor%}
                        <input type="hidden" name="order_id" value="{{order.id}}">

                    </div>


            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-success">حفظ</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
            </div>
            </form>
        </div>

    </div>
</div>


<!-- payment_prove  -->
<div id="payment_prove" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">

                <div class="modal-body">
                    {%if(order.payment_receipt!="")%}
                    <img src="{{this.url_shared.get('') ~order.payment_receipt}}" />
                    {%else%}
                    العميل لم يضيف اثبات الدفع
                    {%endif%}


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
                </div>
        </div>

    </div>
</div>
