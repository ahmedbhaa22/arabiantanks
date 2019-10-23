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
                <a href="{{url('products_statistics/index')}}"><span>احصائيات المنتجات </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <span>تقرير بالدولة / البلد</span>
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
                <i class="fa fa-globe" aria-hidden="true"></i>
                <span class="caption-subject bold uppercase">
                    تقرير بالدولة / البلد
              </span>
            </div>
        </div>

        <div class="panel">
                <div class="panel-body">
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
                                    <form role="form">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label class=" control-label"> اسم المنطقة </label>
                                                    <select id="region_id" class="form-control" id="order">
                                                         <option></option>
                                                         {% for region in regions %}
                                                            <option value="{{region.id}}">{{region.getName()}}</option>
                                                         {% endfor %}
                                                      </select>
                                                </div>
                                            </div>

                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label class=" control-label"> التاريخ من </label>
                                                    <input id="date_from" type="date" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label class=" control-label"> التاريخ إلى </label>
                                                    <input id="date_to" type="date" class="form-control">
                                                </div>
                                            </div>


                                        </div>
                                        <button id="filter_orders" type="button" class="btn btn-primary">فلتر</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="filter_container">
                        <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_33">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th> المنطقة</th>
                                    <th> عدد الطلبات   </th>
                                    <th> تكلفة الطلبات  </th>
                                </tr>
                            </thead>
                            <tbody>
                                {% for order_item in result %}
                                <?php $order = $order_item->{'porder'} ?>

                                    <tr class="odd gradeX">
                                    <td>{{order.id}}</td>
                                    <td>
                                        {% if order.user.data != null %}
                                            {{order.user.data.region.getName()}}
                                        {% endif %}
                                    </td>
                                    <td>{{order_item.total_order_items}}</td>
                                    <td>{{order_item.total_price}}</td>
                                </tr>
                                {% endfor %}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>
<script type="text/javascript">
    $('#filter_orders').on('click', function()
    {
       var region_id = $('#region_id').val();
       var date_from = $('#date_from').val();
       var date_to   = $('#date_to').val();

       $.ajax({
        type: 'post',
        url: "{{url('country_statistics/filterOrders')}}",
        data:{
            region_id: region_id,
            date_from: date_from,
            date_to: date_to
        },
        success: function(response)
        {
            response = JSON.parse(response);

            $('#filter_container').html('');
            $('#filter_container').html(response.content);
        }
       });
    });
</script>