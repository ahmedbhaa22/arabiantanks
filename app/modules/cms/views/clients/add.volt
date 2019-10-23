 <div class="">
                <div class="page-bar " style="position: relative">
                    <ul class="page-breadcrumb">
                        <li>
                            <i class="fa fa-home" aria-hidden="true"></i>
                            <a href="{{url('clients/index')}}"><span> الرئيسية </span></a>
                            <i class="fa fa-angle-left" aria-hidden="true"></i>
                        </li>
                        <li>
                            <a href="{{url('clients/list')}}"><span>العملاء</span></a>
							<i class="fa fa-angle-left" aria-hidden="true"></i>
                        </li>
						<li>
                            <span>إضافة عميل جديد</span>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"></div>

                <div class="col-lg-12">
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/clients/new-employees.png')}}') center center no-repeat ; background-size: contain"></div>
                        </div>
                    </div>
                </div>
                <div class="portlet light clearfix">
                    <div class="portlet-title">
                        <div class="caption font-dark">
                            <i class="fa fa-user-plus font-dark"></i>
                            <span class="caption-subject bold uppercase">  اضافة عميل جديد</span>
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
                    </div>
                    <div class="portlet-body">
                        <div class="row">
                            <form
                            {% if client_id !== null %}
                            action="{{url('clients/save/'~clien_id)}}"
                            {% else %}
                            action="{{url('clients/save')}}"
                            {% endif %}
                             role="form" method="post" enctype="multipart/form-data" id="new-client-form">
                             <input type="hidden" name="from_action" value="{{from_action}}">
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">الاسم </label>
                                        <input required name="name" type="text" class="form-control">
                                    </div>
                                </div>
                                <div class=" col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label"> البريد الالكترونى</label>
                                        <input name="email" type="email" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">تاريخ الميلاد</label>
                                        <input name="birthdate" type="date" class="form-control">
                                    </div>
                                </div>
                                <div class="col-sm-1">
                                    <div class="form-group">
                                        <label class=" control-label checkbox-label">النوع</label>
                                        <div class="col-sm-12 no-padding">
                                            <input name="gender" type="checkbox" class="make-switch" checked data-on-text="ذكر" data-off-text="انثى">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-1" style="margin-right:10px;">
                                    <div class="form-group">
                                        <label class=" control-label checkbox-label">مفعل</label>
                                        <div class="col-sm-12 no-padding">
                                            <input name="active" type="checkbox" class="make-switch" checked data-on-text="نعم" data-off-text="لا">
                                        </div>
                                    </div>
                                </div>


                                <!-- <div class="col-sm-9">
                                    <div class="form-group" id="addresses_container">
                                        <label >عنوان</label>
                                        <div class="col-xs-12 no-padding form-group" id="repeatTHIS">
                                            <input name="addresses[]" type="text" class="form-control">
                                        </div>


                                    </div>
                                </div> -->
                                <div class="col-xs-12 col-md-12">
                                    <h4 class="text-center inside-titles">
                                        عناوين العميل
                                    </h4>
                                </div>
                                <div id="addresses_container">
                                    <div class="row" id="repeatTHIS">
                                    <div class="form-group col-xs-12 no-padding">
                                       
                                        <div class=" col-lg-2 col-md-6 col-xs-6">
                                            <div class="form-group">
                                                <label class=" control-label"> المنطقة</label>
                                                <select name="address_data[0][region]" class="regions form-control">
                                                    <option></option>
                                                    {% for region in regions %}
                                                    <option value="{{region.id}}">{{region.name}}</option>
                                                    {% endfor %}
                                                </select>
                                            </div>
                                        </div>
                                        <div class=" col-lg-2 col-md-6 col-xs-6">
                                            <div class="form-group">
                                                <label class=" control-label"> المدينة</label>
                                                <select name="address_data[0][city]" class="cities form-control">
                                                    <option></option>
                                                   {% for city in cities %}
                                                   <option value="{{city.id}}">{{city.name}}</option>
                                                   {% endfor %}
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-xs-6">
                                            <label class=" control-label"> تفاصيل العنوان</label>
                                            <input name="address_data[0][details]" type="text" class="details form-control">
                                        </div>
                                        <div class="col-md-2 col-xs-2">
                                            <label>  العنوان الرئيسي؟</label>
                                            <div class="funkyradio col-md-12 no-padding">
                                                <div class="funkyradio-success">
                                                    <input type="radio" name="address_data[0][is_main]" id="main-address1" class="is_main the_radio">
                                                    <label for="main-address1"> الرئيسي</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </div>
                                

                                <div class="form-group col-xs-12 no-padding">
                                    <span><a class="btn btn-sm btn-default btn-outline" onclick="repeat()"><i class="fa fa-plus"></i> إضافة عنوان جديد </a></span>
                                </div>
                                <!-- <div class="col-xs-3 gap20">
                                    <button type="button" class="btn btn-xs btn-info" onclick="repeat()">
                                        <i class="fa fa-plus-circle" aria-hidden="true"></i> اضافة عنوان
                                    </button>
                                </div> -->


                                <script type="text/javascript">
                                        var i = 0;
                                    function repeat(e) {
                                      var indecator = ++i;

                                      var clone = $("#repeatTHIS").clone(true).prop({id: 'repeatTHIS'+indecator});

                                      clone.find("input:radio")
                                      .attr('id', indecator).attr('checked', false)
                                      .attr('name', 'address_data['+i+'][is_main]');
                                      clone.find("label").attr('for', indecator);
                                      clone.find(".regions").attr('name', 'address_data['+i+'][region]');
                                      clone.find(".cities").attr('name', 'address_data['+i+'][city]');
                                      clone.find(".details").attr('name', 'address_data['+i+'][details]').val("");
                                      clone.appendTo("#addresses_container");
                                    }
                                </script>

                                 <div class="col-xs-12 col-md-12">
                                    <h4 class="text-center inside-titles">
                                        معلومات عن العميل
                                    </h4>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">تصنيف العميل</label>
                                        <select required name="category_id" class="form-control" id="class">
                                            <option></option>
                                            {% for category in categories%}
                                            <option value="{{category.id}}">{{category.name}}</option>
                                            {% endfor %}
										  </select>
                                    </div>
                                </div>

                                <script>
                                    $(document).ready(function() {
                                        $("#class").on("change", function() {
                                            if ($(this).val() === "other") {
                                                $('#class').append('<input id="myInput" type="text" class="form-control" />');
                                            }
                                            else {
                                                $('#myInput').remove();
                                            }
                                        });
                                    });
                                </script>


                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">الشركة</label>
                                        <input name="company_name" type="text" class="form-control">
                                    </div>
                                </div>

                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">المنطقة</label>
                                        <select name="region_id" class="form-control">
                                            <option></option>
											 {% for region in regions %}
                                                <option value="{{region.id}}">{{region.name}}</option>
                                             {% endfor %}
										  </select>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">المدينة</label>
                                        <select name="city_id" class="form-control">
                                            <option></option>
											{% for city in cities %}
                                                <option value="{{city.id}}">{{city.name}}</option>
                                            {% endfor %}
										  </select>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">الفرع</label>
                                        <select name="branch_id" class="form-control">
											 <option></option>
											{% for branch in branches %}
                                                <option value="{{branch.id}}">{{branch.name}}</option>
                                            {% endfor %}
										  </select>
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label"> الهاتف</label>
                                        <input required name="mobile" type="tel" class="form-control">
                                    </div>
                                </div>
                                <div class=" col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">الرمز البريدى</label>
                                        <input name="postal_code" type="text" class="form-control">
                                    </div>
                                </div>


                                <div class=" col-sm-3">
                                    <div class="form-group">
                                        <label class=" control-label">تعليق المشرف</label>
                                        <textarea name="supervisor_comment" class="form-control"> </textarea>
                                    </div>
                                </div>

                                <div class="col-xs-12 col-md-12">
                                    <h4 class="text-center inside-titles">
                                        كلمة المرور
                                    </h4>
                                </div>

                                <div class="col-xs-12 col-sm-3">
                                    <div class="form-group">
                                        <label class="control-label">كلمة المرور</label>
                                        <input required id="pswd" name="password" type="password" class="form-control" />
                                    </div>
                                </div>

                                <div class="col-xs-12 col-sm-3">
                                    <div class="form-group">
                                        <label class="control-label"> تكرار كلمة المرور </label>
                                        <input required id="pswd_confirm" name="confirm_password" type="password" class="form-control" />
                                        <span id="err_span" hidden style="color:red;">
                                            {% if lang == 1%}
                                            كلمة المرور غير متطابقة
                                            {% else %}
                                            Passwords not matching
                                            {% endif %}
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <button type="submit" id="submit_btn" class="btn btn-primary">اضافة</button>
                                    <button class="btn dark">إلغاء</button>
                                </div>
                        </form>
                        </div>
                    </div>

                </div>
                <!-- END EXAMPLE TABLE PORTLET-->

            </div>

            <script type="text/javascript">
                $(document).ready(function()
                {
                    jQuery.extend(jQuery.validator.messages, {
                        required: 'هذا الحقل مطلوب',
                        email: 'أدخل صيغة بريد إلكتروني صحيحة',
                        min: jQuery.validator.format('هذا الحقل يجب أن يكون على الأقل {0} أحرف'),
                        max: jQuery.validator.format('هذا الحقل يجب أن يكون على الأكثر {0} أحرف'),
                    });

                    $('#new-client-form').validate();

                    var password = $('#pswd');
                    var password_confirm = $('#pswd_confirm');
                    var submit_btn = $('#submit_btn');
                    var err_span = $('#err_span');
                    var cancel_btn = $('#cancel');

                    password_confirm.keyup(function()
                    {
                        if($(this).val() !== password.val())
                        {
                            err_span.fadeIn();
                            submit_btn.attr("disabled",'disabled');
                        }     
                        else
                        {
                            err_span.fadeOut();
                            submit_btn.removeAttr("disabled");
                        }
                    });

                    cancel_btn.click(function()
                    {
                        window.location.href = "{{url('clients/list')}}";     
                    });

                    $('.is_main').on('click', function(e)
                    {
                        $('.is_main').prop('checked', false);
                        $(this).prop('checked', true);
                    });
                });
            </script>