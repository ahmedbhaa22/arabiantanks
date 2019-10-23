<table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
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
        <th> تاريخ النشر </th>
        <th> النشاط الأخير </th>
        <th style="width: 15%"> إجراءات </th>
    </tr>
    </thead>
    <tbody>
    {%for item in page.items%}
    <tr class="odd gradeX">
        <td style="width: 20px;">{{item.ID}}</td>
        <td><a href="mailto:shuxer@gmail.com">{{item.Mail}}</a> </td>
        <td>{{item.Title}}</td>
        <td> {{item.category.name}} </td>
        <td><a href="http://pentavalue.com/en" title="Pentavalue" target="_blank"> الشركة الوطنية للمياة </a></td>
        <td class="center"><a href="tel:01234567890">{{item.Mobile}}</a></td>
        <td> 5588 </td>
        <td> <i class="fa fa-check text-success" aria-hidden="true"></i> </td>
        <td>12/12/2015 </td>
        <td>30/12/2016 </td>
        <td class="funkyradio" style="width: 15%">
            <div class="funkyradio-info">
                <input type="radio" name="client" id="client{{item.ID}}" class="chosen_client" value="{{item.ID}}">
                <label for="client{{item.ID}}"> إختيار العميل </label>
            </div>


        </td>
    </tr>
    {%endfor%}

    </tbody>
</table>
<div class="row">
    <div class="col-md-5 col-sm-5">
        <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
            {{page.current}}/{{page.total_pages}}          </div>
    </div>
    <div class="col-md-7 col-sm-7">
        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
            <ul class="pagination" style="visibility: visible;">
                <li class='ask_client_page'><a href="{{page.first}}">الأول</a></li>
                <li class='ask_client_page'><a href="{{page.before}}">السابق</a></li>
                <li class='ask_client_page'><a href="{{page.next}}">التالي</a></li>
                <li class='ask_client_page'><a href="{{page.last}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>
<script>
    var polls_url= "{{this.url_shared.get('polls_module/polls/polls_table')}}";
    $(".chosen_client").change(function() {
        if(this.checked) {
            var client = $("input[class='chosen_client']:checked").val();
            $("#client_val").val(client);
            $("#poll_choose").load(polls_url);
        }
    });

    $(".ask_client_page a").click(function(e) {
        e.preventDefault();
        var url = "{{this.url_shared.get('polls_module/polls/clients_table')}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#ask_clients_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#clients_table").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>

