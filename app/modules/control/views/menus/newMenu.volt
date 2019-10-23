<div class="modal-header hidden-xs">
    <div class="col-xs-12 ">
        <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('{{this.url_shared.get('ropo_app/')}}img/edit.png') center center no-repeat ; background-size: contain"></div>
    </div>
</div>
<form role="form" action="{{url('menus/createMenu')}}" id="1_add_pop_up_1" method="post">
    <div class="modal-body" >
        <div class="portlet-body " style=" padding: 15px;">
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group ">
                        <label class="control-label">اسم المنيو</label>
                        <input type="text" placeholder="اسم العنصر في المنيو " class="form-control" name="menu_name" required/>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <div class="modal-footer">
        <input type="button" data-dismiss="modal" class="btn dark " value="إلغاء">
        <input type="submit" class="btn green-jungle " value="حفظ التعديلات">
    </div>
</form>



