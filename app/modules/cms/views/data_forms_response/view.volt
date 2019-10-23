<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
//    tinymce.init({
//        selector: '#fieldReplay'
//    });;
</script>
<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */

?>

<div class="portlet light bordered">
    <div class="row">
    <div class="portlet-title modal-header">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">{{ translate._('Read Form And Reply') }}</span>
        </div>

        <div class="actions">

        </div>

    </div>
    <div class="portlet-body" style="display: block;">
        <div id="sample_1_wrapper">

            <p class="ajax-messages"><?php $this->flashSession->output() ?></p>
            <div class="col-md-12 col-xs-12 nopadding-r nopadding-l">
                <div class="col-md-6 col-xs-12 no-pad" style="padding:0;"> <!--col right-->

                    <?php foreach($Response as $key=>$value): ?>                  
                    <div class="col-md-12 col-xs-12">
                        {%if key == "IP"%}
                        {%continue%}
                        {%endif%}
                        <div class="form-group">
                            <label for="fieldTitle" class="col-sm-2 bg-info"><?php echo $translate->_($key); ?></label>
                            <div class="col-sm-10 row-bordered">
                                <?php echo $value ?>
                            </div>
                        </div>
                    </div>
                    <?php endforeach; ?>



                </div><!--end col right-->
                <div class="clearfix"></div>

            </div>

            <?php
            $reply = CpFormsReplies::findFirst(
                array(
                    "Forms_Response = {$ID}"
                )
            );
            if(!$reply):
            ?>

            <div  id ="replyForm" class="col-md-12 col-xs-12 nopadding-r nopadding-l">
                <?php
                echo $this->tag->form(
                    [
                        "DataFormsResponse/replayform",
                        "autocomplete" => "off",
                        "class" => "form-horizontal ",
                        "id" => "form_reponse_replay",
                        "role" => "form",
                        "style" => "display:block",
                        "enctype" => "multipart/form-data"
                    ]
                );
                ?>
                <div class="form-group col-md-12 col-sm-12">
                    <label for="fieldreplay" class="col-sm-2 bg-info">{{ translate._('Reply') }}</label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["Replay", "size" => 200, "class" => "form-control", "id" => "fieldReplay","required"=>"required"]) ?>
                    </div>
                </div>
                <div class="form-group col-md-12 col-sm-12">
                    <label for="fieldEMail" class="col-sm-2 bg-info">{{ translate._('E-Mail') }}</label>
                    <div class="col-sm-10 text-center">

                        <?php echo $this->tag->textField(["EMail", "size" => 30, "class" => "form-control", "id" => "fieldEmail", "value"=>$mail_send,"required"=>"required"]) ?>

                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-12">
                        <?php echo $this->tag->hiddenField(["ID","ID"=>"ID"]) ?>
                        <?php echo $this->tag->submitButton([$translate->_('Send'), "class" => "btn btn-danger"]) ?>
                    </div>
                </div>
                <?php echo $this->tag->endForm(); ?>

            </div>
            </div>
            <div class="clearfix"></div>
            <?php
            else:
             ?>

                 <div id="replayText" class=" bg-info form-group panel panel-default">
                    <div class="panel-body col-md-12 col-sm-12">
                        <?php echo $reply->Replay ?>
                     </div>
                 </div>

             <?php
             endif;
             ?>

          </div>
        </div>
    </div>
    </div>
{{ javascript_include("js/form_response_replay.js") }}
