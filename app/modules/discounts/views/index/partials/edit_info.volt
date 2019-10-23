<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-money" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase"> تعديل خصم</span>
        </div>

    </div>
    <div class="portlet-body">
        <div class="row"><p><?php $this->flashSession->output() ?></p></div>
        <form role="form" action="{{this.url_shared.get('discounts_module/index/save')}}" method="post">
            <div class="form-group">
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">اسم الخصم</label>
                        <input type="text" class="form-control" name="discount_name" value="{{discount.name}}">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class="col-xs-12 no-padding control-label"> النسبة المئوية</label>
                        <div class="col-xs-8 no-padding">
                            <input type="text" class="form-control" name="discount_percentage" value="{{discount.percentage}}">
                        </div>
                        <div class="col-xs-2"> % </div>
                    </div>
                </div>

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> كود الكوبون </label>
                        <input type="text" class="form-control"  name="discount_copoun_code" value="{{discount.coupon}}">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> تاريخ البدء </label>
                        <input type="date" class="form-control"  name="discount_start_date" value="{{ date('Y-m-d', discount.start_date) }}">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> تاريخ النهاية</label>
                        <input type="date" class="form-control"  name="discount_end_date" value="{{ date('Y-m-d', discount.end_date) }}">
                    </div>
                </div>
                <div class="col-sm-12">
                    <input type="hidden" name="discount_id" value="{{discount.id}}">
                    <button class="btn btn-primary" type="submit">تعديل</button>

                </div>
            </div>
            <hr>

        </form>

    </div>
</div>