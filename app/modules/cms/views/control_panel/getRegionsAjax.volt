{%set selected_value=""%}
{%if(selected =="all")%}
{%set selected_value="selected"%}
{%endif%}
<option value="all" {{selected_value}}>All</option>
{%for region in regions%}
{%set selected_value=""%}
{%if(selected ==region.id)%}
{%set selected_value="selected"%}
{%endif%}
<option value="{{region.id}}" {{selected_value}}>{{region.name}}</option>
{%endfor%}