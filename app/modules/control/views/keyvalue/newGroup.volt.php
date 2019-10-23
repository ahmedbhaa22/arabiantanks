<div class="modal-header hidden-xs">
	<div class="col-xs-12 ">
		<div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('<?= $this->url_shared->get() ?>img/edit.png') center center no-repeat ; background-size: contain"></div>
	</div>
</div>

<?php echo $this -> tag -> form(["keyvalue/createGroup", "autocomplete" => "off", "class" => "form-horizontal"]); ?>
<div class="modal-body">

	<div class="portlet-body " style=" padding: 15px;">

		<div class="row">
			<div class="col-sm-4">
				<div class="form-group">
					<label for="fieldTitle" class="control-label"><?= $translate->_('Paramter') ?></label>
					<?php echo $this->tag->textField(["Paramter",  "class" => "form-control", "id" => "fieldTitle", "required" => "required"])
					?>
				</div>
			</div>

			<div class="col-sm-4">
				<div class="form-group">
					<label for="fieldTitle" class="control-label"><?= $translate->_('Title') ?></label>

					<?php echo $this->tag->textField(["Title",  "class" => "form-control", "id" => "fieldTitle", "required" => "required"])
					?>
				</div>
			</div>

		</div>
		<!-- END ROW -->

		<div class="row">
			<div class="form-group">
				<input name="Module_ID" type="hidden" value="<?= $Moduel_ID ?>"/>
			</div>

			<div class="col-sm-4">
				<div class="form-group">
					<label for="fieldActive" class="control-label"><?= $translate->_('Belongs To Departments') ?></label>

					<select name="is_Dept" class="form-control">
						<option value="1">Yes</option>
						<option value="0" selected>No</option>
					</select>

				</div>
			</div>

			<div class="col-sm-4">
				<div class="form-group">
					<label for="fieldTitle" class="control-label"><?= $translate->_('Main Department') ?></label>

					<?php echo Phalcon\Tag::select(["Core_Depts_ID", $main_depts, "using" => ["ID", "Title"], "class"=>"form-control"]); ?>
				</div>
			</div>
		</div>
		<!-- END ROW -->

	</div>
</div>

<div class="modal-footer">

	<input type="hidden" name="Module_ID" value="<?= $Module_ID ?>"/>
	<?php echo $this->tag->submitButton([$translate->_('Save'), "class" => "btn green-jungle"])
	?>
</div>
<?php echo $this -> tag -> endForm(); ?>

