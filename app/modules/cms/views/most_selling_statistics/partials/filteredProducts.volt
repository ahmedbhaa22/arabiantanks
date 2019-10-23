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
<li><a data-page="{{page.first}}" id="first">&laquo;&laquo;</a></li>
<li><a data-page="{{page.before}}" id="before">&laquo;</a></li>
<?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
{% if i == page.current %}
<li class="active"><span>{{i}}</span></li>
{% else %}
<li><a data-page="{{i}}" class="products_filter_page">{{i}}</a></li>
{% endif %}
<?php } ?>
<li><a data-page="{{page.next}}" id="next">&raquo;</a></li>
<li><a data-page="{{page.last}}" id="last">&raquo;&raquo;</a></li>
</ul>

<script type="text/javascript">
    $('.products_filter_page, #first, #before, #next, #last').on('click', function()
    {
       $.ajax({
        type: 'post',
        url: "{{url('most_selling_statistics/filter')}}",
        data: {
            start_date: $('#start_date').val(),
            end_date: $('#end_date').val(),
            category_id: $('#category_id').val(),
            manfct_id: $('#manfct_id').val(),
            branch_id: $('#branch_id').val(),
            page: $(this).data('page')
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