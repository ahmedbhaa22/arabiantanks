<div class="portlet light">
    <div class="row">
        <div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 text-center">
            <div class="img-holder img-thumbnail">
                {% if user.Img %}
                <img src="{{url('') ~ user.Img}}">
                {% else %}
                <img src="http://new.medsafe.su/s/images/expert.png">
                {% endif %}
            </div>
        </div>
        <div class="col-lg-10 col-md-9 col-sm-9  col-xs-12">
            <div class="row">
                <div class="col-md-7 col-xs-12">
                    <h3 class="page-title">
                        {{user.Title}}
                        <small>مسجل <?php echo date("Y/m/d", $user->Join_Date) ?></small>

                    </h3>
                </div>
                <div class="col-md-5 col-xs-12">
                    <div style=" margin-bottom: 15px ; margin-top: 15px ;">
                        <a class="btn green-jungle btn-outline sbold uppercase"
                           style="display: inline; margin-left: 5px ;" onclick="deleteUser({{user.ID}})">
                            <span aria-hidden="true" class="icon-trash"></span>
                            أستبعاد الموظف
                        </a>

                        <a href="{{url('individuals/edit/') ~ user.ID}}" type="button" class="btn btn-edit-my-data btn-transparent green-jungle">
                            <span aria-hidden="true" class="icon-note"></span>

                            تعديل

                        </a>

                    </div>
                </div>
            </div>
            <table class="table table-bordered">
                <tbody>
                <tr>
                    <td>الوظيفة</td>
                    <td>
                        {% if user.information %}
                        {{user.information.job}}
                        {% endif %}
                    </td>
                </tr>
                <tr>
                    <td>نوع الموظف</td>
                    <td>
                        {% if user.information and user.information.user_type %}
                        {{user.information.type.name}}
                        {% endif %}
                    </td>
                </tr>
                {% if user.companies | length > 0 %}
                <tr>
                    <td>الشركة التابع لها</td> 
                    <td>
                        <a>
                            {{user.companies[0].name}}
                            {% else %}
                            Pentavalue
                              
                        </a>
                    </td>
                </tr>
                {% endif %} 
                <tr>
                    <td>تليفون</td>
                    <td>
                        <a>
                        {% if user.information %}
                        {{user.information.mobile}}
                        {% endif %}
                        </a>
                        <span class="fa fa-phone font-green-jungle"></span>
                    </td>
                </tr>
                <tr>
                    <td>البريد الألكترونى</td>
                    <td><a>{{user.Mail}}</a></td>
                </tr>
                <tr>
                    <td>المصدر</td>
                    <td>
                        {% if user.information %}
                        {{user.information.source}}
                        {% endif %}
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>
    <div class="row gap">
        {% if user.information %}
        {{user.information.notes}}
        {% endif %}
     </div>
     <div class="row gap">
        Tags
        {% for uTag in user.tags %}
        <span class="label label-info">{{uTag.name}}</span>
        {% endfor %}
     </div>
</div>

<!-- BEGIN EXAMPLE TABLE PORTLET-->
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase">  حركات الموظف</span>
        </div>
    </div>
    <div class="portlet-body">
        <!--BEGIN TABS-->
        <div class="tab-content">
            <div class="tab-pane active" id="tab_1_1">
                <div class="scroller" style="height: 320px;" data-always-visible="1"
                     data-rail-visible1="0" data-handle-color="#D7DCE2">
                    <ul class="feeds">
                        {% for log in logs %}
                        <li>
                            <div class="col1">
                                <div class="cont">
                                    <div class="cont-col1">
                                        <div class="label label-sm label-danger">
                                            <i class="icon-cursor"></i>
                                        </div>
                                    </div>
                                    <div class="cont-col2">
                                        <div class="desc">
                                            {% if log.event %}
                                            <a href="">
                                            {{log.event.name}}
                                            </a> - الحالة {{log.responseType.name}}</div>
                                            {% endif %}
                                    </div>
                                </div>
                            </div>
                            <div class="col2">
                                <div class="date">{{log.created_at}}</div>
                            </div>
                        </li>
                        {% endfor %}

                    </ul>
                </div>
            </div>

        </div>
        <!--END TABS-->
    </div>
</div>
<!-- END EXAMPLE TABLE PORTLET-->

<!-- Modal _ new Data -->
<div class="modal fade" id="edit-employee" tabindex="-1">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header hidden-xs bold">
                تعديل بيانات
            </div>
            <div class="modal-body">
                <form role="form" method="post" action="{{url('projects/save')}}" id="new_project_form" enctype="multipart/form-data">
                        <div class="portlet-body">
                            <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group ">
                                    <label class="control-label"> الاسم بالكامل  </label>
                                    <input type="text" placeholder=" الاسم بالكامل" class="form-control" value="لينا عبدالحكيم "/>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label">المسمى الوظيفي</label>
                                    <select class="bs-select form-control select-custom" >
                                        <option>UI Designer</option>
                                        <option>Php Developer</option>
                                        <option>IOS Developer</option>
                                        <option selected> ادمن</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label">رقم الموبايل </label>
                                    <input type="number" placeholder="رقم الموبايل" class="form-control " value=""/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label">بريد اليكتروني </label>
                                    <input type="email" placeholder="email" class="form-control " value=""/>
                                </div>
                            </div>

                            
                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
                                    مكان عمل الموظف
                                </h4>
                            </div>
                            <div class="funkyradio col-md-12 col-xs-12">
                                <div class="col-md-4 col-sm-4 funkyradio-default">
                                    <input type="radio" name="client_type" value="1" required="" id="inside" checked>
                                    <label for="inside">داخلي</label>
                                </div>
                                <div class="col-md-4 col-sm-4 funkyradio-default">
                                    <input type="radio" name="client_type" value="2" required="" id="company">
                                    <label for="company">من شركة خارجية</label>
                                </div>
                                <div class="col-md-4 col-sm-4 funkyradio-default">
                                    <input type="radio" name="client_type" value="1" required="" id="freelancer" checked>
                                    <label for="freelancer">Freelancer</label>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-12 companies">
                                    <div class="form-group">
                                        <label class="control-label">الشركة</label>
                                        <select name="company" id="company">
                                            <option>الشركة العقارية</option>
                                            <option>الشركة الهندسية</option>
                                        </select>
                                    </div>
                                </div>

                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
                                    تغير كلمة المرور
                                </h4>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label">كلمة المرور</label>
                                    <input type="password" class="form-control"/>
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
                                    تغير الصورة الشخصية
                                </h4>
                            </div>
                            <div class="col-xs-12 col-md-12">
                                <form action="#" role="form">
                                    <div class="form-group text-center">
                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                            <div class="fileinput-new thumbnail" style="  width: 100%; height: 220px;">
                                                <img src="http://new.medsafe.su/s/images/expert.png" alt=""/></div>
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
                                </form>
                            </div>
                        </div>
                        </div>
                    <div class="modal-footer">
                        <input type="submit" data-dismiss="modal" class="btn dark " value="إلغاء">
                        <input type="submit" class="btn green-jungle " value="اضافة">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function deleteUser(id) {
    if(confirm("Are you sure you want to delete this user?")){
        window.location = "{{url('individuals/delete/')}}" + id;
    };
}
</script>

<!-- End Modal _ new Data  -->