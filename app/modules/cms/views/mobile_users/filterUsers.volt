<div class="portlet light bordered">

    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">{{ translate._("Mobile Users") }}</span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('mobile_users/statistics')}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Users Statistics"); ?>
            </a>
        </div>

        <div class="actions">
            <a type="button" href="#" id="filter-toggle-btn" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                {{ translate._("Filter") }}
            </a>
        </div>

    </div>

    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <div class="row col-sm-12" id="filter-toggle">
                    <form method="POST" action="{{ url('mobile_users/filterUsers/') }}" enctype="multipart/form-data">
                        <div class="col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-2 bg-info"><?php echo $translate->_("User Name"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField(["User", "size" => 30, "class" => "form-control", "id" => "fieldTitle",]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-2 bg-info"><?php echo $translate->_("E-Mail"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField(["Mail", "size" => 30, "class" => "form-control", "id" => "fieldTitle",]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xs-6">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Date From"); ?></label>
                                    <div class="col-md-10 col-sm-10">
                                        <input type="text" name="date_from" id="date_from" class="dateFilter" />
                                    </div>
                                </div>

                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Date To"); ?></label>
                                    <div class="col-md-10 col-sm-10">
                                        <input type="text" name="date_to" id="date_to" class="dateFilter"/>
                                    </div>
                                </div>

                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Active"); ?></label>
                                    <div class="col-md-10 col-sm-10">
                                        <select class="form-control" name="Active">
                                            <option value=""></option>
                                            <option value="1"><?php echo $translate->_("Yes"); ?></option>
                                            <option value="0"><?php echo $translate->_("No"); ?></option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Gender"); ?></label>
                                    <div class="col-md-10 col-sm-10">
                                        <select class="form-control" name="Gender">
                                            <option value=""></option>
                                            <option value="0"><?php echo $translate->_("Female"); ?></option>
                                            <option value="1"><?php echo $translate->_("Male"); ?></option>
                                        </select>
                                    </div>
                                </div>

                            </div>

                        </div>

                        <div class="clearfix"></div>
                        <div class="form-group">
                            <div class="col-sm-12">

                                <?php echo $this->tag->submitButton(["Search", "class" => "btn btn-default", "value" => $translate->_("Search")]) ?>
                                <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn btn-default" id="post"/>-->
                                <!--        <input type='button' value='Test' class="btn btn-default" id="testpost"/>-->
                                <div class="testpost"></div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="clearfix"></div>
                <form name="deleteContentForm" id="deleteMobileUserForm" method="post" action="">
                    <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                        <thead>

                        <tr role="row">
                            <th>
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample_1 .checkboxes">
                                    <span></span>
                                </label>
                            </th>
                            <th class="">{{ translate._("Name") }}</th>
                            <th class="">{{ translate._("User Name") }}</th>
                            <th class="">{{ translate._("Picture") }}</th>
                            <th class="">{{ translate._("Gender") }}</th>
                            <th class="">{{ translate._("E-Mail") }}</th>
                            <th class="">{{ translate._("Registration Date") }}</th>
                            <th class="">{{ translate._("Registration Time") }}</th>
                            <th class="">{{ translate._("Active") }}</th>
                            <th class="">{{ translate._("Edit/Delete") }}</th>

                        </tr>
                        </thead>
                        <tbody>
                        {% for content in page.items %}
                            <tr>
                                <td><label class="mt-checkbox mt-checkbox-single mt-checkbox-outline"><input type="checkbox" name="deleteCheckbox[]" class="checkboxes" value="{{content.ID}}"><span></span></label></td>
                                <td>{{content.Title}}</td>
                                <td>{{content.User}}</td>
                                <td>{{content.Img}}</td>
                                <td>
                                    {% if content.Gender == 0 %}
                                    {{translate._("Female")}}
                                    {% else %}
                                    {{translate._("Male")}}
                                    {% endif %}
                                </td>
                                <td>{{content.Mail}}</td>
                                <td>{{date('m/d/Y', content.Join_Date)}}</td>
                                <td>{{date('H:i:s', content.Join_Date)}}</td>
                                <td>
                                    {% if content.Active == 1 %}
                                    <i class="text-success glyphicon glyphicon-ok" aria-hidden="true"></i>
                                    {% else %}
                                    <i class="text-warning glyphicon glyphicon-remove" aria-hidden="true"></i>
                                    {% endif %}
                                </td>
                                <td>
                                    <div class="btn-group" style="position:relative">
                                        <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> {{ translate._("Edit/Delete") }}
                                            <i class="fa fa-angle-down"></i>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">

                                            <li>
                                                <a href="{{url('mobile_users/edit/' ~content.ID)}}" data-toggle="">
                                                    <i class="icon-tag"></i>{{ translate._("Edit")}}</a>
                                            </li>

                                            <<li>
                                                <a href="{{url('mobile_users/delete/' ~content.ID)}}" data-toggle="">
                                                    <i class="icon-tag"></i>{{ translate._("Delete")}}</a>
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
                                aria-expanded="false"> <?php echo $translate->_("Checked Fuctions"); ?>
                            <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu" role="menu">

                            <li>
                                <a href="#" class="delete-btn" value="sss">
                                    <i class="icon-user"></i> <?php echo $translate->_("Delete Checked"); ?> </a>
                            </li>
                            <li>
                                <a href="#" class="active-btn" value="sss">
                                    <i class="icon-user"></i> <?php echo $translate->_("Activate Checked"); ?> </a>
                            </li>
                            <li>
                                <a href="#" class="deactive-btn" value="sss">
                                    <i class="icon-user"></i> <?php echo $translate->_("Deactivate Checked"); ?> </a>
                            </li>

                        </ul>
                    </div>
                </form>
            </div>


                        <div class="row">
                            <div class="col-md-5 col-sm-5">
                                <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                                    <?php echo $page->current, "/", $page->total_pages ?>
                                </div>
                            </div>
                            <div class="col-md-7 col-sm-7"><div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                                    <ul class="pagination" style="visibility: visible;">
                                        <li><?php echo $this->tag->linkTo("mobile_users/filterUsers"."?Active={$Active}&User={$User}&Mail={$Mail}", "الأولى") ?></li>
                                        <li><?php echo $this->tag->linkTo("mobile_users/filterUsers?page=" . $page->before."&Active={$Active}&User={$User}&Mail={$Mail}", "السابقة") ?></li>
                                        <li><?php echo $this->tag->linkTo("mobile_users/filterUsers?page=" . $page->next."&Active={$Active}&User={$User}&Mail={$Mail}", "التالية") ?></li>
                                        <li><?php echo $this->tag->linkTo("mobile_users/filterUsers?page=" . $page->last."&Active={$Active}&User={$User}&Mail={$Mail}", "الأخيرة") ?></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

        </div>
    </div>

</div>

<script type="text/javascript">
    $( document ).ready(function() {
        $('.dateFilter').datepicker({
            format: "mm/dd/yyyy"
        });
        $('.dateFilter').on('changeDate', function(ev){
            $(this).datepicker('hide');
        });

    });

</script>