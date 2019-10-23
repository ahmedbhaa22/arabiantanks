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
                    <a href="{{content/productsList}}"><span> محتوى </span></a>
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
      </div> <div class="portlet light clearfix">
        <div class="portlet-title">
              <div class="caption font-dark">
                  <h4 class="caption-subject bold uppercase">
			<i class="fa fa-suitcase" aria-hidden="true"></i>
                     {{manfct.Title}}
                  </h4>
              </div>
            <div class="actions">
                    <a type="button" href="{{url('manufacturers/edit/'~manfct.ID)}}" class="btn btn-xs btn-info">
            <i class="fa fa-user-plus"></i> تعديل بيانات الشركة</a>
            </div>
          </div>
	<div class="portlet-body">
	<div class="col-xs-12 no-padding ">
		<div class="col-xs-12 no-padding ">
				<div class="col-md-2 col-sm-3 col-xs-4 no-padding">
						  <img {% if img %}src="{{url.getStatic(img.Img)}}"{% endif %} class="img-responsive" alt="">
              {% if manfct.Active == 1 %}
              <h4 class="text-center text-success"><i class="fa fa-check-circle-o text-success"></i> منشور </h4>
              {% else %}
              <h4 class="text-center text-danger"><i class="fa fa-close text-danger"></i> غير منشور </h4>
              {% endif %}
					</div>

				<div class="col-md-10 col-sm-9 col-xs-8">
				 <div class="panel">
					 <div class="panel-body">
                                 <div class="form-group">
                                        <h3 class="label label-info">ترتيب العرض: {{manfct.Orders}}</h3>
                                 </div>
                                 <div class="form-group"><b>وصف الشركة: </b> &nbsp;
                                     {{manfct.Des}}
                                 </div>
					</div>
				</div>
			</div>
		</div>
		</div>

 <div class="col-md-12 no-padding">
              <ul class="nav nav-tabs nav-justified ">
                <li class="active"><a data-toggle="tab" href="#products"><i class="fa fa-info" aria-hidden="true"></i> المنتجات </a></li>
                  <li class=""><a data-toggle="tab" href="#discount"><i class="fa fa-tag" aria-hidden="true"></i> الخصومات </a></li>
                <li class=""><a data-toggle="tab" href="#seo"><i class="fa fa-info" aria-hidden="true"></i> اعدادات SEO </a></li>
                
              </ul>
  </div>
  <div class="clearfix"></div>
   <div class="tab-content col-md-12 no-padding">
            <div id="products" class="tab-pane fade in active">
                          <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
                                <thead>
                                <tr>
                                    <th>رقم الطلب</th>
                                    <th>حالة طلب الشراء</th>
                                    <th>حالة الدفع</th>
                                    <th>مركز الشحن</th>
                                    <th>موقع</th>
                                    <th>تاريخ النشر</th>
                                    <th>اجمالى الطلبية </th>
                                    <th>اجراءات</th>
                                </tr>
                                </thead>
                                <tbody>
                                  {% for product in manfct.items %}
                                  {% for order in product.relatedOrders() %}
                                      <tr class="odd gradeX">
                                          <td>{{order.id}}</td>
                                          <td>{{order.statusDetails.status_name}}</td>
                                          <td>تحويل بنكي</td>
                                          <td>
                                            {% if order.userAddress != null %}
                                              {{order.userAddress.details}}
                                            {% endif %}
                                          </td>
                                          <td>
                                            {% if order.userAddress != null  and order.userAddress.region != null %}
                                            {{order.userAddress.region.getName()}}
                                            {% endif %}
                                          </td>
                                          <td>{{order.formattedDate()}}</td>
                                          <td>{{order.itemsCount()}}</td>
                                          <td>
                                              <a href="{{url('orders/viewClientOrder/'~order.id)}}"  class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                                              <button class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

                                              <button data-order_id="{{order.id}}" class="delete-order btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                          </td>
                                        </tr>
                                  {% endfor %}
                                  {% endfor %}
                                </tbody>
                            </table>

                    </div><!--products-->
                    <div id="discount" class="tab-pane fade">
<!--
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
                                        <form role="form">
                                            <div class="row">

                                                <div class="col-sm-4">
                                                    <div class="form-group">
                                                        <label class=" control-label">اسم الخصم</label>
                                                        <input type="text" class="form-control">
                                                    </div>
                                                </div>

                                            </div>
                                            <button class="btn btn-primary">فلتر</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
-->
				<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_2">
                            <thead>
                                <tr>
                                    <th>
                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                            <input type="checkbox" class="group-checkable"
                                                   data-set="#sample_1 .checkboxes"/>
                                            <span></span>
                                        </label>
                                    </th>
                                    <th> ID</th>
                                    <th>الاسم</th>
                                    <th> نوع الخصم</th>
                                    <th>تاريخ البدء </th>
                                    <th>تاريخ الإنتهاء</th>
                                    <th> Times used</th>
                                    <th>الاجراءات</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="odd gradeX">
                                    <td>
                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="checkboxes" value="1"/>
                                                <span></span>
                                            </label>
                                    </td>
                                    <td>1</td>
                                    <td>نهاية الموسم </td>
                                    <td>50%</td>
                                    <td>12/11/2017 </td>
                                    <td>12/12/2017 </td>
                                    <td>5</td>
                                    <td>
<!--
                                        <a href="one-client-view.html" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                                        <button class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>
