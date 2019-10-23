<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"> Media</span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('content/addmedia/' ~Item_ID)}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                إضافة ميديا
            </a>
        </div>

    </div>

    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <table
                    class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                    id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting">ID</th>
                        <th class="sorting">Link</th>
                        <th class="sorting">Item_ID</th>
                        <th class="sorting">Img</th>

                        <th class="sorting">إجراءات</th>

                    </tr>
                    </thead>
                    <tbody>
                    {% for media in content %}
                        <tr class="gradeX">
                            <td>{{ media.ID|e }}</td>
                            <td>{{ media.Link|e }}</td>
                            <td>{{ media.Item_ID|e }}</td>
                            <td>{{ media.Img|e }}</td>
                            <td>
                                <div class="btn-group" style="position:relative">
                                    <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown"
                                            aria-expanded="false"> إجراء
                                        <i class="fa fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">
                                        <li>
                                            <a href="{{url('content/editmedia/' ~media.ID)}}">
                                                <i class="icon-docs"></i> تعديل </a>
                                        </li>

                                        <!--                                    <li>-->
                                        <!--                                        <a href="http://localhost/work/pentavalue/phalcon-cms/public/content/edit/-->
                                        <?php //echo $content->ID ?><!--" data-toggle="modal">-->
                                        <!--                                            <i class="icon-tag"></i> تعديل </a>-->
                                        <!--                                    </li>-->
                                        <!---->
                                        <li>
                                            <a href="{{url('content/deletemedia/' ~media.ID)}}"
                                               class="delete-general">
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


        </div>
    </div>
</div>