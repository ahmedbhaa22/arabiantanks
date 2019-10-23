
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
<?php

?>


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
            <span class="caption-subject bold uppercase">{{ translate._("Import Data")}}</span>
        </div>

        <div class="actions">
            <a type="button" href="{{ url('import_data/index/' ~Module_ID)}}" id="" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                {{ translate._("Back") }}
            </a>
        </div>

    </div>



    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="row col-sm-12" id="">
                <form method="POST" action="{{ url('import_data/edit/') ~ID}}" enctype="multipart/form-data">
                    <div class="col-md-6 col-xs-12">
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Source"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php
                                    echo $this->tag->select(
                                        [
                                            "Dept",
                                            $depts_sources,
                                            "using" => [
                                                "ID",
                                                "Title",
                                            ],
                                            "class"=>"form-control",

                                        ]
                                    );
                                    ?>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Name"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php echo $this->tag->textField(["Name", "type" => "text", "class" => "form-control", "id" => ""]) ?>
                                </div>
                            </div>

                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Data"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php echo $this->tag->textField(["Data", "type" => "text", "class" => "form-control", "id" => ""]) ?>
                                </div>
                            </div>

                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Type"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php
                                    echo $this->tag->select(
                                        [
                                            "Type",
                                            $source_types,
                                            "using" => [
                                                "ID",
                                                "Title",
                                            ],
                                            "class"=>"form-control",
                                        ]
                                    );
                                    ?>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Order Data"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php
                                    echo $this->tag->select(
                                        [
                                            "Order",
                                            $order_types,
                                            "using" => [
                                                "ID",
                                                "Order_Title",
                                            ],
                                            "class"=>"form-control",
                                        ]
                                    );
                                    ?>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Operating Menu"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php echo $this->tag->textField(["op_menu", "type" => "text", "class" => "form-control", "id" => ""]) ?>
                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="col-md-12">
                                <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Content"); ?></label>
                                <div class="col-md-10 col-sm-10">
                                    <?php echo $this->tag->textField(["Content", "type" => "text", "class" => "form-control", "id" => ""]) ?>
                                </div>
                            </div>

                        </div>


                    </div>
                    <div class="form-group">
                        <div class="col-md-12 col-xs-12">
                            <input type="hidden" value="{{Module_ID}}" name="module"/>
                            <input type="hidden" value="{{ID}}" name="ID"/>
                            <input type="submit" value="<?php echo $translate->_("Save"); ?>" class="btn btn-default">
                        </div>
                    </div>
                </form>
            </div>
            <div class="clearfix"></div>


        </div>
    </div>
