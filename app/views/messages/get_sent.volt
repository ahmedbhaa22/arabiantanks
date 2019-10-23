<div class="page-content-wrapper">
    <div class="page-content">
        <div class="mail__inbox">
            <div class="row">
                <div class="col-md-2">
                    <div class="inbox-sidebar ">
                        <a href="javascript:;" data-title="Compose" class="btn green compose-btn btn-block">
                            <i class="fa fa-edit"></i> Compose </a>
                        <ul class="inbox-nav">
                            <li class="active">
                                <a href="javascript:;" data-type="inbox" data-title="Inbox"> Inbox
                                    <span class="badge badge-success">3</span>
                                </a>
                            </li>
                            <!-- <li>
                                <a href="javascript:;" data-type="important" data-title="Inbox"> Important </a>
                            </li> -->
                            <li>
                                <a href="javascript:;" data-type="sent" data-title="Sent"> Sent </a>
                            </li>
                            <li>
                                <a href="javascript:;" data-type="draft" data-title="Draft"> Draft
                                    <span class="badge badge-success">8</span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" class="sbold uppercase" data-title="Trash"> Trash
                                    <span class="badge badge-success">23</span>
                                </a>
                            </li>
                        </ul>
                    </div>
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

                                        <td>{{msg.message.Content}}</td>

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
                                                        <a href="messages/view/{{msg.ID}}">
                                                            <i class="icon-docs"></i> مشاهده </a>
                                                    </li>

                                                    <li>
                                                        <a href="javascript:;" class="delete-general">
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