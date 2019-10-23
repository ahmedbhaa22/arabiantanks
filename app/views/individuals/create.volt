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
        <form role="form" method="post" action="{{url('individuals/store')}}" enctype="multipart/form-data">
                <div class="portlet-body">
                    <div class="row">
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group ">
                            <label class="control-label"> الاسم بالكامل  </label>
                            <input type="text" placeholder=" الاسم بالكامل" class="form-control" name="name" value="" required />
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group ">
                            <label class="control-label"> الويظفة  </label>
                            <input type="text" placeholder="الوظيفة" class="form-control" name="job" value="" required/>
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">تليفون </label>
                            <input type="number" placeholder="" class="form-control" name="mobile"/>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">بريد اليكتروني</label>
                            <input type="email" placeholder="email" class="form-control" name="email" required/>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">العنوان</label>
                            <input id="address" name="address" class="form-control"/>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group ">
                            <label class="control-label">اسم المستخدم</label>
                            <input id="user_name" name="user_name" class="form-control" required/>
                        </div>
                        <!-- <div class="form-group">
                            <label class="control-label">المصدر</label>
                            <input name="source" class="form-control" placeholder="عرفناه من فين" />
                        </div> -->
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">المصدر</label>
                            <input name="source" class="form-control" placeholder="عرفناه من فين" />
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
                            <input type="radio" name="location" value="1" required="" id="inside" onchange="toggleCompany()">
                            <label for="inside">من داخل الشركة</label>
                        </div>
                        <div class="col-md-3 col-sm-3 funkyradio-default">
                            <input type="radio" name="location" value="2" required="" id="company" onchange="toggleCompany()">
                            <label for="company">من شركة</label>
                        </div>
                        <div class="col-md-3 col-sm-3 funkyradio-default">
                            <input type="radio" name="user_type" value="1" required="" id="freelancer" checked>
                            <label for="freelancer">Freelancer</label>
                        </div>
                        <div class="col-md-3 col-sm-3 funkyradio-default">
                            <input type="radio" name="user_type" value="2" required="" id="wasset">
                            <label for="wasset">وسيط</label>
                        </div> 
                    </div>
                    <div id="company_data">
                        <div class="col-xs-12 col-md-12 companies"> <!--show only if company checked-->
                            <div class="form-group">
                                <label class="control-label">الشركة</label>
                                <select name="company" id="company">
                                    {% for com in companies %}
                                        <option value="{{com.id}}">{{com.name}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>

                        <!-- <div class="col-xs-6 col-md-6">
                            <div class="form-group">
                                <label class="control-label">النوع</label>
                                <select name="user_type" class="bs-select form-control select-custom" >
                                {% for uType in user_types %}
                                    <option value="{{uType.id}}">{{uType.name}}</option>
                                {% endfor %}
                                </select>
                            </div>
                        </div> -->
                    </div>
                    <!-- <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">النوع</label>
                            <select name="user_type" class="bs-select form-control select-custom" >
                            {% for uType in user_types %}
                                <option value="{{uType.id}}">{{uType.name}}</option>
                            {% endfor %}
                            </select>
                        </div>
                    </div> -->

                    <div class="col-xs-12 col-md-12">
                        <h4 class="text-center inside-titles">
                            تحديد كلمة المرور
                        </h4>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">كلمة المرور</label>
                            <input type="password" name="password" class="form-control" required/>
                        </div>
                    </div>

                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label"> تكررا كلمة المرور </label>
                            <input type="password" class="form-control" required/>
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
                            <input name="notes" class="form-control"/>
                        </div>
                    </div>

                    
                    <div class="col-xs-12 col-md-6">
                        <div class="form-group">
                            <label class="control-label">Tags</label>
                            <select name="tags[]" id="tags">
                                <option>

                                </option>
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
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-new thumbnail" style="  width: 100%; height: 220px;">
                                    <img src="img/material-avatars-add.png" alt=""/></div>
                                <div class="fileinput-preview fileinput-exists thumbnail"
                                     style="max-width: 220px; max-height: 220px;"></div>
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
                <input type="submit" class="btn green-jungle " value="اضافة">
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
