<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
             <li>
                <a href="{{url('content/productsList')}}"><span> المنتجات </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <!-- <li>
                <a href="production_content.html"><span> محتوى </span></a>
                <i class="fa fa-angle-left"></i>
            </li> -->
            <li>
                <span>{{translate._('Product Tags')}}</span>
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
                <i class="fa fa-tag font-dark"></i>
                <span class="caption-subject bold uppercase"> {{translate._('Products Tags')}}</span>
            </div>

        </div>
        <div class="portlet-body">
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
                        <th>اسم التاج</th>
                        <th> المنتجات الموسومة </th>
                        <th>الاجراءات</th>
                    </tr>
                </thead>
                <tbody>
                    {% for _tag in page.items %}
                     <tr class="odd gradeX">
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="checkboxes" value="{{_tag.id}}"/>
                                    <span></span>
                                </label>
                        </td>
                        <td>{{_tag.id}}</td>
                        <td>{{_tag.name}}</td>
                        <td>{{_tag.productsCount()}}</td>
                        <td>

                            <button class="delete_tag btn btn-xs btn-danger" data-tag_id="{{_tag.id}}"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
            <ul class="pagination" style="margin-right:40%;">
            <li><a href="{{url('product_tags/index?page=1')}}">&laquo;&laquo;</a></li>
            <li><a href="{{url('product_tags/index?page='~page.before)}}">&laquo;</a></li>
            <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
            {% if i == page.current %}
            <li class="active"><span>{{i}}</span></li>
            {% else %}
            <li><a href="{{url('product_tags/index?page='~i)}}">{{i}}</a></li>
            {% endif %}
            <?php } ?>
            <li><a href="{{url('product_tags/index?page='~page.next)}}">&raquo;</a></li>
            <li><a href="{{url('product_tags/index?page='~page.last)}}">&raquo;&raquo;</a></li>
            </ul>
            <div class="col-xs-12">
<!--
                <button class="delete-btn btn btn-success btn-md">
                    <i class="fa fa-file-excel-o" aria-hidden="true"></i>إستخراج ملف اكسيل
                </button>
-->
                <button id="delete_selected" class="delete-btn btn btn-danger btn-sm">
                    <i class="fa fa-trash"></i>حذف المحدد
                </button>
            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->

</div>
<script type="text/javascript">
    $('.delete_tag').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد تاجات المنتجات، إستكمال العملية؟'))
       {
            $.ajax({
                type: 'post',
                url: "{{url('product_tags/delete/')}}" + $(this).data('tag_id'),
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{url('product_tags/index')}}";
                        break;
                    }
                }
            });
       } 
    });

    $('#delete_selected').click(function()
            {
               var selected_ids = $('.checkboxes:checked').map(function()
               {
                return $(this).val();
               }).get(); 

               if(selected_ids.length > 0)
               {
                if(confirm('أنت على وشك القيام بحذف مجموعة تاجات، إستكمال العملية؟'))
                {
                    $.ajax({
                    type: 'post',
                    url: "{{url('product_tags/deleteSelected')}}",
                    data: {selected_ids: selected_ids},
                    success: function(response)
                    {
                        response = JSON.parse(response);

                        switch(response.status)
                        {
                            case 0:
                            alert(response.msg);
                            break;
                            case 1:
                            window.location.href = "{{url('product_tags/index')}}";
                            break;
                        }
                    }
                });
                }
               }
            });
</script>