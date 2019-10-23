<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <a href="{{url('content/main/8')}}"><span> المنتجات </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
            <li>
                <a href="{{url('sales/index')}}"><span> المبيعات </span></a>
                <i class="fa fa-angle-left" aria-hidden="true"></i>
            </li>
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
                <span class="caption-subject bold uppercase"> مندوبين المبيعات</span>
            </div>

            <div class="actions">

<!--                <a type="button" href="{{url('sales_visits/index')}}"  class="btn btn-sm btn-success pull-right">-->
<!--                    <i class="fa fa-pencil" aria-hidden="true"></i> احصائيات الزيارات-->
<!--                </a>-->
            </div>

        </div>
        <div class="portlet-body">
            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_11">
                <thead>
                <tr>
                    <th>

                    </th>
                    <th style="width: 20px;"> ID</th>
                    <th> البريد الالكترونى</th>
                    <th> اسم المندوب </th>
                    <th>الهاتف</th>
                    <th>اجراءات</th>

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

                    <td class="center"><a href="tel:{{client.Mobile}}">{{client.Mobile}}</a></td>

                   <td><a href="{{this.url_shared.get('cms_module/sales_visits/sales_visits_stats/') ~client.ID}}">احصائيات</a> </td>
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
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>

