<div class="page-content-wrapper">
    <!-- BEGIN CONTENT BODY -->
    <div class="page-content">
      <!-- BEGIN PAGE BAR -->
        <div class="page-bar " style="position: relative">
            <ul class="page-breadcrumb"><!-- 
                <li>
                    <a href="index.html">C</a>
                    <i class="icon-arrow-left"></i>
                </li> -->
                <li>
                    <span><?php echo $translate->_("Messaging System"); ?> </span>
                </li>
            </ul>

        </div>

        <!-- BEGIN PAGE HEADER-->
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
                       <?php echo $translate->_("Messaging System"); ?>
                    </span>
                </div>
                
            </div>
            <div class="portlet-body">
                <div class="col-md-2">
                    {{partial('shared/side_menu')}}
                </div>
                <div class="col-md-10">
                    <div class="inbox-body">
                        <!-- <div class="inbox-header">
                            <h1 class="pull-left">Compose Message</h1>
                        </div> -->

                        <div class="inbox-content msg">
                            <form class="inbox-compose form-horizontal" id="compose_form" action="send" method="post">
                                <div class="inbox-form-group col-lg-12 mail-to">
                                    <label class="">إلى</label>
                                    <div class="controls controls-to">
                                        <select name="to" id="selectize_compose">
                                            {% if draft is defined and draft.receiver%}
                                            <option value="{{draft.receiver.ID}}" selected>{{draft.receiver.Title}}</option>
                                            {% elseif reply_to is defined %}
                                            <option value="{{reply_to.ID}}" selected>{{reply_to.Title}}</option>
                                            {% endif %}
                                        </select>
                                    </div>
                                </div>

                                <div class="inbox-form-group col-lg-12 subject">
                                    <label class="">الموضوع:</label>
                                    <div class="controls">
                                        <input type="text" class="form-control" name="subject" data-dpmaxz-eid="13"
                                        {% if draft.subject is defined%}
                                        value="{{draft.subject}}" 
                                        {% endif %}
                                        >
                                    </div>
                                </div>

                                <div class="col-lg-12 form-group">
                                    <div class="editorHtmL" id="app" >
                                        <textarea id="message_body" class="" name="message">
                                        {% if draft.Content is defined%}
                                            {{draft.Content}}
                                        {% endif %}
                                        </textarea>
                                    </div>
                                </div>
                                <div class="row">
                                <div class="inbox-compose-btn col-lg-12 no-padding">
                                    <button class="btn btn-sm green" data-dpmaxz-eid="17">
                                        <i class="fa fa-check"></i>ارسال</button>
                                    <a href="{{url("index")}}" class="btn btn-sm default" data-dpmaxz-eid="18" >
                                        <i class="fa fa-trash-o" aria-hidden="true"></i>الغاء</a>
                                    <button type="button" id="save_draft" class="btn btn-sm default"> 
                                        <i class="fa fa-floppy-o" aria-hidden="true"></i> حفظ فى الارشيف</button>
                                </div>
                                </div>
                            </form>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script type="text/javascript">
    var base_url = "{{url('')}}";
    tinymce.init({
        selector: '#message_body'
    });
</script>