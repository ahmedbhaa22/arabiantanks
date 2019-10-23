<div class="row">
{%for group in keyvalues%}
<div class="kv-group-title"><h2>{{group["group_name"]}}</h2></div>
    {%for keyvalue in group['keyvalues']%}
    <div class="col-xs-6  keyvalue_id{{keyvalue['kv_id']}}"> <!-- Start Keyvalue Panel -->
        <div class="panel panel-info">
            <div class="panel-heading">{{keyvalue['title']}}</div>
            <div class="panel-body">
                <div class="col-sm-12">
                    {%if(keyvalue['showSettings']['title']==1)%}
                    {{ partial("content/partials/keyvalue/render/title", ['keyvalue':keyvalue]) }}
                    {%endif%}
                </div>
                <div class="col-sm-12">
                    {%if(keyvalue['showSettings']['des']==1)%}
                    {{ partial("content/partials/keyvalue/render/des", ['keyvalue':keyvalue]) }}
                    {%endif%}
                </div>
                <div class="col-sm-12">
                    {%if(keyvalue['showSettings']['img']==1)%}
                        <div class="form-group">

                            <label for="keyvalue" class="col-sm-2 control-label">{{translate._("Picture")}}</label>
                            <div class="col-sm-8">
<!--                                --><?php //echo $data['Img'] ; ?>
                            </div>
                        </div>
                    {%endif%}
                </div>
                <div class="col-sm-12">
                    <div class="form-group">
                            <label for="keyvalue" class="col-sm-2 control-label">{{translate._("Value")}}</label>
                        <div class="col-sm-8">
                            {% if keyvalue["kv_type"] == "select" %}
                            {{ partial("content/partials/keyvalue/render/select", ['keyvalue':keyvalue]) }}
                            {% elseif keyvalue["kv_type"] == "text" %}
                            {{ partial("content/partials/keyvalue/render/textbox", ['keyvalue':keyvalue]) }}
                            {% elseif keyvalue["kv_type"]  == "checkfield" %}
                            {{ partial("content/partials/keyvalue/render/checkfield", ['keyvalue':keyvalue]) }}
                            {% elseif keyvalue["kv_type"]  == "entity" %}
                            {{ partial("content/partials/keyvalue/render/checkfield", ['keyvalue':keyvalue]) }}
                            {% elseif keyvalue["kv_type"]  == "file" %}
                            {{ partial("content/partials/keyvalue/render/file", ['keyvalue':keyvalue]) }}
                            {% endif %}

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    {%endfor%}
{%endfor%}
</div>

<script src="http://code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
