  <div class="page-bar " style="position: relative">
            <ul class="page-breadcrumb"><!-- 
                <li>
                    <a href="index.html">C</a>
                    <i class="icon-arrow-left"></i>
                </li> -->
                <li>
                    <span>Notification</span>
                </li>
            </ul>

        </div>

<!-- END PAGE TITLE-->
<!-- END PAGE HEADER-->
<div class="row">
    <div class="col-lg-12">
        <div class=" ">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                    <?php if ($settings->banner_image) { ?>
                    <div class=""
                         style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic($settings->banner_image) ?>) center center no-repeat ; background-size: contain"></div>
                    <?php } else { ?>
                    <div class=""
                         style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic('img/notification.png') ?>) center center no-repeat ; background-size: contain"></div>
                    <?php } ?>
                </div>

            </div>
        </div>

    </div>

    <div class="col-md-12">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="fa fa-bell" aria-hidden="true"></i>
                    <span class="caption-subject bold uppercase">
                        <?= $translate->_('Notifications') ?>
                    </span>
                </div>

                <div class="actions btn-group btn-group-lg btn-group-solid margin-bottom-10 ">
                    <!-- <a type="button" data-target="#new_notification" data-toggle="modal" class="btn btn-edit-my-data dark  ">
                        <?= $translate->_('New Notification') ?>
                    </a> -->
                    <a type="button" href="<?= $this->url->get('index/create') ?>" class="btn btn-edit-my-data dark  ">
                        <?= $translate->_('New Notification') ?>
                    </a>
                    <a type="button" href="<?= $this->url->get('settings') ?>" class="btn btn-edit-my-data dark  ">
                        <?= $translate->_('Settings') ?>
                    </a>
                </div>

            </div>
            <div class="portlet-body">
                <table class="table table-striped table-bordered table-hover table-checkable order-column"
                                   id="sample_1">
                    <thead>
                        <tr>
                            <!-- <th>
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable"
                                           data-set="#sample_1 .checkboxes"/>
                                    <span></span>
                                </label>
                            </th> -->
                            <th> الرسالة  </th>
                            <th> الأجهزة </th>
                            <th> عدد الأجهزة </th>
                            <th>  موديول </th>
                            <th>صفحة</th>
                            <th>تاريخ الإرسال</th>
                            <th> تاريخ الانتهاء </th>
                        </tr>
                    </thead>
                    <tbody>

                        <?php foreach ($notifications as $note) { ?>
                        <tr class="odd gradeX">
                            <!-- <td>
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="checkboxes" value="1"/>
                                    <span></span>
                                </label>
                            </td> -->

                            <td><?= $note->Message ?></td>

                            <td>
                                <?php $types = explode(",", $note->notification_type); ?>
                                <?php foreach ($types as $type) { ?>
                                <i class="fa fa-<?= $note->getFAIcon($type) ?>"></i>
                                <?php } ?>
                                <!-- <i class="fa fa-apple"></i> -->

                            </td>

                            <td class="center">
                                
                            </td>

                            <td>
                                <?php if ($note->module) { ?>
                                <?= $note->module->Title ?>
                                <?php } ?>
                            </td>
                            <td>
                                <?php if ($note->topic) { ?>
                                <?= $note->topic->title ?>
                                <?php } ?>
                            </td>
                            <td>
                                <?php if ($note->Send_Time) { ?>
                                <?php echo date("Y-m-d h:i a", (int)($note->Send_Time)); ?>
                                <?php } ?>
                            </td>

                            <td>
                                <?php if ($note->Finished_Time) { ?>
                                <?php echo date("Y-m-d h:i a", (int)($note->Finished_Time)); ?>
                                <?php } ?>
                            </td>
                        </tr>
                        <?php } ?>

                    </tbody>
                </table>
                <!-- <div class="btn-group">
                    <button class="btn  dark dropdown-toggle" type="button" data-toggle="dropdown"
                            aria-expanded="false"> إجراءات على المحدد
                        <i class="fa fa-angle-down"></i>
                    </button>
                    <ul class="dropdown-menu" role="menu">

                        <li>
                            <a href="javascript:;" class="delete-general">
                                <i class="icon-user"></i> حذف المحدد </a>
                        </li>

                    </ul>
                </div> -->
            </div>
        </div>
        <!-- END EXAMPLE TABLE PORTLET-->

    </div>
</div>
<!-- END PAGE HEADER-->
<!-- BEGIN DASHBOARD STATS 1-->

<div class="clearfix"></div>
<!-- END DASHBOARD STATS 1-->

