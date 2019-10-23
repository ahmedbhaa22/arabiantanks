
<div class="portlet-body">
<div class="col-xs-12 col-md-12">
	<form action="{{url('api_manager/saveResponse')}}" method="post">
		<div class="form-group">
			<label class="control-label"></label>
			<textarea name="fail_response">{{api.fail_response}}</textarea>
        </div>
        <div class="form-group">
        	<input type="hidden" name="id" value="{{api.id}}" />
			<input type="submit" value="Save" />
        </div>
     </form>
</div>
</div>