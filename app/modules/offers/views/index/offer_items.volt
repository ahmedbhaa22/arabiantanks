<div class="portlet light clearfix">
<div class="col-xs-12 col-md-12">
    <h4 class="text-center inside-titles">
{{translate._("Products In Offer")}}
    </h4>
</div>
<form action="">
    <table class="table table-striped table-bordered table-hover table-checkable order-column" id="">
        <thead>
        <tr>
            <th>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="group-checkable"
                           data-set="#sample_3 .checkboxes"/>
                    <span></span>
                </label>
            </th>
            <th>صورة المنتج</th>
            <th>اسم المنتج</th>
            <th>السعر </th>
            <th>إجراءات </th>
        </tr>
        </thead>
        <tbody>
        {%for offer_item in offer_items.items%}
        <tr class="odd gradeX">
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="checkboxes" value="{{offer_item.data_cms_id}}"/>
                    <span></span>
                </label>
            </td>
            <td><img src="{{this.url_shared.get('uploads/') ~offer_item.Content.Img}}" height="60px"  width="100px" /></td>
            <td><a href="#">{{offer_item.Content.Title}}</a></td>
            <td>{{offer_item.Content.extraFields.price}} </td>
            <td>
                <a class="removeFromOffer btn btn-xs btn-danger" href="{{this.url_shared.get('offers_module/index/removeFromOffer/' ~offer_item.data_cms_id)}}/{{offer_item.offer_id}}"><i class="fa fa-trash" aria-hidden="true"></i> حذف </a>
            </td>
        </tr>
        {%endfor%}
        </tbody>
    </table>

    <div class="row">
        <div class="col-md-5 col-sm-5">
            <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                                </div>
        </div>
        <div class="col-md-7 col-sm-7">
            <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                <ul class="pagination" style="visibility: visible;">
                    <li class='offer_items_page'><a href="1">الأول</a></li>
                    <li class='offer_items_page'><a href="{{offer_items.before}}">السابق</a></li>
                    <li class='offer_items_page'><a href="{{offer_items.next}}">التالي</a></li>
                    <li class='offer_items_page'><a href="{{offer_items.last}}">الأخير</a></li>
                </ul>
            </div>
        </div>
    </div>

</form>
</div>
<script>
    $(".offer_items_page a").click(function(e) {
        e.preventDefault();
        //$("#products_table").hide();
        //$("#LoadingImage").show();
        var url = "{{url('offers_module/index/offer_items/' ~offer.id)}}"+"&page="+$(this).attr("href"); // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: [], // serializes the form's elements.
            success: function (response)
            {

                $("#offer_items").html(response);
                //$('#collapse-clients-filter').collapse('toggle');
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>