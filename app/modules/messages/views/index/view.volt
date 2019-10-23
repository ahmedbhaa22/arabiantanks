<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">
        <!-- BEGIN PAGE HEADER-->
        <!-- BEGIN PAGE BAR -->
        <div class="page-bar " style="position: relative">
            <ul class="page-breadcrumb"><!-- 
                <li>
                    <a href="index.html">C</a>
                    <i class="icon-arrow-left"></i>
                </li> -->
                <li>
                    <span><?php echo $translate->_("Messaging system"); ?> </span>
                </li>
            </ul>

        </div>
 <!-- BEGIN THEME PANEL -->

        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                {% if settings.banner_image %}
                <div class=""
                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url({{url.getStatic(settings.banner_image)}}) center center no-repeat ; background-size: contain"></div>
                {% else %}
                <div class=""
                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url({{url.getStatic('img/sms.png')}}) center center no-repeat ; background-size: contain"></div>
                {% endif %}
            </div>

        </div>

        <!-- END THEME PANEL -->
        
        <div class="clearfix"></div>
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="fa fa-comments-o" aria-hidden="true"></i>
                    <span class="caption-subject bold uppercase">
                       <?php echo $translate->_("Messaging system"); ?> 
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
                    </div> -->

                <div class="col-sm-2 col-xs-12">
                    {{partial('shared/side_menu')}}
                </div>

                <div class="col-sm-10 col-xs-12 bordered">
                    {% for msg in messages %}
                    <div class="caption font-dark">
                        <span class="caption-subject bold uppercase">
                           {{msg.message.subject}}
                        </span>
                    </div>
                    <div class="msg gap">
                        <div class="bordered ltr">
                            <div class="col-xs-12 no-padding"><b><?php echo $translate->_("From"); ?>:</b> {{ msg.sender.Title }}</div>
                            <div class="col-xs-12 no-padding"><b><?php echo $translate->_("To"); ?>:</b> {{msg.receiver.Title}}</div>
                            <div class="col-xs-12 no-padding"> {{date("H:i A d M Y", msg.message.DateTime)}} </div>
                        </div>
                        <div class="gap">
                            <p>{{msg.message.Content}}</p>
                        </div>
                    </div>
                    <div class="clearfix"></div>

                   {% endfor %}

                    <div class="msg gap">
                       <form class="inbox-compose form-horizontal" id="compose_form" action="{{url('index/reply')}}" method="post">
                            <input type="hidden" name="Parent_ID" value="{{Parent_ID}}">
                            <div class="col-lg-12">
                                <div class="editorHtmL" id="app" >
                                    <textarea id="message_body" class="" name="message"></textarea>
                                </div>
                            </div>

                            <div class="inbox-compose-btn col-lg-12">
                                <button class="btn btn-xs green" data-dpmaxz-eid="17">
                                    <i class="fa fa-check"></i><?php echo $translate->_("Reply"); ?></button>
                                <!-- <a href="{{url("index")}}" class="btn btn-xs default" data-dpmaxz-eid="18" >
                                    <i class="fa fa-trash-o" aria-hidden="true"></i>الغاء</a>
                                <button type="button" id="save_draft" class="btn btn-xs default">
                                    <i class="fa fa-floppy-o" aria-hidden="true"></i>حفظ فى الارشيف</button> -->
                            </div>
                        </form>
                        <div class="clearfix"></div>
                    </div> <!--end reply part-->
                </div>
            </div>
        </div>
        
        <!-- END DASHBOARD -->

    </div>
    <!-- END CONTENT BODY -->
</div>
<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    var base_url = "{{url('')}}";
    tinymce.init({
        selector: '#message_body'
    });
</script>