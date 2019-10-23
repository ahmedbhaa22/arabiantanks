<!--<h3 class="page-title">-->
<!--    <small></small>-->
<!--</h3>-->
<!-- END PAGE TITLE-->
<!-- END PAGE HEADER-->
<div class="row">
    <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
        <div class=""
             style="width: 100%; min-height: 180px; overflow: hidden ; background: url('img/notification.png') center center no-repeat ; background-size: contain"></div>
    </div>

    <div class="col-md-12">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="icon-settings font-dark"></i>
                    <span class="caption-subject bold uppercase">Notifications </span>
                </div>
                <div class="actions">
                    <!--<button type="button" class="btn btn-edit-my-data green-jungle btn-outline  btn-sm btn-block">  إضافة موظف جديد</button>-->

                    <!--<div class="btn-group btn-group-devided" data-toggle="buttons">-->
                    <!--<label class="btn btn-transparent dark btn-outline btn-circle btn-sm active">-->
                    <!--<input type="radio" name="options" class="toggle" id="option1">Actions</label>-->
                    <!--<label class="btn btn-transparent dark btn-outline btn-circle btn-sm">-->
                    <!--<input type="radio" name="options" class="toggle" id="option2">Settings</label>-->
                    <!--</div>-->
                </div>
            </div>
            <div class="portlet-body">
                <!--BEGIN TABS-->
                <div class="tab-content">
                    <div class="tab-pane active" id="tab_1_1">
                        <div class="scroller" style="height: 410px;" data-always-visible="1"
                             data-rail-visible1="0" data-handle-color="#D7DCE2">
                            <ul class="feeds">
                                {%for item in notifications%}
                                <?php
                                $user_check=\Models\UsersMobile::findFirst(["ID={$item->user_id}"]);
                                if(!$user_check){
                                    $item->delete();
                                    continue;
                                }
                                ?>
                                <li>
                                    <div class="col1">
                                        <div class="cont">
                                            <div class="cont-col1">
                                                <div class="label label-sm label-info">
                                                    <i class="icon-key "></i>
                                                </div>
                                            </div>
                                            <div class="cont-col2">
                                                <div class="desc">
                                                    {{item.content}}
                                                    <a href="#"></a>
                                                    By
                                                    <a href="#">{{item.to.Mail}}</a></div>

                                               <a href="{{this.url_shared.get('' ~item.url)}}&notifi={{item.id}}">Confirm</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col2">
                                        <div class="date"><?php echo date('Y-m-d G:i:s', $item->time) ?></div>
                                    </div>

                                </li>
                                {%endfor%}



                            </ul>
                        </div>
                    </div>

                </div>
                <!--END TABS-->
            </div>
        </div>
        <!-- END EXAMPLE TABLE PORTLET-->

    </div>
</div>
<!-- END PAGE HEADER-->
<!-- BEGIN DASHBOARD STATS 1-->

<div class="clearfix"></div>