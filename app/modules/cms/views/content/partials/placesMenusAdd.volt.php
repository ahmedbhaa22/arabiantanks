<div class="upload place_menus">
            <div class="form-group">
                <div class="col-md-12">
                    <div class="kv-group-title"><h2><?php echo $translate->_("Menus"); ?></h2></div>
                    <?php echo $this->tag->fileField(["MediaMenus[]", "size" => 30, "class" => "form-control", "id" => "MediaMenus",]) ?>
                </div>
            </div>
</div>

<?= $this->tag->javascriptInclude('js/GoApp/mediaMenusAdd.js') ?>