<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="<?= $this->url->get('users_application_module') ?>"><?php echo $translate->_("Main Page"); ?></a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <a href="<?= $this->url->get('content/main/') . $module['mod_id'] ?>"><?= $module['mod_title'] ?></a>
            <i class="icon-arrow-left"></i>
        </li>
        
        <li>
            <a href="<?= $this->url->get('content/index/') . $module['mod_id'] ?>"><?php echo $translate->_("Content"); ?> </a>
            <i class="icon-arrow-left"></i>
        </li>
        
        <li>
            <a href=""><?php echo $translate->_("New"); ?> </a>
            
        </li>
        
    </ul>
</div>

<div class="col-lg-12">
    <div class="row">
        <div class="text-center banner" style=" background: url('<?= $this->url_shared->get('uploads/modules_pics/') . $module_setting->Content_Edit_Banner ?>')  center no-repeat ; background-size: contain;">
        </div>
    </div>
</div>
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">
            	<?php echo $translate->_("Add Content"); ?>: <?= $module['mod_title'] ?>  
            	<?php if (($parent != 0)) { ?>
            	- <?= $parent_name ?>
            	<?php } ?>
            	</span>
        </div>
        <div class="actions">
        	<?php if (($parent == 0)) { ?>
            <a type="button" href="<?= $this->url->get('content/index/' . $Module_ID) ?>" data-toggle="modal"
               class="btn green-jungle btn-outline">
                <?php echo $translate->_("Back"); ?>
            </a>
            <?php } else { ?>
            <?php } ?>
        </div>
    </div>

    <p><?php echo $this->flashSession->output() ?></p>
    
    <!--tabs-->

    <div class="">
        <!-- <ul class="nav nav-tabs">
            <li class="active">
                <a href="#1" data-toggle="tab"><?php echo $translate->_("Content Details"); ?></a>
            </li>
            <?php if (($settings->MediaImg == 1)) { ?>
            <li>
                <a href="#2" data-toggle="tab"><?php echo $translate->_("Media"); ?></a>
            </li>
            <?php } ?>
            <?php if (($settings->MediaVideo == 1)) { ?>
            <li>
                <a href="#3" data-toggle="tab"><?php echo $translate->_("Video"); ?></a>
            </li>
            <?php } ?>
            <?php if (($settings->KvInfo == 1)) { ?>
            <li>
                <a href="#4" data-toggle="tab"><?php echo $translate->_("Other Options"); ?></a>
            </li>
            <?php } ?>
        </ul> -->

        <?php
        echo $this->tag->form(
            [
              "content/create",
//             "content/addbulk",
               "autocomplete" => "off",
               "class" => "form-horizontal paymentForm",
               "role" => "form",
               "style" => "display:block",
               "enctype" => "multipart/form-data",
               "id"=>"newContent$Module_ID",
            ]
        );
        ?>
<div class="col-xs-9">
    <!-- Title -->
    <?php if (($settings->Title == 1)) { ?>
    <div class="col-md-12 col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Title"); ?></h2> </div>

            <ul  class="nav nav-tabs">
                <li class="active">
                    <a  href="#title-en" class="small" data-toggle="tab">
                    	<?php if (($this->session->get('auth-identity')['Application_ID'] == 593)) { ?>
                	English
                	<?php } else { ?>
                	Default 
                	<?php } ?>
                    	
                    	</a>
                </li>
                <?php foreach ($app_langs as $app_lang) { ?>
                    <li>
                        <a href="#title_<?= $app_lang->lang_id ?>" class="small"
                           data-toggle="tab"><?= $app_lang->LangDetails->title ?></a>
                    </li>
                <?php } ?>
            </ul>
            <div class="tab-content clearfix">
                <div class="tab-pane active" id="title-en">
                    <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle", "placeholder" => ""]) ?>
                </div>
                <?php foreach ($app_langs as $app_lang) { ?>
                    <div class="tab-pane" id="title_<?= $app_lang->lang_id ?>">
                        <?php echo $this->tag->textField(["Title_".$app_lang->lang_id, "size" => 30, "class" =>
                        "form-control", "id" => "fieldTitle", "placeholder" => ""]) ?>
                    </div>
                <?php } ?>
            </div>

        </div>
    </div>
    <?php } ?>

    <!-- Des -->
    <?php if (($settings->Des == 1)) { ?>
    <div class="col-md-12 col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Desc"); ?></h2></div>
            <ul  class="nav nav-tabs">
                <li class="active">
                    <a  href="#desc-en" class="small" data-toggle="tab">
