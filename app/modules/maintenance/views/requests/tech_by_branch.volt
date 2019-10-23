<label class="control-label"> اختر فني </label>
<select class="form-control" id="tech_choose" name="tech_choose">
    {%for item in techs["items"]%}
    <option value="{{item['ID']}}">{{item['Title']}}</option>
    {%endfor%}
</select>