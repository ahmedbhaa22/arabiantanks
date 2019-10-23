<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
                    <li>
                        <a href="{{url('users_application_module')}}"><?php echo $translate->_("Main Page"); ?></a>
                        <i class="icon-arrow-left"></i>
                    </li>
                   <li>
                        <a href="">{{department['Title']}}</a>
                        
                    </li>
                    
                </ul>
</div>

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
            <i class="fa fa-pie-chart" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase">{{department['Title']}}</span>
        </div>

        <div class="actions">
            <a type="button" href="#" data-toggle="modal" data-target="#myModal"
               class="btn green-jungle btn-outline">
                <?php echo $static_trans['Add Department']?>
            </a>
        </div>
        <div class="actions">
            <a type="button" href="#" id="filter-toggle-btn" class="btn green-jungle btn-outline">
                {{ translate._("Filter") }}
            </a>
        </div>

    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <p><?php $this->flashSession->output() ?></p>
            <div class="row col-sm-12" id="filter-toggle">
                <form method="GET" action="{{ url('departments/search/') ~main_dept}}" enctype="multipart/form-data">
                    <div class="col-md-12 col-xs-12">
                        <div class="form-group">
                            <div class="col-xs-6">
                                <label class="control-label col-md-2  col-sm-2"><?php echo $translate->_("Status"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <select name="active" class="form-control">
                                        <option value="0">{{ translate._("Not Active") }}</option>
                                        <option value="1">{{ translate._("Active") }}</option>
                                    </select>
                                </div>
                            </div>
                            <!-- <div class="funkyradio clearfix">
                                <div class="col-md-6 col-sm-6 col-xs-6">
                                    <div class="funkyradio-success">
                                        <input type="checkbox" id="active" name="">
                                        <label for="active"><?php echo $translate->_("Status"); ?></label>
                                    </div>
                                </div>
                            </div> -->

                        </div>
                        <div class="form-group">
                            <div class="col-xs-6">
                                <label class="control-label col-md-2  col-sm-2"><?php echo $translate->_("Title"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <input type="text" name="Title" id="" class="form-control" />
                                </div>
                            </div>

                        </div>


                    </div>
                    <div class="form-group">
                        <div class="col-md-12 col-xs-12">
                            <input type="hidden" name="main_dept" value="{{ main_dept }}" />
                            <input type="submit" value="<?php echo $translate->_("Apply Filter"); ?>" class="btn green-jungle">
                        </div>
                    </div>
                </form>
            </div>
            <div class="clearfix"></div>
            <div class="">
                <div><a id="reset-table" href=""><?php echo $translate->_("Reset All"); ?></a></div>
                <form name="deleteContentForm" id="deleteDeptForm" method="post" action="">
                    <table
                        class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                        id="sample_depts" role="grid" aria-describedby="sample_1_info">
                        <thead>
                        <tr role="row">
                            <th class="sorting">
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample_1 .checkboxes">
                                    <span></span>
                                </label></th>
                            <th class="sorting">{{ translate._('Title')}}</th>
                            <th class="sorting">{{ translate._('Desc')}}</th>
                            <th class="sorting">{{ translate._('Sort Order')}}</th>
                            <th class="sorting">{{ translate._('Active')}}</th>
                            <th class="sorting">{{ translate._('Edit/Delete')}}</th>

                        </tr>
                        </thead>
                        <tbody>

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


        </div>
    </div>

    <div id="myModal" class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">

        <div class="modal-dialog ">
            <div class="modal-content">
                <div class="modal-header hidden-xs">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">
                        <i class="fa fa-pie-chart" aria-hidden="true"></i>
                        <span class="caption-subject bold uppercase"><?php echo $static_trans['Add Department']?></span>
                    </h4>
                </div>

                <div class="modal-body">
                    <div class="">
                        <?php
                        echo $this->tag->form(
                            [
                                "departments/create",
                                "autocomplete" => "off",
                                "class" => "form-horizontal paymentForm",
                                "role" => "form",
                                "style" => "display:block",
                                "enctype" => "multipart/form-data",
                                "id" => "validateForm1"
                            ]
                        );
                        ?>
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#1" data-toggle="tab">{{ translate._('Details')}}</a>
                            </li>
                            <li>
                                <a href="#2" data-toggle="tab">{{ translate._('Other Options')}}</a>
                            </li>
                            <li>
                                <a href="#3" data-toggle="tab">{{ translate._('Category Attributes')}}</a>
                            </li>
                        </ul>
                        <div class="tab-content ">
                            <div class="tab-pane active" id="1">
                                <div id="sample_1_wrapper">
                                    <div class="col-md-6 no-pad col-xs-12">
                                        <div class="col-xs-12 form-group">
                                            <label for="fieldTitle" class="col-sm-3 control-label">{{
                                                translate._('Title')}}</label>
                                            <div class="col-sm-9">
                                                <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
                                            </div>
                                        </div>

                                        
                                        <div class="col-xs-12 form-group">
                                            <label for="fieldImg" class="col-sm-3 control-label">{{
                                                translate._('Main Picture')}}</label>
                                            <div class="col-sm-9">
                                                <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg","required"=>"required"]) ?>
                                            </div>
                                        </div>

                                        <div class="col-xs-12 form-group">

                                                <label for="fieldOrder" class="col-sm-2 control-label"><?php echo $translate->_("Subject To Maintenance") ?></label>
                                                <div class="col-sm-10">
                                                    <span><?php echo $translate->_("Yes") ?></span>
                                                    <?php
                                                    echo Phalcon\Tag::radioField(array("maintenance", "value" => "yes")); ?>
                                                    <span><?php echo $translate->_("No") ?></span>
                                                    <?php
                                                    echo Phalcon\Tag::radioField(array("maintenance", "value" => "no"))
                                                    ?>


                                                </div>

                                        </div>
                                    </div>

                                    <div class="col-md-6 col-xs-12 no-pad">
                                        <div class="col-xs-12 form-group">
                                            <label for="fieldActive" class="col-sm-3 control-label">
                                                {{ translate._('Active')}}
                                            </label>
                                            <div class="col-sm-9">
                                                <?php echo $this->tag->selectStatic(["Active", array("1" => $translate->_("Yes"), "0" => $translate->_("Yes")), "class" => "form-control", "id" => "fieldActive"]) ?>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 form-group">
                                            <label for="fieldContent" class="col-sm-3 control-label">{{
                                                translate._('Sort Order')}}</label>
                                            <div class="col-sm-9">
                                                <?php echo $this->tag->numericField(["Orders", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldOrders","value"=>"0"]) ?>
                                            </div>
                                        </div>
                                        <div class="col-xs-12 form-group">
                                            <label for="fieldOrder" class="col-sm-3 control-label">
                                                {{ translate._('Has Parent Department ?')}}
                                            </label>
                                            <div class="col-sm-9">
                                                <div class="col-md-6 no-pad">
                                                    <span>{{ translate._('Yes')}}</span>
                                                    <?php
                                                    echo Phalcon\Tag::radioField(array("Has_Parent", "value" => "yes","class"=>"Has_Parent",)); ?>
                                                    <span>{{ translate._('No')}}</span>
                                                    <?php
                                                    echo Phalcon\Tag::radioField(array("Has_Parent", "value" => "no","class"=>"Has_Parent","checked"=>"checked",))
                                                    ?>
                                                </div>
                                                <div class="col-md-6 no-pad">
                                                    <?php echo Phalcon\Tag::select([
                                                        "Parent_Depts_ID",
                                                        "class"=>"Parent_Depts_ID",
                                                        \DataCmsDeptsRel::find(array(
                                                            "Module_ID ={$Module_ID} AND Core_Depts_ID={$main_dept}"
                                                        )),
                                                        "using" => ["ID", "Title"]]);
                                                    ?>
                                                </div>

                                            </div>
                                        </div>


                                    </div>

                                    <div class="col-xs-12 form-group">
                                        <label for="fieldContent" class="col-sm-2 control-label">{{
                                            translate._('Details')}}</label>
                                        <div class="col-sm-10">
                                            <?php echo $this->tag->textArea(["Des", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldDes"]) ?>
                                        </div>
                                    </div>

                                    <?php echo $this->tag->hiddenField("ID") ?>
                                    <?php echo $this->tag->hiddenField("Module_ID") ?>
                                    <?php echo $this->tag->hiddenField("Core_Depts_ID") ?>
                                    <?php echo $this->tag->hiddenField("Lang_ID") ?>


                                </div>
                            </div>
                            <div class="tab-pane" id="2">
                                <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">

                                    <div class="row">
                                        <?php

                                        $groupname = "";
                                        foreach ($keyValueData as $data):
                                            if ($groupname !== $data['GroupName']):
                                                ?>
                                                <div class="kv-group-title"><h2><?php echo $data['GroupName'] ?></h2>
                                                </div>
                                                <?php
                                                $groupname = $data['GroupName'];
                                            endif;
                                            ?>
                                            <div class="bg-dark btn-circle text-center"
                                                 style="padding: 2px ; color: #fff;">
                                                <div
                                                    class="light text-uppercase"><?php echo $data['KeyValueTitle']; ?></div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">

                                                    <label for="keyvalue"
                                                           class="col-sm-2 control-label"><?php echo $translate->_("Value"); ?></label>
                                                    <div class="col-sm-10">
                                                        <?php echo $data['ControlValue']; ?>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">

                                                    <label for="keyvalue"
                                                           class="col-sm-2 control-label"><?php echo $translate->_("Title"); ?></label>
                                                    <div class="col-sm-10">
                                                        <?php echo $data['Title']; ?>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">

                                                    <label for="keyvalue"
                                                           class="col-sm-2 control-label"><?php echo $translate->_("Desc"); ?></label>
                                                    <div class="col-sm-10">
                                                        <?php echo $data['Des']; ?>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">

                                                    <label for="keyvalue"
                                                           class="col-sm-2 control-label"><?php echo $translate->_("Picture"); ?></label>
                                                    <div class="col-sm-10">
                                                        <?php echo $data['Img']; ?>
                                                    </div>
                                                </div>
                                            </div>
                                            <?php if ($data['Add'] == 1): ?>
                                            <input type="hidden" name="kvAddIDs[]"
                                                   value="<?php echo $data['KV_ID'] ?>"/>
                                        <?php endif; ?>
                                        <?php endforeach; ?>

                                    </div>

                                </div>
                            </div>


                            <div class="tab-pane" id="3">
                                {%for group in category_attributes%}
                                {%for key,keyvalue in group['keyvalues']%}
                                {{keyvalue['title']}}
                                {{ check_field("keyvalue_attribute"~keyvalue['kv_id'],"class":"form-control","value":keyvalue['kv_id']) }}
                                {%endfor%}
                                {%endfor%}
                            </div>
                            

                            
                        </div>
                    </div>
                </div>

                <script>
                    $(document).ready(function() {
                        $('.Parent_Depts_ID').hide();
                        $('.Has_Parent').click(function() {
                            if($(this).attr('value') == 'yes') {
                                $('.Parent_Depts_ID').show();
                            }

                            else {
                                $('.Parent_Depts_ID').hide();
                            }
                        });
                    });
                </script>
                <div class="modal-footer">
                    <div class="col-sm-12">
                        <?php echo $this->tag->submitButton(["Save", "class" => "btn green-jungle", "value" => $translate->_("Save")]) ?>
                        <input type="button" data-dismiss="modal" class="btn dark "
                               value="{{ translate._('Cancel')}}">
                    </div>
                </div>
                <?php echo $this->tag->endForm(); ?>

            </div>

            <script>
                // Wait for the DOM to be ready
                $(function () {
                    $.validator.setDefaults({
                        ignore: []
                    });
                    // Initialize form validation on the registration form.
                    // It has the name attribute "registration"
                    $("#validateForm1").validate({
                        rules: {
                            Title: {
                                required: true
                            },
                            Des: {
                                required: true
                            },
                            Order: {
                                number: true,
                            },
                            //Key Value Validation(Dynamic)
                            <?php
                            foreach ($keyvalueempty as $item):
                                $validate_kv = new \Vokuro\Pentavalue\KeyvalueOld();
                                echo $validate_kv->returnAddValidation($item->ID);
                                unset($validate_kv);
                            endforeach;
                            ?>
                        }

                    });
                });

            </script>
            <script>var main_dept = {{main_dept}}</script>
            {{ javascript_include("js/filters/departments.js") }}
        </div>
    </div>
