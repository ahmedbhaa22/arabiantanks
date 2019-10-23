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
                                <strong>رقم الطلب: </strong> {{order.id}}
                            </div>
                            <div class="pull-right">
                                <img data-brackets-id="93449" src="{{this.url_shared.get("img")}}/logo-original.png">
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div class="todo-tasklist-item-text col-xs-6">
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td>
                                            العميل / Customer
                                        </td>
                                        <td>{% if order.user != null %}
                                            {{order.user.Title}}
                                            {% endif %}</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            العنوان / Address
                                        </td>
                                        <td>{% if order.user != null %}
                                            {% if order.user.mainAddress %}
                                            {{order.user.mainAddress.details}}
                                            {% endif %}
                                            {% endif %}</td>
                                    </tr>
                                    <tr>
                                        <td>
                                            االموبايل / Mobile
                                        </td>
                                        <td> {% if order.user != null %}
                                            {{order.user.Mobile}}
                                            {% endif %}</td>
                                    </tr>


                                    </tbody>
                                </table>
                            </div>

                            <table class="table gap table-bordered order-column ">
                                <thead>
                                <tr>
                                    <th rowspan="2"> Item ID <br> رقم الصنف</th>
                                    <th rowspan="2">Description <br> الوصف </th>
                                    <th rowspan="2"> Qty <br> الكمية</th>
                                    <th rowspan="2">Unit Price <br> سعر الإفرادي</th>
                                    <th rowspan="2">Discount <br> الخصم</th>
                                    <th>
                                        Total Excl. VAT <br> ج قبل الضريبة
                                    </th>
                                    <th>
                                        VAT% <br> الضريبة%
                                    </th>
                                    <th>
                                        Total amount <br> الإجمالي
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                {% for item in order.items %}
                                {% if item.item_type_id == 1 %}
                                <tr class="odd gradeX">
                                    <td>{{item.id}}</td>
                                    <td>
                                        <h5> {{item.cmsDetails.Title}} </h5>
                                        <h5> اللون: {% if item.productColor %}{{item.productColor.name}}{% endif %} </h5>
                                        <h5> مكان التسليم: {{item.deliveryPlace.name}} </h5>
                                    </td>
                                    <td>{{item.count}}</td>
                                    <td>
                                        {{item.cmsDetails.extraFields.price}} (SAR)
                                    </td>
                                    <td>
                                        {{this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID)}} (SAR)
                                    </td>
                                    <td>{{item.count * (item.cmsDetails.extraFields.price - this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID))}} (SAR) </td>

                                    <td>{{item.cmsDetails.extraFields.tax_percent}}</td>

                                    <td>{{item.count * (item.cmsDetails.extraFields.price - this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID) +this.ApiFactory.getItemTaxAmount(item.cmsDetails.ID))}} (SAR) </td>
                                </tr>
                                {% else %}
                                <tr class="odd gradeX">
                                    <td>{{item.id}}</td>
                                    <td>
                                        <h5> {{item.offerDetails.name}} </h5>
                                        <h5> اللون: </h5>
                                        <h5> مكان التسليم: {{item.deliveryPlace.name}} </h5>
                                    </td>
                                    <td>{{item.count}}</td>
                                    <td>{{item.offerDetails.price}} (SAR)</td>
                                    <td></td>
                                    <td></td>
                                    <td>{{item.count * item.offerDetails.price}} (SAR) </td>
                                </tr>
                                {% endif %}
                                {% endfor %}
                                </tbody>
                            </table>

                            <table class="table table-bordered order-column">
                                <thead>
                                <tr>
                                    <th>
                                        Sub total <br> اجمالي مبلغ المبيعات
                                    </th>
                                    <th>
                                        Total discount <br> إجمالي الخصم
                                    </th>
                                    <th>
                                        VAT amount <br> قيمة الضريبة
                                    </th>
                                    <th>
                                        Shipping Fees <br> قيمة الشحن
                                    </th>

                                    <th>
                                        Net amount <br> الإجمالي
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr class="odd gradeX">
                                    <td>
                                        {{total_price }} SAR
                                    </td>
                                    <td>
                                        {{order_total_data['content'][0]['discount_amount']}} SAR
                                    </td>
                                    <td>{{total_tax_cost}}</td>
                                    <td>
                                        0
                                    </td>

                                    <td>
                                        {{order.total_price }}
                                    </td>
                                </tr>

                                </tbody>
                                <tfoot>

                                </tfoot>
                            </table>

                            <div class="text-center">
                                "GCC CUSTOMER ARE REQUIERD TO SELF ACCOUNT FOR TAX ON THE SUPPLY
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