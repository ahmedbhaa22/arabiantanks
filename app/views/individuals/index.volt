<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url({{url('ropo_app/img/all-employees.png')}}) center no-repeat;">
        </div>
    </div>
</div>
<div class="portlet light bordered">
    <div class="portlet-title">
        <!-- <div class="caption font-dark">
            <i class="icon-settings font-dark"></i>
            <span class="caption-subject bold uppercase"> موظفين الشركة</span>
        </div> -->

        <div class="actions">
            <a type="button" href="{{url('individuals/create')}}" 
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block"> إضافة موظف
                جديد</a>
        </div>

        <a type="button" class="btn btn-edit-my-data btn-transparent green-jungle " style="display: inline" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true">
            <span aria-hidden="true" class="icon-note"></span>
            فلتر
        </a>

    </div>
     <div class="portlet light panel-collapse collapse" id="collapseOne" >
        <form method="get" action="{{url('individuals')}}">
            <div class="row">  
                <div class="col-xs-5 col-md-5 col-xs-5">
                    <div class="form-group ">
                        <div class="col-md-3 col-xs-3"><label class="control-label">اسم الفرد</label></div>
                        <div class="col-md-9 col-xs-9">
                            <input id="name" name="name" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-5 col-md-5 col-xs-5">
                    <div class="form-group ">
                        <div class="col-md-3 col-xs-3"><label class="control-label">الوظيفة</label></div>
                        <div class="col-md-9 col-xs-9">
                            <input id="job" name="job" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-5 col-md-5 col-xs-5">
                    <div class="form-group">
                        <div class="col-md-2 col-xs-2"><label class="control-label">الشركة</label></div>
                        <div class="col-md-9 col-xs-9">
                            <select name="companies[]" id="companies">
                                <option></option>
                                {% for com in companies %}
                                <option value="{{com.id}}">{{com.name}}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col-xs-5 col-md-5 col-xs-5">
                    <div class="form-group">
                        <div class="col-md-3 col-xs-3"><label class="control-label">Tags</label></div>
                        <div class="col-md-9 col-xs-9">
                            <select name="tags[]" id="tags">
                                <option>

                                </option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="col-md-2 col-xs-2">
                    <input type="submit" name="submit_waybill" value="فلتر" class="form-control btn">
                </div>
            </div>
        </form>
    </div>  
    <div class="portlet-body">

        <table class="table table-striped table-bordered table-hover table-checkable order-column"
               id="sample_1">
            <thead>
            <tr>
                <th>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="group-checkable"
                               data-set="#sample_1 .checkboxes"/>
                        <span></span>
                    </label>
                </th>
                <th> أسم الموظف</th>
                <th> المسمى الموظيفي </th>
                <th> بريد اليكتروني </th>
                <th> اسم الشركة </th>
                <th> تاريخ التسجيل</th>
                <th> إجراءات</th>
            </tr>
            </thead>
            <tbody>
                {% for user in users %}
                <tr class="odd gradeX">
                    <td>
                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" name="user_checkbox" class="checkboxes" value="{{user.ID}}"/>
                            <span></span>
                        </label>
                    </td>

                    <td> <a href="#">{{user.Title}}</a> </td>
                    <td>
                        {% if user.information %}
                        {{user.information.job}}
                        {% endif %}
                    </td>
                    <td> <a href="#">{{user.Mail}}</a> </td>
                    <td>
                            {% if user.companies | length > 0 %}
                        <a href="{{url('companies/view/') ~ user.companies[0].id}}">
                            {{user.companies[0].name}}
                            {% else %}
                            Pentavalue
                        </a>
                            {% endif %}  
                    </td>

                    <td class="center"><?php echo date("Y/m/d", $user->Join_Date); ?></td>
                    <td>
                        <div class="btn-group">
                            <button class="btn btn-xs green dropdown-toggle" type="button"
                                    data-toggle="dropdown" aria-expanded="false"> إجراء
                                <i class="fa fa-angle-down"></i>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li>
                                    <a href="{{url('individuals/view/') ~ user.ID}}">
                                        <i class="icon-docs"></i> مشاهده </a>
                                </li>

                                <li>
                                    <a href="{{url('individuals/edit/') ~ user.ID}}">
                                        <i class="icon-tag"></i> تعديل </a>
                                </li>

                                <li>
                                    <a onclick="deleteUser({{user.ID}})">
                                        <i class="icon-user"></i> حذف </a>
                                </li>

                            </ul>
                        </div>
                    </td>
                </tr>
                {% endfor %}
            </tbody>
        </table>
        <div class="btn-group">
            <button class="btn  green dropdown-toggle" type="button" data-toggle="dropdown"
                    aria-expanded="false"> إجراءات على المحدد
                <i class="fa fa-angle-down"></i>
            </button>
            <ul class="dropdown-menu" role="menu">

                <li>
                    <a href="javascript:;" onclick="deleteMarked()">
                        <i class="icon-user"></i> حذف المحدد </a>
                </li>

            </ul>
        </div>
    </div>
</div>

<!-- Modal _ new Data -->
<div class="modal fade" id="edit-employee" tabindex="-1">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header hidden-xs bold">
                اضافة موظف
            </div>
            <div class="modal-body">
                <form role="form" method="post" action="{{url('projects/save')}}" id="new_project_form" enctype="multipart/form-data">
                        <div class="portlet-body">
                            <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group ">
                                    <label class="control-label"> الاسم بالكامل  </label>
                                    <input type="text" placeholder=" الاسم بالكامل" class="form-control" value="جون "/>
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
        window.location = "individuals/delete/" + id;
    };
}

$(".group-checkable").change(function(){
    if($(this).is(':checked')){
        console.log('checked');
        $(".checkboxes").prop("checked", true);
    }
    else
    {
        console.log('unchecked');
        $(".checkboxes").prop("checked", false);
    }    
});

$(".checkboxes").click(function () {
    $(".group-checkable").prop("checked", false);
})

function deleteMarked() {
    var values = $("input[name='user_checkbox']:checked").map(function () {
      return this.value;
    }).get();

    console.log(values);
    $.ajax({
        url: "{{url('individuals/multi_delete')}}",
        method: "POST",
        data: {ids: values},
        success: function(response){
            location.reload();
        }
    });
}
</script>

<!-- End Modal _ new Data  -->
