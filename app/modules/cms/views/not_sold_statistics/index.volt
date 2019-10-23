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
                <span>  المنتجات التي لم يتم شراؤها </span>
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
                 <i class="fa fa-shopping-cart" aria-hidden="true"></i>
                <span class="caption-subject bold uppercase">
                    المنتجات التي لم يتم شراؤها
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
                                    <div class="col-sm-5 no-padding">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class=" control-label">اسم المنتج</label>
                                                <input id="product_name" type="text" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class=" control-label"> اسم الشركة المصنعة </label>
                                                <select id="manfct_id" class="form-control">
                                                    <option></option>
                                                    {% for manfct in manfcts %}
                                                        <option value="{{manfct.ID}}">{{manfct.Title}}</option>
                                                    {% endfor %}
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class=" control-label">  المنطقة</label>
                                                <select class="form-control">
                                                    <option>جميع</option>
                                                    <option> مكة </option>
                                                    <option>الرياض</option>
                                                    <option>المدينة</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 no-padding control-label"> سعر المنتج </label>
                                                    <div class="col-xs-10 no-padding">
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
                                    </div>


                                    <div class="col-sm-5">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"> التصنيف </label>
                                            <div class="col-sm-10 dept_tree">
                                                {{cats_tree}}
                                              </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-12" style="vertical-align: bottom">
                                        <button type="button" id="filter_products" class="btn btn-primary">فلتر</button>
                                    </div>

<!--
                            <div class="col-sm-4">
                                <label class=" control-label">اللغة الرسمية</label>
                                <input type="checkbox" class="make-switch" checked data-on-text="العربية" data-off-text="English">
                            </div>
-->
                        </div>

                    </form>
                        </div>
                    </div>
                </div>
            </div>
            <div id="filter-container">
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
                        <th style="width: 20px;"> ID</th>
                        <th>الصورة</th>
                        <th> اسم المنتج </th>
                        <th> السعر</th>
                        <th> الوصف </th>
                        <th>التصنيف</th>
                        <th> شركة التصنيع </th>
                        <th> التاريخ </th>
                        <th> مفعل </th>
                        <th>الاجراءات</th>
                    </tr>
                </thead>
                <tbody>
                    {% for item in page.items %}

                        <?php $product = $item->{'product'} ?>

                        <tr class="odd gradeX">
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="checkboxes" value="{{product.ID}}"/>
                                    <span></span>
                                </label>
                        </td>
                        <td style="width: 20px;">{{product.ID}}</td>
                        <td> <img src="{{url.getStatic('uploads/'~product.Img)}}" height="60px">  </td>
                        <td>{{product.Title}}</td>
                        <td>
                            {% if product.extraFields != null %}
                                {{product.extraFields.price}} SAR
                            {% endif %}
                        </td>
                        <td>{{product.Des}}</td>
                        <td>
                            {% if product.categories != null and product.categories|length > 0 %}   
                                {% for cat in product.categories %}
                                    {{cat.Title}} , 
                                {% endfor %}
                            {% endif %}
                        </td>
                        {% if product.manufacturers != null and product.manufacturers|length > 0 %}
                        <td><a href="{{url('manufacty
                            /view/'~product.manufacturers[0].ID)}}">{{product.manufacturers[0].Title}}</a> </td>
                        {% else %}
                        <td></td>
                        {% endif %}

                        <td>{{product.getDate()}}</td>
                        {% if product.Active == 1 %}
                        <td> <i class="text-success fa fa-check" aria-hidden="true"></i> </td>
                        {% else %}
                        <td> <i class="text-danger fa fa-close" aria-hidden="true"></i> </td>
                        {% endif %}
                        <td>
                            <a href="{{url('content/productView/'~product.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                            <a href="{{url('content/edit/'~product.ID)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                            <button data-product_id="{{product.ID}}" class="delete_product btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
            <ul class="pagination" style="margin-right:40%;">
            <li><a href="{{url('not_sold_statistics/index?page=1')}}">&laquo;&laquo;</a></li>
            <li><a href="{{url('not_sold_statistics/index?page='~page.before)}}">&laquo;</a></li>
            <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
            {% if i == page.current %}
            <li class="active"><span>{{i}}</span></li>
            {% else %}
            <li><a href="{{url('not_sold_statistics/index?page='~i)}}">{{i}}</a></li>
            {% endif %}
            <?php } ?>
            <li><a href="{{url('not_sold_statistics/index?page='~page.next)}}">&raquo;</a></li>
            <li><a href="{{url('not_sold_statistics/index?page='~page.last)}}">&raquo;&raquo;</a></li>
            </ul>
            </div>
            <div class="col-xs-12">
                <button id="export_excel" class="delete-btn btn btn-success btn-md">
                    <i class="fa fa-file-excel-o" aria-hidden="true"></i>إستخراج ملف اكسيل
                </button>
                <button id="delete_selected" class="delete-btn btn btn-danger btn-md">
                    <i class="fa fa-trash"></i>حذف المحدد
                </button>
            </div>
                </div>
            </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>
<script type="text/javascript">
$('.delete_product').click(function()
{
    if(confirm('You are about to delete product, continue?'))
    {
        $.ajax({
            type: 'post',
            url: "{{url('content/deleteProduct/')}}" + $(this).data('product_id'),
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('not_sold_statistics/index')}}";
                    break;
                }
            }
        });
    }
});

