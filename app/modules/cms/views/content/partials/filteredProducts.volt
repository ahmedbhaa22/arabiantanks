<table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
    <thead>
        <tr>
            <th>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="group-checkable"
                           data-set="#sample_1 .checkboxes"/>
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
            <th style="width: 20px;"> عدد مرات الشراء</th>
            <th> التاريخ </th>
            <th> مفعل </th>
            <th>الاجراءات</th>
        </tr>
    </thead>
    <tbody>
        {% for product in page.items %}
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
                {% if null != product.extraFields %}
                    {{product.extraFields.price}} SAR
                {% endif %}
            </td>
            <td>{{product.Des}}</td>
            <td>
                {% for cat in product.categories %}
                    {{cat.Title}}, 
                {% endfor %}
            </td>
            <td>
                {% for manfc in product.manufacturers %}
                    <a href="#">{{manfc.Title}}</a> , 
                {% endfor %}
            </td>

            <td style="width: 20px;">{{product.purchaseNumber()}}</td>
            <td><?php echo date('d/m/Y', $product->DateTime); ?></td>
            <td>
                {% if product.Active == 1%}
                <i class="text-success fa fa-check" aria-hidden="true"></i>
                {% else %}
                <i class="text-danger fa fa-close" aria-hidden="true"></i>
                {% endif %}
            </td>
            <td>
                <a href="{{url('content/productView/'~product.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                <a href="{{url('content/edit/'~product.ID)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                <button data-product_id="{{product.ID}}" class="btn btn-xs btn-danger delete_product"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
            </td>
        </tr>
        {% endfor %}
    </tbody>
</table>
<ul class="pagination" style="margin-right:40%;">
<li><a data-page="{{page.first}}" id="first">&laquo;&laquo;</a></li>
<li><a data-page="{{page.before}}" id="before">&laquo;</a></li>
<?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
{% if i == page.current %}
<li class="active"><span>{{i}}</span></li>
{% else %}
<li><a class="products_filter_page" data-page={{i}}>{{i}}</a></li>
{% endif %}
<?php } ?>
<li><a data-page="{{page.next}}" id="next">&raquo;</a></li>
<li><a data-page="{{page.last}}" id="last">&raquo;&raquo;</a></li>
</ul>

<script type="text/javascript">
$('.products_filter_page, #first, #before, #next, #last').on('click', function()
{
    var product_name = $('#product_name').val();
    var manfct_id    = $('#manfcts').val();
    var price_from   = $('#price_from').val();
    var price_to     = $('#price_to').val();
    var depts_ids    = $('.dept_id:checked').map(function()
    {
        return $(this).val();
    }).get();

   $.ajax({
    type: 'post',
    url: "{{url('content/filterproducts')}}",
    data:{
        product_name: product_name,
        manfcts: manfct_id,
        price_from: price_from,
        price_to: price_to,
        depts_ids: depts_ids,
        page: $(this).data('page')
    },
    success: function(response)
    {
        response = JSON.parse(response);
        $('#filter-container').html('');
        $('#filter-container').html(response.content);
    }
   }); 
});

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
                    window.location.href = "{{url('content/productsList/')}}";
                    break;
                }
            }
        });
    }
});
</script>
