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
            <th> ID</th>
            <th>الاسم</th>
            <th> منشور</th>
            <th>ترتيب العرض </th>
            <th>الاجراءات</th>
        </tr>
    </thead>
    <tbody>
        {% for manfct in page.items %}
            <tr class="odd gradeX">
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="checkboxes" value="{{manfct.ID}}"/>
                        <span></span>
                    </label>
            </td>
            <td>{{manfct.ID}}</td>
            <td>{{manfct.Title}}</td>
            <td>
                {% if manfct.Active == 1 %}
                <i class="fa fa-check text-success" aria-hidden="true"></i> نعم
                {% else %}
                 <i class="fa fa-times text-danger" aria-hidden="true"></i> لا 
                {% endif %}
            </td>
            <td>{{manfct.Orders}}</td>
            <td>
                <a href="{{url('manufacturers/view/'~manfct.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                <a href="{{url('manufacturers/edit/'~manfct.ID)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>

                <button data-manfct_id="{{manfct.ID}}" class="delete_manfct btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
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
<li><a data-page="{{i}}" class="manfcts_filter_page">{{i}}</a></li>
{% endif %}
<?php } ?>
<li><a data-page="{{page.next}}" id="next">&raquo;</a></li>
<li><a data-page="{{page.last}}" id="last">&raquo;&raquo;</a></li>
</ul>

<script type="text/javascript">
    $('.manfcts_filter_page, #first, #before, #next, #last').on('click', function()
    {
        var active = $('#checkbox1').is(':checked')?1:0;

       $.ajax({
        type: 'post',
        url: "{{url('manufacturers/filterManufacturers')}}",
        data: {
            name: $('#name').val(),
            active: active,
            page: $(this).data('page')
        },
        success: function(response)
        {
            response = JSON.parse(response);

            $('#filtered_manfcts_container').html('');
            $('#filtered_manfcts_container').html(response.content);
        }
       }); 
    });

    $('#export_excel').on('click', function()
    {
        var ids = {{all_ids}};

        var selected_manfcts = $('.checkboxes:checked').map(function()
        {
            return $(this).val();     
        }).get(); 

        var export_ids = selected_manfcts;

        if(selected_manfcts.length == 0)
        {
            export_ids = ids;
        }

        $.ajax({
            type: 'post',
            url: "{{url('manufacturers/exportExcel')}}",
            data: {all_ids: export_ids},
            success: function(response)
            {
                response = JSON.parse(response);
                
                switch(response.status)
                {
                    case 0:
                    alert('no data to export');
                    break;
                    case 1:
                    window.location.href = "{{url.getStatic('manufacturers/')}}" + response.file_name;
                    break;
                }
            }
        });
    });
</script>