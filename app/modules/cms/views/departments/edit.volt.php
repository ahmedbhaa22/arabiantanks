<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
                    <li>
                        <a href="<?= $this->url->get('users_application_module') ?>"><?php echo $translate->_("Main Page"); ?></a>
                        <i class="icon-arrow-left"></i>
                    </li>
                   <li>
                        <a href="<?= $this->url->get('departments/index/') . $main_department->ID ?>&Module_ID=<?= $module->ID ?>"><?= $main_department->Title ?></a>
                        <i class="icon-arrow-left"></i>
                    </li>
                    <li>
                        <a href=""><?php echo $translate->_("Edit"); ?></a> 
                        
                    </li>
                    
                </ul>
</div>
<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    tinymce.init({
        selector: '#fieldContent'
    });

</script>
<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>
<?php


?>
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?= $translate->_('Edit') ?></span>
        </div>

        <div class="actions">
<!--            --><?php //echo $this->tag->linkTo(["departments", "السابق"]) ?>
        </div>

    </div>


    <div class="container">
        <div class="row">
            <div class="col-sm-3">
                <title>Language</title>
                <select id="dynamic_select">
                    <option>Choose Language</option>
                    <option value="<?= $this->url->get('departments/edit/' . $ID) ?>">Default</option>
                    <?php foreach ($langs as $lang) { ?>
                    <option value="<?= $this->url->get('departments/edit/' . $ID) ?>?lang_id=<?= $lang->lang_id ?>"><?= $lang->LangDetails->title ?></option>
                    <?php } ?>
                </select>
            </div>

            <script>
                $(function(){
                    // bind change event to select
                    $('#dynamic_select').on('change', function () {
                        var url = $(this).val(); // get selected value
                        if (url) { // require a URL
                            window.location = url; // redirect
                        }
                        return false;
                    });
                });
            </script>
        </div>
        <p></p>
        <?php
        if(isset($_GET['lang_id'])){
            $save_url="departments/save"."?lang_id=".$_GET['lang_id'];
        }else{
            $save_url="departments/save";
        }
        echo $this->tag->form(
            [
                $save_url,
                "autocomplete" => "off",
                "class" => "form-horizontal paymentForm",
                "role" => "form",
                "style" => "display:block",
                "enctype" => "multipart/form-data"
            ]
        );
        ?>
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#1" data-toggle="tab"><?= $translate->_('Department Details') ?></a>
            </li>
            <li>
                <a href="#2" data-toggle="tab"><?= $translate->_('Other Options') ?></a>
            </li>

        </ul>

        <div class="tab-content ">
            <div class="tab-pane active" id="1">
                <div class="portlet-body">
                    <div id="sample_1_wrapper">
                        <div class="col-md-6 no-pad col-xs-12">
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-3 control-label"><?= $translate->_('Title') ?></label>
                                <div class="col-sm-9">
                                    <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle"]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xs-12">
                            <div class="form-group">
                                <label for="fieldContent" class="col-sm-3 control-label"><?= $translate->_('Details') ?></label>
                                <div class="col-sm-9">
                                    <?php echo $this->tag->textArea(["Des", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldDes"]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xs-12">
                            <div class="form-group">
                                <label for="fieldImg" class="col-sm-3 control-label"><?= $translate->_('Main Picture') ?></label>
                                <div class="col-sm-9">
                                    <?php echo $this->tag->fileField(["Img", "size" => 30, "class" => "form-control", "id" => "fieldImg"]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xs-12">
                            <div class="form-group">
                                <label for="fieldActive" class="col-sm-3 control-label"><?= $translate->_('Active') ?>ا</label>
                                <div class="col-sm-9">
                                    <?php echo $this->tag->selectStatic(["Active", array("1" => "نعم", "0" => "لا"), "class" => "form-control", "id" => "fieldActive"]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xs-12">
                            <div class="form-group">
                                <label for="fieldContent" class="col-sm-3 control-label"><?= $translate->_('Sort Order') ?></label>
                                <div class="col-sm-9">
                                    <?php echo $this->tag->textField(["Orders", "cols" => 30, "rows" => 4, "class" => "form-control", "id" => "fieldOrders"]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xs-12">
                            <div class="form-group">
                                <label for="fieldOrder" class="col-sm-3 control-label"><?= $translate->_('Main Department') ?></label>
                                <div class="col-sm-9">
                                    <?php echo Phalcon\Tag::select([
                                        "Core_Depts_ID",
                                        \DataCmsDepts::find("Module_ID={$Module_ID}"),
                                        "using" => ["ID", "Title"]]);
                                    ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 no-pad col-xs-12">
                            <div class="form-group">
                                <label for="fieldOrder" class="col-sm-3 control-label"><?= $translate->_('Parent Department') ?></label>
                                <div class="col-sm-9">
                                    <span>نعم</span>
                                    <?php
                                    echo Phalcon\Tag::radioField(array("Has_Parent", "value" => "yes")); ?>
                                    <span>لا</span>
                                    <?php
                                    echo Phalcon\Tag::radioField(array("Has_Parent", "value" => "no"))
                                    ?>
                                    <div class=row">
                                        <select name="Parent_Depts_ID">
                                            <?php foreach (\DataCmsDeptsRel::findWithLang($Module_ID, $main_department) as $dept): ?>
                                           <option id="<?= $dept['ID'] ?>"><?= $dept['Title'] ?></option>
                                         <?php endforeach;?>
                                        </select>

                                    </div>

                                </div>
                            </div>
                        </div>


                        <?php echo $this->tag->hiddenField("ID") ?>
                        <?php echo $this->tag->hiddenField("Application_ID") ?>
                        <?php echo $this->tag->hiddenField("Module_ID") ?>
                        <?php echo $this->tag->hiddenField("Lang_ID") ?>

                    </div>
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
                                <div class="kv-group-title"><h2><?php echo $data['GroupName'] ?></h2></div>
                                <?php
                                $groupname = $data['GroupName'];
                            endif;
                            ?>
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
                            <div class="col-sm-6">
                                <div class="form-group">

                                    <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Picture"); ?></label>
                                    <div class="col-sm-10">
                                        <?php echo $data['Img'] ; ?>
                                    </div>
                                </div>
                            </div>
                            <?php if($data['Add']==1): ?>
                            <input type="hidden" name="kvAddIDs[]" value="<?php echo $data['KV_ID'] ?>"/>
                        <?php endif; ?>
                        <?php endforeach; ?>

                    </div>

                </div>
            </div>


            <div class="form-group">
                <div class="col-sm-12">
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn btn-danger"]) ?>
                </div>
            </div>

            <?php echo $this->tag->endForm(); ?>

        </div>

    </div>
</div>
<script>
    // Wait for the DOM to be ready
    $(function() {

        // Initialize form validation on the registration form.
        // It has the name attribute "registration"
        $("#validateForm1").validate({
            rules: {
                Title: {
                    required:true
                },
                Des: {
                    required:true
                },
                Order: {
                    number: true,
                },
                //Key Value Validation(Dynamic)

            }

        });
    });
</script>