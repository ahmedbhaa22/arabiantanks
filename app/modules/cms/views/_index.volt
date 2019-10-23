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

<?php if ($Toggle_Grid == 0): ?>
    <div class="portlet light bordered">

        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="icon-user font-dark"></i>
                <span class="caption-subject bold uppercase"> <?php echo $translate->_("Content"); ?></span>
            </div>

            <div class="actions">
                <a type="button" href="{{url('content/new/') ~Module_ID}}" data-toggle="modal"
                   class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                    <?php echo $translate->_("New Content"); ?>
                </a>

            </div>

            <div class="actions">
                <a type="button" href="{{url('content/advancedSearch/') ~Module_ID}}" data-toggle="modal"
                   class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                    <?php echo $translate->_("Advanced Search"); ?>
                </a>
            </div>

            <div class="actions">
                <a type="button" href="#" id="filter-toggle-btn" class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                    {{ translate._("Filter") }}
                </a>
            </div>

        </div>


        <div class="row">
            <div class="col-md-2 col-sm-2">
                <a type="button" href="{{ url('content/toggleDisplay/') ~Module_ID}}&Toggle_Grid=0" data-toggle=""
                   class="">
                    <i class="fa fa-bars fa-2" aria-hidden="true" style="color:red"></i>
                </a>
                <a type="button" href="{{ url('content/toggleDisplay/') ~Module_ID}}&Toggle_Grid=1" data-toggle=""
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
                    <form method="POST" action="{{ url('content/filterContent/') }}" enctype="multipart/form-data">
                        <div class="col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-2 bg-info"><?php echo $translate->_("Content Contains"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField(["Content", "size" => 30, "class" => "form-control", "id" => "fieldTitle",]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-12 col-xs-12">
                            <div class="form-group">
                                <label for="fieldTitle" class="col-sm-2 bg-info"><?php echo $translate->_("Title Contains"); ?></label>
                                <div class="col-sm-10">
                                    <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle",]) ?>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-xs-6">
                            <div class="form-group">
                                <label for="fieldActive" class="col-sm-2 bg-info"><?php echo $translate->_("Departments"); ?></label>
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
                                            ]), 0);
                                        }

                                        ?>
                                    </ul>

                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xs-6">
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Date From"); ?></label>
                                    <div class="col-md-10 col-sm-10">
                                        <input type="text" name="date_from" id="date_from" />
                                    </div>
                                </div>

                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <label class="control-label col-md-2 bg-info col-sm-2"><?php echo $translate->_("Date To"); ?></label>
                                    <div class="col-md-10 col-sm-10">
                                        <input type="text" name="date_to" id="date_to" />
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="clearfix"></div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <input type="hidden" name="Module_ID" value="<?php echo $Module_ID ?>"/>
                                <?php echo $this->tag->submitButton(["Search", "class" => "btn btn-default", "value" => $translate->_("Search")]) ?>
                                <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn btn-default" id="post"/>-->
                                <!--        <input type='button' value='Test' class="btn btn-default" id="testpost"/>-->
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
                            id="sample_1" role="grid" aria-describedby="sample_1_info">
                            <thead>
                            <tr role="row">
                                <th class="sorting">
                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                        <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample_1 .checkboxes">
                                        <span></span>
                                    </label></th>
                                <th class="sorting"><?php echo $translate->_("Main Picture"); ?></th>
                                <th class="sorting"><?php echo $translate->_("Title"); ?></th>
                                <th class="sorting"><?php echo $translate->_("Desc"); ?></th>
                                <th class="sorting"><?php echo $translate->_("OrderBy"); ?></th>

                                <th class="sorting"><?php echo $translate->_("Visitors Count"); ?></th>
                                <th class="sorting"><?php echo $translate->_("Date"); ?></th>
                                <th class="sorting"><?php echo $translate->_("Time"); ?></th>
                                <th class="sorting"><?php echo $translate->_("Active"); ?></th>
                                <!--                        --><?php
                                //                        foreach ($main_depts as $main_dept):
                                //                            ?>
                                <!--                            <th class="sorting">-->
                                <?php //echo $main_dept->Title; ?><!--</th>-->
                                <!--                            --><?php
                                //                        endforeach;
                                //                        ?>


                                <th class="sorting"><?php echo $translate->_("Edit/Delete"); ?></th>

                            </tr>
                            </thead>
