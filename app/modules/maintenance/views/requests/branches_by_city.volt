<select class=" form-control" name="order_branch" id="order_branch">
    {%for item in branches["items"]%}
    <option value="{{item['id']}}">{{item['name']}}</option>
    {%endfor%}
</select>