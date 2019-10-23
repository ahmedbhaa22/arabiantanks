<div id="filtered_clients_container" class="col-xs-12 no-padding space">
    <table class="table table-striped table-bordered table-hover table-checkable order-column table-condensed" id="">
        <thead>
        <tr>

            <th style="width: 20px;"> ID</th>
            <th> البريد الالكترونى</th>
            <th> اسم العميل </th>
            <th> تصنيف العميل</th>
            <th>الشركة</th>
            <th>الهاتف</th>
            <th> الرمز البريدي </th>
            <th> نشط</th>
            <th> تاريخ التسجيل </th>
            <th>اختيار العميل</th>
        </tr>
        </thead>
        <tbody>
        {% for client in page.items %}
        <tr class="odd gradeX">

            <td style="width: 20px;">{{client.ID}}</td>
            <td><a href="mailto:{{client.Mail}}">{{ client.Mail }}</a> </td>
            <td>{{ client.Title }}</td>
            <td>{{ client.category.name }}</td>
            <td>
                {%if(client.data)%}
                {{ client.data.company_name }}
                {%else%}
                {%endif%}

            </td>
            <td class="center"><a href="tel:{{client.Mobile}}">{{ client.Mobile }}</a></td>
            <td>
                {%if(client.data)%}
                {{ client.data.postal_code }}
                {%else%}
                {%endif%}
            </td>
            {% if client.Active == 1%}
            <td> <i class="fa fa-check text-success" aria-hidden="true"></i> </td>
            {% else %}
            <td> <i class="fa fa-times text-danger" aria-hidden="true"></i> </td>
            {% endif %}
            <td><?php echo date('d/m/Y', $client->Join_Date); ?></td>
            <td>
                <input type="radio" name="client_choose" class="client_choose" value="{{ client.ID }}"  />
            </td>
        </tr>
        {% endfor %}
        </tbody>
    </table>

</div>

<div class="row">
    <div class="col-md-5 col-sm-5">
        <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
            {{page.total_pages}}/{{page.current}}                    </div>
    </div>
    <div class="col-md-7 col-sm-7">
        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
            <ul class="pagination" style="visibility: visible;">
                <li class='clients_page' style="opacity: 1;position: relative;padding: 0"><a href="1">الأول</a></li>
                <li class='clients_page' style="opacity: 1;position: relative;padding: 0"><a href="{{page.before}}">السابق</a></li>
                <li class='clients_page' style="opacity: 1;position: relative;padding: 0"><a href="{{page.next}}">التالي</a></li>
                <li class='clients_page' style="opacity: 1;position: relative;padding: 0"><a href="{{page.last}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>
<script>
    $(".clients_page a").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/requests/getClientsAjax')}}"+"&page="+$(this).attr("href")+"&fast={{fast_search}}"; // the script where you handle the form input.
        var client_name=$("#client_name").val();
        var client_mobile=$("#client_mobile").val();
        var data = {
            'client_name': client_name,
            'client_mobile': client_mobile
        };
        $.ajax({
            type: "POST",
            url: url,
            data: data, // serializes the form's elements.
            success: function (response)
            {

                $("#clients_content").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });

    $('input:radio[name="client_choose"]').change(
        function(){
            if ($(this).is(':checked')) {
               // alert($(this).val());
                var value= $(this).val();

                // append goes here
                var client_info_url= "{{url('maintenance_module/requests/clientInfoAjax/')}}"+value;
                $.ajax({
                    type: "POST",
                    url: client_info_url,
                    success: function (response)
                    {

                        var json = response;
                        $("#revise_client_name").text(json.Title);
                        $("#client_phone").val(json.Mobile);
                        $("#revise_client_phone").text(json.Mobile);
                        $("#client_mail").val(json.Mail);
                        $("#revise_client_mail").text(json.Mail);
                        $("#client_region").val(json.region_name);
                        $("#revise_client_region").text(json.region_name);

                        //$('#collapse-clients-filter').collapse('toggle');
                    }
                });
            }
        });
</script>