<!-- Modal _ new Data -->
<div class=" new-client modal fade" id="new_notification" tabindex="-1" >
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header hidden-xs">
                <div class="   col-xs-12 ">
                    <div class="" style="width: 100%; min-height: 100px; overflow: hidden ; background: url('img/new-clients.png') center center no-repeat ; background-size: contain"></div>
                </div>
            </div>
            <form role="form" action="index/store" id="send_notification" method="post">
                <div class="modal-body" >
                        <div class="sample_1_wrapper">
                            <div class="col-md-6 no-pad col-xs-12">
                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><?= $translate->_('Module') ?></label>
                                    <div class="col-sm-9">
                                    <select name="module_id" id="module" class="form-control" onchange="fetch_select(this.value)">
                                        <option value=""><?= $translate->_('Choose Module') ?></option>
                                        <?php foreach ($modules as $module) { ?>
                                            <option value="<?= $module->ID ?>"><?= $module->Title ?></option>
                                        <?php } ?>
                                    </select>
                                        </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label"></label>
                                    <div class="col-sm-9" id="ModuleDepts">

                                    </div>
                                </div>



                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><?= $translate->_('Choose Topic') ?></label>
                                    <div class="col-sm-9">
                                    <select name="topic_id" id="topics">

                                    </select>
                                        </div>
                                </div>



                                <div class="form-group ">
                                    <label class="col-sm-3 control-label"><?= $translate->_('Choose Message') ?></label>
                                    <div class="col-sm-9">
                                    <input type="text" placeholder="message" value="" name="message" class="form-control" required/>
                                        </div>
                                </div>


                                <div class="form-group ">
                                    <label class="col-sm-3 control-label"><?= $translate->_('Age') ?></label>
                                    <div class="col-sm-9">
                                    <input type="number" value="" name="age" class="form-control" required/>
                                        </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-3 control-label"><?= $translate->_('Choose Notification Type') ?></label>
                                    <div class="col-sm-9">
                                        <select name="notification_type[]" id="notification_type" required>
                                            <option value="1"><?= $translate->_('Android') ?></option>
                                            <option value="2"><?= $translate->_('iOS') ?></option>
                                            <option value="3"><?= $translate->_('Mail') ?></option>
                                            <option value="4"><?= $translate->_('Message') ?></option>
                                            <option value="5"><?= $translate->_('Chrome') ?></option>
                                        </select>
                                    </div>
                                </div>

                        </div>
                        <!-- END of Col Right -->
                        <div class="col-md-6 no-pad col-xs-12">

                                <div class="form-group funkyradio">
                                    

                                    <div class="funkyradio-success col-sm-6 col-xs-12">
                                        <input type="checkbox" name="male" id="male"  class="form-control"  value="1"/>
                                        <label for="male"><?= $translate->_('Male') ?></label>
                                    </div>

                                    <div class="funkyradio-success col-sm-6 col-xs-12">
                                        <input type="checkbox" name="female" id="female"  class="form-control"  value="1" />
                                        <label for="female"><?= $translate->_('Female') ?></label>
                                    </div>

                                    <!-- <div class="funkyradio-success col-sm-6 col-xs-12">
                                        <input type="checkbox" name="like" id="like"  class="form-control" required/>
                                        <label for="like"><?= $translate->_('Like') ?></label>
                                    </div>

                                    <div class="funkyradio-success col-sm-6 col-xs-12">
                                        <input type="checkbox" name="favourite" id="favourite"  class="form-control" required/>
                                        <label for="favourite"><?= $translate->_('Favourite') ?></label>
                                    </div> -->

                                </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label"><?= $translate->_('Send Time') ?></label>
                                <div class="col-sm-9">
                                    <input placeholder="Send time" id="send_time" name="send_time" class="form-control datepicker"/>
                                </div>
                            </div>

                        </div>
                        <!-- END of Col Left -->
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="submit" data-dismiss="modal" class="btn dark " value="<?= $translate->_('Cancel') ?>">
                    <input type="submit" class="btn green-jungle " value="<?= $translate->_('Send') ?>">
                </div>
            </form>
        </div>
    </div>

    <?= $this->tag->javascriptInclude('ropo_app/js/jquery.min.js') ?>
    <script type="text/javascript">
        function fetch_select(val)
        {
            $.ajax({
                type: 'post',
                url: main_url+'ads/getDepartmentsAjax',
                data: {
                    get_option:val
                },
                success: function (response) {
                    document.getElementById("ModuleDepts").innerHTML=response;
                }
            });
        }



        function autocompleteTest() {
            $('#auto_complete_content').autocomplete({
                serviceUrl: main_url+'/ads/getAjaxContentByModule/'+$("#module").val(),
                onSelect: function (suggestion) {
                    //alert('You selected: ' + suggestion.value + ', ' + suggestion.data);
                    $('#Content_ID').val(suggestion.data);
                }
            });
        }
        $("#send_notification").on('submit',function (e){
            if($('#auto_complete_content').val()==""){
                $('#Content_ID').val("");
            }
        });



    </script>
    <style>
        .autocomplete-suggestions { border: 1px solid #999; background: #FFF; overflow: auto; }
        .autocomplete-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; }
        .autocomplete-selected { background: #F0F0F0; }
        .autocomplete-suggestions strong { font-weight: normal; color: #3399FF; }
        .autocomplete-group { padding: 2px 5px; }
        .autocomplete-group strong { display: block; border-bottom: 1px solid #000; }
    </style>
</div>