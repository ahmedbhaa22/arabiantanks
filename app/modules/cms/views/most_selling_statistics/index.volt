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
                <span> الأكثر مبيعا </span>
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
                <i class="fa fa-line-chart" aria-hidden="true"></i>
                <span class="caption-subject bold uppercase">
                 احصائيات بالمنتجات الأكثر مبيعا
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
                                    <!-- <form role="form"> -->
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label class=" control-label"> تاريخ البدء </label>
                                                    <input id="start_date" type="date" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label class=" control-label"> تاريخ الإنتهاء </label>
                                                    <input id="end_date" type="date" class="form-control">
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label class=" control-label"> التصنيف </label>
                                                    <select id="category_id" class="form-control">
                                                        <option></option>
                                                        {% for cat in categories %}
                                                            <option value="{{cat.ID}}">{{cat.Title}}</option>
                                                        {% endfor %}
                                                      </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label class=" control-label"> الشركة المصنعة </label>
                                                    <select id="manfct_id" class="form-control" >
                                                        <option></option>
                                                        {% for manfct in manfcts %}
                                                            <option value="{{manfct.ID}}">{{manfct.Title}}</option>
                                                        {% endfor %}
                                                      </select>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label class=" control-label"> مكان التسليم  </label>
                                                    <select id="branch_id" class="form-control">
                                                        <option></option>
                                                        {% for branch in branches %}
                                                            <option value="{{branch.id}}">{{branch.name}}</option>
                                                        {% endfor %}
                                                      </select>
                                                </div>
                                            </div>
                                            
                                        </div>
                                        <button type="button" id="filter_product" class="btn btn-primary">فلتر</button>
                                    <!-- </form> -->
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="cleaerfix"></div>

                    <div class="row gap" id="filtered_products_container">
                            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_11">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th> الاسم</th>
                                        <th>اجمالى الكمية</th>
                                        <th> المبلغ الكلي </th>
                                        <th class="small-col">الاجراءات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {% for item in page.items%}
                                        <?php
                                            $product_id    = $item->{'product'}->ID;
                                            $product_name  = $item->{'product'}->Title;
                                            $product_price = $item->{'product'}->extraFields->price;
                                         ?>
                                        <tr class="odd gradeX">
                                        <td>{{product_id}}</td>
                                        <td>{{product_name}}</td>
                                        <td>{{item.total_count}}</td>
                                        <td>{{product_price * item.total_count}}</td>
                                        <td>
                                            <a href="{{url('content/productView/'~product_id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                                        </td>
                                    </tr>
                                    {% endfor %}
                                </tbody>
                            </table>
                            <ul class="pagination" style="margin-right:40%;">
                            <li><a href="{{url('most_selling_statistics/index?page='~page.first)}}" >&laquo;&laquo;</a></li>
                            <li><a href="{{url('most_selling_statistics/index?page='~page.before)}}">&laquo;</a></li>
                            <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
                            {% if i == page.current %}
                            <li class="active"><span>{{i}}</span></li>
                            {% else %}
                            <li><a href="{{url('most_selling_statistics/index?page='~i)}}">{{i}}</a></li>
                            {% endif %}
                            <?php } ?>
                            <li><a href="{{url('most_selling_statistics/index?page='~page.next)}}">&raquo;</a></li>
                            <li><a href="{{url('most_selling_statistics/index?page='~page.last)}}">&raquo;&raquo;</a></li>
                            </ul>
                        </div>
                </div>
            </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->

</div>

<script type="text/javascript">
    $('#filter_product').on('click', function()
    {
       $.ajax({
        type: 'post',
        url: "{{url('most_selling_statistics/filter')}}",
        data: {
            start_date: $('#start_date').val(),
            end_date: $('#end_date').val(),
            category_id: $('#category_id').val(),
            manfct_id: $('#manfct_id').val(),
            branch_id: $('#branch_id').val()
        },
        success: function(response)
        {
            response = JSON.parse(response);

            $('#filtered_products_container').html('');
            $('#filtered_products_container').html(response.content);
        }
       }); 
    });
</script>