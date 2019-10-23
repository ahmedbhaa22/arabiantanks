<!DOCTYPE html>
<html lang="ar">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="description" content="Bootstrap Admin App + jQuery">
    <meta name="keywords" content="app, responsive, jquery, bootstrap, dashboard, admin">
    <title>Tanks | Bill pdf</title>
    <link rel="apple-touch-icon" sizes="57x57" href="img/favicon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="img/favicon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="img/favicon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" ssizes="76x76" href="img/favicon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="img/favicon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="img/favicon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="img/favicon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="img/favicon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="img/favicon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192" href="/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="img/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="img/favicon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="img/favicon/favicon-16x16.png">
    <link rel="manifest" href="/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
    <meta name="thie-color" content="#ffffff">



</head>

<body>
<!-- Main section-->
<div class="page-container page">
    <div class="portlet clearfix">
<div class="portlet-title">
    <div class="caption font-dark">
        <strong>رقم الطلب: </strong> {{order.id}}
    </div>
    <div class="pull-right">
        <img data-brackets-id="93449" src="{{this.url_shared.get("img")}}/logo-original.png">
    </div>
</div>
<div class="portlet-body">
    <div class="todo-tasklist-item-text col-xs-6">
        <table class="table" style="width:800px">
            <tbody>
            <tr>
                <td>
                    العميل / Customer
                </td>
                <td>{% if order.user != null %}
                    {{order.user.Title}}
                    {% endif %}</td>
            </tr>
            <tr>
                <td>
                    العنوان / Address
                </td>
                <td>{% if order.user != null %}
                    {% if order.user.mainAddress %}
                    {{order.user.mainAddress.details}}
                    {% endif %}
                    {% endif %}</td>
            </tr>
            <tr>
                <td>
                    االموبايل / Mobile
                </td>
                <td> {% if order.user != null %}
                    {{order.user.Mobile}}
                    {% endif %}</td>
            </tr>


            </tbody>
        </table>
    </div>

    <table class="table gap table-bordered order-column " style="width:800px">
        <thead>
        <tr>
            <th rowspan="2"> Item ID <br> رقم الصنف</th>
            <th rowspan="2">Description <br> الوصف </th>
            <th rowspan="2"> Qty <br> الكمية</th>
            <th rowspan="2">Unit Price <br> سعر الإفرادي</th>
            <th rowspan="2">Discount <br> الخصم</th>
            <th>
                Total Excl. VAT <br> ج قبل الضريبة
            </th>
            <th>
                VAT% <br> الضريبة%
            </th>
            <th>
                Total amount <br> الإجمالي
            </th>
        </tr>
        </thead>
        <tbody>
        {% for item in order.items %}
        {% if item.item_type_id == 1 %}
        <tr class="odd gradeX">
            <td>{{item.id}}</td>
            <td>
                <h5> {{item.cmsDetails.Title}} </h5>
                <h5> اللون: {% if item.productColor %}{{item.productColor.name}}{% endif %} </h5>
                <h5> مكان التسليم: {{item.deliveryPlace.name}} </h5>
            </td>
            <td>{{item.count}}</td>
            <td>
                {{item.cmsDetails.extraFields.price}} (SAR)
            </td>
            <td>
                {{this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID)}} (SAR)
            </td>
            <td>{{item.count * (item.cmsDetails.extraFields.price - this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID))}} (SAR) </td>

            <td>{{item.cmsDetails.extraFields.tax_percent}}</td>

            <td>{{item.count * (item.cmsDetails.extraFields.price - this.ApiFactory.getItemDiscountAmount(item.cmsDetails.ID) +this.ApiFactory.getItemTaxAmount(item.cmsDetails.ID))}} (SAR) </td>
        </tr>
        {% else %}
        <tr class="odd gradeX">
            <td>{{item.id}}</td>
            <td>
                <h5> {{item.offerDetails.name}} </h5>
                <h5> اللون: </h5>
                <h5> مكان التسليم: {{item.deliveryPlace.name}} </h5>
            </td>
            <td>{{item.count}}</td>
            <td>{{item.offerDetails.price}} (SAR)</td>
            <td></td>
            <td></td>
            <td>{{item.count * item.offerDetails.price}} (SAR) </td>
        </tr>
        {% endif %}
        {% endfor %}
        </tbody>
    </table>

    <table class="table table-bordered order-column">
        <thead>
        <tr>
            <th>
                Sub total <br> اجمالي مبلغ المبيعات
            </th>
            <th>
                Total discount <br> إجمالي الخصم
            </th>
            <th>
                VAT amount <br> قيمة الضريبة
            </th>
            <th>
                Shipping Fees <br> قيمة الشحن
            </th>

            <th>
                Net amount <br> الإجمالي
            </th>
        </tr>
        </thead>
        <tbody>
        <tr class="odd gradeX">
            <td>
                {{total_price }} SAR
            </td>
            <td>
                {{order_total_data['content'][0]['discount_amount']}} SAR
            </td>
            <td>{{total_tax_cost}}</td>
            <td>
                0
            </td>

            <td>
                {{order.total_price }}
            </td>
        </tr>

        </tbody>
        <tfoot>

        </tfoot>
    </table>

    <div class="text-center">
        "GCC CUSTOMER ARE REQUIERD TO SELF ACCOUNT FOR TAX ON THE SUPPLY
    </div>

    <div class="clearfix"></div>



</div>
        <div class="clearfix"></div>
        </div>
    </div>
</body>