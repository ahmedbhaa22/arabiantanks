{{ content() }}

<form method="post">

<h2>الصلاحيات</h2>

<div class="portlet light" align="center">

		<div class="portlet-body">
			<div class="form-group-permissions">
				<label for="profileId" class="col-sm-1 control-label">{{ translate._("Choose") }}</label>

	            <div class="col-sm-2">
	            	{{ select('profileId', profiles, 'using': ['id', 'name'], 'useEmpty': true, 'emptyText': '...', 'emptyValue': '') }}
	            </div>
				<div class="col-sm-2">
					{{ submit_button('Search', 'class': 'btn btn-primary') }}
				</div>
			</div>
		</div>


{% if request.isPost() and profile %}
<div class="portlet-body">
{% for resource, actions in acl.getResources() %}

	<div class="bg-dark btn-circle text-center" style="padding: 2px ; color: #fff;">
		<div class="light text-uppercase">
			{{ resource }}
		</div>
	</div>

	<div class="row space">
	<table class="table table-bordered table-striped" align="center">
		<thead>
			<tr>
				<th width="5%"></th>
				<th>Description</th>
			</tr>
		</thead>
		<tbody>
			{% for action in actions %}
			<tr>
				<td align="center"><input type="checkbox" name="permissions[]" value="{{ resource ~ '.' ~ action }}"  {% if permissions[resource ~ '.' ~ action] is defined %} checked="checked" {% endif %}></td>
				<td>{{ acl.getActionDescription(action) ~ ' ' ~ resource }}</td>
			</tr>
			{% endfor %}
		</tbody>
	</table>
	</div>

{% endfor %}
</div>
{% endif %}

</form>
<style>
.form-group-permissions{

	margin-bottom: 15px;
	display: flex;

}
</style>