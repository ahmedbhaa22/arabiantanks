<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">
        
        <div class="page-bar " style="position: relative">
            <ul class="page-breadcrumb"><!-- 
                <li>
                    <a href="index.html">C</a>
                    <i class="icon-arrow-left"></i>
                </li> -->
                <li>
                    <span><?php echo $translate->_("Messaging System"); ?></span>
                </li>
            </ul>

        </div>

        <!-- BEGIN PAGE HEADER-->
        <!-- BEGIN THEME PANEL -->

        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <?php if ($settings->banner_image) { ?>
                <div class=""
                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic($settings->banner_image) ?>) center center no-repeat ; background-size: contain"></div>
                <?php } else { ?>
                <div class=""
                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic('img/sms.png') ?>) center center no-repeat ; background-size: contain"></div>
                <?php } ?>
            </div>

        </div>

        <!-- END THEME PANEL -->
        <!-- BEGIN PAGE BAR -->
        
        <div class="clearfix"></div>
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="fa fa-comments-o" aria-hidden="true"></i>
                    <span class="caption-subject bold uppercase">
                       <?php echo $translate->_("Messaging System"); ?>
                    </span>
                </div>
                
            </div>
            <div class="portlet-body">

                    <!-- <div class="bar clearfix">
                        <div class="col-lg-3 col-md-3 col-xs-6 main-block text-center ">
                            <a href="tracking.html" class="bg-blue-madison">
                                Category 1
                            </a>
                        </div>

                        <div class="col-lg-3 col-md-3 col-xs-6 main-block text-center ">
                            <a href="orders.html" class="bg-purple">
                                 Category 2
                            </a>
                        </div>

                        <div class="col-lg-3 col-md-3 col-xs-6 main-block text-center ">
                            <a href="view-client.html" class="bg-yellow-soft">
                                Category 3
                            </a>
                        </div>

                        <div class="col-lg-3 col-md-3 col-xs-6 main-block text-center ">
                            <a href="final-report.html" class="bg-red-thunderbird">
                                Category 4
                            </a>
                        </div>
                    </div>
 -->
                <div class="col-sm-2 col-xs-12">
                    <?= $this->partial('shared/side_menu') ?>
                </div>
                <div class="col-sm-10 col-xs-12 bordered">
                    <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
                        <thead>
                        <tr>
                            <th style="width: 2%;">
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable"
                                           data-set="#sample_1 .checkboxes"/>
                                    <span></span>
                                </label>
                            </th>
                            <th style="width: 60%"> عنوان الرسالة</th>
                            <th > مرسل من</th>
                            <th> تاريخ </th>
                            <th> إجراءات</th>
                        </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($messages as $msg) { ?>
                            <tr class="odd gradeX">
                                <td>
                                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                        <input type="checkbox" name="msg_id[]" class="checkboxes" value="<?= $msg->ID ?>"/>
                                        <span></span>
                                    </label>
                                </td>

                                <td><a href="<?= $this->url->get('index/view/') . $msg->ID ?>"><?= strip_tags($msg->message->subject) ?></a></td>

                                <td>
                                    <?php if ($msg->sender != false) { ?>
                                    <?= $msg->sender->Title ?>
                                    <?php } ?>
                                </td>

                                <td class="center"> <?= date('Y-m-d', $msg->message->DateTime) ?></td>

                                <td>
                                    <div class="btn-group">
                                        <!-- <button class="btn btn-xs dark dropdown-toggle" type="button"
                                                data-toggle="dropdown" aria-expanded="false"> إجراء
                                            <i class="fa fa-angle-down"></i>
                                        </button>
                                        <ul class="dropdown-menu" role="menu">
                                            <li>
                                                <a href="index/view/<?= $msg->ID ?>">
                                                    <i class="icon-docs"></i> مشاهده </a>
                                            </li>

                                            <li>
                                                <a onclick="deleteMessage(<?= $msg->ID ?>)">
                                                    <i class="icon-user"></i> حذف </a>
                                            </li>
                                        </ul> -->

                                        <a href="<?= $this->url->get('index/view/') . $msg->ID ?>" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                                        <a onclick="deleteMessage(<?= $msg->ID ?>)" class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </a>
                                    </div>
                                </td>
                            </tr>
                            <?php } ?>
                        </tbody>
                    </table>

                    <div class="btn-group">
                        <a onclick="multideleteMessage()" class="btn btn-xs btn-danger">
                            <i class="fa fa-trash-o" aria-hidden="true"></i> حذف المحدد
                        </a>

                        <!-- <button class="btn  dark dropdown-toggle" type="button" data-toggle="dropdown"
                                aria-expanded="false"> إجراءات على المحدد
                            <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu" role="menu">

                            <li>
                                <a href="javascript:;" class="delete-general">
                                    <i class="icon-user"></i> حذف المحدد </a>
                            </li>

                        </ul> -->
                    </div>
                
                    <div class="clearfix"></div>
                    
                </div>
                
            </div>
        </div>
        
        <!-- END DASHBOARD -->

    </div>
    <!-- END CONTENT BODY -->
</div>

<script type="text/javascript">
function deleteMessage(id) {
    if(confirm("Are you sure you want to delete this message?")){
        window.location = "<?= $this->url->get('index/delete') ?>" + "/" + id;
    }
}

function multideleteMessage() {
    var values = $("input[name='msg_id[]']:checked").map(function () {
      return this.value;
    }).get();
    if(!values.length){
        alert('الرجاء اختيار رسالة اولا');
        return;
    }
    if(confirm("هل انت متأكد من حذف هذه الرسائل")){

        console.log(values);
        window.location = "<?= $this->url->get('index/deleteMultiple?msgs=') ?>" + JSON.stringify(values);
    }
}
</script>