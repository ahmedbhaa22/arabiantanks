<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">

            <li>
                <span>الزيارات</span>
            </li>
        </ul>
    </div>
    <div class="clearfix"></div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
    <div class="portlet light clearfix">
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-users font-dark"></i>
                <span class="caption-subject bold uppercase"> الزيارات</span>
            </div>

            <div class="actions">
                <a type="button" href="{{this.url_shared.get('sales_visits_module/sales_visits/add')}}" class="btn btn-edit-my-data green-jungle btn-outline  btn-block">
					   <i class="fa fa-user-plus"></i>
					   اضافة زيارة</a>
            </div>

            <div class="actions">
                <a type="button" href="{{this.url_shared.get('sales_visits_module/clients/list')}}" class="btn btn-edit-my-data green-jungle btn-outline  btn-block">
                    <i class="fa fa-user-plus"></i>
                    العملاء</a>
            </div>

            <div class="actions">
                <a type="button" href="{{this.url_shared.get('sales_visits_module/clients/new')}}" class="btn btn-edit-my-data green-jungle btn-outline  btn-block">
                    <i class="fa fa-user-plus"></i>
                    اضافة عميل</a>
            </div>



        </div>
        <div class="panel-group accordion hide-print" id="accordion1">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">
                            <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                        </a>
                    </h4>
                </div>

                {{ partial("sales_visits/partials/filter_visits",['regions':regions]) }}
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
                        <th> نوع المهمة</th>
                        <th> اسم العميل </th>
                        <th> تاريخ الزيارة</th>
                        <th> تصنيف العميل</th>
                        <th>الاجراءات</th>
                    </tr>
                </thead>
                <tbody>
                    {% for visit in page.items %}
                        <tr class="odd gradeX">
                            <td>
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                        <input type="checkbox" class="checkboxes" value="{{visit.id}}"/>
                                        <span></span>
                                    </label>
                            </td>
                            <td>{{visit.missionType.name_ar}}</td>
                            <td>{{visit.client.Title}}</td>
                            <td>{{visit.formattedDate('d/m/Y')}}</td>
                            <td>
                                {% if visit.client.category != null %}
                                    {{visit.client.category.name}}
                                {% endif %}
                            </td>
                            <td>
                                <a href="{{this.url_shared.get('sales_visits_module/sales_visits/view/'~visit.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                                <a href="{{this.url_shared.get('sales_visits_module/sales_visits/edit/'~visit.id)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                                <?php if($this->session->get('auth-identity')['is_admin']=="1"):?>
                                <button data-visit_id="{{visit.id}}" class="delete-visit btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                <?php endif; ?>
                            </td>
                        </tr>
                    {% endfor %}
                </tbody>
            </table>
            <ul class="pagination" style="margin-right:40%;">
            <li><a href="{{url('sales_visits_module/sales_visits/index?page=1')}}">&laquo;&laquo;</a></li>
            <li><a href="{{url('sales_visits_module/sales_visits/index?page='~page.before)}}">&laquo;</a></li>
            <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
            {% if i == page.current %}
            <li class="active"><span>{{i}}</span></li>
            {% else %}
            <li><a href="{{url('sales_visits_module/sales_visits/index?page='~i)}}">{{i}}</a></li>
            {% endif %}
            <?php } ?>
            <li><a href="{{url('sales_visits_module/sales_visits/index?page='~page.next)}}">&raquo;</a></li>
            <li><a href="{{url('sales_visits_module/sales_visits/index?page='~page.last)}}">&raquo;&raquo;</a></li>
            </ul>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>

<script type="text/javascript">
    $('.delete-visit').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد زيارات المبيعات، إستكمال العملية؟'))
       {
            $.ajax({
                type: 'post',
                url: "{{this.url_shared.get('sales_visits_module/sales_visits/delete/')}}" + $(this).data('visit_id'),
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                        alert(response.msg);
                        break;
                        case 1:
                        window.location.href = "{{this.url_shared.get('sales_visits_module/sales_visits/index')}}";
                        break;
                    }
                }
            });
       }
    });




</script>