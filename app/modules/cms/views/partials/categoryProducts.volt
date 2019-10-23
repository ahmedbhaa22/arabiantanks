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
                        <th style="width: 20px;"> ID</th>
                        <th>الصورة</th>
                        <th> اسم المنتج </th>
                        <th> السعر</th>
                        <th> الوصف </th>
                        <th> شركة التصنيع </th>
                        <th style="width: 20px;"> عدد مرات الشراء</th>
                        <th> التاريخ </th>
                        <th> مفعل </th>
                        <th>الاجراءات</th>
                    </tr>
                </thead>
                <tbody>
                    {% for item in products %}
                        <tr class="odd gradeX">
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="checkboxes" value="{{item.ID}}"/>
                                    <span></span>
                                </label>
                        </td>
                        <td style="width: 20px;">{{item.ID}}</td>
                        <td> <img src="{{url.getStatic('images/products/'~item.Img)}}" height="60px">  </td>
                        <td>{{item.Title}}</td>
                        <td>
                            {% if item.extraFields != null %}
                                {{item.extraFields.price}} SAR
                            {% endif %}
                        </td>
                        <td> {{item.Des}}</td>
                        <td>
                            {% for manfct in item.manufacturers %}
                            <a href="{{url('manufacturers/view/'~manfct.ID)}}">{{manfct.Title}}</a> ,
                            {% endfor %}
                        </td>

                        <td style="width: 20px;">{{item.purchaseNumber()}}</td>
                        <td>{{item.getDate()}}</td>
                        <td>
                            {% if item.Active == 1 %}
                                 <i class="text-success fa fa-check" aria-hidden="true"></i> 
                            {% else %}
                                 <i class="text-danger fa fa-close" aria-hidden="true"></i> 
                            {% endif %}
                        </td>
                        <td>
                            <a href="{{url('content/productView/'~item.ID)}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>
                            <a href="{{url('content/edit/'~item.ID)}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>
                            <button data-product_id="{{item.ID}}" class="detach-product btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>