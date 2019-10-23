        <!-- BEGIN CONTENT BODY -->
        <div class="">
            <div class="page-bar " style="position: relative">
                <ul class="page-breadcrumb">
                    <li>
                        <i class="fa fa-home" aria-hidden="true"></i>
                        <a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
                        <i class="fa fa-angle-left" aria-hidden="true"></i>
                    </li>
                    <li><span> المستخدمين </span>
                    </li>
                </ul>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class=" ">
                        <div class="row">
                            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                                <div class=""
                                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('img/all-employees.png')}}') center center no-repeat ; background-size: contain"></div>
                            </div>

                        </div>
                    </div>

                </div>

                <div class="col-md-12">
                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div class="portlet light clearfix">
                        <div class="portlet-title">
                            <div class="caption font-dark">
                                <i class="icon-settings font-dark"></i>
                                <span class="caption-subject bold uppercase"> موظفين الشركة</span>
                            </div>

                            <div class="actions">
                                <a type="button" data-target=".add-user" data-toggle="modal"
                                   class="btn btn-edit-my-data green-jungle btn-outline   btn-block"> <i class="fa fa-user-plus" aria-hidden="true"></i>
                                    إضافة موظف جديد</a>

                            </div>

                        </div>
                        <div class="portlet-body">
                            {% if session.get('error_msgs')|length %}
                            <ul style="color:red;float:left;">
                                {% for msg in session.get('error_msgs') %}
                                    <li style="float:left;">{{msg['field']}} : {{msg['message']}}</li><br>
                                    <?php $this->session->set('error_msgs', []) ?>
                                {% endfor %}
                            </ul>
                            {% endif %}
                             <?php $this->flashSession->output(); ?>
                            <table class="table table-striped table-bordered table-hover table-checkable order-column"
                                   id="sample_111">
                                <thead>
                                <tr>
                                    <th>
                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                            <input type="checkbox" class="group-checkable"
                                                   data-set="#sample_111 .checkboxes"/>
                                            <span></span>
                                        </label>
                                    </th>
                                    <th> أسم الموظف</th>
                                    <th> نوع العضوية</th>
                                    <th> تاريخ التسجيل</th>
                                    <th> تاريخ آخر تسجيل دخول</th>
                                    <th> إجراءات</th>
                                </tr>
                                </thead>
                                <tbody>
                                    {% for user in page.items %}
                                    <tr class="odd gradeX">
                                    <td>
                                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                            <input type="checkbox" class="checkboxes" value="{{user.ID}}"/>
                                            <span></span>
                                        </label>
                                    </td>

                                    <td>{{user.Title}}</td>

                                    <td>
                                        <a href="mailto:{{user.Mail}}">
                                            {% if user.user_rules != null and user.user_rules|length > 0%}
                                            {{user.user_rules[0].name}}
                                            {% endif %}
                                        </a>
                                    </td>

                                    <td class="center">{{user.formattedJoinDate()}}</td>
                                    <td class="center">-</td>
                                    <td>
                                        <a href="{{url('cp_users/viewUser/'~user.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                                        <button
                                        data-user_username="{{user.User}}"
                                        data-user_id="{{user.ID}}"
                                        data-user_name="{{user.Title}}"
                                        data-user_email="{{user.Mail}}"
                                        data-user_region="{{user.getRegionID()}}"
                                        data-user_city="{{user.getCityID()}}"
                                        data-user_branch="{{user.getBranchID()}}"
                                        data-user_rule="{{user.getRuleID()}}"
                                        data-user_mobile="{{user.Mobile}}"
                                        data-user_mobile2=""
                                        data-user_img="{{user.Img}}"
                                          data-target=".new-employee" data-toggle="modal" class="btn btn-xs btn-success edit-user"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

                                        <button data-user_id="{{user.ID}}" class="btn btn-xs btn-danger delete_user"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                                    </td>
                                </tr>
                                    {% endfor %}
                                </tbody>
                            </table>
                            <ul class="pagination" style="margin-right:40%;">
                            <li><a href="{{url('cp_users/usersList?page=1')}}">&laquo;&laquo;</a></li>
                            <li><a href="{{url('cp_users/usersList?page='~page.before)}}">&laquo;</a></li>
                            <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
                            {% if i == page.current %}
                            <li class="active"><span>{{i}}</span></li>
                            {% else %}
                            <li><a href="{{url('cp_users/usersList?page='~i)}}">{{i}}</a></li>
                            {% endif %}
                            <?php } ?>
                            <li><a href="{{url('cp_users/usersList?page='~page.next)}}">&raquo;</a></li>
                            <li><a href="{{url('cp_users/usersList?page='~page.last)}}">&raquo;&raquo;</a></li>
                            </ul>
