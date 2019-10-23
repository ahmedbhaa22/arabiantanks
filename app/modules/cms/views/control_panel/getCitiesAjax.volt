{%set selected_value=""%}
{%if(selected =="all")%}
{%set selected_value="selected"%}
{%endif%}
<option value="all" {{selected_value}}>All</option>
{%for city in cities%}
{%set selected_value=""%}
{%if(selected ==city.id)%}
{%set selected_value="selected"%}
{%endif%}
<option value="{{city.id}}" {{selected_value}}>{{city.name}}</option>
{%endfor%}