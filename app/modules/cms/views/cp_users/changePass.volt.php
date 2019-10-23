<div class="modal-content">
    <div class="modal-header hidden-xs">
        <div class="col-xs-12 ">
            <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/default-form-img.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
    <form method="post" action="<?= $this->url->get('cp_users/changePassPost') ?>" id="changePass">
        <div class="modal-body">
            <div class="portlet-body " style=" padding: 15px;">
                <div class="row">

                    <div class="col-xs-12">
                        <div class="form-group">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">كلمة المرور الحالية</label>
                            <div class="col-xs-4 nopadding-r">
                                <input type="text" id="current" name="current" class="form-control" required="" value="">
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-12">
                        <div class="form-group">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">كلمة المرور الجديدة</label>
                            <div class="col-xs-4 nopadding-r">
                                <input type="password" id="password" name="password" class="form-control" required="" value="">
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-12">
                        <div class="form-group">
                            <label for="fieldTitle" class="control-label col-xs-12 no-padding">اعادة كلمة المرور الجديدة</label>
                            <div class="col-xs-4 nopadding-r">
                                <input type="password" id="repassword" name="repassword" class="form-control" required="" value="">
                            </div>
                        </div>
                    </div>



                </div>
            </div>
        </div>
        <div class="modal-footer">
            <input type="" data-dismiss="modal" class="btn dark " value="إلغاء">
            <input type="submit" id="submit" class="btn green-jungle " value="حفظ التعديلات">
        </div>
    </form>
</div>