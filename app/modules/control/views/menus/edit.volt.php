<div class="modal-header hidden-xs">
    <div class="col-xs-12 ">
        <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('<?= $this->url_shared->get('ropo_app/') ?>img/edit.png') center center no-repeat ; background-size: contain"></div>
    </div>
</div>
<?php
echo $this->tag->form(
    [
        "menus/save",
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
                        <label class="control-label"> اسم العنصر </label>
                        <?php echo $this->tag->textField(["name", "class" => "form-control", "id" => "name","required"]) ?>
                    </div>
                </div>
                <div class="col-xs-12">
                    <div class="form-group ">
                        <label class="control-label"> الرابط </label>
                        <?php echo $this->tag->textField(["href", "class" => "form-control", "id" => "href" ,"required"]) ?>
                    </div>
                </div>
                <div class="col-xs-12">
                    <div class="form-group ">
                        <label class="control-label"> الأيكون </label>
                        <div class="col-xs-12 no-padding">
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon1" value=" icon-screen-tablet">
                                <label for="icon1"><i class="  icon-screen-tablet"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon2" value=" fa fa-bars">
                                <label for="icon2"><i class=" fa fa-bars"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon3" value=" fa fa-tag">
                                <label for="icon3"><i class=" fa fa-tag"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon4" value=" fa fa-trash">
                                <label for="icon4"><i class=" fa fa-trash"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon5" value=" fa fa-language">
                                <label for="icon5"><i class=" fa fa-language"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon6" value=" fa fa-bars">
                                <label for="icon6"><i class=" fa fa-circle-thin"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon7" value=" icon-layers">
                                <label for="icon7"><i class="icon-layers"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon8" value=" fa fa-bars">
                                <label for="icon8"><i class="icon-doc"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon9" value=" icon-envelope">
                                <label for="icon9"><i class="icon-envelope"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon10" value=" icon-paper-clip">
                                <label for="icon10"><i class="icon-paper-clip"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon11" value=" icon-bell">
                                <label for="icon11"><i class="icon-bell"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon12" value=" icon-magnifier">
                                <label for="icon12"><i class="icon-magnifier"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon13" value=" fa fa-home">
                                <label for="icon13"><i class="fa fa-home"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon14" value=" fa fa-lock">
                                <label for="icon14"><i class="fa fa-lock"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon15" value=" icon-user">
                                <label for="icon15"><i class="icon-user"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon16" value=" icon-map">
                                <label for="icon16"><i class="icon-map"></i></label>
                            </div>
                            <div class="col-md-1 col-sm-4 col-xs-4 nopadding-r">
                                <input type="radio" name="icon" class="icon" id="icon17" value=" icon-note">
                                <label for="icon17"><i class="icon-note"></i></label>
                            </div>
                        </div>
                        <div class="col-xs-12 no-padding">
                            <?php echo $this->tag->textField(["other_icon", "class" => "form-control", "id"=>"other_icon"]) ?>
                        </div>
                        <?php echo $this->tag->hiddenField(["id", "class" => "form-control"]) ?>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" data-dismiss="modal" class="btn dark " value="إلغاء">
        <input type="submit" class="btn green-jungle " value="حفظ التعديلات">
    </div>
<?php echo $this->tag->endForm(); ?>

<script>
    $("input[name=icon]:radio").click(function(eventObj) {
        var className = this.value;
        $("input[name=other_icon]").val(className);
    });
</script>
