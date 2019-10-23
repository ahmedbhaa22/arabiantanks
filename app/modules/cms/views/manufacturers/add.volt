<div class="">
        <div class="page-bar " style="position: relative">
            <ul class="page-breadcrumb">
                <li>
                    <i class="fa fa-home" aria-hidden="true"></i>
                    <a href="{{url('users-application_module')}}"><span> الرئيسية </span></a>
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
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="fa fa-money" aria-hidden="true"></i>
                    <span class="caption-subject bold uppercase"> اضافة شركة مصنعة </span>
                </div>
                <div>
                  {% if session.get('error_msgs')|length %}
                  <ul style="color:red;float:left;">
                      {% for msg in session.get('error_msgs') %}
                          <li style="float:left;">{{msg['field']}} : {{msg['message']}}</li><br>
                          <?php $this->session->set('error_msgs', []) ?>
                      {% endfor %}
                  </ul>
                  {% endif %}
                </div>
                <div class="gap">
                  <?php $this->flashSession->output(); ?>
                </div>
            </div>
            <div class="portlet-body">
                 <form id="new-manfct-form" role="form" action="{{url('manufacturers/save')}}" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class=" control-label">اسم الشركة المصنعة</label>
                                <input required name="name" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-3 gap">
                            <div class="funkyradio form-group gap">
                                <div class="funkyradio-success">
                                    <input name="active" type="checkbox" name="checkbox" id="checkbox1" checked />
                                    <label for="checkbox1"> مفعل</label>
                                </div>  
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-lable">ترتيب العرض </label>
                                <input required name="order" min="1" type="number" class="form-control">
                            </div>
                        </div>
                        
                        <div class="row form-group">
                            <div class="col-xs-12 no-padding" id="repeatTHIS">
                                <div class="col-xs-4">
                                    <div class="kv-group-title">
                                        <h2> الصورة </h2>
                                    </div>
                                    <input name="img" type="file" id="fieldImg" name="Img" class="form-control"/>
                                </div>
                                <div class="col-xs-4">
                                    <div class="kv-group-title">
                                        <h2> عنوان الصورة </h2>
                                    </div>
                                    <input name="image_title" type="text" id="title" name="title" class="form-control"/>
                                </div>
                                <div class="col-xs-4">
                                    <div class="kv-group-title">
                                        <h2> alt </h2>
                                    </div>
                                    <input name="img_alt" type="text" id="alt" name="alt" class="form-control" />
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-10">
                            <div class="form-group">
                                <label class=" control-label"> وصف الشركة </label>
                                <textarea required name="desc" class="form-control"></textarea>
                            </div>
                        </div>
                        
                        
                     </div>
                     <div class="row">
                         <div class="kv-group-title">
                        <h2> إعدادات SEO  </h2> </div>
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
                                        <input name="meta_keyword" class="text-box single-line" id="MetaKeywords" type="text">
                                        <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                       <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
                                   </td>
                                   <td class="adminData">
                                        <textarea name="meta_desc" cols="20" id="MetaDescription" rows="2"></textarea>
                                        <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input name="meta_title" class="text-box single-line" id="MetaTitle" type="text" value="">
                                        <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%"  class="adminTitle">
                                        <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input name="seo_page" class="text-box single-line" id="SeName" type="text">
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
                                        <input class="text-box single-line" id="MetaKeywords" name="MetaKeywords" type="text" value="water, watery, horizontal tanks, horizontal tank, plastic tanks, plastic tank, tanks insulation, tank insulation, polyetheleen, water, alzamil water tanks">
                                        <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                       <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
                                   </td>
                                   <td class="adminData">
                                        <textarea cols="20" id="MetaDescription" name="MetaDescription" rows="2"></textarea>
                                        <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input class="text-box single-line" id="MetaTitle" name="MetaTitle" type="text" value="">
                                        <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%"  class="adminTitle">
                                        <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input class="text-box single-line" id="SeName" name="SeName" type="text" value="vertical-tank-capacity-16000-ltr">
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
                                        <input class="text-box single-line" id="MetaKeywords" name="MetaKeywords" type="text" value="water, watery, horizontal tanks, horizontal tank, plastic tanks, plastic tank, tanks insulation, tank insulation, polyetheleen, water, alzamil water tanks">
                                        <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                       <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
                                   </td>
                                   <td class="adminData">
                                        <textarea cols="20" id="MetaDescription" name="MetaDescription" rows="2"></textarea>
                                        <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input class="text-box single-line" id="MetaTitle" name="MetaTitle" type="text" value="">
                                        <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%"  class="adminTitle">
                                        <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input class="text-box single-line" id="SeName" name="SeName" type="text" value="vertical-tank-capacity-16000-ltr">
                                        <span class="field-validation-valid" data-valmsg-for="SeName" data-valmsg-replace="true"></span>
                                           </td>
                                       </tr>
                                   </tbody></table>
                          </div>
                        </div>
                         
                         <div class="col-xs-12 col-md-12">
                            <button class="btn btn-primary">اضافة</button>
                            <button class="btn dark">اغلاق</button>
                        </div>
                     </div>
                </form>

        </div>
        <!-- END EXAMPLE TABLE PORTLET-->

    </div>
</div>
<script type="text/javascript">
  $(document).ready(function()
    {
       jQuery.extend(jQuery.validator.messages, {
          required: 'هذا الحقل مطلوب'
      });

  $('#new-manfct-form').validate();
    });
 
</script>