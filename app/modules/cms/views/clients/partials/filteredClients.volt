<table class="table table-striped table-bordered table-hover table-checkable order-column custom_table" id="sample_11">
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
        <th> البريد الالكترونى</th>
        <th> اسم العميل </th>
        <th> تصنيف العميل</th>
        <th>الشركة</th>
        <th>الهاتف</th>
		<th> الرمز البريدي </th>
        <th> نشط</th>
		<th> تاريخ التسجيل </th>
        <th>الاجراءات</th>
    </tr>
</thead>
<tbody>
    {% for client in page.items %}
        <tr class="odd gradeX">
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="checkboxes" value="{{ client.ID }}"/>
                        <span></span>
                    </label>
            </td>
            <td style="width: 20px;">{{client.ID}}</td>
            <td><a href="mailto:{{client.Mail}}">{{ client.Mail }}</a> </td>
            <td>{{ client.Title }}</td>
            <td>{{ client.category.name }}</td>
            <td>{{ client.data.company_name }}</td>
            <td class="center"><a href="tel:{{client.Mobile}}">{{ client.Mobile }}</a></td>
            <td>{{client.data.postal_code}}</td>
            {% if client.Active == 1%}
            <td> <i class="fa fa-check text-success" aria-hidden="true"></i> </td>
            {% else %}
            <td> <i class="fa fa-times text-danger" aria-hidden="true"></i> </td>
            {% endif %}
            <td><?php echo date('d/m/Y', $client->Join_Date); ?></td>
            <td>
                <a href="{{url('clients/view/'~client.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                <a href="{{url('clients/edit/'~client.ID)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>

                <button data-client_id="{{client.ID}}" class="btn btn-xs btn-danger delete_client"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
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
<li><a class="clients_filter_page" data-page={{i}}>{{i}}</a></li>
{% endif %}
<?php } ?>
<li><a data-page="{{page.next}}" id="next">&raquo;</a></li>
<li><a data-page="{{page.last}}" id="last">&raquo;&raquo;</a></li>
</ul>

<script type="text/javascript">

$("#delete_selected_clients").on('click', function()
{
    var selected_clients = $(".checkboxes:checked").map(function()
    {
        return $(this).val();
    }).get();

    if(selected_clients.length > 0)
    {
        if(confirm('أتا على وشك لقيام بحذف مجموعة عملاء، إستكمال العملية؟'))
        {
            $.ajax({
            'type':'post',
            'url':"{{url('clients/deleteSelected')}}",
            'data':{'clients':selected_clients},
            'success':function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('clients/list')}}"
                    break;
                }
            }
        });
        }
    }
});

    $("#export_excel").on('click', function()
        {
            console.log({{all_ids}});
            var ids = {{all_ids}};

            var selected_clients = $(".checkboxes:checked").map(function()
            {
                return $(this).val();
            }).get();

            var export_ids = selected_clients;

            if(selected_clients.length == 0)
            {
                export_ids = ids;
            }

            $.ajax({
                'type':'post',
                'url':"{{url('clients/exportExcel')}}",
                'data':{'all_ids':export_ids},
                'success':function(response)
                {
                    response = JSON.parse(response);
                    switch(response.status)
                    {
                        case 0:
                        alert('no data to export');
                        break;
                        case 1:
                        window.location.href = "{{url.getStatic('clients/')}}"+response.file_name;

                        // $.ajax({
                        //     'type':'post',
                        //     'url':"{{url('clients/removeFile')}}",
                        //     'data':{file_name:response.file_name},
                        // });
                        break;
                    }
                }
            });                        
        });

    $('.clients_filter_page, #first, #before, #next, #last').on('click', function()
    {
        var category_id = $('#category_id').val();
        var client_name = $('#client_name').val();
        var email       = $('#email').val();
        var last_login  = $('#last_login').val();
        var company_name = $('#company_name').val();
        var mobile       = $('#mobile').val();
        var country_id   = $('#country_id').val();
        var region_id    = $('#region_id').val();
        var is_active    = $('#checkbox1').is(':checked')?1:0;
        var not_active   = $('#checkbox2').is(':checked')?1:0;

        $.ajax({
            type: 'post',
            url: "{{url('clients/filterClients')}}",
            data:{
                category_id: category_id,
                client_name: client_name,
                email: email,
                last_login: last_login,
                company_name: company_name,
                mobile: mobile,
                country_id : country_id,
                region_id: region_id,
                is_active: is_active,
                not_active: not_active,
                page: $(this).data('page')
            },
            success: function(response)
            {
                response = JSON.parse(response);
                $('#filtered_clients_container').html('');
                $('#filtered_clients_container').html(response.content);
            }
        });
    });
</script>