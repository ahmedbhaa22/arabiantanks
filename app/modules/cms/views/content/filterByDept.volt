<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<?php
use Phalcon\Tag;
use Phalcon\Escaper;
use Phalcon\Mvc\Url;

$url = new Url();
$e = new Escaper();
?>


    <div class="portlet light bordered">

        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="icon-user font-dark"></i>
                <span class="caption-subject bold uppercase"> {{ translate._('Advanced Search') }}</span>
            </div>


        </div>

        <div class="portlet-body">
            <div id="sample_1_wrapper">
                <div class="table-scrollable">
                    <table
                        class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                        id="sample_filter_byDept" role="grid" aria-describedby="sample_1_info">
                        <thead>
                        <tr role="row">
                            <th class="sorting">
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample_1 .checkboxes">
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
                        <?php foreach ($page->items as $content): ?>
                            <tr class="gradeX">
                                <td><label class="mt-checkbox mt-checkbox-single mt-checkbox-outline"><input type="checkbox" name="deleteCheckbox[]" class="checkboxes" value="<?php echo $content->Content->ID ?>"><span></span></label></td>
                                {% if(list_settings.Img==1)%}
                                <td><img src="{{ this.url_shared.get('uploads/')}}<?php echo $content->Content->Img ?>" style="width: 50px;height: 50px;"></td>
                                {% endif %}
                                {% if(list_settings.Title==1)%}
                                {%if(lang_id==0)%}
                                <td><?php echo $content->Content->Title ?></td>
                                {%else%}
                                <td><?php echo $content->Content->getTitleByLang($lang_id) ?></td>
                                {%endif%}
                                {% endif %}
                                {% if(list_settings.Des==1)%}
                                {%if(lang_id==0)%}
                                <td><?php echo $content->Content->Des ?></td>
                                {%else%}
                                <td><?php echo $content->Content->getDesByLang($lang_id) ?></td>
                                {%endif%}
                                {% endif %}
                                {% if(list_settings.Order==1)%}
                                <td><?php echo $content->Content->Order ?></td>
                                {% endif %}
                                {% if(list_settings.Visit_Num==1)%}
                                <td><?php echo $content->Content->Visit_Num ?></td>
                                {% endif %}
                                {% if(list_settings.DateTime==1)%}
                                <td><?php echo date('m/d/Y', $content->Content->DateTime); ?></td>
                                <td><?php echo date('H:i:s', $content->Content->DateTime); ?></td>
                                {% endif %}
                                {% if(list_settings.Active==1)%}
                                <td>
                                    {% if content.Content.Active == 1 %}
                                    <i class="text-success glyphicon glyphicon-ok" aria-hidden="true"></i>
                                    {% else %}
                                    <i class="text-warning glyphicon glyphicon-remove" aria-hidden="true"></i>
                                    {% endif %}

                                </td>
                                {% endif %}
                                {% if "dkvs"|length!== 0%}
                                <?php foreach ($dkvs as $dkv): ?>
                                    <td>
                                        <?php
                                        $kv_userdata = DataKeyvalueUserdata::findFirst("DKV_ID={$dkv->ID} AND Item_ID={$content->Content->ID}");
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
                                    {% if(Module_ID==20195) %}

                                    <a href="{{url('content/viewRelatedContent/')}}&parent=<?php echo $content->Content->ID ?>&child_module=20197"  class="btn btn-xs btn-success">


                                        {%endif%}

                                        <a href="{{url('content/edit/')}}<?php echo $content->Content->ID ?>" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>



                                        {% if(content_settings.Del==1)%}

                                        <a href="{{url('content/delete/')}}<?php echo $content->Content->ID ?>" class="btn btn-xs btn-danger" onclick="return confirm('Are you sure you want to delete this item?');"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>


                                        {%endif%}

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
                    <div class="col-md-7 col-sm-7">
                        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                            <ul class="pagination" style="visibility: visible;">
                                <li><?php echo $this->tag->linkTo("content/filterByDept/$Dept_ID",  $translate->_("First")) ?></li>
                                <li><?php echo $this->tag->linkTo("content/filterByDept/$Dept_ID?page=" . $page->before,  $translate->_("Previous")) ?></li>
                                <li><?php echo $this->tag->linkTo("content/filterByDept/$Dept_ID?page=" . $page->next,  $translate->_("Next")) ?></li>
                                <li><?php echo $this->tag->linkTo("content/filterByDept/$Dept_ID?page=" . $page->last,  $translate->_("Last")) ?></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <style>
            .contentImg {
                height: 100px;
                width: 100px;
            }
        </style>
    </div>



<!------ End OF List ------->




















