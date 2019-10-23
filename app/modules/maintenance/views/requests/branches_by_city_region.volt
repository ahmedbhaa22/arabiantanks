<label class=" control-label">  الفرع  </label>
<select class=" form-control" name="order_branch" id="order_branch">
    {%for item in branches["items"]%}
    <option value="{{item['id']}}">{{item['name']}}</option>
    {%endfor%}
</select>

<script>
    $("#order_branch").change(function() {
        $("#tech_choose").html("");
        var value = $("#order_branch").val();
        var tech_url = "{{url('maintenance_module/requests/tech_by_branch/')}}";
        $("#tech_choose_container").load(tech_url+value);
    });
</script>