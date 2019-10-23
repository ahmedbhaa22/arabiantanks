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
                <a href="{{url('sales/index')}}"><span> المبيعات </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <span>عربات التسوق</span>
            </li>
        </ul>
    </div>
    <div class="clearfix"></div>
    <div class="col-lg-12">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                    <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner-cart.png')}}') center center no-repeat ; background-size: contain"></div>
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
                    عربات التسوق
              </span>
            </div>
        </div>
        <div class="portlet-body">
                    <div class="col-md-6 no-padding">
                        <ul class="nav nav-tabs nav-justified ">
                            <li id="for-sum" class="active"><a data-toggle="tab" href="#sum"> عربات التسوق الحالية  </a></li>
                            <li id="for-req" class=""><a data-toggle="tab" href="#req">القوائم المفضلة </a></li>
                        </ul>
                    </div>
                    <div class="clearfix"></div>

                    <div class="tab-content col-md-12 no-padding">
                        <div id="sum" class="tab-pane fade in active">
                            <div class="panel-group accordion" id="accordion1">
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-order-filter">
                                                  <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                                                </a>
                                        </h4>
                                    </div>
                                    <div id="collapse-order-filter" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <form role="form" method="post" action="{{url('sales_cart/index?tab=sum')}}" enctype="multipart/form-data">
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label class=" control-label"> اسم العميل </label>
                                                            <input name="cart_client_name" type="text" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label class=" control-label"> عدد المنتجات في عربة التسوق </label>
                                                            <input name="cart_items_count" type="number" class="form-control" min="1">
                                                        </div>
                                                    </div>
                                                </div>
                                                <button class="btn btn-primary">فلتر</button>
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
                                                       data-set="#sample_11 .checkboxes"/>
                                                <span></span>
                                            </label>
                                        </th>
                                        <th> ID </th>
                                        <th>اسم العميل</th>
                                        <th> مجموعة المنتجات </th>
                                        <th>الاجراءات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {% for cart in carts_page.items %}
                                    <tr class="odd gradeX">
                                        <td>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="checkboxes" value="{{cart.id}}"/>
                                                <span></span>
                                            </label>
                                        </td>
                                        <td>{{cart.id}}</td>
                                        <td>
                                            {% if cart.user != null %}
                                                <a href="{{url('clients/view/'~cart.user.ID)}}">{{cart.user.Title}}</a>
                                            {% else %}
                                            <a href="#"></a>
                                            {% endif %}
                                        </td>
                                        <td>
                                            <table class="table">
                                                <?php 

                                                $items = [];
                                                $counter = 0;
                                                $index   = 0;

                                                foreach($cart->items as $item)
                                                {
                                                    if(($counter%4) != 0)
                                                    {
                                                        $items[$index][] = $item;
                                                    }
                                                    else
                                                    {
                                                        $index += 1;
                                                        $items[$index][] = $item;
                                                    }

                                                    $counter+=1;
                                                }
                                                //var_dump($items);die;
                                                ?>

                                                {% for item in items %}
                                                <tr>
                                                    {% for details in item %}
                                                        {% if details.item_type_id == 1 %}
                                                            <td class="text-center col-xs-3 media">
                                                             {% if details.cmsDetails != null %}
                                                                <img src="{{url.getStatic('uploads/'~details.cmsDetails.Img)}}" alt="Image" class="img-circle" width="27px" height="27px"> <a href="" >{{details.cmsDetails.Title}}</a>
                                                             {% endif %}
                                                            </td>
                                                        {% else %}
                                                            <td class="text-center col-xs-3 media">
                                                             {% if details.offerDetails != null %}
                                                                <img src="{{url.getStatic('uploads/'~details.offerDetails.image)}}" alt="Image" class="img-circle" width="27px" height="27px"> <a href="" >{{details.offerDetails.name}}</a>
                                                             {% endif %}
                                                            </td>
                                                        {% endif %}
                                                    {% endfor %}
                                                </tr>
                                                {% endfor %}
                                            </table>
                                        </td>
                                        <td>
                                            <a {% if cart.user != null %}
                                                    href="{{url('clients/view/'~cart.user.ID)}}"
                                                {% else %}
                                                    href="#"
                                                {% endif %} 
                                             class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> مشاهدة </a>
                                        </td>
                                    </tr>
                                    {% endfor %}
                                </tbody>
                            </table>
                            <ul class="pagination" style="margin-right:40%;">
                            <li><a href="{{url('sales_cart/index?tab=sum&carts_page=1')}}">&laquo;&laquo;</a></li>
                            <li><a href="{{url('sales_cart/index?tab=sum&carts_page='~carts_page.before)}}">&laquo;</a></li>
                            <?php for($i = 1; $i <= $carts_page->total_pages; $i++){ ?>
                            {% if i == carts_page.current %}
                            <li class="active"><span>{{i}}</span></li>
                            {% else %}
                            <li><a href="{{url('sales_cart/index?tab=sum&carts_page='~i)}}">{{i}}</a></li>
                            {% endif %}
                            <?php } ?>
                            <li><a href="{{url('sales_cart/index?tab=sum&carts_page='~carts_page.next)}}">&raquo;</a></li>
                            <li><a href="{{url('sales_cart/index?tab=sum&carts_page='~carts_page.last)}}">&raquo;&raquo;</a></li>
                            </ul>
                        </div>
                        <div id="req" class="tab-pane fade in ">
                            <div class="panel-group accordion" id="accordion2">
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-fav" href="#collapse-fav">
                                                  <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                                                </a>
                                        </h4>
                                    </div>
                                    <div id="collapse-fav" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <form role="form" method="post" action="{{url('sales_cart/index?tab=req')}}" enctype="multipart/form-data">
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label class=" control-label"> اسم العميل </label>
                                                            <input name="wishlist_client_name" type="text" class="form-control">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label class=" control-label"> عدد المنتجات في قائمة الامنيات </label>
                                                            <input name="wishlist_items_number" type="number" class="form-control" min="1">
                                                        </div>
                                                    </div>
                                                </div>
                                                <button class="btn btn-primary">فلتر</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_22">
                                <thead>
                                    <tr>
                                        <th>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="group-checkable"
                                                       data-set="#sample_22 .checkboxes"/>
                                                <span></span>
                                            </label>
                                        </th>
                                        <th> ID </th>
                                        <th> مجموعة المنتجات </th>
                                        <th>الاجراءات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {% for wishlist in wishlist_page.items %}
                                        <tr class="odd gradeX">
                                        <td>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="checkboxes" value="{{wishlist.id}}"/>
                                                <span></span>
                                            </label>
                                        </td>
                                        <td>{{wishlist.id}}</td>
                                        <td>
                                            {% if wishlist.user != null %}
                                                <a href="{{url('clients/view/'~wishlist.user.ID)}}">{{wishlist.user.Title}}</a>
                                            {% else %}
                                                <a href="#"></a>
                                            {% endif %}
                                        </td>
                                        <td>
                                            <table class="table">
                                                <?php 

                                                $w_items = [];
                                                $w_counter = 0;
                                                $w_index   = 0;

                                                foreach($wishlist->items as $w_item)
                                                {
                                                    if(($w_counter%4) != 0)
                                                    {
                                                        $w_items[$w_index][] = $w_item;
                                                    }
                                                    else
                                                    {
                                                        $w_index += 1;
                                                        $w_items[$w_index][] = $w_item;
                                                    }

                                                    $w_counter+=1;
                                                }
                                                //var_dump($items);die;
                                                ?>
                                                {% for w_item in w_items %}
                                                <tr>
                                                    {% for w_details in w_item %}
                                                        {% if w_details.item_type_id == 1 %}
                                                            <td class="text-center col-xs-3 media">
                                                             {% if w_details.cmsDetails != null %}
                                                                <img src="{{url.getStatic('uploads/'~w_details.cmsDetails.Img)}}" alt="Image" class="img-circle" width="27px" height="27px"> <a href="" >{{w_details.cmsDetails.Title}}</a>
                                                             {% endif %}
                                                            </td>
                                                        {% else %}
                                                            <td class="text-center col-xs-3 media">
                                                             {% if w_details.offerDetails != null %}
                                                                <img src="{{url.getStatic('uploads/'~w_details.offerDetails.image)}}" alt="Image" class="img-circle" width="27px" height="27px"> <a href="" >{{w_details.offerDetails.name}}</a>
                                                             {% endif %}
                                                            </td>
                                                        {% endif %}
                                                    {% endfor %}
                                                </tr>
                                                {% endfor %}
                                            </table>
                                        </td>
                                        <td>
                                            <a  {% if wishlist.user != null %}
                                                    href="{{url('clients/view/'~wishlist.user.ID)}}"
                                                {% else %}
                                                    href="#"
                                                {% endif %}
                                             class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> مشاهدة </a>
                                                }
                                            }
                                        </td>
                                    </tr>
                                    {% endfor %}
                                </tbody>
                            </table>
                            <ul class="pagination" style="margin-right:40%;">
                            <li><a href="{{url('sales_cart/index?tab=req&wishlist_page=1')}}">&laquo;&laquo;</a></li>
                            <li><a href="{{url('sales_cart/index?tab=req&wishlist_page='~wishlist_page.before)}}">&laquo;</a></li>
                            <?php for($i = 1; $i <= $wishlist_page->total_pages; $i++){ ?>
                            {% if i == wishlist_page.current %}
                            <li class="active"><span>{{i}}</span></li>
                            {% else %}
                            <li><a href="{{url('sales_cart/index?tab=req&wishlist_page='~i)}}">{{i}}</a></li>
                            {% endif %}
                            <?php } ?>
                            <li><a href="{{url('sales_cart/index?tab=req&wishlist_page='~wishlist_page.next)}}">&raquo;</a></li>
                            <li><a href="{{url('sales_cart/index?tab=req&wishlist_page='~wishlist_page.last)}}">&raquo;&raquo;</a></li>
                            </ul>
                        </div>
                    </div>

        </div>
    </div>

</div>
<script type="text/javascript">
    $(document).ready(function()
    {
        var active_tab = '{{tab}}';

        switch(active_tab)
        {
            case 'req':
                $('#for-sum').removeClass('active');
                $('#sum').removeClass('active');

                $('#for-req').addClass('active');
                $('#req').addClass('active');
            break;
            case 'sum':
                $('#for-req').removeClass('active');
                $('#req').removeClass('active');

                $('#for-sum').addClass('active');
                $('#sum').addClass('active');
            break;
        }
    });
</script>