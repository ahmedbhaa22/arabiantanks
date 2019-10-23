<div class="modal-content">
    <div class="modal-header hidden-xs">
        <div class="col-xs-12 ">
            <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{this.url_shared.get("ropo_app/")}}img/default-form-img.png') center center no-repeat ; background-size: contain"></div>
    </div>
</div>
<form method="post" action="" id="editKeyvalueSave" >
    <div class="modal-body" >
        <div class="portlet-body " style=" padding: 15px;">
            <div class="row">


                <!--                        <div class="col-xs-6">-->
                <!--                            <div class="form-group">-->
                <!--                                <input type="text" id="fieldTitle" name="Paramter" class="form-control"required="required" placeholder="Parameter">-->
                <!--                            </div>-->
                <!--                        </div>-->
                <div class="col-xs-12 funkyradio">
                    <div class="funkyradio-default">
                        {{ check_field("showMenu") }}
                        <label for="showMenu">{{translate._("Show in Content List")}}</label>
                    </div>
                </div>

                <div class="col-xs-12">
                    <div class="form-group">

                        <div class="col-xs-4 nopadding-r">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{translate._("Default")}}</label>
                            {%for app_lang in app_langs%}
                            {%if app_lang.is_default == 1%}
                            <?php
                            $default_kv_lang= $keyvalue->getDataKeyvalueLang(["Lang_ID={$app_lang->lang_id}"]);
                            if($default_kv_lang){
                                $default_value= $default_kv_lang->Title;
                            }else{
                                $default_value="";
                            }

                            ?>
                            <input type="text" id="fieldTitle{{app_lang.lang_id}}" name="TitleDefault" class="formDefault-control" required value='{{default_value}}'>
                            {%endif%}
                            {%endfor%}
                        </div>
                        {%for app_lang in app_langs%}
                        {%if app_lang.is_default == 1%}
                        {%continue%}
                        {%endif%}
                        {%if keyvalue.getDataKeyvalueLang(["Lang_ID=" ~app_lang.lang_id])%}
                        <div class="col-xs-4 nopadding-r">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{app_lang.LangDetails.title}}</label>
                            <input type="text" id="fieldTitle{{app_lang.lang_id}}" name="Title{{app_lang.lang_id}}" class="form-control" value='{{keyvalue.getDataKeyvalueLang(["Lang_ID=" ~app_lang.lang_id]).Title}}'>
                        </div>
                        {%else%}
                        <div class="col-xs-4 nopadding-r">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{app_lang.LangDetails.title}}</label>
                            <input type="text" id="fieldTitle{{app_lang.lang_id}}" name="Title{{app_lang.lang_id}}" class="form-control" value=''>
                        </div>
                        {%endif%}
                        {%endfor%}

                    </div>
                </div>
                <!-- <div class="col-xs-4">
                    <div class="form-group">
                        <label for="fieldActive" class="control-label">الجروب</label>
                            <select id="Module_ID" name="Module_ID">
                                <option value="">جروب 1</option>
                                <option value="">جروب 2</option>
                            </select>
                    </div>
                </div> -->

                <div class="col-xs-12">
                    <div class="form-group">
                        <div class="funkyradio gap">
                            <label for="fieldActive" class="control-label">{{translate._("Additional Fields Show Options")}}</label>
                            <div class="col-xs-12 no-padding">

                                <div class="col-xs-3 nopadding-r">
                                    <div class="funkyradio-default">
                                        {{ check_field("Title") }}
                                        <label for="Title">{{translate._("Title")}}</label>
                                    </div>
                                </div>

                                <div class="col-xs-3 nopadding-r">
                                    <div class="funkyradio-default">
                                        {{ check_field("Des") }}
                                        <label for="Des">{{translate._("Description")}}</label>
                                    </div>
                                </div>

                                <div class="col-xs-3 nopadding-r">
                                    <div class="funkyradio-default">
                                        {{ check_field("Img") }}
                                        <label for="Img">{{translate._("Image")}}</label>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>

                {%if(kv_type == 1 or kv_type == 3)%}
                <div class="col-sm-12" id="select-options" style="display: block;">
                    <div class="form-group">
                        <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{translate._("Select Options")}}</label>
                        {%for option in options %}
                        <div class="col-xs-12 nopadding-r">
                            <div id="existed-options">
                                {%for lang in option.getDataKeyvalueOptionLang("Lang_ID=2")%}
                                <div>
                                    <div class="col-xs-4 nopadding-r">
                                        <label for="fieldTitle" class="control-label col-xs-12 no-padding">Default</label>
                                        <input type="text" id="option{{option.ID}}lang2" name="option{{option.ID}}lang2" class="form-control"  value="{{lang.Title}}">
                                    </div>

                                </div>
                                {%endfor%}
                                {%for app_lang in app_langs%}
                                {%if(app_lang.lang_id==2)%}{%continue%}{%endif%}
                                {%if option.getDataKeyvalueOptionLang("Lang_ID=" ~app_lang.lang_id)|length ==0%}
                                <div>
                                    <div class="col-xs-4 nopadding-r">
                                        <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{app_lang.LangDetails.title}}</label>
                                        <input type="text" id="fieldTitle{{app_lang.lang_id}}" name="option{{option.ID}}lang{{app_lang.lang_id}}" class="form-control"  value="">
                                    </div>

                                </div>
                                {%endif%}
                                {%for lang in option.getDataKeyvalueOptionLang("Lang_ID=" ~app_lang.lang_id)%}
                                <div>
                                    <div class="col-xs-4 nopadding-r">
                                        <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{app_lang.LangDetails.title}}</label>
                                        <input type="text" id="fieldTitle{{app_lang.lang_id}}" name="option{{option.ID}}lang{{app_lang.lang_id}}" class="form-control"  value="{{lang.Title}}">
                                    </div>

                                </div>
                                {%endfor%}
                                {%endfor%}



                            </div>

                        </div>
                        {%endfor%}
                        <div class="col-xs-12 nopadding-r" id="new-option">
                            <div class="col-xs-4 nopadding-r">
                                <label for="fieldTitle" class="control-label col-xs-12 no-padding">Default</label>
                                <input type="text" id="fieldTitle{{app_lang.lang_id}}" name="option_new1[]" class="form-control"  value="">
                            </div>
                            {%for app_lang in app_langs%}
                            {%if(app_lang.lang_id==2)%}{%continue%}{%endif%}
                            <div>
                                <div class="col-xs-4 nopadding-r">
                                    <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{app_lang.LangDetails.title}}</label>
                                    <input type="text" id="fieldTitle{{app_lang.lang_id}}" name="option_new{{app_lang.lang_id}}[]" class="form-control"  value="">
                                </div>

                            </div>
                            {%endfor%}

                        </div>


                    </div>
                    <a class="btn btn-xs btn-primary" onclick="repeat()">
                        <i class="fa fa-plus-circle" aria-hidden="true"></i>  {{translate._("Add Option")}}
                    </a>
                    <script type="text/javascript">
                        var i = 0;
                        var original = document.getElementById('new-option');

                        function repeat() {
                            var clone = original.cloneNode(true);
                            clone.id = "new-option" + ++i;
                            original.parentNode.appendChild(clone);
                        }



                    </script>

                </div>
                {%endif%}


            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="" data-dismiss="modal" class="btn dark " value="{{translate._("Cancel")}}">
        <input type="submit" id="submit"  class="btn green-jungle " value="{{translate._("Save")}}">
    </div>
</form>
</div>


<script>

    $("#editKeyvalueSave").submit(function(e) {
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var url = "{{url('keyvalue/editKeyvalueSave/') ~kv_id}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#editKeyvalueSave").serialize(), // serializes the form's elements.
            success: function(data)
            {
                alert(data); // show response from the php script.
                location.reload();
            }
        });


    });





</script>












<!-- OLD View -->
