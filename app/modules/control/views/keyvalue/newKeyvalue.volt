
    <div class="modal-header hidden-xs">
        <div class="col-xs-12 ">
            <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{this.url_shared.get("ropo_app/")}}img/default-form-img.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
    <form action="{{url('keyvalue/createKeyvalue')}}" class="form-horizontal" autocomplete="off" method="post">
        <div class="modal-body" >
            <div class="portlet-body " style=" padding: 15px;">
                <div class="row">

                    <div class="col-xs-6">
                        <div class="form-group">
                            <input type="text" id="fieldTitle" name="Paramter" class="form-control"required="required" placeholder="Parameter">
                        </div>
                    </div>
                    <div class="col-xs-6 funkyradio">
                        <div class="funkyradio-default">
                            <input type="checkbox" name="Show_menu" id="Show_menu{{group.ID}}" checked  />
                            <label for="Show_menu{{group.ID}}">إظهار في المحتوى</label>
                        </div>
                        <div class="funkyradio-default">
                            <input type="checkbox" name="from_external_table" id="from_external_table{{group.ID}}"/>
                            <label for="from_external_table{{group.ID}}">القيم من جدول أخر؟</label>
                        </div>
                        <div id="external_table_div" hidden>
                            <select name="external_table" class="form-control">
                                {% for entity in setup_entities %}
                                    <option value="{{ entity.id }}">{{ entity.name }}</option>
                                {% endfor %}
                            </select>
                        </div>
                    </div>


                    <div class="col-xs-12">
                        <div class="form-group">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">العنوان</label>
                            <div class="col-xs-4 nopadding-r">
                                <input type="text" id="fieldTitle1" name="Title" class="form-control" required="required" placeholder="Default">
                            </div>
                            {%for lang in langs%}
                            <div class="col-xs-4 nopadding-r">
                                <input type="text" id="fieldTitle1" name="Title{{lang.lang_id}}" class="form-control" required="required" placeholder="{{lang.LangDetails.title}}">
                            </div>
                            {%endfor%}
                        </div>
                    </div>
                    <input type="hidden" name="Group_ID" value="{{group.ID}}" />
                    <input type="hidden" name="Module_ID" value="{{group.Module_ID}}" />

                    <div class="col-xs-12 basic_keyvalue_fields">
                        <div class="form-group">
                            <label for="fieldActive" class="control-label">النوع</label>
                            <div class="col-xs-12 no-padding">
                                <div class="col-xs-3 nopadding-r">
                                    <input type="radio" name="CKV_ID" class="icon small ignore_hide" id="combo{{group.ID}}" value="1" >
                                    <label for="combo{{group.ID}}"><i class="fa fa-angle-down"></i> قائمة أختيارات  </label>
                                </div>

                                <div class="col-xs-3 nopadding-r">
                                    <input type="radio" name="CKV_ID" class="icon small" id="text_box{{group.ID}}" value="2">
                                    <label for="text_box{{group.ID}}"><i class="fa icon-pencil"></i> مربع نص  </label>
                                </div>

                                <div class="col-xs-3 nopadding-r">
                                    <input type="radio" name="CKV_ID" class="icon small ignore_hide" id="check_box{{group.ID}}" value="3">
                                    <label for="check_box{{group.ID}}"><i class="fa icon-check"></i> مربع تصحيح  </label>
                                </div>

                                <div class="col-xs-3 nopadding-r">
                                    <input type="radio" name="CKV_ID" class="icon small" id="upload_box{{group.ID}}" value="4">
                                    <label for="upload_box{{group.ID}}"><i class="fa icon-cloud-upload"></i> رفم ملف  </label>
                                </div>

                                <div class="col-xs-3 nopadding-r">
                                    <input type="radio" name="CKV_ID" class="icon small" id="paragraph{{group.ID}}" value="5">
                                    <label for="paragraph{{group.ID}}"><i class="fa icon-book-open"></i> مربع فقرة  </label>
                                </div>

                                <div class="col-xs-3 nopadding-r">
                                    <input type="radio" name="CKV_ID" class="icon small" id="time{{group.ID}}" value="6">
                                    <label for="time{{group.ID}}"><i class="fa icon-calendar"></i> تاريخ  </label>
                                </div>

                                <div class="col-xs-3 nopadding-r">
                                    <input type="radio" name="CKV_ID" class="icon small" id="db{{group.ID}}" value="7">
                                    <label for="db{{group.ID}}"><i class="fa icon-layers"></i> DB  </label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-12 basic_keyvalue_fields" id="main-depts{{group.ID}}" style="">
                        <div class="form-group">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">الأقسام الرئيسية (عند
                                الDB فقط) </label>
                            <div class="col-xs-12 nopadding-r">
                                <?php echo Phalcon\Tag::select([
                                    "Core_Depts_ID",
                                    $main_depts,
                                    "using" => ["ID", "Title"]]);
                                ?>
                            </div>
                        </div>


                    </div>
                    <div class="col-sm-12 basic_keyvalue_fields" id="select-options{{group.ID}}" style="display: none;">
                        <div class="form-group">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">الأختيارات</label>
                            <div class="col-xs-12 nopadding-r">
                                <div id="add-option">
                                    <div>
                                        <div class="col-xs-4 nopadding-r">
                                            <input type="text" id="fieldTitle1" name="seletcTitleDefault[]" class="form-control">
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <a class="btn btn-xs btn-primary" onclick="repeat()">
                                <i class="fa fa-plus-circle" aria-hidden="true"></i>  أضف اختيار
                            </a>
                        </div>
                        <script type="text/javascript">
                            var i = 0;
                            var original = document.getElementById('add-option');

                            function repeat() {
                                var clone = original.cloneNode(true);
                                clone.id = "add-option" + ++i;
                                original.parentNode.appendChild(clone);
                            }
                            function valueChanged()
                            {
                                if($('#combo{{group.ID}}').is(":checked"))
                                    $("#select-options{{group.ID}}").show();
                                else
                                    $("#select-options{{group.ID}}").hide();
                            }

                                $('#combo{{group.ID}}').on( "change", function() {

                                    var test = $(this).val();
                                    //$("#select-options{{group.ID}}").hide();
                                    $("#select-options{{group.ID}}").show();
                                } );
                            $('#check_box{{group.ID}}').on( "change", function() {

                                var test = $(this).val();
                                //$("#select-options{{group.ID}}").hide();
                                $("#select-options{{group.ID}}").show();
                            } );
                            $('input:radio:not(".ignore_hide")').on( "change", function() {

                                var test = $(this).val();
                                //$("#select-options{{group.ID}}").hide();
                                $("#select-options{{group.ID}}").hide();
                            } );

                        </script>

                    </div>

                    <div class="col-sm-12 basic_keyvalue_fields" id="kv_validation_settings" style="">
                        <div class="form-group">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">الفاليديشن </label>
                            {%for kv_type in kv_types%}
                            <div class="col-xs-3 nopadding-r">
                                <input type="radio" name="kv_type" id="kv_type{{kv_type.id}}" value="{{kv_type.id}}"  />
                                <label for="kv_type{{kv_type.id}}">{{kv_type.type}}</label>
                            </div>
                            {%endfor%}
                            <div class="clearfix"></div>
                            <div class="col-xs-3 nopadding-r">
                                <input type="checkbox" name="required_kv" id="required_kv" />
                                <label for="required_kv">Keyvalue Required ?</label>
                            </div>

                        </div>


                    </div>

                </div>
            </div>
        </div>
        <div class="modal-footer">
            <input type="button" data-dismiss="modal" class="btn dark " value="إلغاء">
            <input type="submit"  class="btn green-jungle " value="حفظ التعديلات">
        </div>
    </form>

    <script type="text/javascript">
        var external_table_check = $("#from_external_table{{group.ID}}");

        external_table_check.change(function()
        {
            if($(this).is(':checked'))
            {
                $('#external_table_div').show();
                $('.basic_keyvalue_fields').hide();
            }
            else
            {
                $('#external_table_div').hide();
                $('.basic_keyvalue_fields').show();
            }
        });
    </script>