<!--
                            <div class="btn-group">
                                <button class="btn  green dropdown-toggle" type="button" data-toggle="dropdown"
                                        aria-expanded="false"> إجراءات على المحدد
                                    <i class="fa fa-angle-down"></i>
                                </button>
                                <ul class="dropdown-menu" role="menu">

                                    <li>
                                        <a href="javascript:;" class="delete-general">
                                            <i class="icon-user"></i> حذف المحدد </a>
                                    </li>

                                </ul>
                            </div>
-->
                        </div>
                    </div>
                    <!-- END EXAMPLE TABLE PORTLET-->

                </div>
            </div>
            <!-- END PAGE HEADER-->
            <!-- BEGIN DASHBOARD STATS 1-->

            <div class="clearfix"></div>
            <!-- END DASHBOARD STATS 1-->

        </div>
        <!-- END CONTENT BODY -->
    </div>

    <div class="new-employee modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header hidden-xs">
                <div class="   col-xs-12 ">
                    <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{url.getStatic('img/edit.png')}}') center center no-repeat ; background-size: contain"></div>
                </div>
            </div>
            <form role="form" action="{{url('cp_users/editProfile')}}" method="post" enctype="multipart/form-data" id="1_add_pop_up_1">
                <input type="hidden" name="user_id" id="form_user_id">
                <input type="hidden" name="from_action" value="users_list">
                <div class="modal-body" >
                    <div class="portlet-body " style=" padding: 15px;">
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group ">
                                    <label class="control-label"> الاسم بالكامل  </label>
                                    <input name="name" type="text" placeholder=" الاسم بالكامل" class="form-control" id="form_user_name" />
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group ">
                                    <label class="control-label"> البريد الإلكتروني </label>
                                    <input type="email"  class="form-control" id="form_user_email" name="email" />
                                </div>
                            </div>
                            <div class="col-xs-6 col-md-3">
                                <div class="form-group ">
                                    <label class="control-label"> أسم المستخدم </label>
                                    <input id="form_user_username" type="text"  class="form-control" name="username"/>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label"> المنطقة </label>
                                    <select name="region_id" id="form_user_region" class=" region_id bs-select form-control select-custom" >
                                        <option></option>
                                        {% for region in regions %}
                                            <option value="{{region.id}}">{{region.name}}</option>
                                        {% endfor %}
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label"> المدينة </label>
                                    <select id="form_user_city" name="city_id" class="city_id bs-select form-control select-custom" >
                                        <option></option>
                                        {% for city in cities %}
                                            <option value="{{city.id}}">{{city.name}}</option>
                                        {% endfor %}
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label"> الفرع </label>
                                    <select id="form_user_branch" name="branch_id" class="branch_id bs-select form-control select-custom" >
                                        <option></option>
                                        {% for branch in branches %}
                                            <option value="{{branch.id}}">{{branch.name}}</option>
                                        {% endfor %}
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label">دور الموظف </label>
                                    <select id="form_user_rule" name="rule_id" class="bs-select form-control select-custom" >
                                        <option></option>
                                        {% for rule in rules %}
                                        <option value="{{rule.id}}">{{rule.name}}</option>
                                        {% endfor %}
                                    </select>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label">رقم الموبايل </label>
                                    <input id="form_user_mobile" name="mobile" type="number" placeholder="رقم الموبايل" class="form-control"/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label">رقم الموبايل 2 </label>
                                    <input id="form_user_mobile2" name="mobile2" type="number" placeholder="رقم الموبايل" class="form-control"/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
                                    تغير كلمة المرور
                                </h4>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label"> كلمة المرور الحالية</label>
                                    <input id="form_user_old_password" name="old_password" type="password" class="form-control"/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label">كلمة المرور الجديدة</label>
                                    <input id="form_user_new_password" name="new_password" type="password" class="form-control"/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
                                    تغير الصورة الشخصية
                                </h4>
                            </div>
                            <div class="col-xs-12 col-md-12">
                                <!-- <form action="#" role="form"> -->
                                    <div class="form-group text-center">
                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                            <div class="fileinput-new thumbnail" style="  width: 100%; height: 220px;">
                                                <img id="form_user_img" alt=""/></div>
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
                                <!-- </form> -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" data-dismiss="modal" class="btn dark " value="إلغاء">
                    <input type="submit" class="btn green-jungle " value="حفظ التعديلات">
                </div>
            </form>
        </div>
    </div>