-->

                                        <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                    </td>
                                </tr>

                            </tbody>
                        </table>

                    </div><!--discount -->
                    <div id="seo" class="tab-pane fade">
                      <form role="form" method="post" action="{{url('manufacturers/updateSeo')}}" enctype="multipart/form-data">
                            <input type="hidden" name="manfct_id" value="{{manfct.ID}}">
				                    <div class="col-sm-2 gap">
                            <ul class="nav nav-tabs tabs-left">
                              <li class="active"><a data-toggle="tab" href="#standared">Standared</a></li>
                              <li><a data-toggle="tab" href="#arabic"> Arabic</a></li>
                              <li><a data-toggle="tab" href="#english">English</a></li>
                            </ul>
                        </div>


                        <div class="tab-content col-sm-10">
                          <div id="standared" class="tab-pane fade in active">
                            <table class="table ">
                                <tbody><tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaKeywords" title="ميتا الكلمات الرئيسية المراد إضافتها إلى رأس صفحة المنتج">ميتا الكلمات الرئيسية</label>:
                                   </td>
                                   <td class="adminData">
                                        <input{% if manfct.seoSettings != null and manfct.seoSettings|length > 0 %}
                                                value="{{manfct.seoSettings[0].meta}}" 
                                                {% endif %}
                                         class="text-box single-line" id="MetaKeywords" name="MetaKeywords" type="text">
                                        <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                       <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
                                   </td>
                                   <td class="adminData">
                                        <textarea cols="20" id="MetaDescription" name="MetaDescription" rows="2">{% if manfct.seoSettings != null and manfct.seoSettings|length > 0 %}{{manfct.seoSettings[0].meta_description}}{% endif %}</textarea>
                                        <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input{% if manfct.seoSettings != null and manfct.seoSettings|length > 0 %}
                                                value="{{manfct.seoSettings[0].title_description}}" 
                                                {% endif %}
                                         class="text-box single-line" id="MetaTitle" name="MetaTitle" type="text" value="">
                                        <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%"  class="adminTitle">
                                        <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input{% if manfct.seoSettings != null and manfct.seoSettings|length > 0 %}
                                                value="{{manfct.seoSettings[0].page_title}}" 
                                                {% endif %}
                                         class="text-box single-line" id="SeName" name="SeName" type="text">
                                        <span class="field-validation-valid" data-valmsg-for="SeName" data-valmsg-replace="true"></span>
                                           </td>
                                       </tr>
                                   </tbody></table>
                          </div>
                          <div id="arabic" class="tab-pane fade">
                            <table class="table ">
                                <tbody><tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaKeywords" title="ميتا الكلمات الرئيسية المراد إضافتها إلى رأس صفحة المنتج">ميتا الكلمات الرئيسية</label>:
                                   </td>
                                   <td class="adminData">
                                        <input class="text-box single-line" id="MetaKeywords" type="text" value="water, watery, horizontal tanks, horizontal tank, plastic tanks, plastic tank, tanks insulation, tank insulation, polyetheleen, water, alzamil water tanks">
                                        <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                       <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
                                   </td>
                                   <td class="adminData">
                                        <textarea cols="20" id="MetaDescription" rows="2"></textarea>
                                        <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input class="text-box single-line" id="MetaTitle" type="text" value="">
                                        <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%"  class="adminTitle">
                                        <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input class="text-box single-line" id="SeName" type="text" value="vertical-tank-capacity-16000-ltr">
                                        <span class="field-validation-valid" data-valmsg-for="SeName" data-valmsg-replace="true"></span>
                                           </td>
                                       </tr>
                                   </tbody></table>
                          </div>
                          <div id="english" class="tab-pane fade">
                            <table class="table ">
                                <tbody><tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaKeywords" title="ميتا الكلمات الرئيسية المراد إضافتها إلى رأس صفحة المنتج">ميتا الكلمات الرئيسية</label>:
                                   </td>
                                   <td class="adminData">
                                        <input class="text-box single-line" id="MetaKeywords" type="text" value="water, watery, horizontal tanks, horizontal tank, plastic tanks, plastic tank, tanks insulation, tank insulation, polyetheleen, water, alzamil water tanks">
                                        <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                       <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
                                   </td>
                                   <td class="adminData">
                                        <textarea cols="20" id="MetaDescription" rows="2"></textarea>
                                        <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input class="text-box single-line" id="MetaTitle" type="text" value="">
                                        <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%"  class="adminTitle">
                                        <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input class="text-box single-line" id="SeName" type="text" value="vertical-tank-capacity-16000-ltr">
                                        <span class="field-validation-valid" data-valmsg-for="SeName" data-valmsg-replace="true"></span>
                                           </td>
                                       </tr>
                                   </tbody></table>
                          </div>
                        </div>
                        
                        <div class="col-xs-12 col-md-12">
                            <input type="submit" value="حفظ التعديل" class="btn btn-primary"/>
                        </div>
                      </form> 
                    </div><!--seo-->
	</div>
</div>
    </div>
    <!-- END PAGE HEADER-->
    <!-- BEGIN DASHBOARD STATS 1-->

    <div class="clearfix"></div>
    <!-- END DASHBOARD STATS 1-->

</div>
<script type="text/javascript">
$('.delete-order').on('click', function()
  {
    if(confirm('أنت على وشك القيام بذف طلب، إستكمال العملية؟'))
    {
      $.ajax({
        type: 'post',
        usl: "{{url('orders/deleteOrder/')}}" + $(this).data('order_id'),
        success: function(response)
        {
          response = JSON.parse(response);

          switch(response.status)
          {
            case 0:
            alert(response.msg);
            break;
            case 1:
            window.location.href = "{{url('manufacturers/view/'~manfct.ID)}}";
            break;
          }
        }
      });
    }
  });
</script>