<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <a href="{{url('products_statistics/index')}}"><span>احصائيات المنتجات </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <span>احصائيات عامة </span>
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
                <i class="fa fa-pie-chart" aria-hidden="true"></i>
                <span class="caption-subject bold uppercase">
                 احصائيات عامة
              </span>
            </div>
        </div>

        <div class="clearfix">
            <div class="clearfix statistics-titles bg-purple-plum">
                <div class="caption">
                    <span class="col-lg-2 col-md-2 col-sm-3 col-xs-4 caption-subject bold uppercase">   إجمالي الطلبات </span>
                    <div class="col-lg-10 col-md-10 col-sm-9 col-xs-8">
                        <select id="all_orders_filter" class="form-control">
                            <option value="today">اليوم</option>
                            <option value="this_week">هذا الأسبوع</option>
                            <option value="this_month">هذا الشهر</option>
                            <option value="this_year">هذه السنة</option>
                            <option value="al_time">كل الوقت</option>
                        </select>
                    </div>
                </div>
            </div>
            <div id="all_orders_container" class="col-xs-12  widget-cont no-padding">

            <div class="col-lg-3 col-sm-6">
                <!-- START widget-->
                <div class="panel widget bg-gray">
                    <div class="row row-table">
                        <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                            <i class="fa fa-battery-empty fa-2x" aria-hidden="true"></i>
                        </div>
                        <div class="col-xs-12 pv-lg">
                            <div id="new_order_count" class="h2 mt0">0</div>
                            <div class="text-uppercase"> قيد الاجراء </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6">
                <!-- START widget-->
                <div class="panel widget bg-gray">
                    <div class="row row-table">
                        <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                            <i class="fa fa-battery-half fa-2x" aria-hidden="true"></i>
                        </div>
                        <div class="col-xs-12 pv-lg">
                            <div id="pending_order_count" class="h2 mt0">0</div>
                            <div class="text-uppercase"> قيد التنفيذ </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6">
                <!-- START widget-->
                <div class="panel widget bg-gray">
                    <div class="row row-table">
                        <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                            <i class="fa fa-battery-full  fa-2x" aria-hidden="true"></i>
                        </div>
                        <div class="col-xs-12 pv-lg">
                            <div id="shipping_order_count" class="h2 mt0">0</div>
                            <div class="text-uppercase"> تم التنفيذ </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-6">
                <!-- START widget-->
                <div class="panel widget bg-gray">
                    <div class="row row-table">
                        <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                            <i class="fa fa-ban fa-2x"></i>
                        </div>
                        <div class="col-xs-12 pv-lg">
                            <div id="cancel_order_count" class="h2 mt0">0</div>
                            <div class="text-uppercase"> ألغى </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>

        <div class="clearfix">
            <div class="statistics-titles  "><span class="caption-subject bold uppercase">	طلبات غير مكتملة </span></div>
            <div class="col-xs-12 widget-cont no-padding">
                {% if unfinished_orders['new_order'] != null %}
                <div class="col-lg-6 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                                <div class="c100 p12 small">
                                    {% set percent = (unfinished_orders['new_order'].orders_count / all_orders_count) * 100 %}
                                        <span>{{helpers.h_round(percent)}}%</span>
                                        <div class="slice">
                                            <div class="bar"></div>
                                            <div class="fill"></div>
                                        </div>
                                    </div>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{unfinished_orders['new_order'].orders_count}}</div>
                                <div class="text-uppercase">مجموع الطلبات التي لم يتم تأكيد الدفع لها</div>
                            </div>
                        </div>
                    </div>
                </div>
                {% else %}
                <div class="col-lg-6 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                                <div class="c100 p12 small">
                                        <span>0%</span>
                                        <div class="slice">
                                            <div class="bar"></div>
                                            <div class="fill"></div>
                                        </div>
                                    </div>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">0</div>
                                <div class="text-uppercase">مجموع الطلبات التي لم يتم تأكيد الدفع لها</div>
                            </div>
                        </div>
                    </div>
                </div>
                {% endif %}
                
                {% if unfinished_orders['pending'] != null %}
                <div class="col-lg-6 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                                <div class="c100 p30 small">
                                    {% set p_percent = helpers.h_rounf(unfinished_orders['pending'].orders_count / all_orders_count) * 100 %}
                                        <span>{{p_percent}}%</span>
                                        <div class="slice">
                                            <div class="bar"></div>
                                            <div class="fill"></div>
                                        </div>
                                    </div>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">{{unfinished_orders['pending'].orders_count}}</div>
                                <div class="text-uppercase"> مجموع الطلبات التي لم يتم شحنها بعد </div>
                            </div>
                        </div>
                    </div>
                </div>
                {% else %}
                <div class="col-lg-6 col-sm-6">
                    <!-- START widget-->
                    <div class="panel widget bg-gray">
                        <div class="row row-table">
                            <div class="col-xs-3 text-center bg-gray-dark pv-lg">
                                <div class="c100 p30 small">
                                        <span>0%</span>
                                        <div class="slice">
                                            <div class="bar"></div>
                                            <div class="fill"></div>
                                        </div>
                                    </div>
                            </div>
                            <div class="col-xs-12 pv-lg">
                                <div class="h2 mt0">0</div>
                                <div class="text-uppercase"> مجموع الطلبات التي لم يتم شحنها بعد </div>
                            </div>
                        </div>
                    </div>
                </div>
                {% endif %}
            </div>
        </div>

        <div class="clearfix">
                    <div class=" statistics-titles bg-green-sharp"><span class="caption-subject bold uppercase">	العملاء المسجلين  </span> </div>
                    <div class="col-sm-3 col-xs-6">
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                            <h4 class="widget-thumb-heading">في آخر 7 أيام</h4>

                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon circle bg-green-sharp icon-user"></i>

                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle">  عميل  </span>
                                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="600">{{seven_days_clients[0].clients_count}}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-3 col-xs-6">
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                            <h4 class="widget-thumb-heading"> في الأيام ال 14 الأخيرة  </h4>

                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon circle bg-green-sharp icon-user"></i>

                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle">  عميل  </span>
                                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="600">{{forteen_days_clients[0].clients_count}}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-3 col-xs-6">
                        <div class="widget-thumb widget-bg-color-white text-uppercase margin-bottom-20 bordered">
                            <h4 class="widget-thumb-heading"> الشهر الماضي </h4>

                            <div class="widget-thumb-wrap">
                                <i class="widget-thumb-icon circle bg-green-sharp icon-user"></i>

                                <div class="widget-thumb-body">
                                    <span class="widget-thumb-subtitle">  عميل  </span>
                                    <span class="widget-thumb-body-stat" data-counter="counterup" data-value="600">{{month_clients[0].clients_count}}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

        <div class="panel">
            <div class=" statistics-titles bg-yellow-gold"><span class="caption-subject bold uppercase">	كلمات البحث الشائعة</span></div>
            <div class="panel-body">
                <div class="col-xs-12 no-padding">
                    {% for keyword in searched_keywords %}
                        <div class="col-md-2 col-sm-3 col-xs-4 margin-bottom-20">
                        <div class="bordered">
                            <span class="badge badge-success pull-right">{{keyword.count}}</span>{{keyword.keyword}}
                        </div>
                    </div>
                    {% endfor %}
                </div>
            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>
<script type="text/javascript">
    $('#all_orders_filter').on('change', function()
    {
       $.ajax({
        type: 'get',
        url: "{{url('general_statistics/allOrders')}}",
        data: {all_orders_filter: $(this).val()},
        success: function(response)
        {
            response = JSON.parse(response);

            var orders = response.all_orders;

            if(orders.new_order != null)
            {
                $('#new_order_count').text(orders.new_order.orders_count);
            }
            else
            {
                $('#new_order_count').text(0);
            }

            if(orders.pending != null)
            {
                $('#pending_order_count').text(orders.pending.orders_count);
            }
            else
            {
                $('#pending_order_count').text(0);
            }

            if(orders.shipping != null)
            {
                $('#shipping_order_count').text(orders.shipping.orders_count);
            }
            else
            {
                $('#shipping_order_count').text(0);
            }

            if(orders.cancel != null)
            {
                $('#cancel_order_count').text(orders.cencel.orders_count);
            }
            else
            {
                $('#cancel_order_count').text(0);
            }
        }
       }); 
    });
</script>