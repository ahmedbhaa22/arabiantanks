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
            <span class="caption-subject bold uppercase"> <?php echo $translate->_("APIs Manager"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('api_manager/new/')}}" data-toggle="modal"
               class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                <?php echo $translate->_("Api Add"); ?>
            </a>

        </div>

    </div>
    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <p><?php $this->flashSession->output() ?></p>

            <div class="clearfix"></div>

            <form action="{{url('api_manager/save')}}" method="post" enctype="multipart/form-data">
            <div class="row">
                {% for row in content.ScreenMain.Screens %}
                <img class="contentImg" src="{{ url('uploads/') ~row.media}}"/>
                <div class="form-group">
                    <label for="fieldFailResponse" class="col-sm-2 control-label">Update Image</label>
                    <div class="col-sm-10">
                        <input type="file" name="media{{row.id}}" />
                    </div>
                </div>
                {% endfor %}
            </div>
                <div class="clearfix"></div>
            <div class="row">
                <div class="form-group">
                    <label for="fieldFailResponse" class="col-sm-2 control-label">Success Response</label>
                    <div class="col-sm-10">
                        <textarea rows="4" cols="50" name="success_response">
                           {{content.success_response}}
                       </textarea>

                    </div>
                </div>
                <div class="form-group">
                    <label for="fieldFailResponse" class="col-sm-2 control-label">Fail Response</label>
                    <div class="col-sm-10">
                        <textarea rows="4" cols="50" name="fail_response">
                           {{content.fail_response}}
                       </textarea>

                    </div>
                </div>
                <div class="form-group">
                    <label for="fieldFailResponse" class="col-sm-2 control-label">Empty Response</label>
                    <div class="col-sm-10">
                        <textarea rows="4" cols="50" name="empty_response">
                           {{content.empty_response}}
                       </textarea>

                    </div>
                </div>
                <div class="form-group">
                    <label for="fieldFailResponse" class="col-sm-2 control-label">Title</label>
                    <div class="col-sm-10">
                        <textarea rows="4" cols="50" name="{{title}}">
                           {{content.title}}
                       </textarea>


                    </div>
                </div>
                <div class="form-group">
                    <label for="fieldFailResponse" class="col-sm-2 control-label">Des</label>
                    <div class="col-sm-10">
                        <input name="des" type="text" value="{{content.des}}"/>

                    </div>
                </div>
                <div class="form-group">
                    <label for="fieldFailResponse" class="col-sm-2 control-label">Api link</label>
                    <div class="col-sm-10">
                       <textarea rows="5" cols="50" name="api_link">
                           {{content.api_link}}
                       </textarea>
                    </div>
                </div>


                <input type="hidden" value="{{content.id}}" name="id" />

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <?php echo $this->tag->submitButton(["GO", "class" => "btn btn-default"]) ?>
                    </div>
                </div>

            </div>
            </form>

        </div>
    </div>
    <style>
        .contentImg {
            height: 25%;
            width: 25%;
        }
    </style>
</div>

<style>
    #sample_1 tfoot th.filter input {
        width: 100px;
        height: 25px;
    }
</style>

<!------ End OF List ------->

<script type="text/javascript">
    $(document).ready(function () {
        $('#date_from').datepicker({
            format: "yyyy-mm-dd"
        });
        $('#date_to').datepicker({
            format: "yyyy-mm-dd"
        });
    });

</script>








