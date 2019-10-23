<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_11">
    <thead>
        <tr>
            <th>
               
            </th>
            <th style="width: 20px;"> ID</th>
            <th> البريد الالكترونى</th>
            <th> اسم العميل </th>
            <th> تصنيف العميل</th>
            <th>الشركة</th>
            <th>الهاتف</th>
			<th> الرمز البريدي </th>
            <th> نشط</th>
        </tr>
    </thead>
    <tbody>
        {% for client in page.items %}
            <tr class="odd gradeX">
                <td>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="radio" name="client_id" class="checkboxes" value="{{client.ID}}"/>
                            <span></span>
                        </label>
                </td>
                <td style="width: 20px;">{{client.ID}}</td>
                <td><a href="mailto:{{client.Mail}}">{{client.Mail}}</a> </td>
                <td>{{client.Title}}</td>
                <td>
                    {% if client.category != null %}
                        {{client.category.name}}
                    {% endif %}
                </td>
                <td>
                    {% if client.data != null %}
                        {{client.data.company_name}}
                    {% endif %}
                </td>
                <td class="center"><a href="tel:{{client.Mobile}}">{{client.Mobile}}</a></td>
                <td>
                    {% if client.data != null %}
                        {{client.data.postal_code}}
                    {% endif %}
                </td>
                <td>
                    {% if client.Active == 1 %}
                        <i class="fa fa-check text-success" aria-hidden="true"></i> 
                    {% else %}
                        <i class="fa fa-close text-danger" aria-hidden="true"></i> 
                    {% endif %}
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
<li><a data-page="{{i}}" class="clients_filter_page">{{i}}</a></li>
{% endif %}
<?php } ?>

<li><a data-page="{{page.next}}" id="next">&raquo;</a></li>

<li><a data-page="{{page.last}}" id="last">&raquo;&raquo;</a></li>
</ul>

<script type="text/javascript">
    $('.clients_filter_page, #first, #before, #next, #last').on('click', function()
    {
       $.ajax({
        type: 'get',
        url: "{{url('sales_visits/filterClients')}}",
        data:{
            'client_category':$('#client_category').val(),
            'client_name':$('#client_name').val(),
            'client_email': $('#client_email').val(),
            'company': $('#company').val(),
            'mobile':$('#mobile').val(),
            'country': $('#country').val(),
            'region': $('#region').val(),
            'active': $('#active').is(':checked'),
            'not_active': $('#not_active').is(':checked'),
            'page':$(this).data('page')
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