<!--                            <tfoot>-->
<!--                            <tr>-->
<!--                                <th class=""></th>-->
<!--                                <th class=""></th>-->
<!--                                <th class="filter"></th>-->
<!--                                <th class="filter"></th>-->
<!--                                <th class="filter"></th>-->
<!--                                <th class="filter"></th>-->
<!--                                <th class="filter"></th>-->
<!--                                <th class="filter"></th>-->
<!--                                <th class="filter"></th>-->
<!--                                <th class=""></th>-->
<!--                            </tr>-->
<!--                            </tfoot>-->
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
<?php endif; ?>
<!------ End OF List ------->


<?php if ($Toggle_Grid == 1): ?>
    <div class="portlet light bordered">

        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="icon-user font-dark"></i>
                <span class="caption-subject bold uppercase"> <?php echo $translate->_("Content") ?></span>
            </div>

            <div class="actions">
                <a type="button" href="{{url('content/new/') ~Module_ID}}" data-toggle="modal"
                   class="btn btn-edit-my-data green-jungle btn-outline   btn-block">
                    <?php echo $translate->_("New Content") ?>
                </a>
            </div>

        </div>


        <div class="row">
            <div class="col-md-2 col-sm-2">
                <a type="button" href="{{ url('content/toggleDisplay/') ~Module_ID}}&Toggle_Grid=0" data-toggle=""
                   class="">
                    <i class="fa fa-bars fa-2" aria-hidden="true" style="color:red"></i>
                </a>
                <a type="button" href="{{ url('content/toggleDisplay/') ~Module_ID}}&Toggle_Grid=1" data-toggle=""
                   class="">
                    <i class="fa fa-th-large fa-2" aria-hidden="true" style="color:red"></i>
                </a>
            </div>
            <div class="col-md-2 col-sm-2">

            </div>
        </div>

        <div class="portlet-body">
            <div class="row">

            </div>
            <div id="sample_1_wrapper">

                    <div class="all-building-slider">
                        <div class="swiper-container ">
                            <div class="swiper-wrapper">
                                <!---slide---->
                                <?php foreach ($page->items as $content): ?>
                                    <div class="swiper-slide">
                                        <a href="{{url('content/edit/')}}<?php echo $content->ID ?>">
                                            <div class="img-container"
                                                 style="background: url('<?php echo $base_uri . "uploads/" . $content->Img ?>') center center no-repeat ; background-size: cover; ">
                                                <!--<img src="http://activelearningps.com/wp-content/uploads/2013/10/glass-building.jpg">-->
                                            </div>
                                            <div class="black-fade"
                                                 style="background: url('img/fade-black.png') center center repeat-x ; background-size: contain; "></div>
                                            <h3 class="title-block green-jungle"><?php echo $content->Title ?> </h3>
                                        </a>

                                        <div class="btn-group dropup button-over-block">
                                            <a class="dropdown-toggle" data-toggle="dropdown">
                                                <img src="{{url('ropo_app/')}}img/three-dots.png" height="30">
                                            </a>
                                            <ul class="dropdown-menu pull-right" role="menu">

                                                <li>
                                                    <a href="{{url('content/edit/')}}<?php echo $content->ID ?>">
                                                        <?php echo $translate->_("Edit") ?></a></li>

                                                <li>
                                                    <a class="delete-general"
                                                       href="{{url('content/edit/')}}<?php echo $content->ID ?>">
                                                        <?php echo $translate->_("Delete") ?> </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                <?php endforeach; ?>

                            </div>

                        </div>

                    </div>
                    <div class="clearfix"></div>


                <div class="row">
                    <div class="col-md-5 col-sm-5">
                        <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                            <?php echo $page->current, "/", $page->total_pages ?>
                        </div>
                    </div>
                    <div class="col-md-7 col-sm-7">
                        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                            <ul class="pagination" style="visibility: visible;">
                                <li><?php echo $this->tag->linkTo("content/index/$Module_ID", $translate->_("First")) ?></li>
                                <li><?php echo $this->tag->linkTo("content/index/$Module_ID?page=" . $page->before, $translate->_("Back")) ?></li>
                                <li><?php echo $this->tag->linkTo("content/index/$Module_ID?page=" . $page->next, $translate->_("Next")) ?></li>
                                <li><?php echo $this->tag->linkTo("content/index/$Module_ID?page=" . $page->last, $translate->_("Last")) ?></li>
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
<?php endif; ?>
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








