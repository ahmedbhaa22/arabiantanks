<script>
    var mediaMenus = [
        <?php
        foreach($mediaMenus as $Image):

        ?>
        {
            name: "<?php echo $Image->Img ?>",
            url: "<?php echo $this->config->application->baseUri; ?> /uploads/<?php echo $Image->Img ?>",
            file: "<?php echo $this->config->application->baseUri; ?>/uploads/<?php echo $Image->Img ?>",
            type: "image/jpg",
            size: 5453,
            ID: "<?php echo $Image->ID ?>"
        },
        <?php
        endforeach;
        ?>
    ]
</script>
<div class="tab-pane" id="5">

                <div id="upload" class="place_menus">
                    <div class="form-group">

                        <div class="col-sm-12">
                            <?php echo $this->tag->fileField(["MediaMenus[]", "size" => 30, "class" => "form-control", "id" => "MenusEditContent",]) ?>

                        </div>

                    </div>
                </div>

</div>
{{ javascript_include("js/GoApp/mediaMenusEdit.js") }}
<div id="deletedMediaMenus"></div>