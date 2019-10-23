<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-money" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase"> إضافة خصم</span>
        </div>

    </div>
    <div class="portlet-body">
        <form role="form" action="{{this.url_shared.get('discounts_module/index/create')}}" method="post">
            <div class="form-group">
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">اسم الخصم</label>
                        <input type="text" class="form-control" name="discount_name" required>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-xs-12 no-padding control-label"> النسبة المئوية</label>
                        <div class="col-xs-8 no-padding">
                            <input type="text" class="form-control" name="discount_percentage" required>
                        </div>
                        <div class="col-xs-2"> % </div>
                    </div>
                </div>

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> كود الكوبون </label>
                        <input type="text" class="form-control"  name="discount_copoun_code" required>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> تاريخ البدء </label>
                        <input type="date" class="form-control"  name="discount_start_date" required>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> تاريخ النهاية</label>
                        <input type="date" class="form-control"  name="discount_end_date" required>
                    </div>
                </div>
                <div class="col-sm-12">
                    <button class="btn btn-primary">إضافة</button>
                    <button class="btn dark"> الغاء</button>
                </div>
            </div>
            <hr>

</form>

    </div>
</div>