<?php if (($this->session->get('auth-identity')['Application_ID'] == 593)) { ?>
                	English
                	<?php } else { ?>
                	Default 
                	<?php } ?>
                    	
</a>
                </li>
                <?php foreach ($app_langs as $app_lang) { ?>
                    <li>
                        <a href="#desc_<?= $app_lang->lang_id ?>" class="small"
                           data-toggle="tab"><?= $app_lang->LangDetails->title ?></a>
                    </li>
                <?php } ?>
            </ul>
            <div class="tab-content clearfix">
                <div class="tab-pane active" id="desc-en">
                    <?php echo $this->tag->textField(["Des", "size" => 30, "class" => "form-control", "id" => "fieldDes"]) ?>
                </div>
                <?php foreach ($app_langs as $app_lang) { ?>
                    <div class="tab-pane" id="desc_<?= $app_lang->lang_id ?>">
                        <?php echo $this->tag->textField(["Des_".$app_lang->lang_id, "size" => 30, "class" =>
                        "form-control", "id" => "fieldDes"]) ?>
                    </div>
                <?php } ?>
            </div>
        </div>
    </div>
    <?php } ?>

    
    <!-- Content -->
    <?php if (($settings->Content == 1)) { ?>
    <div class="col-md-12 col-xs-12">
            <div class="form-group">
                <div class="kv-group-title"><h2><?php echo $translate->_("Content Details"); ?></h2></div>
                <ul  class="nav nav-tabs">
	                <li class="active">
	                    <a  href="#text-en" class="small" data-toggle="tab">
	                    	<?php if (($this->session->get('auth-identity')['Application_ID'] == 593)) { ?>
                	English
                	<?php } else { ?>
                	Default 
                	<?php } ?>
                    	
	                    </a>
	                </li>
                    <?php foreach ($app_langs as $app_lang) { ?>
                        <li>
                            <a href="#content_<?= $app_lang->lang_id ?>" class="small"
                               data-toggle="tab"><?= $app_lang->LangDetails->title ?></a>
                        </li>
                    <?php } ?>
	            </ul>
	            <div class="tab-content clearfix">
	                <div class="tab-pane active" id="text-en">
	                	<?php echo $this->tag->textArea(["Content", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldContent"]) ?>
            		</div>
                    <?php foreach ($app_langs as $app_lang) { ?>
                        <div class="tab-pane" id="content_<?= $app_lang->lang_id ?>">
                            <?php echo $this->tag->textArea(["Content_".$app_lang->lang_id, "size" => 30, "class" =>
                            "form-control", "id" => "fieldDes"]) ?>
                        </div>
                    <?php } ?>
            	</div>
            </div>
        </div>
    <?php } ?>

    <!-- MediaImg -->
    <?php if (($settings->MediaImg == 1)) { ?>
        <div id="upload">
            <div class="form-group">
                <div class="col-md-12">
                    <div class="kv-group-title"><h2><?php echo $translate->_("Pictures"); ?></h2></div>
                    <?php echo $this->tag->fileField(["Media[]", "size" => 30, "class" => "form-control", "id" => "fieldMedia",]) ?>
                </div>  
            </div>
        </div>
    <?php } ?>
    
    <!-- Menus go app -->
    <?php if (($Module_ID == 20195)) { ?>
        <?= $this->partial('content/partials/placesMenusAdd') ?>
    <?php } ?>
  

    <!-- Video -->
    <?php if (($settings->MediaVideo == 1)) { ?>
    <div class="">
        <div class="form-group">
            <div class="col-md-12 col-xs-12">
                <div class="kv-group-title">
                    <h2><?php echo $translate->_("YouTube Videos"); ?></h2> 

                </div>
                
                <div class="input_fields_wrap add-new">
                    <div class=" col-xs-10"><input type="text" class="form-control" name="mediaVideos[]"></div>

                    <div class="actions">
                        <a class="add_field_button btn btn-default btn-sm">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i> &nbsp; 
                            <?php echo $translate->_("Add More"); ?>
                        </a>
                    </div>
                </div>
                <!-- <button class="add_field_button btn btn-edit-my-data dark gap">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i><?php echo $translate->_("Add More"); ?>
                        
                    </button> -->


            </div>
        </div>
    </div>
    <?php } ?>

    <!-- KV -->
    <?php if (($settings->KvInfo == 1)) { ?>
    <?= $this->partial('content/partials/keyvalue/new_kv', []) ?>        

    <?php } ?>
</div> <!--end main col-xs-8 -->

<div class="col-xs-3 bg-info"> <!-- side bar -->
    <!-- Active -->
    <?php if (($settings->Active == 1)) { ?>
    <div class="col-xs-12 no-padding gap">
        <!-- <div class="form-group">
            <label for="fieldActive" class="col-sm-5"><?php echo $translate->_("Active"); ?></label>
            <div class="col-sm-7">
                <?php echo $this->tag->selectStatic(["Active", array("1" => $translate->_("Yes"), "0" => $translate->_("No")), "class" => "form-control", "id" => "fieldActive",]) ?>
            </div>
        </div> -->       
       <div class="funkyradio"> 
           <div class="funkyradio-success">
                <input type="checkbox" id="Active" name="Active" value="Y" checked="checked">   
                <label for="Active"><?php echo $translate->_("Active"); ?></label>
            </div> 
        </div>
    </div>
    <?php } ?>

    <!-- Img -->
    <?php if (($settings->Img == 1)) { ?>
    <div class="col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Main Picture"); ?></h2></div>
            <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg", "required"=>"required"]) ?>
        </div>
    </div>
    <?php } ?>

    <!-- Depts -->
    <?php if (($settings->Depts == 1)) { ?>
    <div class="col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Departments"); ?></h2></div>
            <div class="dept_tree">
                <ul>
                    <?php
                    $cats = new \Models\Content();
                    $main_depts = DataCmsDepts::find(array("Module_ID={$Module_ID}"));
                    if(count($main_depts)>0){
                        foreach ($main_depts as $main_dept) {
                    if($main_dept->ID==30){continue;}
                            ?>
                            <div>
                                <?php
                                echo $main_dept->Title
                                ?>
                            </div>
                            <?php
                            $cats->buildTree(\DataCmsDeptsRel::find([
                                "Core_Depts_ID=" . $main_dept->ID
                    ]), 0,$lang);
                        }
                    }
                    ?>
                </ul>
            </div>
        </div>
    </div>
    <?php } ?>
    
    <!-- Special Cases -->
    <?php if (($this->session->get('auth-identity')['Application_ID'] == 593)) { ?>
    <div class="col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Zones"); ?></h2></div>
            <div class="dept_tree">
            	   <?php 
            	   echo \Phalcon\Tag::select(array(
    "zones",
    $zones,
    
    "class" => "form-control",
    ));
            	   ?>
            </div>
        </div>
    </div>
    <?php } ?>
    <?php if (($this->session->get('auth-identity')['is_admin'] == 1)) { ?>
    <div class="col-xs-12">
        <div class="form-group">
            <div class="kv-group-title"><h2><?php echo $translate->_("Order"); ?></h2></div>
            </div>
            <?php echo $this->tag->textField(["Order", "size" => 1, "class" =>
                        "form-control", "id" => "fieldOrder","value"=>"0"]) ?>
     </div>
     <div class="clearfix"></div>
    <?php } ?>    
   </div>
    
    
    
