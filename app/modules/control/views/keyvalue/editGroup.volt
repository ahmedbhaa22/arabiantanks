<div class="modal-header hidden-xs">
    <div class="col-xs-12 ">
        <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{this.url_shared.get("ropo_app/")}}img/default-form-img.png') center center no-repeat ; background-size: contain"></div>
</div>
</div>
<div class="portlet light bordered">
    <div class="portlet-title">
        <p><?php $this->flashSession->output() ?></p>
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">{{ translate._('Edit Group')}}</span>
        </div>


    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">

            <?php
            echo $this->tag->form(
                [
                    "keyvalue/saveGroup",
                    "autocomplete" => "off",
                    "class" => "form-horizontal",
                    "id" => "saveGroup"
                ]
            );
            ?>

            <div class="col-xs-12">
                <div class="form-group">

                    <div class="col-xs-4 nopadding-r">
                        <label for="fieldTitle" class="control-label col-xs-12 no-padding">Default</label>
                        <input type="text" id="fieldTitle{{group_langs[0].ID}}" name="TitleDefault" class="form-control" required value="{{group_langs[0].Title}}">
                    </div>
                    {%for app_lang in app_langs%}
                    {%if(app_lang.lang_id==1)%}{% continue %} {%endif%}
                    {%if group.getGroupLang(["Lang_ID=" ~app_lang.lang_id])%}
                    <div class="col-xs-4 nopadding-r">
                        <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{app_lang.LangDetails.title}}</label>
                        <input type="text" id="fieldTitle{{app_lang.lang_id}}" name="Title{{app_lang.lang_id}}" class="form-control" value='{{group.getGroupLang(["Lang_ID=" ~app_lang.lang_id]).Title}}'>
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






            <div class="form-group">
                <div class="col-sm-10">
                    <input type="hidden" name="Module_ID" value="{{Module_ID}}"/>
                    <input type="" data-dismiss="modal" class="btn dark " value="إلغاء">
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn green-jungle"]) ?>
                </div>
            </div>

            <?php echo $this->tag->endForm(); ?>

        </div>
    </div>
</div>

<script>
    $("#saveGroup").submit(function(e) {
        e.preventDefault(); // avoid to execute the actual submit of the form.
        var url = "{{url('keyvalue/saveGroup/') ~group.ID}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#saveGroup").serialize(), // serializes the form's elements.
            success: function(data)
            {
                alert(data); // show response from the php script.
            }
        });


    });
</script>