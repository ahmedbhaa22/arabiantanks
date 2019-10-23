{{ stylesheet_link('css/bootstrap-tagsinput.css') }}
{{ javascript_include("js/bootstrap-tagsinput.min.js") }}
<div class="">
            <div class="page-bar " style="position: relative">
                <ul class="page-breadcrumb">
                    <li>
                        <i class="fa fa-home" aria-hidden="true"></i>
                        <a href="index.html"><span> الرئيسية </span></a>
                        <i class="fa fa-angle-left" aria-hidden="true"></i>
                    </li>
                    <li>
                        <a href="production.html"><span> المنتجات </span></a>
                        <i class="fa fa-angle-left" aria-hidden="true"></i>
                    </li>
                    <li>
                        <a href="sales.html"><span> المبيعات </span></a>
                        <i class="fa fa-angle-left" aria-hidden="true"></i>
                    </li>
                    <li>
                        <span>الطلبات</span>
                    </li>
                </ul>
            </div>
            <div class="clearfix"></div>
            <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner-orderts.png')}}') center center no-repeat ; background-size: contain"></div>
                        </div>
                    </div>
                </div>

                <div class="clearfix"></div>
                <!-- END DASHBOARD -->
            <div class="portlet light clearfix">
                <div class="portlet-title">
                    <div class="caption font-dark">
                        <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                        <span class="caption-subject bold uppercase">
                            الطلبات 
                      </span>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="col-md-6 no-padding">
                        <ul class="nav nav-tabs nav-justified ">
                            <li class="active"><a data-toggle="tab" href="#sum"> طلبات الشراء </a></li>
                            <!-- <li class=""><a data-toggle="tab" href="#return">	طلبات الارجاع </a></li> -->
                        </ul>
                    </div>
                    <div class="clearfix"></div>

                    <div class="tab-content col-md-12 no-padding">
                        <div id="sum" class="tab-pane fade in active">
                           <div class="panel-group accordion" id="accordion1">
                                <div class="panel panel-info">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#buy-filter">
                                                  <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="buy-filter" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <form role="form" action="{{url('sales_orders/index')}}" method="post" enctype="multipart/form-data">
                                                <div class="row">

                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label">تاريخ من</label>
                                                            <input name="date_from" type="date" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label">تاريخ الى</label>
                                                            <input name="date_to" type="date" class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label"> حالة طلب الشراء</label>
                                                            <select name="order_status" class="form-control">
                                                                <option value="all">جميع</option>
                                                                {% for p_status in purchase_order_statuses%}
                                                                    <option value="{{p_status.id}}">{{p_status.display_name_ar}}</option>
                                                                {% endfor %}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label"> مكان التسليم </label>
                                                            <select name="delivery_place" class="form-control">
                                                                <option></option>
                                                                {% for d_place in delivery_places%}
                                                                    <option value="{{d_place.id}}">{{d_place.name}}</option>
                                                                {% endfor %}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label"> المنتج </label>
                                                            <input name="product_name" type="text" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label"> رقم الطلب </label>
                                                            <input name="order_number" type="number" class="form-control">
                                                        </div>
                                                    </div>
													<div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class=" control-label"> البريد الإلكتروني</label>
                                                            <input name="user_email" type="email" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <div class="form-group">
                                                            <label class="col-xs-12 control-label">  Tags </label>
                                                            <input name="tags" type="text" data-role="tagsinput" class="form-control col-xs-12">
                                                        </div>
                                                    </div>
                                                </div>
                                                <input type="submit" value="فلتر" class="btn btn-primary">
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_11">
                                <thead>
                                    <tr>
                                        <th>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="group-checkable"
                                                       data-set="#sample_11 .p_checkboxes"/>
                                                <span></span>
                                            </label>
                                        </th>
                                        <th class="small-col">رقم <br> الطلب</th>
										<th> اسم العميل </th>
										<th> البريد الإلكتروني </th>
                                        <th> حالة طلب الشراء</th>
                                        <th> مكان التسليم</th>
                                        <th>تاريخ النشر</th>
                                        <th>إجمالي الطلبية</th>
                                        <th>الاجراءات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {% for p_item in purchase_page.items %}
                                        <tr class="odd gradeX">
                                        <td>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="checkboxes p_checkboxes" value="{{p_item.id}}"/>
                                                <span></span>
                                            </label>
                                        </td>
                                        <td class="small-col">{{p_item.id}}</td>
                                        <td><a 
                                            {% if p_item.user != null %}
                                                href="{{url('clients/view/'~p_item.user.ID)}}"
                                            {% else %}
                                                href="#"
                                            {% endif %}
                                            >
                                            {% if p_item.user != null %}
                                                {{p_item.user.Title}}
                                            {% endif %}
                                        </a></td>
                                        <td>
                                            {% if p_item.user != null %}
                                                {{p_item.user.Mail}}
                                            {% endif %}
                                        </td>
                                        <td> <span class="bold text-info">{{p_item.statusDetails.display_name_ar}}</span>  </td>
                                        <td></td>
                                        <td>{{p_item.formattedDate()}}</td>
                                        <td>{{p_item.itemsCount()}}</td>
                                        <td>
                                            <a href="{{url('orders/viewClientOrder/'~p_item.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> مشاهدة </a>

                                            <button data-p_item_id="{{p_item.id}}" class="delete_purchase_item btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                        </td>
                                    </tr>
                                    {% endfor %}
                                </tbody>
                            </table>
                            <ul class="pagination" style="margin-right:40%;">
                            <li><a href="{{url('sales_orders/index?purchase_page=1')}}">&laquo;&laquo;</a></li>
                            <li><a href="{{url('sales_orders/index?purchase_page='~purchase_page.before)}}">&laquo;</a></li>
                            <?php for($i = 1; $i <= $purchase_page->total_pages; $i++){ ?>
                            {% if i == purchase_page.current %}
                            <li class="active"><span>{{i}}</span></li>
                            {% else %}
                            <li><a href="{{url('sales_orders/index?purchase_page='~i)}}">{{i}}</a></li>
                            {% endif %}
                            <?php } ?>
                            <li><a href="{{url('sales_orders/index?purchase_page='~purchase_page.next)}}">&raquo;</a></li>
                            <li><a href="{{url('sales_orders/index?purchase_page='~purchase_page.last)}}">&raquo;&raquo;</a></li>
                            </ul>
                            <div class="col-xs-12">
                                <button type="button" id="export_purchase_excel" class="btn btn-success btn-md">
                                    <i class="fa fa-file-excel-o"></i>إستخراج ملف إكسيل
                                </button>
                                <button type="button" id="delete_selected_purchase_items" class="delete-btn btn btn-danger btn-md">
                                    <i class="fa fa-trash"></i>حذف المحدد
                                </button>
                            </div>
                        </div>
                        <!-- <div id="return" class="tab-pane fade in ">
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
                                                                <option> قيد الإجراء </option>
                                                                <option> عودة بإذن </option>
                                                                <option> اصلاح المنتج</option>
                                                                <option> استرداد المنتج </option>
                                                                <option> رفض الطلب </option>
                                                                <option> ألغي </option>
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
                                                            <label class=" control-label"> المنتج </label>
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
                                                            <input type="text" data-role="tagsinput" value="test," class="form-control col-xs-12">
                                                        </div>
                                                    </div>
                                                </div>
                                                <button class="btn btn-primary">فلتر</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                                        <th>رقم الطلب</th>
                                        <th> المنتج  </th>
                                        <th>  الكمية </th>
                                        <th>العميل</th>
                                        <th> البريد الإلكتروني </th>
                                        <th>ترتيب </th>
                                        <th> حالة طلب الإرجاع</th>
                                        <th>سبب الرجوع</th>
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
                                        <td> <a class="text-info bold" href="product-view.html">خزان</a> </td>
                                        <td> 5 </td>
                                        <td><a href="one-client-view.html">علي أحمد </a></td>
                                        <td> example@gmail.com </td>
                                        <td>7</td>
                                        <td><span class="bold text-info">قيد الإجراء</span></td>
                                        <td>العميل غير موجود بالعنوان المذكور</td>
                                        <td>
                                            <a href="order-view-returned.html" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i>مشاهدة </a>

                                            <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                        </td>
                                    </tr>

                                    <tr class="odd gradeX">
                                        <td>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="checkboxes" value="1"/>
                                                <span></span>
                                            </label>
                                        </td>
                                        <td>2</td>
                                        <td> <a class="text-info bold" href="product-view.html">خزان</a> </td>
                                        <td>8 </td>
                                        <td><a href="one-client-view.html">علي فادي علاء </a></td>
                                        <td> example@gmail.com </td>
                                        <td>18</td>
                                        <td><span class="bold text-success"> إصلاح المنتج </span> </td>
                                        <td>العميل غير موجود بالعنوان المذكور</td>
                                        <td>
                                            <a href="order-view-returned.html" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i>مشاهدة </a>

                                            <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="col-xs-12">
                                <button class="delete-btn btn btn-success btn-md">
                                    <i class="fa fa-file-excel-o" aria-hidden="true"></i>إستخراج ملف إكسيل
                                </button>
                                <button class="delete-btn btn btn-danger btn-md">
                                    <i class="fa fa-trash"></i>حذف المحدد
                                </button>
                            </div>
                        </div> -->
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>
<script type="text/javascript">
    $('.delete_purchase_item').on('click', function()
    {
       if(confirm('أنت على وشك حذف طلب شراء، إستكمال العملية؟'))
       {
            $.ajax({
                type: 'post',
                url: "{{url('sales_orders/deletePurchaseItem/')}}" + $(this).data('p_item_id'),
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('sales_orders/index/#sum')}}";
                        break;
                    }
                }
            });
       } 
    });

    $('#delete_selected_purchase_items').on('click', function()
    {
       var selected_purchase_items = $('.p_checkboxes:checked').map(function()
        {
            return $(this).val();
        }).get();

       if(selected_purchase_items.length > 0)
       {
            if(confirm('أنت على وشك حذف مجموعة طلبات شراء، إستكمال العملية؟'))
            {
                $.ajax({
                    type: 'post',
                    url: "{{url('sales_orders/deleteSelectedPurchaseItems')}}",
                    data: {ids: selected_purchase_items},
                    success: function(response)
                    {
                        response = JSON.parse(response);

                        switch(response.status)
                        {
                            case 0:
                            alert(response.msg);
                            break;
                            case 1:
                            window.location.href = "{{url('sales_orders/index/#sum')}}";
                            break;
                        }
                    }
                });
            }
       }
    });

    $('#export_purchase_excel').on('click', function()
    {
       var selected_purchase_items = $('.p_checkboxes:checked').map(function()
        {
            return $(this).val();
        }).get();

       if(selected_purchase_items.length < 1)
       {
         selected_purchase_items = {{purchase_ids}};
       }

       $.ajax({
            type: 'post',
            url: "{{url('sales_orders/exportPurchaseOrders')}}",
            data: {'purchase_ids' : selected_purchase_items},
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert('no data to export');
                    break;
                    case 1:
                    window.location.href = "{{url.getStatic('products/')}}" + response.file_name
                    break;
                }
            }
       });
    });
</script>