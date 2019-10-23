<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-tag font-dark"></i>
            <span class="caption-subject bold uppercase">{{offer.name}}</span>
        </div>
        <div class="actions">

            <!--
                                            <a href="#add-products" class="btn btn-xs btn-success">
                                                <i class="fa fa-shopping-cart" aria-hidden="true"></i> إضافة منتجات
                                            </a>
            -->

            <a type="button" href="{{url('offers_module/index/edit/') ~offer.id}}" class="btn btn-xs btn-info">
                <i class="fa fa-pencil-square-o" aria-hidden="true"></i> تعديل بيانات العرض
            </a>
            <a type="button" href="{{url('offers_module/index/delete/') ~offer.id}}" class="btn btn-xs btn-danger"  onclick="return confirm('Are you sure you want to delete this item?');">
                <i class="fa fa-trash-o" aria-hidden="true"></i> حذف العرض
            </a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="col-xs-6">
            <table class="table">
                <tbody>
                <tr>
                    <td class="bold">نسبة الخصم</td>
                    <td><i class="fa fa-tag" aria-hidden="true"></i> {{offer.discount_percent}}% </td>
                </tr>
                <tr>
                    <td class=" bold"><i class="fa fa-calendar" aria-hidden="true"></i> مدة العرض </td>
                    <td>
                        {%for rel_type in offer_rel_type%}
                        {%if(rel_type.type_id==2)%}
                        {{translate._("From")}}
                        {{ date('d-m-Y', rel_type.start_date) }}
                        {{translate._("To")}}
                        {{ date('d-m-Y', rel_type.end_date) }}
                        {%endif%}
                        {%endfor%}


                    </td>
                </tr>
                <tr >
                    <td class="bold" > وصف العرض  </td>
                    <td>{{offer.description}}</td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="col-xs-6">
            <table class="table">
                <tbody>
                <tr >
                    <td class="bold">عدد المنتجات في العرض</td>
                    <td><label class="label label-danger circle"> {{offer.products_number}} </label></td>
                </tr>

                <tr>
                    <td class="bold"> ترتيب الظهور في الصفحة الرئيسية </td>
                    <td>
                        <div class="col-xs-9 no-padding">
                            <label class="label label-success circle"> {{offer.show_in_homepage}} </label>
                        </div>
                        <div class="col-xs-3 no-padding">
                            <a type="button" href="" class="btn btn-xs btn-success pull-right" data-toggle="modal" data-target="#numModal">
                                <i class="fa fa-edit" aria-hidden="true"></i> تعديل
                            </a>
                        </div>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>

    </div><!-- end portlet-->
</div>