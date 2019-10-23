<?= $this->getContent() ?>

<form method="post">

<h2>الصلاحيات</h2>

<div class="portlet light" align="center">

		<div class="portlet-body">
			<div class="form-group-permissions">
				<label for="profileId" class="col-sm-1 control-label"><?= $translate->_('Choose') ?></label>

	            <div class="col-sm-2">
	            	<?= $this->tag->select(['profileId', $profiles, 'using' => ['id', 'name'], 'useEmpty' => true, 'emptyText' => '...', 'emptyValue' => '']) ?>
	            </div>
				<div class="col-sm-2">
					<?= $this->tag->submitButton(['Search', 'class' => 'btn btn-primary']) ?>
				</div>
			</div>
		</div>


<?php if ($this->request->isPost() && $profile) { ?>
<div class="portlet-body">
<?php foreach ($this->acl->getResources() as $resource => $actions) { ?>

	<div class="bg-dark btn-circle text-center" style="padding: 2px ; color: #fff;">
		<div class="light text-uppercase">
			<?= $resource ?>
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
			<?php foreach ($actions as $action) { ?>
			<tr>
				<td align="center"><input type="checkbox" name="permissions[]" value="<?= $resource . '.' . $action ?>"  <?php if (isset($permissions[$resource . '.' . $action])) { ?> checked="checked" <?php } ?>></td>
				<td><?= $this->acl->getActionDescription($action) . ' ' . $resource ?></td>
			</tr>
			<?php } ?>
		</tbody>
	</table>
	</div>

<?php } ?>
</div>
<?php } ?>

</form>
<style>
.form-group-permissions{

	margin-bottom: 15px;
	display: flex;

}
</style>