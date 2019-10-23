<div class="">
    <div class="row">
        <div class="col-lg-12">
            <div class="portlet light clearfix">
                 <div class="portlet-title">
                            <div class="caption font-dark">
                                <i class="fa fa-user font-dark"></i>
                                <span class="caption-subject bold uppercase"> {{user.Title}}</span>
                            </div>

                            <div class="actions">
                                <a type="button" class="btn btn-edit-my-data green-jungle btn-block "
                                   data-target=".static" data-toggle="modal" style="display: inline">
                                    <span aria-hidden="true" class="icon-note"></span> تعديل بيانات الموظف
                                </a>
                                <button id="delete-user" data-user_id="{{user.ID}}" class="btn btn-edit-my-data green-jungle btn-outline  btn-block btn-outline "
                                       style="display: inline; margin-left: 5px ;">
                                        <span aria-hidden="true" class="icon-trash"></span>
                                        أستبعاد الموظف
                                </button>
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
                    <div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 text-center">
                        <div class="img-holder img-thumbnail"
                             style="width: 180px; height: 180px ; overflow: hidden ; background: url('{{url.getStatic('uploads/users/'~user.Img)}}') center center no-repeat ; background-size: cover"></div>
                        <small>تاريخ التسجيل: {{user.formattedJoinDate()}}</small>

                    </div>
                    <div class="col-lg-10 col-md-9 col-sm-9  col-xs-12">


                        <table class="table table-bordered">
                            <tbody>
                                <tr>
                                    <td>دور الموظف</td>
                                    <td>
                                        {% if user.user_rules != null and user.user_rules|length > 0%}
                                            {{user.user_rules[0].name}}
                                        {% endif %}
                                    </td>
                                </tr>
                                <tr>
                                    <td>البريد الألكترونى</td>
                                    <td>{{user.Mail}}</td>
                                </tr>
                                <tr>
                                    <td>المنطقة</td>
                                    <td>
                                        {% if user.data != null and user.data.region != null %}
                                            {{user.data.region.getName()}}
                                        {% endif %}
                                    </td>
                                </tr>
                                <tr>
                                    <td>المدينة</td>
                                    <td>
                                        {% if user.data != null and user.data.city != null %}
                                            {{user.data.city.getName()}}
                                        {% endif %}
                                    </td>
                                </tr>
                                <tr>
                                    <td>الفرع</td>
                                    <td>
                                        {% if user.data != null and user.data.branch != null %}
                                            {{user.data.branch.name}}
                                        {% endif %}
                                    </td>
                                </tr>
                                <tr>
                                    <td>موبايل</td>
                                    <td>
                                        <a tel:{{user.Mobile}}>{{user.Mobile}}</a>
                                        <span class="fa fa-phone font-green-jungle"></span>
                                        <!-- <a tel:0125247542>0125247542</a>
                                        <span class="fa fa-phone font-green-jungle"></span> -->
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </div>
    </div>
    <!-- END PAGE HEADER-->
    <!-- BEGIN DASHBOARD STATS 1-->

    <div class="clearfix"></div>
    <!-- END DASHBOARD STATS 1-->

</div>

        <!-- Modal _ Data -->
<div class=" static modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
<div class="modal-dialog ">
    <div class="modal-content">
        <div class="modal-header hidden-xs">
            <div class="   col-xs-12 ">
                <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{url.getStatic('img/edit.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
        <form role="form" action="{{url('cp_users/editProfile')}}" method="post" enctype="multipart/form-data" id="1_add_pop_up_1">
            <input type="hidden" name="user_id" value="{{user.ID}}">
            <input type="hidden" name="from_action" value="user_view">
            <div class="modal-body" >
                <div class="portlet-body " style=" padding: 15px;">
                    <div class="row">
                        <div class="col-xs-12 col-md-6">
                            <div class="form-group ">
                                <label class="control-label"> الاسم بالكامل  </label>
                                <input name="name" type="text" placeholder=" الاسم بالكامل" class="form-control" value="{{user.Title}}"/>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6">
                            <div class="form-group ">
                                <label class="control-label"> البريد الإلكتروني </label>
                                <input name="email" type="email"  class="form-control" value=" {{user.Mail}}"/>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <label class="control-label"> المنطقة </label>
                                <select name="region_id" class="bs-select form-control select-custom" >
                                    <option></option>
                                    {% for region in regions %}
                                        {% if user.data.region_id == region.id %}
                                        <option selected value="{{region.id}}">{{region.getName()}}</option>
                                        {% else %}
                                        <option value="{{region.id}}">{{region.getName()}}</option>
                                        {% endif %}
                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <label class="control-label"> المدينة </label>
                                <select name="city_id" class="bs-select form-control select-custom" >
                                   <option></option>
                                   {% for city in cities %}
                                        {% if city.id == user.data.city_id %}
                                        <option selected value="{{city.id}}">{{city.getName()}}</option>
                                        {% else %}
                                        <option value="{{city.id}}">{{city.getName()}}</option>
                                        {% endif %}
                                   {% endfor %}
                                </select>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <label class="control-label"> الفرع </label>
                                <select name="branch_id" class="bs-select form-control select-custom" >
                                    <option></option>
                                    {% for branch in branches %}
                                        {% if branch.id == user.data.branch_id %}
                                        <option selected value="{{branch.id}}">{{branch.name}}</option>
                                        {% else %}
                                        <option value="{{branch.id}}">{{branch.name}}</option>
                                        {% endif %}
                                    {% endfor %}
                                </select>
                            </div>
                      </div>
                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <label class="control-label">دور الموظف </label>
                                <select name="rule_id" class="bs-select form-control select-custom" >
                                    <option></option>
                                    {% for rule in rules %}
                                        {% if user.user_rules and user.user_rules|length > 0 and user.user_rules[0].id == rule.id %}
                                        <option selected value="{{rule.id}}">{{rule.name}}</option>
                                        {% else %}
                                        <option value="{{rule.id}}">{{rule.name}}</option>
                                        {% endif %}
                                    {% endfor %}
                                </select>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <label class="control-label">رقم الموبايل </label>
                                <input name="mobile" type="number" placeholder="رقم الموبايل" class="form-control " value="{{user.Mobile}}"/>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-4">
                            <div class="form-group">
                                <label class="control-label">رقم الموبايل 2 </label>
                                <input name="mobile2" type="number" placeholder="رقم الموبايل" class="form-control " value=""/>
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
                                <input name="old_password" type="password" class="form-control"/>
                            </div>
                        </div>

                        <div class="col-xs-12 col-md-6">
                            <div class="form-group">
                                <label class="control-label">كلمة المرور الجديدة</label>
                                <input name="new_password" type="password" class="form-control"/>
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
                                            <img src="{{url.getStatic('uploads/users/'~user.Img)}}" alt=""/></div>
                                        <div class="fileinput-preview fileinput-exists thumbnail"
                                             style="max-width: 220px; max-height: 220px;"></div>
                                        <div style=" margin-top:20px">
                                            <span class="btn default btn-file">
                                            <span class="fileinput-new"> أختار الصورة</span>
                                            <span class="fileinput-exists"> تغير </span>
                                            <input type="file" name="img"> </span>
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
    $('#delete-user').on('click', function()
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
</script>