<div class="portlet light bordered">

    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"> مستخدمين الموبايل</span>
        </div>

        <div class="actions">

        </div>

    </div>



    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting">المسلسل</th>
                        <th class="sorting">الإسم</th>
                        <th class="sorting">المستخدم</th>
                        <th class="sorting">الصورة</th>
                        <th class="sorting">النوع</th>
                        <th class="sorting">البريد الإلكتروني</th>
                        <th class="sorting">تاريخ التسجيل</th>
                        <th class="sorting">Application_ID</th>
                        <th class="sorting">أكتيف أم لا</th>
                        <th class="sorting">اجراءات</th>

                    </tr>
                    </thead>
                    <tbody>
                    {% for user in page.items %}
                    <tr class="gradeX" id="ad{{ad.ID}}">
                        <td>{{ user.ID }}</td>
                        <td>{{ user.Title }}</td>
                        <td>{{ user.User }}</td>
                        <td><img src="{{ user.Img }}" style="width: 50px;height: 50px;"></td>
                        <td>{{ user.Gender }}</td>
                        <td>{{ user.Mail }}</td>
                        <td>{{ user.Join_Date }}</td>
                        <td>{{ user.Application_ID }}</td>
                        <td>{{ user.Active }}</td>

                        <td>
                            <div class="btn-group" style="position:relative">
                                <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> إجراء
                                    <i class="fa fa-angle-down"></i>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <!-- <li>
                                        <a href="_client_profile.html">
                                            <i class="icon-docs"></i> مشاهده </a>
                                    </li> -->

                                    <li>
                                        <a href="mobile_users/edit/{{user.ID}}" data-toggle="modal">
                                            <i class="icon-tag"></i> تعديل </a>
                                    </li>

                                    <li>
                                        <a href="mobile-users/delete/{{user.ID}}">
                                            <i class="icon-user"></i> حذف </a>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    {% endfor %}
                    </tbody>
                </table>
            </div>

            <div class="row">
                <div class="col-md-5 col-sm-5">
                    <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                        <?php echo $page->current, "/", $page->total_pages ?>
                    </div>
                </div>
                <div class="col-md-7 col-sm-7"><div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                        <ul class="pagination" style="visibility: visible;">
                            <li><?php echo $this->tag->linkTo("mobile_users/{$filter}", "First") ?></li>
                            <li><?php echo $this->tag->linkTo("mobile_users/{$filter}?page=" . $page->before, "Previous") ?></li>
                            <li><?php echo $this->tag->linkTo("mobile_users/{$filter}?page=" . $page->next, "Next") ?></li>
                            <li><?php echo $this->tag->linkTo("mobile_users/{$filter}?page=" . $page->last, "Last") ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>