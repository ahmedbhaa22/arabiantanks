<div class="modal-header hidden-xs">
    <div class="col-xs-12 ">
        <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('<?= $this->url_shared->get('ropo_app/') ?>img/edit.png') center center no-repeat ; background-size: contain"></div>
    </div>
</div>
<?php
echo $this->tag->form(
    [
        "menus/saveMenu",
        "autocomplete" => "off",
        "class" => "form-horizontal paymentForm",
        "role" => "form",
        "style" => "display:block",
        "enctype" => "multipart/form-data"
    ]
);
?>
<div class="modal-body" >
    <div class="portlet-body " style=" padding: 15px;">
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group ">
                    <label class="control-label">Menu Name</label>
                    <?php echo $this->tag->textField(["menu_name", "class" => "form-control", "id" => "name","required"]) ?>
                </div>
            </div>
            <input type="hidden" value="<?= $menu_id ?>" name="menu_id" />

        </div>
    </div>
</div>
<div class="modal-footer">
    <input type="button" data-dismiss="modal" class="btn dark " value="إلغاء">
    <input type="submit" class="btn green-jungle " value="حفظ التعديلات">
</div>
<?php echo $this->tag->endForm(); ?>
