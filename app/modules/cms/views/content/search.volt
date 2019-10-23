<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="{{url('users_application_module')}}"><?php echo $translate->_("Main Page"); ?></a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <a href="{{url('content/main/') ~module['mod_id']}}">{{module['mod_title']}}</a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <a href=""><?php echo $translate->_("Content"); ?> </a>

        </li>

    </ul>
</div>
<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url('{{this.url_shared.get('uploads/modules_pics/') ~module_setting.Content_Banner}}')  center no-repeat ; background-size: contain;">
        </div>
    </div>
</div>
<div class="clear-fix"></div>

    <div class="portlet light bordered">

        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="icon-user font-dark"></i>
                <span class="caption-subject bold uppercase"> <?php //echo $translate->_("Content"); ?> {{module['mod_title']}}</span>
            </div>
            {% if(content_settings.Add==1)%}
            <div class="actions">
                <a type="button" href="{{url('content/new/') ~module['mod_id']}}" data-toggle="modal"
                   class="btn green-jungle btn-outline">
                    <?php echo $translate->_("New Content"); ?>
                </a>

            </div>
            {% endif%}
            {% if(this.session.get('auth-identity')['Application_ID']!=593) %}
<!--            <div class="actions">-->
<!--                <a type="button" href="{{url('content/advancedSearch/') ~module['mod_id']}}" data-toggle="modal"-->
<!--                   class="btn green-jungle btn-outline">-->
<!--                    --><?php //echo $translate->_("Advanced Search"); ?>
<!--                </a>-->
<!--            </div>-->
            {% endif%}
            {% if(this.session.get('auth-identity')['Application_ID']!=593) %}
            <div class="actions">
                <a type="button" href="#" id="filter-toggle-btn" class="btn green-jungle btn-outline">
                    {{ translate._("Filter") }}
                </a>
            </div>
            {%endif%}

        </div>


        <div class="row">
            <div class="col-md-2 col-sm-2">
                <a type="button" href="{{ url('content/toggleDisplay/') ~module['mod_id']}}&Toggle_Grid=0" data-toggle=""
                   class="">
                    <i class="fa fa-bars fa-2" aria-hidden="true" style="color:red"></i>
                </a>
                <a type="button" href="{{ url('content/toggleDisplay/') ~module['mod_id']}}&Toggle_Grid=1" data-toggle=""
                   class="">
                    <i class="fa fa-th-large fa-2" aria-hidden="true" style="color:red"></i>
                </a>
            </div>
            <div class="col-md-2 col-sm-2">

            </div>
        </div>
        <div class="portlet-body">
            <div id="sample_1_wrapper">
                <p><?php $this->flashSession->output() ?></p>
                <div class="row col-sm-12" id="filter-toggle">
                    <form method="POST" action="{{ url('content/search/') }}?is_first=0" enctype="multipart/form-data">
                        <div class="col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-2 "><?php echo $translate->_("Content Contains"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField(["Content", "size" => 30, "class" => "form-control", "id" => "fieldTitle",]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-2 "><?php echo $translate->_("Title Contains"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle",]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xs-6">

                            <div class="form-group">
                                <label for="fieldActive" class="col-sm-2 "><?php echo $translate->_("Departments"); ?></label>
                                <div class="col-sm-10 dept_tree">

                                    <ul>
                                        <?php
                                        $cats = new Models\Content();
                                        $main_depts = DataCmsDepts::find(array("Module_ID={$Module_ID}"));
                                        foreach ($main_depts as $main_dept) {
                                            ?>
                                            <div>
                                                <?php

                                                $get_lang=\DataCmsDeptsLang::findFirst("core_dept_id={$main_dept->ID} AND lang_id={$lang_id}");
                                                if(!$get_lang){
                                                    echo $main_dept->Title;
                                                }else{
                                                    echo $get_lang->title;
                                                }

                                                ?>
                                            </div>
                                            <?php
                                            $cats->buildTree(\DataCmsDeptsRel::find([
                                                "Core_Depts_ID=" . $main_dept->ID
                                            ]), 0,$lang_id);
                                        }

                                        ?>
                                    </ul>

                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xs-6">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2  col-sm-2"><?php echo $translate->_("Date From"); ?></label>
                                    <div class="col-md-10 col-sm-10">
                                        <input type="text" name="date_from" class="form-control" id="date_from" />
                                    </div>
                                </div>

                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2  col-sm-2"><?php echo $translate->_("Date To"); ?></label>
                                    <div class="col-md-10 col-sm-10">
                                        <input type="text" name="date_to" class="form-control" id="date_to" />
                                    </div>
                                </div>

                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label for="fieldActive" class="col-sm-2 "><?php echo $translate->_("Language"); ?></label>
                                    <select id="dynamic_select" name="lang">

                                        <option value="0" >Default Content</option>
                                        {%for lang in langs%}
                                        <option value="{{lang.lang_id}}">{{lang.LangDetails.title}}</option>
                                        {%endfor%}
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label for="fieldActive" class="col-sm-2 "><?php echo $translate->_("Active"); ?></label>
                                    <select id="dynamic_select" name="Active">
                                        <option value="0" >No</option>                                        {
                                        <option value="1">Yes</option>

                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <input type="hidden" name="Module_ID" value="<?php echo $Module_ID ?>"/>
                                <?php echo $this->tag->submitButton(["Search", "class" => "btn green-jungle", "value" => $translate->_("Search")]) ?>
                                <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn green-jungle" id="post"/>-->
                                <!--        <input type='button' value='Test' class="btn green-jungle" id="testpost"/>-->
                                <div class="testpost"></div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="clearfix"></div>
                <div class="table-scrollable">
                    <div><a id="reset-table" href=""><?php echo $translate->_("Reset All"); ?></a></div>
                    <!--                    <div><a href="{{url('content/index/' ~Module_ID)}}">--><?php //echo $translate->_("Search By Date"); ?><!--</a></div>-->
                    <form name="deleteContentForm" id="deleteContentForm" method="post" action="">

                        <table
                            class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                            id="sample" role="grid" aria-describedby="sample_1_info">
                            <thead>
                            <tr role="row">
                                <th class="sorting">
                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                        <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample .checkboxes">
                                        <span></span>
                                    </label></th>
                                {% if(list_settings.Img==1)%}
                                <th class="sorting"><?php echo $translate->_("Main Picture"); ?></th>
                                {% endif %}
                                {% if(list_settings.Title==1)%}
                                <th class="sorting"><?php echo $translate->_("Title"); ?></th>
                                {% endif %}
                                {% if(list_settings.Des==1)%}
                                <th class="sorting"><?php echo $translate->_("Desc"); ?></th>
                                {% endif %}
                                {% if(list_settings.Order==1)%}
                                <th class="sorting"><?php echo $translate->_("OrderBy"); ?></th>
                                {% endif %}
                                {% if(list_settings.Visit_Num==1)%}
                                <th class="sorting"><?php echo $translate->_("Visitors Count"); ?></th>
                                {% endif %}
                                {% if(list_settings.DateTime==1)%}
                                <th class="sorting"><?php echo $translate->_("Date"); ?></th>
                                <th class="sorting"><?php echo $translate->_("Time"); ?></th>
                                {% endif %}
                                {% if(list_settings.Active==1)%}
                                <th class="sorting"><?php echo $translate->_("Active"); ?></th>
                                {% endif %}
                                {% if "dkvs"|length!== 0%}
                                {%if(lang_id==0)%}
                                <?php foreach ($dkvs as $dkv): ?>
                                    <th><?php echo $dkv->DataKeyvalueLang->Title?></th>
                                <?php endforeach; ?>
                                {%else%}
                                <?php foreach ($dkvs as $dkv): ?>
                                    <th><?php echo $dkv->DataKeyvalueLang->getKvTitleByLang($dkv->ID,$lang_id)?></th>
                                <?php endforeach; ?>
                                {%endif%}
                                {%endif%}

                                <th class="sorting"><?php echo $translate->_("Edit/Delete"); ?></th>

                            </tr>
                            </thead>
                            <tbody>
                            <?php foreach ($items['content'] as $content): ?>
                                <tr class="gradeX">
                                    <td><label class="mt-checkbox mt-checkbox-single mt-checkbox-outline"><input type="checkbox" name="deleteCheckbox[]" class="checkboxes" value="<?php echo $content['id'] ?>"><span></span></label></td>
                                    {% if(list_settings.Img==1)%}
                                    <td><img src="{{this.url_shared.get('/')}}<?php echo  $content['image'] ?>" style="width: 50px;height: 50px;"></td>
                                    {% endif %}
                                    {% if(list_settings.Title==1)%}
                                    {%if(lang_id==0)%}
                                    <td><?php echo  $content['name'] ?></td>
                                    {%else%}
                                    <td><?php echo  $content['name'] ?></td>
                                    {%endif%}
                                    {% endif %}
                                    {% if(list_settings.Des==1)%}
                                    {%if(lang_id==0)%}
                                    <td><?php echo $content['description'] ?></td>
                                    {%else%}
                                    <td><?php echo $content['description'] ?></td>
                                    {%endif%}
                                    {% endif %}
                                    {% if(list_settings.Order==1)%}
                                    <td><?php echo $content['order'] ?></td>
                                    {% endif %}
                                    {% if(list_settings.Visit_Num==1)%}
                                    <td><?php echo $content['visit_num'] ?></td>
                                    {% endif %}
                                    {% if(list_settings.DateTime==1)%}
                                    <td><?php echo date('m/d/Y', $content['created_at']);?></td>
                                    <td><?php echo date('h:i:s', $content['created_at']);?></td>
                                    {% endif %}
                                    {% if(list_settings.Active==1)%}
                                    <td>
                                        <?php if($content['active'] ==1): ?>
                                            <i class="text-success glyphicon glyphicon-ok" aria-hidden="true"></i>
                                        <?php else: ?>
                                            <i class="text-warning glyphicon glyphicon-remove" aria-hidden="true"></i>
                                        <?php endif;?>
                                    </td>
                                    {% endif %}
                                    {% if "dkvs"|length!== 0%}
                                    <?php foreach ($dkvs as $dkv): ?>
                                        <td>
                                            <?php
                                            $kv_userdata = DataKeyvalueUserdata::findFirst("DKV_ID={$dkv->ID} AND Item_ID={$content['id']}");
                                            if(!isset($kv_userdata->Value)){
                                                echo "";
                                            }else{
                                                echo \Vokuro\Pentavalue\Keyvalue::getKeyvalue($kv_userdata->DataKeyvalue->CKV_ID,$kv_userdata->DKV_ID,$kv_userdata->Value);
                                            }
                                            ?>

                                        </td>
                                    <?php endforeach; ?>
                                    {% endif %}
                                    <td>
                                        <div class="btn-group" style="position:relative">
                                            <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> <?php echo $translate->_("Edit/Delete"); ?>
                                                <i class="fa fa-angle-down"></i>
                                            </button>
                                            <ul class="dropdown-menu" role="menu">

                                                {% if(Module_ID==20195) %}
                                                <li>
                                                    <a href="{{url('content/viewRelatedContent/')}}&parent=<?php echo $content['id'] ?>&child_module=20197" data-toggle="modal">
                                                        <i class="icon-tag"></i> <?php echo $translate->_("Promotions"); ?></a>
                                                </li>
                                                {%endif%}
                                                <li>
                                                    <a href="{{url('content/edit/')}}<?php echo $content['id'] ?>" data-toggle="modal">
                                                        <i class="icon-tag"></i> <?php echo $translate->_("Edit"); ?></a>
                                                </li>

                                                {% if(content_settings.Del==1)%}
                                                <li>
                                                    <a href="{{url('content/delete/')}}<?php echo $content['id'] ?>" class="">
                                                        <i class="icon-user"></i> <?php echo $translate->_("Delete"); ?> </a>
                                                </li>
                                                {%endif%}
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            <?php endforeach; ?>

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

<!--            <div class="row">-->
<!--                <div class="col-md-5 col-sm-5">-->
<!--                    <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">-->
<!--                        --><?php //echo $page->current, "/", $page->total_pages ?>
<!--                    </div>-->
<!--                </div>-->
<!--                <div class="col-md-7 col-sm-7"><div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">-->
<!--                        <ul class="pagination" style="visibility: visible;">-->
<!--                            <li>--><?php //echo $this->tag->linkTo("content/search/{$Module_ID}", $translate->_("First")) ?><!--</li>-->
<!--                            <li>--><?php //echo $this->tag->linkTo("content/search/{$Module_ID}?page=" . $page->before, $translate->_("Back")) ?><!--</li>-->
<!--                            <li>--><?php //echo $this->tag->linkTo("content/search/{$Module_ID}?page=" . $page->next, $translate->_("Next")) ?><!--</li>-->
<!--                            <li>--><?php //echo $this->tag->linkTo("content/search/{$Module_ID}?page=" . $page->last, $translate->_("Last")) ?><!--</li>-->
<!--                        </ul>-->
<!--                    </div>-->
<!--                </div>-->
<!--            </div>-->

        </div>
        <style>
            .contentImg {
                height: 100px;
                width: 100px;
            }
        </style>
    </div>
    <script>var module_id={{Module_ID}}</script>

    {{ javascript_include("js/filters/content.js") }}
    <style>
        #sample_1 tfoot th.filter input{
            width:100px;
            height:25px;
        }
    </style>
<!------ End OF List ------->

<script type="text/javascript">
    $( document ).ready(function() {
        $('#date_from').datepicker({
            format: "yyyy-mm-dd"
        });
        $('#date_to').datepicker({
            format: "yyyy-mm-dd"
        });
    });

</script>








