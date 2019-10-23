<div class="page-content-wrapper">
    <div class="page-content">
        <div class="mail__inbox">
            <div class="row">
                <div class="col-md-2">
                    {{partial('shared/side_menu')}}
                </div>
                <div class="col-md-10">
                    <div class="inbox-body">
                        <div class="inbox-header">
                            <h1 class="pull-left">Sent</h1>

                        </div>
                        <div class="inbox-content">
                            <table class="table table-striped table-bordered table-hover table-checkable order-column"  id="sample_1">
                                <thead>
                                    <tr>
                                        <th>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="group-checkable"
                                                       data-set="#sample_1 .checkboxes"/>
                                                <span></span>
                                            </label>
                                        </th>
                                        <th> الرسالة </th>
                                        <th> وارد من</th>
                                        <th> التاريخ</th>
                                        <th> إجراءات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {% for msg in messages %}
                                    <tr class="odd gradeX">
                                        <td>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="checkboxes" value="1"/>
                                                <span></span>
                                            </label>
                                        </td>

                                        <td>{{msg.message.subject}}</td>

                                        <td>
                                            <a href="#">
                                            {% if msg.sender != false %}
                                            {{msg.sender.Title}}
                                            {% endif %}
                                            </a>
                                        </td>

                                        <td class="center"> {{date("Y-m-d", msg.message.DateTime)}}</td>

                                        <td>
                                            <div class="btn-group">
                                                <button class="btn btn-xs dark dropdown-toggle" type="button"
                                                        data-toggle="dropdown" aria-expanded="false"> إجراء
                                                    <i class="fa fa-angle-down"></i>
                                                </button>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li>
                                                        <a href="{{url('index/view/') ~ msg.ID}}">
                                                            <i class="icon-docs"></i> مشاهده </a>
                                                    </li>

                                                    <li>
                                                        <a onclick="deleteMessage({{msg.ID}})">
                                                            <i class="icon-user"></i> حذف </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                    </tr>
                                    {% endfor %}
                                </tbody>
                            </table>
                            <div class="btn-group">
                                <button class="btn  dark dropdown-toggle" type="button" data-toggle="dropdown"
                                        aria-expanded="false"> إجراءات على المحدد
                                    <i class="fa fa-angle-down"></i>
                                </button>
                                <ul class="dropdown-menu" role="menu">

                                    <li>
                                        <a href="javascript:;" class="delete-general">
                                            <i class="icon-user"></i> حذف المحدد </a>
                                    </li>

                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function deleteMessage(id) {
    if(confirm("Are you sure you want to delete this message?")){
        window.location = "{{url('index/delete')}}" + "/" + id;
    }
}
</script>