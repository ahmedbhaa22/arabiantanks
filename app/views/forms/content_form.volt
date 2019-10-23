{% extends "layouts/main.volt" %}

{% block content %}
<div class="row">
<div class="col-md-12">
<div class="portlet light bordered">
<div class="portlet-title">
<div class="caption font-dark">
                                <i class="icon-tag font-dark"></i>
                                <span class="caption-subject bold uppercase">
                                    Add Content
                                </span>
                            </div>
</div>
<div class="portlet-body">
{{ form('content/save', 'method': 'post', 'enctype': 'multipart/form-data') }}
<div class="form-group"> 
    <label for="content_title">Title</label>
{{ text_field("content_title", "size": 64,"class" : "form-control input-lg") }}
</div>

<div class="form-group"> 
<label for="content_description">Description</label>
{{ text_field("content_description", "size": 128, "class" : "form-control input-lg") }}
</div>
<div class="form-group"> 
<label for="content_body">Body</label>
{{ text_area("content_body", "class" : "form-control input-lg") }}
</div>
<div class="form-group">
<label for="content_picture">Picture</label>
<div class="form-group">{{ file_field('content_picture') }}</div>
</div>
    {{ submit_button('Save',"class" : "btn btn-primary") }}
{{ end_form() }}
</div>
</div>
</div>
</div>
{% endblock %}