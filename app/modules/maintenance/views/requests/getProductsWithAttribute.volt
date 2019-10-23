<select class=" form-control" name="product" id="chosen_product">
    {%for item in result%}
    <option value="{{item['ID']}}">{{item['Title']}}</option>
    {%endfor%}

</select>