$('#delete_selected').click(function()
{
   var selected_ids = $('.checkboxes:checked').map(function()
   {
    return $(this).val();
   }).get(); 

   if(selected_ids.length > 0)
   {
    if(confirm('أنت على وشك القيام بحذف مجموعة منتجات، إستكمال العملية؟'))
    {
        $.ajax({
        type: 'post',
        url: "{{url('content/deleteSelectedProducts')}}",
        data: {selected_ids: selected_ids},
        success: function(response)
        {
            response = JSON.parse(response);

            switch(response.status)
            {
                case 0:
                alert(response.msg);
                break;
                case 1:
                window.location.href = "{{url('not_sold_statistics/index')}}";
                break;
            }
        }
    });
    }
   }
});

$("#export_excel").on('click', function()
{
    var selected_ids = $('.checkboxes:checked').map(function()
    {
        return $(this).val();
    }).get();

    if(selected_ids.length < 1)
    {
        selected_ids = {{export_ids}}
    }

    $.ajax({
        'type':'post',
        'url':"{{url('content/exportProductsExcel')}}",
        'data':{'all_ids':selected_ids},
        'success':function(response)
        {
            response = JSON.parse(response);
            switch(response.status)
            {
                case 0:
                alert('no data to export');
                break;
                case 1:
                window.location.href = "{{url.getStatic('products/')}}"+response.file_name;

                // $.ajax({
                //     'type':'post',
                //     'url':"{{url('content/removeExportedProductsFile')}}",
                //     'data':{file_name:response.file_name},
                // });
                break;
            }
        }
    });                        
});

$('#filter_products').on('click', function()
{
   var product_name = $('#product_name').val();
   var manfct_id    = $('#manfct_id').val();
   var price_from   = $('#price_from').val();
   var price_to     = $('#price_to').val();
   var depts_ids    = $('.dept_id:checked').map(function()
    {
        return $(this).val();
    }).get();

   $.ajax({
    type: 'post',
    url: "{{url('not_sold_statistics/filterProducts')}}",
    data: {
        product_name: product_name,
        manfct_id: manfct_id,
        price_from: price_from,
        price_to: price_to,
        depts_ids: depts_ids
    },
    success: function(response)
    {
        response = JSON.parse(response);
        $('#filter-container').html('');
        $('#filter-container').html(response.content);
    }
   });
});
</script>