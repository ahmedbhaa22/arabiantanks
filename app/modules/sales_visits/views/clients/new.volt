<script type="text/javascript">
    function noenter() {
        return !(window.event && window.event.keyCode == 13); }
</script>
<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">

            <li>
                <span>الزيارات</span>
            </li>
        </ul>
    </div>
    <div class="clearfix"></div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
    <div class="portlet light clearfix">
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-users font-dark"></i>
                <span class="caption-subject bold uppercase"> اضافة عميل جديد</span>
            </div>



        </div>
        <div class="portlet-body">
            <form role="form" action="{{this.url_shared.get('sales_visits_module/clients/save')}}" id="msg" enctype="multipart/form-data" method="post">

                <div class="modal-body">

                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">اسم العميل</label>
                            <input type="text" class="form-control" name="name" required/>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">البريد الالكتروني</label>
                            <input type="email" class="form-control" name="email"/>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">الهاتف الجوال</label>
                            <input type="text" class="form-control" name="mobile" required/>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">المنطقة</label>
                                <select name="region" required>
                                    <option></option>
                                    {% for region in regions %}
                                    <option value="{{region.id}}">{{region.name}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">تصنيف العميل</label>
                                <select name="client_cat" required>
                                    <option></option>
                                    {% for category in client_categories %}
                                    <option value="{{category['id']}}">{{category['name']}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>





                    </div>
<div class="row"></div>
                    <div class="clearfix"></div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success" onkeypress="return noenter()"> حفظ</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
                    </div>
            </form>

        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->
</div>

