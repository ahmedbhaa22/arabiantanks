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
                            <span>تفاصيل الطلب</span>
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
                            <span class="caption-subject bold uppercase"> الفاتورة </span>
                        </div>
                        <div class="actions">

                              <button data-order_id="{{order.id}}" id="delete_order" type="button" class="btn btn-xs btn-danger">
                                <i class="fa fa-trash-o" aria-hidden="true"></i> حذف الطلب
                              </button>
                          </div>
                    </div>
                    <div class="portlet-body">
                        <div class="panel gap clearfix">
                            <div class="panel-heading">
                                <div class="panel-title">
                                    <strong>رقم الطلب: </strong> {{order.id}}
                                    <div class="pull-right">
                                        <i class="fa fa-calendar"></i> <?php echo date('d/m/Y', $order->date); ?>
                                    </div>
                                </div>
                            </div>
                             <div class="panel-body">
                                <div class="todo-tasklist-item-text col-xs-6">
                                    <h5 class="bold text-info">معلومات الفاتورة</h5>
                                      <table class="table">
                                         <tbody>

                                            <tr>
                                               <td style="width:130px;">
                                                  الاسم
                                               </td>
                                               <td>
                                                {% if order.user != null %}
                                                  {{order.user.Title}}
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
                                               <td>
                                                 	الحوالة البنكية
<!--
                                                    اونلاين
                                                    الدفع عند الاستلام
-->
                                               </td>
                                            </tr>
                                         </tbody>
                                       </table>
                                  </div>
                                 <div class="todo-tasklist-item-text col-xs-6">
                                     <h5 class="bold text-info">معلومات التسليم</h5>
                                      <table class="table">
                                         <tbody>

                                            <tr>
                                               <td style="width:130px;">
                                                  الاسم
                                               </td>
                                               <td>
                                                {% if order.user != null %}
                                                  {{order.user.Title}}
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
                                                  مكان التسليم
                                               </td>
                                               <td>
                                                <!-- {% if order.deliveryPlace != null %}
                                                  {{order.deliveryPlace.name}}
                                                {% endif %} -->
                                               </td>
                                            </tr>
                                         </tbody>
                                       </table>
                                  </div>

                                 <table class="table gap table-bordered order-column ">
                                     <thead>
                                     <tr>
                                         <th rowspan="2">اسم المنتج</th>
                                         <th rowspan="2">السعر الاصلي</th>
                                         <th rowspan="2">الخصم</th>
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
                                         <td>{{item.count}}</td>
                                         <td>{{item.count * (item.cmsDetails.extraFields.price - this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID))}} (SAR) </td>
                                     </tr>
                                     {% else %}
                                     <tr class="odd gradeX">
                                         <td>
                                             <h5> {{item.offerDetails.name}} </h5>
                                             <h5> اللون: </h5>
                                             <h5> مكان التسليم: {{item.deliveryPlace.name}} </h5>
                                         </td>
                                         <td>{{item.offerDetails.price}} (SAR)</td>
                                         <td>{{item.count}}</td>
                                         <td>{{item.count * item.offerDetails.price}} (SAR) </td>
                                     </tr>
                                     {% endif %}
                                     {% endfor %}
                                     </tbody>
                                 </table>

                                 <div class="col-xs-12">
                                     <h5>المجموع: {{order.total_price}} (SAR)</h5>
                                     <h5>الشحن: {{total_shipping_fee}} (SAR)</h5>
                                     <h5 class="bold">إجمالي الطلبية: {{order.total_price + total_shipping_fee}} (SAR)</h5>
                                 </div>



                                 <div class="clearfix"></div>
                                 <hr>
                                <div class="row gap">
                                    <a target="_blank" href="{{url('orders/exportBill/'~order.id)}}" id="export_pdf" class="btn btn-info btn-md">
                                        <i class="fa fa-file-pdf-o" aria-hidden="true"></i>إستخراج ملف pdf
                                    </a>
                                    <!-- <button class="btn btn-success btn-lg">
                                        <i class="fa fa-truck" aria-hidden="true"></i>  شحن الطلب
                                    </button> -->
                                </div>
                            </div>


                        </div>

                    </div><!-- end portlet-->
                </div>
                <!-- END EXAMPLE TABLE PORTLET-->


                    <div class="clearfix"></div>
                    <!-- END DASHBOARD -->

            </div>
            <script type="text/javascript">
            $('#delete_order').click(function()
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

            $('#export_pdf').click(function()
              {
                var order_id = "{{order.id}}";
                $.ajax({
                  type:'post',
                  url: "{{url('orders/exportBill')}}",
                  data:{order_id:order_id},
                  success: function(response)
                  {
                    console.log(response);
                  }
                });
              });
            </script>