<input type="hidden" id="product_id" value="{{product_id}}">
<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
	<thead>
		<tr>
			<th>
				<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
					<input type="checkbox" class="group-checkable"
						   data-set="#sample_1 .checkboxes"/>
					<span></span>
				</label>
			</th>
			<th> ID</th>
			<th>اسم العرض</th>
			<th> منطقة تطبيق العرض </th>
			<th>مدة العرض</th>
			<th>وصف العرض</th>
			<th>رابط العرض</th>
			<th>الاجراءات</th>
		</tr>
	</thead>
	<tbody>
        {% for poffer in offers %}
        <tr class="odd gradeX">
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="checkboxes" value="{{poffer.id}}"/>
                        <span></span>
                    </label>
            </td>
            <td>{{poffer.id}}</td>
            <td>{{poffer.name}}</td>
            <td>
                {% for region in poffer.regions %}
                {{region.name}} , 
                {% endfor %}
            </td>
            <td style="text-align:left;">
                {% for type in poffer.types %}
                    {% if type.id == 1%}
                    {{type.name}} <br>
                    {% else %}
                    {{type.name ~ poffer.getStartEndDates()}}
                    {% endif %}
                {% endfor %}
            </td>
            <td>{{poffer.description}}</td>
            <td>
                <a href="{{url.getStatic('offers_module/index/new/'~poffer.id)}}" class="btn btn-xs btn-info">   رابط العرض</a>
            </td>
            <td>
                <a href="{{url.getStatic('offers_module/index/new/'~poffer.id)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                <a href="{{url.getStatic('offers_module/index/new/'~poffer.id)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                <button data-offer_id="{{poffer.id}}" class="delete_offer btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
            </td>
        </tr>
        {% endfor %}
	</tbody>
</table>

<script type="text/javascript">
    $('.delete_offer').on('click', function()
    {
       if(confirm('أنت على وشك حذف أحد العروض، إستكمال العملية؟'))
       {
        $.ajax({
            type: 'post',
            url: "{{url.getStatic('offers_module/index/ajaxDeleteOffer/')}}" + $(this).data('offer_id'),
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('content/productView/')}}" + $('#product_id').val();
                    break;
                }
            }
        });
       } 
    });
</script>