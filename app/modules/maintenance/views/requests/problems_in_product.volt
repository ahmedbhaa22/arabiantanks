<select class=" form-control" name="chosen_problem" id="chosen_problem">
    {%for item in problems%}
    <option value="{{item['id']}}">{{item['name']}}</option>
    {%endfor%}

</select>