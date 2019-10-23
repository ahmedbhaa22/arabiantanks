<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url({{url('ropo_app/img/new-employees.png')}}) center no-repeat;">
        </div>
    </div>
</div>
<div class="col-md-8 col-md-offset-2 col-sm-12 col-xs-12">
<div class="portlet light bordered">
    <div class="portlet-title">
        <!-- <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase"> اضافة موظف</span>
        </div> -->

        <div class="actions">
            <a type="button" href="{{url('individuals')}}" 
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                السابق</a>
        </div>

    </div>
    <div class="portlet-body">
        <form role="form" method="post" action="{{url('individuals/update/') ~ user.ID }}" enctype="multipart/form-data">
                <div class="portlet-body">
                    <div class="row">
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group ">
                            <label class="control-label"> الاسم بالكامل  </label>
                            <input type="text" placeholder=" الاسم بالكامل" class="form-control" name="name" value="{{user.Title}}" required />
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group ">
                            <label class="control-label"> الويظفة  </label>
                            <input id="job" name="job" class="form-control" required
                            {% if user.information %}
                             value="{{user.information.job}}"
                            {% endif %}
                            />
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">تليفون </label>
                            <input type="number" placeholder="رقم الموبايل" class="form-control" name="mobile"
                            {% if user.information %}
                             value="{{user.information.mobile}}"
                            {% endif %}
                            />
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">بريد اليكتروني</label>
                            <input type="email" placeholder="email" class="form-control" name="email" value="{{user.Mail}}" required/>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">العنوان</label>
                            <input id="address" name="address" class="form-control"
                            {% if user.information %}
                             value="{{user.information.address}}"
                            {% endif %}
                            />
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group ">
                            <label class="control-label">اسم المستخدم</label>
                            <input type="text" placeholder="اسم المستخدم" class="form-control" name="user_name"  value="{{user.User}}" required/>
                        </div>
                        <!-- <div class="form-group">
                            <label class="control-label">المصدر</label>
                            <input name="source" class="form-control" placeholder="عرفناه من فين" />
                        </div> -->
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">المصدر</label>
                            <input name="source" class="form-control"
                            {% if user.information %}
                             value="{{user.information.source}}"
                            {% endif %}
                            />
                        </div>
                    </div>
                    
                    <div class="col-xs-12 col-md-12">
                        <h4 class="text-center inside-titles">
                            مكان عمل الموظف
                        </h4>
                    </div>
                    <div class="funkyradio col-md-12 col-xs-12">
                        <!-- <div class="col-md-6 col-sm-6 funkyradio-default">
                            <input type="radio" name="user_location" value="1" required="" id="inside" checked onchange="toggleCompany()">
                            <label for="inside">داخلي</label>
                        </div>
                        <div class="col-md-6 col-sm-6 funkyradio-default">
                            <input type="radio" name="user_location" value="2" required="" id="company" onchange="toggleCompany()">
                            <label for="company">من شركة خارجية</label>
                        </div> -->
                        <!-- <div class="col-md-3 col-sm-3 funkyradio-default">
                            <input type="radio" name="client_type" value="3" required="" id="freelancer"> -->

                        <div class="col-md-3 col-sm-3 funkyradio-default">
                            <input type="radio" name="location" value="1" required="" id="inside"
                            {% if user.profiles | length and user.profiles[0].name != "Individuals" %}
                            checked
                            {% endif %}
                            onchange="toggleCompany()">
                            <label for="inside">من داخل الشركة</label>
                        </div>
                        <div class="col-md-3 col-sm-3 funkyradio-default">
                            <input type="radio" name="location" value="2" required="" id="company"
                            {% if user.profiles | length and user.profiles[0].name == "Individuals" %}
                            checked
                            {% endif %}
                            onchange="toggleCompany()">
                            <label for="company">من شركة</label>
                        </div>
                        <div class="col-md-3 col-sm-3 funkyradio-default">
                            <input type="radio" name="user_type" value="1" required id="freelancer"
                            {% if user.information and user.information.user_type == 1 %}
                            checked
                            {% endif %}
                            >
                            <label for="freelancer">Freelancer</label>
                        </div>
                        <div class="col-md-3 col-sm-3 funkyradio-default">
                            <input type="radio" name="user_type" value="2" required id="wasset"
                            {% if user.information and user.information.user_type == 2 %}
                            checked
                            {% endif %}
                            >
                            <label for="wasset">وسيط</label>
                        </div> 
                    </div>
                    <div id="company_data">
                        <div class="col-xs-12 col-md-12 companies"> <!--show only if company checked-->
                            <div class="form-group">
                                <label class="control-label">الشركة</label>
                                <select name="company" id="company">
                                    <?php $com_ids = array_map(function($item){return $item['id'];}, $user->companies->toArray()) ?>
                                    {% for com in companies %}
                                        <option value="{{com.id}}"
                                        <?php if(in_array($com->id, $com_ids)){echo "selected";} ?>
                                        >{{com.name}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                    </div>


                    <div class="col-xs-12 col-md-12">
                        <h4 class="text-center inside-titles">
                            تحديد كلمة المرور
                        </h4>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">كلمة المرور</label>
                            <input type="password" name="password" class="form-control"/>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label"> تكررا كلمة المرور </label>
                            <input type="password" class="form-control"/>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-12">
                        <h4 class="text-center inside-titles">
                            معلومات اضافية
                        </h4>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">ملاحظات</label>
                            <input name="notes" class="form-control"
                            {% if user.information %}
                             value="{{user.information.notes}}"
                            {% endif %}
                            />
                        </div>
                    </div>

                    
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">Tags</label>
                            <select name="tags[]" id="tags">
                            {% for utag in user.tags %}
                            <option value="{{utag.id}}" selected>{{utag.name}}</option>
                            {% endfor %}
                            </select>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-12">
                        <h4 class="text-center inside-titles">
                            تغير الصورة الشخصية
                        </h4>
                    </div>
                    <div class="col-xs-12 col-md-12">
                        <div class="form-group text-center">
                            <div class="fileinput 
                            {% if user.Img %}
                            fileinput-exists
                            {% else %}
                            fileinput-new
                            {% endif %}
                            " data-provides="fileinput">
                                <div class="fileinput-new thumbnail" style="  width: 100%; height: 220px;">
                                    <img src="img/material-avatars-add.png" alt=""/></div>
                                <div class="fileinput-preview fileinput-exists thumbnail"
                                     style="max-width: 220px; max-height: 220px;">
                                         {% if user.Img %}
                                         <img src="{{url('/') ~ user.Img}}">
                                         {% endif %}
                                     </div>
                                <div style=" margin-top:20px">
                                    <span class="btn default btn-file">
                                    <span class="fileinput-new"> أختار الصورة</span>
                                    <span class="fileinput-exists"> تغير </span>
                                    <input type="file" name="..."> </span>
                                    <a href="javascript:;" class="btn default fileinput-exists" data-dismiss="fileinput"> حذف </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    
                </div>
                </div>
            <div class="modal-footer">
                <a href="{{url('individuals')}}" class="btn dark">إلغاء</a>
                <input type="submit" class="btn green-jungle " value="تعديل">
            </div>
        </form>
    </div>
</div>
</div>

<script type="text/javascript">
function toggleCompany(){
    // console.log($("input[name='user_location']:checked").val());d
    if($("input[name='location']:checked").val() == 2){
        $("#company_data").show();
    }else{
        $("#company_data").hide();
    }
}

toggleCompany();
</script>

