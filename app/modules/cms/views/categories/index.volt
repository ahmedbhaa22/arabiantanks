<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url('home/index/1')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
             <li>
                <a href="{{url('home/index/2')}}"><span> المنتجات </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <a href="{{url('content/productsList')}}"><span> محتوى </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <span>التصنيفات </span>
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
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-puzzle-piece" aria-hidden="true"></i>
                <span class="caption-subject bold uppercase">  التصنيفات </span>
            </div>
            <div class="actions">
                <a type="button" href="{{url('categories/add')}}" class="btn green-jungle btn-outline btn-block">
					   <i class="fa fa-plus"></i>
					   اضافة تصنيف جديد </a>
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
                                    <div class="col-xs-4">
                                        <label class="control-label col-md-2  col-sm-2">الاسم</label>
                                        <div class="col-md-10 col-sm-10">
                                            <input type="text" id="name" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-xs-3">
                                        <div class="col-md-12">
                                            <input id="active" type="checkbox" class="make-switch" data-on-text="مفعل" checked data-on-color="info" data-off-text="غير مفعل" data-off-color="danger">

                                        </div>
                                    </div>
                                <div class="col-xs-3">
                                    <button id="filter_categories" type="button" class="btn btn-sm btn-primary">فلتر</button>
                                </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="filtered_categories_container">
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
                        <td>
                            {% if cat.ar != null %}
                                {{cat.ar.title}}
                            {% else %}
                                {{cat.Title}}
                            {% endif %}
                        </td>
                        <td>
                            {% if cat.ar != null %}
                                {{cat.ar.des|striptags}}
                            {% else %}
                                {{cat.Des|striptags}}
                            {% endif %}
                        </td>
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
            <li><a href="{{url('categories/index?page=1')}}">&laquo;&laquo;</a></li>
            <li><a href="{{url('categories/index?page='~page.before)}}">&laquo;</a></li>
            <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
            {% if i == page.current %}
            <li class="active"><span>{{i}}</span></li>
            {% else %}
            <li><a href="{{url('categories/index?page='~i)}}">{{i}}</a></li>
            {% endif %}
            <?php } ?>
            <li><a href="{{url('categories/index?page='~page.next)}}">&raquo;</a></li>
            <li><a href="{{url('categories/index?page='~page.last)}}">&raquo;&raquo;</a></li>
            </ul>
            </div>

            <div class="col-xs-12">
                <button id="activate_selected" class="btn btn-success btn-md">
                    <i class="fa fa-check" aria-hidden="true"></i>
                     تفعيل المختار
                </button>
                 <button id="deactivate_selected" class="btn dark btn-md">
                    <i class="fa fa-times" aria-hidden="true"></i>
                      عدم تفعيل المختار
                </button>
                <button id="delete_selected" class="delete-btn btn btn-danger btn-md">
                    <i class="fa fa-trash"></i>حذف المحدد
                </button>
            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->

</div>

<script type="text/javascript">
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

    $('#delete_selected').on('click', function()
    {
        var selected_ids = $('.checkboxes:checked').map(function()
        {
            return $(this).val();     
        }).get();

        if(selected_ids.length > 0)
        {
            if(confirm('أنت على وشك حذف مجموعة أقسام، إستكمال العملية؟'))
            {
                $.ajax({
                    type: 'post',
                    url: "{{url('categories/deleteSelected')}}",
                    data: {ids: selected_ids},
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
        }
    });

    $('#activate_selected').on('click', function()
    {
        var selected_ids = $('.checkboxes:checked').map(function()
        {
            return $(this).val();     
        }).get(); 

        if(selected_ids.length > 0)
        {
            $.ajax({
                type: 'post',
                url: "{{url('categories/activateSelected')}}",
                data: {ids: selected_ids},
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

    $('#deactivate_selected').on('click', function()
    {
       var selected_ids = $('.checkboxes:checked').map(function()
       {
            return $(this).val(); 
       }).get();

       if(selected_ids.length > 0)
       {
            $.ajax({
                type: 'post',
                url: "{{url('categories/deactivateSelected')}}",
                data: {ids: selected_ids},
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

    $('#filter_categories').on('click', function()
    {
        var active = $('#active').is(':checked')?1:0;

       $.ajax({
        type: 'post',
        url: "{{url('categories/filterCategories')}}",
        data: {
            name: $('#name').val(),
            active: active,
        },
        success: function(response)
        {
            response = JSON.parse(response);

            $('#filtered_categories_container').html('');
            $('#filtered_categories_container').html(response.content);
        }
       }); 
    });
</script>