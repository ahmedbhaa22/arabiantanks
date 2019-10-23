<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_33">
<thead>
    <tr>
        <th>ID</th>
        <th> المنطقة</th>
        <th> عدد الطلبات   </th>
        <th> تكلفة الطلبات  </th>
    </tr>
</thead>
<tbody>
    {% for order_item in orders %}
    <?php $order = $order_item->{'porder'} ?>

        <tr class="odd gradeX">
        <td>{{order.id}}</td>
        <td>
            {% if order.user.data != null %}
                {{order.user.data.region.getName()}}
            {% endif %}
        </td>
        <td>{{order_item.total_order_items}}</td>
        <td>{{order_item.total_price}}</td>
    </tr>
    {% endfor %}
</tbody>
</table>