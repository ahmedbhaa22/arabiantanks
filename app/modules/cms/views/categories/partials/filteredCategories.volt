<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_11">
    <thead>
        <tr>
            <th style="width: 20px;">
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="group-checkable"
                           data-set="#sample_11 .checkboxes"/>
                    <span></span>
                </label>
            </th>
            <th style="width: 30px;"> ID</th>
            <th>الأسم</th>
            <th> الوصف </th>
            <th style="width: 20px;">ترتيب العرض </th>
            <th style="width: 20px;">مفعل</th>
            <th style="width: 100px;">الاجراءات</th>
        </tr>
    </thead>
    <tbody>
        {% for cat in page.items %}
            <tr class="odd gradeX">
            <td style="width: 20px;">
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="checkboxes" value="{{cat.ID}}"/>
                    <span></span>
                </label>
            </td>
            <td style="width: 30px;">{{cat.ID}}</td>
            <td>{{cat.Title}}</td>
            <td>{{cat.Des}}</td>
            <td style="width: 20px;">{{cat.Orders}}</td>
            <td style="width: 20px;">
                {% if cat.Active == 1%}
                <i class="text-success fa fa-check" aria-hidden="true"></i> 
                {% else %}
                <i class="text-danger fa fa-close" aria-hidden="true"></i> 
                {% endif %}
            </td>
            <td style="width:100px;">
                <a href="{{url('categories/view/'~cat.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                <a href="{{url('categories/edit/'~cat.ID)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                <button data-cat_id="{{cat.ID}}" class="delete-cat btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
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
<li><a data-page="{{i}}" class="categories_filter_page">{{i}}</a></li>
{% endif %}
<?php } ?>
<li><a data-page="{{page.next}}" id="next">&raquo;</a></li>
<li><a data-page="{{page.last}}" id="last">&raquo;&raquo;</a></li>
</ul>

<script type="text/javascript">
    $('.categories_filter_page, #first, #before, #next, #last').on('click', function()
    {
        var active = $('#active').is(':checked')?1:0;

       $.ajax({
        type: 'post',
        url: "{{url('categories/filterCategories')}}",
        data: {
            name: $('#name').val(),
            active: active,
            page: $(this).data('page')
        },
        success: function(response)
        {
            response = JSON.parse(response);

            $('#filtered_categories_container').html('');
            $('#filtered_categories_container').html(response.content);
        }
       }); 
    });

    $('.delete-cat').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد الأقسام، إستكمال العملية؟'))
       {
        $.ajax({
            type: 'post',
            url: "{{url('categories/delete/')}}" + $(this).data('cat_id'),
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('categories/index')}}";
                    break;
                }
            }
        });
       } 
    });
</script>