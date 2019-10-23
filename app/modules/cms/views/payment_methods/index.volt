<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url.getStatic('cms_module/home/index/1')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
             <li>
                <a href="{{url.getStatic('cms_module/home/index/3')}}"><span> التحكم في الويبسايت </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>طرق الدفع / البنوك</li>
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
                <span class="caption-subject bold uppercase">  طرق الدفع / البنوك </span>
            </div>
            <div class="actions">
                <a type="button" href="{{url.getStatic('cms_module/payment_methods/new')}}" class="btn green-jungle btn-outline btn-block">
					   <i class="fa fa-plus"></i>
					   اضافة بنك جديد </a>
            </div>
        </div>
        <div class="portlet-body">
            <!-- <div class="panel-group accordion" id="accordion1">
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
            </div> -->
            <div id="filtered_banks_container">
                <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
                <thead>
                    <tr>
                        <th style="width: 20px;">
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                <input type="checkbox" class="group-checkable"
                                       data-set="#sample_1 .checkboxes"/>
                                <span></span>
                            </label>
                        </th>
                        <th style="width: 30px;"> مسلسل</th>
                        <th>أسم البنك</th>
                        <th> أسم الحساب </th>
                        <th>رقم الحساب</th>
                        <th style="width: 100px;">الاجراءات</th>
                    </tr>
                </thead>
                <tbody>
                    {% for bank in payment_methods %}
                        <tr class="odd gradeX">
                        <td style="width: 20px;">
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                <input type="checkbox" class="checkboxes" value="{{bank.id}}"/>
                                <span></span>
                            </label>
                        </td>
                        <td style="width: 30px;">{{bank.id}}</td>
                        <td>{{bank.bank_name}}</td>
                        <td>{{bank.account_name}}</td>
                        <td>{{bank.account_number}}</td>
                        <td style="width:100px;">
                            <a href="{{url.getStatic('cms_module/payment_methods/edit/'~bank.id)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                            <button data-bank_id="{{bank.id}}" class="delete-bank btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
            </div>

            <div class="col-xs-12">
                <button id="delete_selected_banks" class="delete-btn btn btn-danger btn-md">
                    <i class="fa fa-trash"></i>حذف المحدد
                </button>
            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->

</div>

<script type="text/javascript">
    $('.delete-bank').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد البنوك، إستكمال العملية؟'))
       {
        $.ajax({
            type: 'post',
            url: "{{url.getStatic('cms_module/payment_methods/delete/')}}" + $(this).data('bank_id'),
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url.getStatic('cms_module/payment_methods/index')}}";
                    break;
                }
            }
        });
       } 
    });

    $('#delete_selected_banks').on('click', function()
    {
        var selected_ids = $('.checkboxes:checked').map(function()
        {
            return $(this).val();     
        }).get();

        if(selected_ids.length > 0)
        {
            if(confirm('أنت على وشك حذف مجموعة بنوك إستكمال العملية؟'))
            {
                $.ajax({
                    type: 'post',
                    url: "{{url.getStatic('cms_module/payment_methods/deleteSelected')}}",
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
                            window.location.href = "{{url.getStatic('cms_module/payment_methods/index')}}";
                            break;
                        }
                    }
                });
            }
        }
    });
</script>