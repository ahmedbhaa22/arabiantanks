<div class="repeatRootEntity bordered form-group" style="margin-top:15px;">

        <a class="remove_param_{{uid}} btn btn-link">Remove Parameter</a>

    <div class="form-group">
        <div class="col-xs-11 ">
            <div class="col-md-6">
                <label>Field</label>
                <select class="form-control" name="entity_fields_{{uid}}">
                    {%for k,v in model_fields%}
                    {%if(k=="ID" OR k=="id")%}
                    {%continue%}
                    {%endif%}
                    <option value="{{k}}">{{k}}</option>
                    {%endfor%}
                </select>
            </div>
            <div class="col-md-6">
                <label>Paremeter</label>
                <input type="text" class="form-control" placeholder="paremeter" required name="parameter_{{uid}}">
            </div>
        </div>
        <div class="clearfix"></div>
        <br/>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="validation_required_{{uid}}" id="validation_required_{{uid}}">
                    <label for="validation_required_{{uid}}">Required</label>
                </div>
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="validation_email_{{uid}}" id="validation_email_{{uid}}">
                    <label for="validation_email_{{uid}}">Email</label>
                </div>
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="validation_alnum_{{uid}}" id="validation_alnum_{{uid}}">
                    <label for="validation_alnum_{{uid}}">Number</label>
                </div>
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="validation_passwordConfirm_{{uid}}" id="validation_passwordConfirm_{{uid}}">
                    <label for="validation_passwordConfirm_{{uid}}">Passsword Confim</label>
                </div>
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="validation_string_legnth_{{uid}}" id="validation_string_legnth_{{uid}}">
                    <label for="validation_string_legnth_{{uid}}">String Legnth</label>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="validation_rule_options_{{uid}}">
            <div class="form-group">
                <div class="col-sm-12">
                    <label>Confirm Password Field</label>
                    <input type="text" class="form-control" placeholder="type text" name="confirm_password_{{uid}}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-6">
                    <label>Minimum</label>
                    <input type="number" class="form-control" placeholder="number" name="min_{{uid}}">
                </div>
                <div class="col-xs-6">
                    <label>Maximum</label>
                    <input type="number" class="form-control" placeholder="number"name="max_{{uid}}">
                </div>
            </div>
        </div>

    </div>
    <input type="hidden" name="param_root[]" value="{{uid}}" />

        <br/>
    </div>

<script>
    $(".remove_param_{{uid}}").click(function(event) {
        event.preventDefault();
        $(this).parent('div').remove();
    });
</script>