</div>

<!-- add new user modal -->
    <div class="add-user modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header hidden-xs">
                <div class="   col-xs-12 ">
                    <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{url.getStatic('img/new-employees.png')}}') center center no-repeat ; background-size: contain"></div>
                </div>
            </div>
            <form role="form" action="{{url('cp_users/saveUser')}}" method="post" enctype="multipart/form-data" id="1_add_pop_up_1">
                <div class="modal-body" >
                    <div class="portlet-body " style=" padding: 15px;">
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group ">
                                    <label class="control-label"> الاسم بالكامل  </label>
                                    <input name="name" type="text" placeholder=" الاسم بالكامل" class="form-control" required/>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-6">
                                <div class="form-group ">
                                    <label class="control-label"> البريد الإلكتروني </label>
                                    <input type="email"  class="form-control" name="email" required />
                                </div>
                            </div>
                            <div class="col-xs-6 col-md-3">
                                <div class="form-group ">
                                    <label class="control-label"> أسم المستخدم </label>
                                    <input type="text"  class="form-control" name="username" required />
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label"> المنطقة </label>
                                    <select id="add_region_id" name="region_id" class="bs-select form-control select-custom" required >
                                        <option></option>
                                        {% for region in regions %}
                                            <option value="{{region.id}}">{{region.name}}</option>
                                        {% endfor %}
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label"> المدينة </label>
                                    <select id="add_city_id" name="city_id" class="bs-select form-control select-custom" required >

                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label"> الفرع </label>
                                    <select id="add_branch_id" name="branch_id" class="bs-select form-control select-custom" required >
                                        <!-- <option></option>
                                        {% for branch in branches %}
                                            <option value="{{branch.id}}">{{branch.name}}</option>
                                        {% endfor %} -->
                                    </select>
                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label">الفروع المسموحه للموظف </label>
                                   <div class="row"></div>
                                    <div class="allowed_branches_div">
                                        <ul class="allowed_branches_container">

                                        </ul>

                                    </div>

                                </div>
                            </div>
                            <div class="clearfix"></div>

                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label">دور الموظف </label>
                                    <select name="rule_id" class="bs-select form-control select-custom" required>
                                        <option></option>
                                        {% for rule in rules %}
                                        <option value="{{rule.id}}">{{rule.name}}</option>
                                        {% endfor %}
                                    </select>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label">رقم الموبايل </label>
                                    <input name="mobile" type="number" placeholder="رقم الموبايل" class="form-control" required/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-4">
                                <div class="form-group">
                                    <label class="control-label">رقم الموبايل 2 </label>
                                    <input name="mobile2" type="number" placeholder="رقم الموبايل" class="form-control"/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
                                  كلمة المرور
                                </h4>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label"> كلمة المرور </label>
                                    <input name="password" type="password" class="form-control" required/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <div class="form-group">
                                    <label class="control-label">تكرار كلمة المرور</label>
                                    <input name="confirm_password" type="password" class="form-control" required/>
                                </div>
                            </div>

                            <div class="col-xs-12 col-md-12">
                                <h4 class="text-center inside-titles">
                                   الصورة الشخصية
                                </h4>
                            </div>
                            <div class="col-xs-12 col-md-12">
                                <!-- <form action="#" role="form"> -->
                                    <div class="form-group text-center">
                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                            <div class="fileinput-new thumbnail" style="  width: 100%; height: 220px;">
                                                <img id="form_user_img" alt=""/></div>
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
                                <!-- </form> -->
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="button" data-dismiss="modal" class="btn dark " value="إلغاء">
                    <input type="submit" class="btn green-jungle " value="حفظ التعديلات">
                </div>
            </form>
        </div>
    </div>
