<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="index.html"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
             <li>
                <a href="production.html"><span> المنتجات </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <a href="production_content.html"><span> محتوى </span></a>
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
                <span class="caption-subject bold uppercase">  تعديل تصنيف </span>
            </div>
        </div>
        <div class="portlet-body">
           <ul class="nav nav-tabs ">
                    <li class="active"><a data-toggle="tab" href="#info"> معلومات التصنيف  </a></li>
                    <li class=""><a data-toggle="tab" href="#seo">  إعدادات SEO </a></li>
               <li>
                   <a href="#3" data-toggle="tab">{{ translate._('Category Attributes')}}</a>
               </li>
                    <!-- <li class=""><a data-toggle="tab" href="#discounts"> الخصومات </a></li> -->
                </ul>
          <form action="{{url('categories/save/'~category.ID)}}" method="post" role="form" enctype="multipart/form-data">
            <input type="hidden" name="from_action" value="edit">
            <div class="tab-content col-md-12 no-padding">
                <div id="info" class="tab-pane fade in active">
                    <div class="col-xs-6 form-group">
                        <div class="kv-group-title">
                            <h2> اسم التصنيف </h2> </div>
                        <div class="col-sm-12 no-padding">
                            <ul class="nav small-tabs nav-tabs">
                              <li class="active">
                                <a href="#title_ar" class="small" data-toggle="tab">العربية</a>
                              </li>
                              <li>
                                <a href="#title-en" class="small" data-toggle="tab">  English   </a>
                              </li>
                            </ul>
                            <div class="tab-content clearfix">
                              <div class="tab-pane active" id="title_ar">
                                <input {% if category.ar != null %}
                                          value="{{category.ar.title}}"
                                        {% else %}
                                          value="{{category.Title}}"
                                        {% endif %}
                                 required type="text" id="fieldTitle" name="name_ar" class="form-control" size="30" placeholder="">
                              </div>
                              <div class="tab-pane" id="title-en">
                                <input {% if category.en != null %}
                                          value="{{category.en.title}}"
                                        {% else %}
                                          value="{{category.Title}}"
                                        {% endif %}
                                 required type="text" id="fieldTitle" name="name_en" class="form-control" size="30" placeholder="">
                              </div>
                            </div>
                        </div>
                    </div>
                        
                    
                    <div class="col-xs-6 form-group">
                        <label for="fieldOrder" class="col-sm-3 control-label">
                          التصنيف الأصلي</label>
                        <div class="col-sm-9">
                            <select required data-val="true" data-val-number="The field التصنيف الأصل must be a number." data-val-required="'Parent Category Id' must not be empty." id="ParentCategoryId" name="paret_category_id" class="valid">
                                <option selected="selected" value="0">[None]</option>
                                {% for cat in categories %}
                                {% if category.Parent_Depts_ID == cat.ID %}
                                  <option selected value="{{cat.ID}}">{{cat.Title}}</option>
                                {% else %}
                                  <option value="{{cat.ID}}">{{cat.Title}}</option>
                                {% endif %}
                                {% endfor %}
                            </select>
                        </div>
                    </div>

                    <div class="col-xs-6 form-group">
                        <label for="fieldContent" class="col-sm-3 control-label">ترتيب العرض</label>
                        <div class="col-sm-9">
                            <input value="{{category.Orders}}" type="number" name="order" class="form-control" min="0" />      </div>
                    </div>

                    <div class="col-xs-6 form-group">
                        <label for="fieldContent" class="col-sm-3 control-label">الضريبة</label>
                        <div class="col-sm-9">
                            <input value="{{cat_tax}}" type="number" name="cat_tax" class="form-control" min="0" />      </div>
                    </div>

                    <div class="form-group col-xs-12">
                      <label for="main_image">الصورة الرئيسية</label>
                      <input
                      {% if (category.Img == "0") %}
                        required
                      {% endif %}
                       type="file" name="main_image" class="form-control" id="main_image">
                        <a href="{{this.url_shared.get('uploads/') ~category.Img}}" target="_blank">{{translate._('View Image')}}</a>
                    </div>


                        
                    <div class="col-xs-12 form-group">
                        <div class="form-group">
                          <div class="kv-group-title">
                            <h2>وصف التصنيف</h2> </div>
                          <div class="col-xs-12 no-padding">
                            <ul class="nav small-tabs nav-tabs">
                              <li class="active">
                                <a href="#title_ar2" class="small" data-toggle="tab">العربية</a>
                              </li>
                              <li>
                                <a href="#title_en2" class="small" data-toggle="tab">  English   </a>
                              </li>
                            </ul>
                            <div class="tab-content clearfix">
                              <div class="tab-pane active" id="title_ar2">
                                  <textarea required name="des_ar" id="des_ar" class="form-control">{% if category.ar != null %} {{category.ar.des}} {% else %} {{category.Des}} {% endif %}</textarea>
                              </div>
                              <div class="tab-pane" id="title_en2">
                                <textarea required name="des_en" id="des_en" class="form-control">{% if category.en != null %} {{category.en.des}} {% else %} {{category.Des}} {% endif %}</textarea>
                              </div>
                            </div>
                          </div>
                        </div>
                    </div>
                        
                    <div class="col-xs-3  form-group">
                        <div class="funkyradio col-sm-12">
                                <div class="funkyradio-success">
                                    <input {% if category.show_in_homepage == 1 %}
                                              checked 
                                            {% endif %}
                                     type="checkbox" name="show_in_home_page" id="checkbox1"/>
                                    
                                    <label for="checkbox1"> يظهر في الصفحة الرئسية </label>
                                </div>
                        </div>
                    </div>
                    <div class="col-xs-3 form-group">
                        <div class="funkyradio col-sm-12">
                                <div class="funkyradio-success">
                                    <input {% if category.Active == 1%}
                                            checked
                                            {% endif %}
                                     type="checkbox" name="active" id="checkbox2"/>
                                    <label for="checkbox2"> مفعل</label>
                                </div>
                        </div>
                    </div> 
                    <div class="col-xs-3 form-group">
                        <div class="funkyradio col-sm-12">
                                <div class="funkyradio-success">
                                    <input type="checkbox" name="maintainable" id="checkbox3" 
                                      {% if category.subject_to_maintenance == 1 %}
                                        checked
                                      {% endif %}
                                     />
                                    <label for="checkbox3">قابل للصيانة</label>
                                </div>
                        </div>
                    </div>
                        
                    <div class="col-xs-12 form-group">
                        
                        <div class="col-xs-8 no-padding" id="repeatTHIS">
                            <div class="col-xs-6">
                                <label for="fieldContent" class="control-label"> الصورة</label>
                                <input type="file" id="fieldImg" name="imgs[]" class="form-control"/>
                            </div>
                            <div class="col-xs-3">
                                <label for="title" class="control-label"> Title </label>
                                <input type="text" id="title" name="img_title[]" class="form-control"/>
                            </div>
                            <div class="col-xs-3">
                                <label for="alt" class="control-label">alt </label>
                                <input type="text" id="alt" name="img_alt[]" class="form-control" />
                            </div>
                        </div>
                        <div class="col-xs-2 gap">
                            <button type="button" class="btn btn-xs btn-info" onclick="repeat()">
                                <i class="fa fa-plus-circle" aria-hidden="true"></i> اضافة المزيد
                            </button>
                        </div>


                    </div>
                    <!-- Existed Images  -->
                    <div class="col-xs-12 form-group" id="">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>الصورة</th>
                                <th>Title</th>
                                <th>alt</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            {% for img_alt in category.images%}
                            <tr>
                                <td><a href="{{this.url_shared.get() ~img_alt.Img}}" target="_blank">View Picture</a></td>
                                <td>{{img_alt.img_title}}</td>
                                <td>{{img_alt.img_alt}}</td>
                                <td><a href="{{this.url_shared.get('cms_module/categories/delete_media/') ~img_alt.ID}}">{{translate._("Delete")}}</a> </td>
                            </tr>
                            {% endfor %}
                            </tbody>

                        </table>
                    </div>
                    <!-- videos -->
                    <div class="col-xs-12 form-group">
                      {% if category.videos|length > 0 %}
                        {% for video_link in category.videos %}
                          <div class="col-xs-8 no-padding" id="repeatVideos">
                            <div class="col-xs-6">
                                <label for="title" class="control-label"> رابط الفيديو Youtube </label>
                                <input type="text" id="video_link" name="videos[]" class="form-control" value="{{video_link.Link}}" />
                            </div>
                          </div>
                        {% endfor %}
                      {% else %}
                        <div class="col-xs-8 no-padding" id="repeatVideos">
                        <div class="col-xs-6">
                                <label for="title" class="control-label"> رابط الفيديو Youtube </label>
                                <input type="text" id="video_link" name="videos[]" class="form-control"/>
                        </div>
                      </div>
                      {% endif %}
                      
                      <div class="col-xs-2 gap">
                            <button type="button" class="btn btn-xs btn-info" onclick="repeatVideos()">
                                <i class="fa fa-plus-circle" aria-hidden="true"></i> اضافة المزيد
                            </button>
                        </div>
                    </div>
                </div><!-- end of info-->

                <div id="seo" class="tab-pane fade in">
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
                                        <input {% if category.seo != null %}
                                                value="{{category.seo.meta}}"
                                              {% endif %}
                                         class="text-box single-line" id="MetaKeywords" name="meta_keywords" type="text">
                                        <span class="field-validation-valid" data-valmsg-for="MetaKeywords" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                       <label for="MetaDescription" title="ميتا الوصف المراد إضافتها إلى رأس صفحة المنتج">وصف ميتا</label>:
                                   </td>
                                   <td class="adminData">
                                        <textarea cols="20" id="MetaDescription" name="meta_desc" rows="2">{% if category.seo != null %}{{category.seo.meta_description}}{% endif %}</textarea>
                                        <span class="field-validation-valid" data-valmsg-for="MetaDescription" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%" class="adminTitle">
                                        <label for="MetaTitle" title="تجاوز عنوان الصفحة. الإعداد الافتراضي هو اسم المنتج.">العنوان الوصفي</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input {% if category.seo != null %}
                                                value="{{category.seo.title_description}}"
                                              {% endif %}
                                         class="text-box single-line" id="MetaTitle" name="meta_title" type="text" value="">
                                        <span class="field-validation-valid" data-valmsg-for="MetaTitle" data-valmsg-replace="true"></span>
                                   </td>
                               </tr>
                               <tr>
                                   <td style="width: 20%"  class="adminTitle">
                                        <label for="SeName" title="تعيين اسم صفحة صديقة محرك بحث مثل '--أفضل--المنتج' لجعل الخاص بك عنوان URL لصفحة 'http://www.yourStore.com/the-best-product'. ترك فارغاً لتوليد تلقائياً استناداً إلى اسم المنتج.">اسم الصفحة صديقة محرك البحث</label>:
                                                               </td>
                                                               <td class="adminData">
                                        <input {% if category.seo != null %}
                                                value="{{category.seo.page_title}}"
                                              {% endif %}
                                         class="text-box single-line" id="SeName" name="page_title" type="text">
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
                </div><!--endof seo-->


                <div class="tab-pane" id="3">
                    {%for group in category_attributes%}
                    {%for key,keyvalue in group['keyvalues']%}
                    <div class="row">
                        <div class="col-md-4">{{keyvalue['title']}}</div>
                        <div class="col-md-4">{{ check_field("keyvalue_attribute"~keyvalue['kv_id'],"class":"","value":keyvalue['kv_id']) }}</div>

                    </div>
                    <br><br>
                    {%endfor%}
                    {%endfor%}

                </div>

                <!-- <div id="discounts" class="tab-pane fade in">
                       <div class="panel panel-success">
                        <div class="panel-heading">
                            <div class="panel-title">
                                إضافة خصم للتصنيف
                            </div>
                        </div>
                        <div class="panel-body">
                              <div class="row">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class=" control-label">اسم الخصم</label>
                                                    <input name="discount_name" type="text" class="form-control" 
                                                    {% if category.discount != null %}
                                                      value="{{category.discount.name}}" 
                                                    {% endif %}
                                                    >
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class="col-xs-12 no-padding control-label"> النسبة المئوية</label>
                                                    <div class="col-xs-8 no-padding">
                                                        <input name="discount_percent" type="text" class="form-control" 
                                                        {% if category.discount != null %}
                                                          value="{{category.discount.percentage}}" 
                                                        {% endif %}
                                                        >
                                                    </div>
                                                    <div class="col-xs-2"> % </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class=" control-label"> كود الكوبون </label>
                                                    <input name="discount_coupon" type="text" class="form-control" 
                                                    {% if category.discount != null %}
                                                          value="{{category.discount.coupon}}" 
                                                        {% endif %}
                                                    >
                                                </div>
                                            </div>

                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class=" control-label"> تاريخ البدء </label>
                                                    <input name="start_date" type="date" class="form-control" 
                                                    {% if category.discount != null %}
                                                      value="{{category.discount.dateFieldStartDate()}}"
                                                    {% endif %}
                                                    >
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label class=" control-label"> تاريخ النهاية</label>
                                                    <input name="end_date" type="date" class="form-control" 
                                                    {% if category.discount != null %}
                                                      value="{{category.discount.dateFieldEndDate()}}"
                                                    {% endif %}
                                                    >
                                                </div>
                                            </div>
                                        </div>
        </div>
      </div>
                    </div>

    
                </div><!-- end of discounts-->



        </div>
            <div class="col-xs-12">
            <button type="submit" class="btn btn-success btn-md">
                <i class="fa fa-save" aria-hidden="true"></i>
                 حفظ
            </button>
            <a href="{{url('categories/index')}}" class="delete-btn btn dark btn-md">
                 إلغاء
            </a>
            </div>
          </form>

        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->

</div>


<script type="text/javascript">
    var i = 0;
    var original = document.getElementById('repeatTHIS');

    function repeat() {
      var clone = original.cloneNode(true);
      clone.id = "repeatTHIS" + ++i;
      original.parentNode.appendChild(clone);
    }

    // repeat videos
    var j = 0;
    var videos_original = document.getElementById('repeatVideos');

    function repeatVideos()
    {
      var video_clone = videos_original.cloneNode(true);
      video_clone.id  = "repeatVideos"+ ++i;
      videos_original.parentNode.appendChild(video_clone);
      $('#'+video_clone.id+' :input').val('');
    }
</script>

{{ javascript_include("js/ckeditor/ckeditor.js") }}
<script>
    CKEDITOR.replace( 'des_en' );
    CKEDITOR.replace( 'des_ar' );
</script>