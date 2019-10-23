<div class="modal-header hidden-xs">
    <div class="col-xs-12 ">
        <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{this.url_shared.get("ropo_app/")}}img/edit.png') center center no-repeat ; background-size: contain"></div>
    </div>
</div>
<form role="form" action="{{url('application_localization/createLangSave')}}" id="1_add_pop_up_1" method="post">
    <div class="modal-body" >
        <div class="portlet-body " style=" padding: 15px;">
            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group ">
                        <label class="control-label"> {{ translate._('Language')}} </label>
                        <?php echo Phalcon\Tag::select([
                            "Langs",
                            $langs,
                            "class" => "form-control",
                            "using" => ["id", "title"]]);
                        ?>
                    </div>
                </div>
<!--                <div class="col-xs-6">-->
<!--                    <div class="form-group ">-->
<!--                        <label class="control-label"> Code </label>-->
<!--                        <input type="text" placeholder="code" class="form-control"/>-->
<!--                    </div>-->
<!--                </div>-->
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" data-dismiss="modal" class="btn dark " value="{{ translate._('Cancel')}}">
        <input type="submit"  class="btn green-jungle " value="{{ translate._('Save')}}">
    </div>
</form>