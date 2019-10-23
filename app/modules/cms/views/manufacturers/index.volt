<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
             <li>
                <a href="{{url('content/main/8')}}"><span> المنتجات </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <a href="{{url('content/productsList')}}"><span> محتوى </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <span>الشركات المصنعة</span>
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
        <div class="gap">
                  <?php $this->flashSession->output(); ?>
                </div>
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-suitcase" aria-hidden="true"></i>
                <span class="caption-subject bold uppercase"> الشركات المصنعة</span>
            </div>

            <div class="actions">
                <a type="button" href="{{url('manufacturers/add')}}" class="btn btn-edit-my-data green-jungle btn-outline  btn-block">
					   <i class="fa fa-user-plus"></i>
					   اضافة شركة مصنعة</a>
            </div>
            
        </div>
        <div class="portlet-body">
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
                                <div class="row">

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="col-md-2 col-xs-4">اسم الشركة</label>
                                            <div class="col-md-10 col-xs-8">
                                                <input id="name" type="text" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-group funkyradio col-xs-12 no-padding">
                                            <div class="funkyradio-success">
                                                <input type="checkbox" name="checkbox" id="checkbox1" checked />
                                                <label for="checkbox1"> مفعل</label>
                                            </div>
                                        </div>
                                        
                                    </div>

                                </div>
                                <button id="filter_manfcts" type="button" class="btn btn-primary">فلتر</button>
                        </div>
                    </div>
                </div>
            </div>
            <div id="filtered_manfcts_container">
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
            <li><a href="{{url('manufacturers/index?page=1')}}">&laquo;&laquo;</a></li>
            <li><a href="{{url('manufacturers/index?page='~page.before)}}">&laquo;</a></li>
            <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
            {% if i == page.current %}
            <li class="active"><span>{{i}}</span></li>
            {% else %}
            <li><a href="{{url('manufacturers/index?page='~i)}}">{{i}}</a></li>
            {% endif %}
            <?php } ?>
            <li><a href="{{url('manufacturers/index?page='~page.next)}}">&raquo;</a></li>
            <li><a href="{{url('manufacturers/index?page='~page.last)}}">&raquo;&raquo;</a></li>
            </ul>
            </div>
            <div class="col-xs-12">
                <button id="export_excel" class="btn btn-success btn-sm">
                    <i class="fa fa-file-excel-o" aria-hidden="true"></i>إستخراج ملف اكسيل
                </button>
                <button id="delete_selected" class="btn btn-danger btn-sm">
                    <i class="fa fa-trash"></i>حذف المحدد
                </button>
            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>
<script type="text/javascript">
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

    $('.delete_manfct').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد المصنعين، إستكمال العملية؟'))
       {
            $.ajax({
                'type':'post',
                'url': "{{url('manufacturers/delete/')}}"+$(this).data('manfct_id'),
                'success': function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('manufacturers/index')}}";
                        break;
                    }
                }
            });
       } 
    });

    $("#delete_selected").click(function()
    {
        var selected_manfcts = $(".checkboxes:checked").map(function()
        {
            return $(this).val();
        }).get();

        if(selected_manfcts.length > 0)
        {
            if(confirm('أنت على وشك القيام بحذف مجموعة مصنعين، إستكمال العملية؟'))
            {
                $.ajax({
                'type':'post',
                'url':"{{url('manufacturers/deleteSelected')}}",
                'data':{'manfcts':selected_manfcts},
                'success':function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('manufacturers/index')}}"
                        break;
                    }
                }
            });
            }
        }
    });

    $('#filter_manfcts').on('click', function()
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
</script>