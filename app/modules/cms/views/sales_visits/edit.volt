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
            <a href="{{url('sales/index')}}"><span>المبيعات</span></a>
            <i class="fa fa-angle-left"></i>
        </li>
		<li>
			<a href="{{url('sales_visits/index')}}"><span>الزيارات</span></a>
            <i class="fa fa-angle-left"></i>
		</li>
		<li>
			<span>تعديل الزيارة</span>
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
</div> <div class="portlet light clearfix">
<div class="portlet-title">
      <div class="caption font-dark">
          <h4 class="caption-subject bold uppercase">
			<i class="fa fa-user" aria-hidden="true"></i>
            تعديل الزيارة
          </h4>
      </div>
  </div>
	<div class="portlet-body">
    
    <form role="form" action="{{url('sales_visits/save/'~visit.id)}}" method="post" enctype="multipart/form-data">
        <div class="col-xs-12 no-padding clearfix">
       <div class="col-md-6 form-group">
            <label class="control-label"> تاريخ الزيارة :</label>
            <input value="{{visit.formattedDate('Y-m-d')}}" name="visit_date" type="date" class="form-control">
        </div>
       <div class="col-md-6 form-group">
            <label class="control-label"> نوع المهمة:</label>
            <select name="mission_type" class="select form-control">
                {% for mission in mission_types %}
                    {% if mission.id == visit.mission_type_id %}
                        <option selected value="{{mission.id}}">{{mission.name_ar}}</option>
                    {% else %}
                        <option value="{{mission.id}}">{{mission.name_ar}}</option>
                    {% endif %}
                {% endfor %}
            </select>
        </div>

        <div class="col-md-12 form-group">
            <label class="control-label"> ملاحظات المندوب: </label>
            <textarea name="comment" class="form-control" >{{visit.representitve_comment}}</textarea>
        </div>
    </div>

    <div class="panel panel-success clearfix gap">
        <div class="panel-heading">
            <div class="panel-title">
                <i class="fa fa-plus"></i>
                أختيار العميل المعني بالزيارة
            </div>
        </div>
        <div class="panel-body">
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
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label"> تصنيف العميل </label>
                                        <select id="client_category" class="form-control" id="sel1">
                                            <option></option>
                                            {% for category in user_categories %}
                                                <option value="{{category.id}}">{{category.name}}</option>
                                            {% endfor %}
                                          </select>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label"> اسم العميل</label>
                                        <input id="client_name" type="text" class="form-control">
                                    </div>
                                </div>
                                <div class=" col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label"> البريد الالكترونى</label>
                                        <input id="client_email" type="email" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">الشركة</label>
                                        <input id="company" type="text" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label"> الهاتف</label>
                                        <input id="mobile" type="tel" class="form-control">
                                    </div>
                                </div>
                                <div class=" col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label"> البلد</label>
                                        <select id="country" class="form-control">
                                            <option></option>
                                            {% for country in countries %}
                                                <option value="{{country.id}}">{{country.getName()}}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <div class=" col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label"> المنطقة</label>
                                        <select id="region" class="form-control">
                                            <option></option>
                                            {% for region in regions %}
                                                <option value="{{region.id}}">{{region.getName()}}</option>
                                            {% endfor %}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class=""> حالة العضو </label>
                                    <div class="col-xs-12 no-padding funkyradio">
                                        <div class="col-xs-6 funkyradio-success">
                                            <input type="checkbox" name="checkbox" id="active">
                                            <label for="active">مفعل </label>
                                        </div>
                                        <div class="col-xs-6 funkyradio-success">
                                            <input type="checkbox" name="checkbox" id="not_active">
                                            <label for="not_active"> غير مفعل </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="button" id="filter_clients" class="btn btn-primary">
                                فلتر
                            </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-12" id="filter-container">
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
                <tr class="odd gradeX">
                <td>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input checked type="radio" name="client_id" class="checkboxes" value="{{visit.client.ID}}"/>
                            <span></span>
                        </label>
                </td>
                <td style="width: 20px;">{{visit.client.ID}}</td>
                <td><a href="mailto:{{visit.client.Mail}}">{{visit.client.Mail}}</a> </td>
                <td>{{visit.client.Title}}</td>
                <td>
                    {% if visit.client.category != null %}
                        {{visit.client.category.name}}
                    {% endif %}
                </td>
                <td>
                    {% if visit.client.data != null %}
                        {{visit.client.data.company_name}}
                    {% endif %}
                </td>
                <td class="center"><a href="tel:{{visit.client.Mobile}}">{{visit.client.Mobile}}</a></td>
                <td>
                    {% if visit.client.data != null %}
                        {{visit.client.data.postal_code}}
                    {% endif %}
                </td>
                <td>
                    {% if visit.client.Active == 1 %}
                        <i class="fa fa-check text-success" aria-hidden="true"></i> 
                    {% else %}
                        <i class="fa fa-close text-danger" aria-hidden="true"></i> 
                    {% endif %}
                </td>
            </tr>
            </tbody>
        </table>
        </div>
        <div class="col-sm-12">
            <button type="submit" class="btn btn-success"> تعديل الزيارة</button>
            <a href="{{url('sales_visits/index')}}" class="btn dark">إلغاء</a>
        </div>
        </div>
    </div>
    </form>
</div>
</div>
</div>

<script type="text/javascript">
    $('#filter_clients').on('click', function()
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
            'not_active': $('#not_active').is(':checked')
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