</div>

    <script type="text/javascript">
        var modal_user_id      = $('#form_user_id');
        var modal_user_name    = $("#form_user_name");
        var modal_user_email   = $('#form_user_email');
        var modal_user_region  = $('#form_user_region');
        var modal_user_city    = $('#form_user_city');
        var modal_user_branch  = $('#form_user_branch');
        var modal_user_rule    = $('#form_user_rule');
        var modal_user_mobile  = $('#form_user_mobile');
        var modal_user_mobile2 = $('#form_user_mobile2');
        var modal_user_img     = $('#form_user_img');
        var modal_user_username = $('#form_user_username');

        $('.edit-user').on('click', function()
        {
            modal_user_id.val($(this).data('user_id'));
            modal_user_name.val($(this).data('user_name'));
            modal_user_email.val($(this).data('user_email'));
            modal_user_region.val($(this).data('user_region'));
            modal_user_city.val($(this).data('user_city'));
            modal_user_branch.val($(this).data('user_branch'));
            modal_user_rule.val($(this).data('user_rule'));
            modal_user_mobile.val($(this).data('user_mobile'));
            modal_user_mobile2.val($(this).data('user_mobile2'));
            modal_user_img.attr('src', "{{url.getStatic('uploads/users/')}}"+$(this).data('user_img'));
            modal_user_username.val($(this).data('user_username'));
        });

        $('.delete_user').on('click', function()
        {
           if(confirm('أنت على وشك حذف أحد مستخدمي النظام، إستكمال العملية؟'))
           {
                $.ajax({
                    type: 'post',
                    url: "{{url('cp_users/deleteSystemUser/')}}"+$(this).data('user_id'),
                    success: function(response)
                    {
                        response = JSON.parse(response);

                        switch(response.status)
                        {
                            case 0:
                            alert(response.msg);
                            break;
                            case 1:
                            window.location.href = "{{url('cp_users/usersList')}}";
                            break;
                        }
                    }
                });
           } 
        });

    $('#add_region_id').on('change', function()
    {
       $.ajax({
        type: 'get',
        url: "{{url('cp_users/getRegionCitiesAndBranches/')}}" + $(this).val(),
        success: function(response)
        {
            response = JSON.parse(response);

            $('#add_city_id').html('');
            $('#add_branch_id').html('');
            $('.allowed_branches_container').html("");

            for(var i = 0; i < response.cities.length; i++)
            {

                var option = "<option value='"+response.cities[i].id+"'>"+response.cities[i].name+"</option>";
                $('#add_city_id').append(option);
            }

            for(var j = 0; j < response.branches.length; j++)
            {

                var option = "<option value='"+response.branches[j].id+"'>"+response.branches[j].name+"</option>";
                $('#add_branch_id').append(option);

                var allowed_branches = "<li><input type='checkbox' name='allowed_branches[]' value='"+response.branches[j].id+"'>"+response.branches[j].name+"</li>";
                $('.allowed_branches_container').append(allowed_branches);
            }
        }
       }); 
    });

    $('#form_user_region').on('change', function()
    {
       $.ajax({
        type: 'get',
        url: "{{url('cp_users/getRegionCitiesAndBranches/')}}" + $(this).val(),
        success: function(response)
        {
            response = JSON.parse(response);

            $('#form_user_city').html('');
            $('#form_user_branch').html('');

            for(var i = 0; i < response.cities.length; i++)
            {
                var option = "<option value='"+response.cities[i].id+"'>"+response.cities[i].name+"</option>";
                $('#form_user_city').append(option);
            }

            for(var j = 0; j < response.branches.length; j++)
            {
                var option = "<option value='"+response.branches[j].id+"'>"+response.branches[j].name+"</option>";
                $('#form_user_branch').append(option);
            }
        }
       }); 
    });
    </script>