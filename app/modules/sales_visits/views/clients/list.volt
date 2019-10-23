<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url('sales_visits_module/sales_visits')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>

        </ul>
    </div>
    <div class="clearfix"></div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/clients/banner-clients.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
    <div class="portlet light clearfix">
        <div class="gap">
            <?php $this->flashSession->output(); ?>
        </div>
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-users font-dark"></i>
                <span class="caption-subject bold uppercase"> العملاء</span>
            </div>



        </div>
        <div class="portlet-body">
<!--            <div class="panel-group accordion" id="accordion1">-->
<!--                <div class="panel panel-info">-->
<!--                    <div class="panel-heading">-->
<!--                        <h4 class="panel-title">-->
<!--                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">-->
<!--                                <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>-->
<!--                            </a>-->
<!--                        </h4>-->
<!--                    </div>-->
<!--                    <div id="collapse-clients-filter" class="panel-collapse collapse">-->
<!--                        <div class="panel-body">-->
<!--                            <div class="row">-->
<!--                                <div class="col-sm-3">-->
<!--                                    <div class="form-group">-->
<!--                                        <label class=" control-label"> تصنيف العميل </label>-->
<!--                                        <select id="category_id" class="form-control" id="sel1">-->
<!--                                            <option></option>-->
<!--                                            {% for category in categories %}-->
<!--                                            <option value="{{category.id}}">{{category.name}}</option>-->
<!--                                            {% endfor %}-->
<!--                                        </select>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <div class="col-sm-3">-->
<!--                                    <div class="form-group">-->
<!--                                        <label class=" control-label"> اسم العميل</label>-->
<!--                                        <input id="client_name" type="text" class="form-control">-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <div class=" col-sm-3">-->
<!--                                    <div class="form-group">-->
<!--                                        <label class=" control-label"> البريد الالكترونى</label>-->
<!--                                        <input id="email" type="email" class="form-control">-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <div class="col-sm-3">-->
<!--                                    <div class="form-group">-->
<!--                                        <label class=" control-label"> تاريخ آخر نشاط للعميل</label>-->
<!--                                        <input id="last_login" type="date" class="form-control">-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <div class="col-sm-3">-->
<!--                                    <div class="form-group">-->
<!--                                        <label class=" control-label">الشركة</label>-->
<!--                                        <input id="company_name" type="text" class="form-control">-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <div class="col-sm-3">-->
<!--                                    <div class="form-group">-->
<!--                                        <label class=" control-label"> الهاتف</label>-->
<!--                                        <input id="mobile" type="tel" class="form-control">-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <div class=" col-sm-3">-->
<!--                                    <div class="form-group">-->
<!--                                        <label class=" control-label"> البلد</label>-->
<!--                                        <select id="country_id" class="form-control">-->
<!--                                            <option></option>-->
<!--                                            {% for country in countries %}-->
<!--                                            <option value="{{country.id}}">{{country.name}}</option>-->
<!--                                            {% endfor %}-->
<!--                                        </select>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <div class=" col-sm-3">-->
<!--                                    <div class="form-group">-->
<!--                                        <label class=" control-label"> المنطقة</label>-->
<!--                                        <select id="region_id" class="form-control">-->
<!--                                            <option></option>-->
<!--                                            {% for region in regions %}-->
<!--                                            <option value="{{region.id}}">{{region.name}}</option>-->
<!--                                            {% endfor %}-->
<!--                                        </select>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                                <div class="col-sm-4">-->
<!--                                    <label class=""> حالة العضو </label>-->
<!--                                    <div class="col-xs-12 no-padding funkyradio">-->
<!--                                        <div class="col-xs-6 funkyradio-success">-->
<!--                                            <input value="1" type="checkbox" name="is_active" id="checkbox1">-->
<!--                                            <label for="checkbox1">مفعل </label>-->
<!--                                        </div>-->
<!--                                        <div class="col-xs-6 funkyradio-success">-->
<!--                                            <input value="0" type="checkbox" name="is_active" id="checkbox2">-->
<!--                                            <label for="checkbox2"> غير مفعل </label>-->
<!--                                        </div>-->
<!--                                    </div>-->
<!--                                </div>-->
<!--                            </div>-->
<!--                            <button id="filter_clients" class="btn btn-primary">فلتر</button>-->
<!--                        </div>-->
<!--                    </div>-->
<!--                </div>-->
<!--            </div>-->
            <div id="filtered_clients_container">
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
                        <th> أضيف بواسطة </th>
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
                        <td>{{client.CreatedBy.Title}}</td>
                        {% if client.Active == 1%}
                        <td> <i class="fa fa-check text-success" aria-hidden="true"></i> </td>
                        {% else %}
                        <td> <i class="fa fa-times text-danger" aria-hidden="true"></i>
                            <a href="{{url('clients/activate_user/') ~client.ID}}" onclick="return confirm('تفعيل العضو؟')">تفعيل العضو</a>
                        </td>
                        {% endif %}
                        <td><?php echo date('d/m/Y', $client->Join_Date); ?></td>
                        <td>
<!--                            <a href="{{url('clients/view/'~client.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>-->
<!---->
<!--                            <a href="{{url('clients/edit/'~client.ID)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>-->

<!--                            <button data-client_id="{{client.ID}}" class="btn btn-xs btn-danger delete_client"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>-->
                        </td>
                    </tr>
                    {% endfor %}
                    </tbody>
                </table>
                <ul class="pagination" style="margin-right:40%;">
                    <li><a href="{{url('sales_visits_module/clients/list?page=1')}}">&laquo;&laquo;</a></li>
                    <li><a href="{{url('sales_visits_module/clients/list?page='~page.before)}}">&laquo;</a></li>
                    <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
                        {% if i == page.current %}
                        <li class="active"><span>{{i}}</span></li>
                        {% else %}
                        <li><a href="{{url('sales_visits_module/clients/list?page='~i)}}">{{i}}</a></li>
                        {% endif %}
                    <?php } ?>
                    <li><a href="{{url('sales_visits_module/clients/list?page='~page.next)}}">&raquo;</a></li>
                    <li><a href="{{url('sales_visits_module/clients/list?page='~page.last)}}">&raquo;&raquo;</a></li>
                </ul>
            </div>
            <div class="col-xs-12">

            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>

<script type="text/javascript">
    $('#filter_clients').on('click', function()
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
            url: "{{url('sales_visits_module/clients/filterClients')}}",
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
                not_active: not_active
            },
            success: function(response)
            {
                response = JSON.parse(response);

                $('#filtered_clients_container').html('');
                $('#filtered_clients_container').html(response.content);
            }
        });
    });

    $(".delete_client").on('click', function()
    {
        if(confirm('You are about to delete a client, continue?'))
        {
            $.ajax({
                'type':'post',
                'url': "{{url('sales_visits_module/clients/delete/')}}"+$(this).data('client_id'),
                'success': function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                            alert(response.msg);
                            break;
                        case 1:
                            window.location.href = "{{url('clients/list')}}";
                            break;
                    }
                }
            });
        }
    });

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
                    'url':"{{url('sales_visits_module/clients/deleteSelected')}}",
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

    $("#export_excel").on('click',function()
    {
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
            'url':"{{url('sales_visits_module/clients/exportExcel')}}",
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
                        window.location.href = "{{url.getStatic('sales_visits_module/clients/list')}}"+response.file_name;

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
</script>