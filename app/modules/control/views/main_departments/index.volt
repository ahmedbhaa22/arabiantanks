<div class="portlet light bordered">
    <!--<div class="row">-->
    <!--    <nav>-->
    <!--        <ul class="pager">-->
    <!--            <li class="next">--><?php //echo $this->tag->linkTo(["content/new", "Create "]); ?><!--</li>-->
    <!--        </ul>-->
    <!--    </nav>-->
    <!--</div>-->
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">{{translate._("Main Departments")}}</span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('main_departments/new/' ~Module_ID) }}" data-toggle="modal" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                {{translate._("Add Main Department")}}
            </a>
        </div>

    </div>



    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                    <tr role="row">
                        <th class="sorting">{{translate._("ID")}}</th>
                        <th class="sorting">{{translate._("Title")}}</th>
                        <th class="sorting">{{translate._("Des")}}</th>

                        <th class="sorting">{{translate._("Edit/Delete")}}</th>

                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($page->items as $content): ?>
                        <tr class="gradeX">
                            <td><?php echo $content->ID ?></td>
                            <td><?php echo $content->Title ?></td>
                            <td><?php echo $content->Des ?></td>
                              <td>
                                <div class="btn-group" style="position:relative">
                                    <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">  {{translate._("Edit/Delete")}}
                                        <i class="fa fa-angle-down"></i>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">

                                        <li>
                                            <a href="{{url('main_departments/edit/')}}<?php echo $content->ID ?>" data-toggle="modal">
                                                <i class="icon-tag"></i> {{translate._("Edit")}} </a>
                                        </li>

                                        <!-- <li>
                                            <a href="{{url('main_departments/delete/')}}<?php echo $content->ID ?>" class="delete-general">
                                                <i class="icon-user"></i> {{translate._("Delete")}} </a>
                                        </li> -->
                                    </ul>
                                </div>
                            </td>
                        </tr>
                    <?php endforeach; ?>
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
                            <li><?php echo $this->tag->linkTo("main_departments/index/{$Module_ID}", "First") ?></li>
                            <li><?php echo $this->tag->linkTo("main_departments/index/{$Module_ID}?page=" . $page->before, $translate->_("Previous")) ?></li>
                            <li><?php echo $this->tag->linkTo("main_departments/index/{$Module_ID}?page=" . $page->next, $translate->_("Next")) ?></li>
                            <li><?php echo $this->tag->linkTo("main_departments/index/{$Module_ID}?page=" . $page->last, $translate->_("Last")) ?></li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
