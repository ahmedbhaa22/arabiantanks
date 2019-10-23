<div class="portlet light bordered">
    <!--<div class="row">-->
    <!--    <nav>-->
    <!--        <ul class="pager">-->
    <!--            <li class="next">--><!--</li>-->
    <!--        </ul>-->
    <!--    </nav>-->
    <!--</div>-->
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"></span>
        </div>

        <div class="actions">
            <a type="button" href="{{ url('menus/new')}}" data-toggle="" data-target="" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                إضافة            </a>
        </div>


    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">

            <div class="clearfix"></div>
            <div class="table-scrollable">
                <p><?php $this->flashSession->output() ?></p>
                    <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer">
                        <thead>
                        <th>{{ translate._('Title')}}</th>
                        <th>{{ translate._('Icon')}}</th>
                        <th>{{ translate._('Link')}}</th>
                        <th>{{ translate._('Sort Order')}}</th>
                        <th>{{ translate._('Edit/Delete')}}</th>
                        </thead>
                        <tbody>
                        {% for item in menu %}
                        <tr>
                           <td>{{ item.name }}</td>
                            <td>{{ item.icon }}</td>
                            <td>{{ item.href }}</td>
                            <td>{{ item.order }}</td>
                            <td><div class="btn-group" style="position:relative">
                                    <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> إجراء
                                        <i class="fa fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">

                                        <li>
                                            <a href="{{ url('menus/edit/' ~item.id) }}" data-toggle="modal">
                                                <i class="icon-tag"></i>{{ translate._('Edit')}}</a>
                                        </li>
                                        <li>
                                            <a href="{{ url('menus/delete/' ~item.id) }}" data-toggle="modal">
                                                <i class="icon-tag"></i>{{ translate._('Delete')}}</a>
                                        </li>


                                    </ul>
                                </div></td>
                        </tr>
                        {% endfor %}
                        </tbody>
                    </table>

            </div>


        </div>
    </div>


</div>