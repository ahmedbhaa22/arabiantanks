<div class="portlet light bordered">


    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Content Details"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="<?= $this->url->get('content/index/' . $Module_ID) ?>" data-toggle="modal"
               class="btn green-jungle btn-outline">
                <?php echo $translate->_("Back"); ?>
            </a>
        </div>

    </div>

    <!--tabs-->

    <div class="container">

        <?php
        echo $this->tag->form(
            [
                "content/advancedPost",
                "autocomplete" => "off",
                "class" => "form-horizontal paymentForm",
                "role" => "form",
                "style" => "display:block",
                "method"=>"post",
                "enctype" => "multipart/form-data",
                "id" => "newContent",

            ]
        );
        ?>
        <div id="sample_1_wrapper">
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
                            $cats = new \Models\Content();
                            $main_depts = DataCmsDepts::find(array("Module_ID={$Module_ID}"));
                            foreach ($main_depts as $main_dept) {
                                ?>
                                <div>
                                    <?php
                                    echo $main_dept->Title
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
            <title>Language</title>
            <select id="dynamic_select" name="lang"> 
                
                <option value="0" >Default Content</option>
                <?php foreach ($langs as $lang) { ?>
                <option value="<?= $lang->lang_id ?>"><?= $lang->LangDetails->title ?></option>
                <?php } ?>
            </select>
            </div>
        </div>
            </div>

            <div class="clearfix"></div>


            <!-- START KEY VALUE -->
            <div class="row">
                <?php

                $groupname = "";
                foreach ($keyValueData as $data):
                    if ($groupname !== $data['GroupName']):
                        ?>
                        <div class="kv-group-title"><h2><?php echo $data['GroupName'] ?></h2></div>
                        <?php
                        $groupname = $data['GroupName'];?>

                    <?php endif;?>
                    <div class="bg-dark btn-circle text-center" style="padding: 2px ; color: #fff;">
                        <div class="light text-uppercase"><?php echo $data['KeyValueTitle'] ; ?></div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">

                            <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Value"); ?></label>
                            <div class="col-sm-10">
                                <?php echo $data['ControlValue'] ; ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">

                            <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Title"); ?></label>
                            <div class="col-sm-10">
                                <?php echo $data['Title'] ; ?>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">

                            <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Desc"); ?></label>
                            <div class="col-sm-10">
                                <?php echo $data['Des'] ; ?>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <?php if($data['Add']==1): ?>
                    <input type="hidden" name="kvAddIDs[]" value="<?php echo $data['KV_ID'] ?>"/>
                <?php endif; ?>
                <?php endforeach; ?>
                <input type="hidden" name="Module_ID" value="<?php echo $Module_ID ?>"/>
            </div>
            <!-- END KEY VALUE -->

            <div class="form-group">
                <div class="col-sm-12">
                    <?php echo $this->tag->submitButton(["Search", "class" => "btn green-jungle", "value" => $translate->_("Search")]) ?>
                    <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn green-jungle" id="post"/>-->
                    <!--        <input type='button' value='Test' class="btn green-jungle" id="testpost"/>-->
                    <div class="testpost"></div>
                </div>
            </div>
        </div>

    </div>


    <!-- End Form -->

    <?php echo $this->tag->endForm(); ?>

</div>

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
<!--end tabs-->
<hr>