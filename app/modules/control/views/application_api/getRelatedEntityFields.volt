<div class="relatedEntityParam_{{entity_id}} bordered form-group" style="margin-top:15px;">
    <a class="remove_related_param_{{entity_id}}_{{ruid}} btn btn-link">Remove Parameter</a>
    <div class="form-group">
        <div class="col-xs-11 ">
            <div class="col-md-6">
                <label>Field</label>
                <select class="form-control" name="related_entity_fields_{{entity_id}}_{{ruid}}">
                    {%for k,v in model_fields%}
                    {%if(k=="ID" OR k=="id")%}
                    {%continue%}
                    {%endif%}
                    <option value="{{k}}">{{k}}</option>
                    {%endfor%}
                </select>
            </div>
            <div class="col-md-6">
                <label>paremeters</label>
                <input type="text" class="form-control" placeholder="paremeters" required name="related_parameter_{{entity_id}}_{{ruid}}">
            </div>
        </div>
        <div class="clearfix"></div>
        <br/>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="related_validation_required_{{entity_id}}_{{ruid}}" id="related_validation_required_{{entity_id}}_{{ruid}}">
                    <label for="related_validation_required_{{entity_id}}_{{ruid}}">Required</label>
                </div>
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="related_validation_email_{{entity_id}}_{{ruid}}" id="related_validation_email_{{entity_id}}_{{ruid}}">
                    <label for="related_validation_email_{{entity_id}}_{{ruid}}">Email</label>
                </div>
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="related_validation_alnum_{{entity_id}}_{{ruid}}" id="related_validation_alnum_{{entity_id}}_{{ruid}}">
                    <label for="related_validation_alnum_{{entity_id}}_{{ruid}}">Number</label>
                </div>
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="related_validation_passwordConfirm_{{entity_id}}_{{ruid}}" id="related_validation_passwordConfirm_{{entity_id}}_{{ruid}}">
                    <label for="related_validation_passwordConfirm_{{entity_id}}_{{ruid}}">Passsword Confim</label>
                </div>
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="gap funkyradio ">
                <div class="funkyradio-primary">
                    <input type="checkbox" name="related_validation_string_legnth_{{entity_id}}_{{ruid}}" id="related_validation_string_legnth_{{entity_id}}_{{ruid}}">
                    <label for="related_validation_string_legnth_{{entity_id}}_{{ruid}}">String Legnth</label>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="related_validation_rule_options_{{entity_id}}_{{ruid}}">
            <div class="form-group">
                <div class="col-sm-12">
                    <label>Confirm Password Field</label>
                    <input type="text" class="form-control" placeholder="type text" name="confirm_password_{{entity_id}}_{{ruid}}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-6">
                    <label>Minimum</label>
                    <input type="number" class="form-control" placeholder="number" name="min_{{entity_id}}_{{ruid}}">
                </div>
                <div class="col-xs-6">
                    <label>Maximum</label>
                    <input type="number" class="form-control" placeholder="number" name="max_{{entity_id}}_{{ruid}}">
                </div>
            </div>
        </div>

    </div>

    <br/>
    <input type="hidden" name="param_related_{{entity_id}}[]" value="{{ruid}}" />
</div>


<script>
    $(".remove_related_param_{{entity_id}}_{{ruid}}").click(function(event) {
        event.preventDefault();
        $(this).parent('div').remove();
    });
</script>








