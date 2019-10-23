<div class="portlet light bordered">
<div class="portlet-body">
<div id="sample_1_wrapper">
<ul>
{%for app in Applications%}

    <li>
        <h3>{{app['App_Name']}}</h3>
            <ul>
                {%for module in app['Modules']%}
                <li>
                    <a href="{{url('general_api_listing/switchlist')}}&app={{app['App_ID']}}&id={{module['Module_ID']}}">{{module['Module_Title']}}</a>
                </li>
                {%endfor%}
            </ul>
    </li>


{%endfor%}
</ul>
</div>
</div>
</div>