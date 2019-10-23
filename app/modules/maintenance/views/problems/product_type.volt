<option></option>
{%for item in product_types["items"]%}
<option value="{{item['ID']}}">{{item['Title']}}</option>
{%endfor%}