</div>

    <div class="col-sm-12">
        <div class="form-group">
        	<input type="hidden" name="isParent" value="<?= $parent ?>" />
            <?php echo $this->tag->submitButton(["Save", "class" => "btn green-jungle", "value"=>$translate->_("Save") ]) ?>
    <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn green-jungle" id="post"/>-->
    <!--        <input type='button' value='Test' class="btn green-jungle" id="testpost"/>-->
            <div class="testpost"></div>
        </div>
    </div>

</div>





<!-- End Form -->
<?php echo $this->tag->hiddenField("ID") ?>
<?php echo $this->tag->hiddenField("Module_ID") ?>
    <!-- Is All Languages Are Required ? -->
    <?php if (($this->session->get('auth-identity')['Application_ID'] == 593)) { ?>
        <input type="hidden" name="LangsRequired" value="1"/>
    <?php } else { ?>
        <input type="hidden" name="LangsRequired" value="0"/>
    <?php } ?>
    <!-- END OF  Is All Languages Are Required ? -->

    <?php echo $this->tag->endForm(); ?>
<div class="clearfix"></div>
</div>


<!--end tabs-->
<hr>
<script>
    // Wait for the DOM to be ready
    $(function() {

        // Initialize form validation on the registration form.
        // It has the name attribute "registration"
        $.validator.setDefaults({
            ignore: []
        });
        $("#newContent<?= $Module_ID ?>").validate({
            rules: {
               
                Title: {
                    required: true,
                },
                Content: {
                    //required: true,
                },
                Des: {
                    required: true,
                },
            }

        });
    });
</script>


