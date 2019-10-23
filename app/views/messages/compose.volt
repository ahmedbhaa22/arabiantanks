<div class="page-content-wrapper">
    <div class="page-content">
        <div class="mail__inbox">
            <div class="row">
                <div class="col-md-2">
                    <div class="inbox-sidebar ">
                        <a href="javascript:;" data-title="Compose" class="btn green compose-btn btn-block">
                            <i class="fa fa-edit"></i>
                            Compose </a>
                        <ul class="inbox-nav">
                            <li class="active">
                                <a href="javascript:;" data-type="inbox" data-title="Inbox"> Inbox
                                    <span class="badge badge-success">3</span>
                                </a>
                            </li>
                            <!-- <li>
                                <a href="javascript:;" data-type="important" data-title="Inbox"> Important </a>
                            </li> -->
                            <li>
                                <a href="javascript:;" data-type="sent" data-title="Sent"> Sent </a>
                            </li>
                            <li>
                                <a href="javascript:;" data-type="draft" data-title="Draft"> Draft
                                    <span class="badge badge-success">8</span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" class="sbold uppercase" data-title="Trash"> Trash
                                    <span class="badge badge-success">23</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="inbox-body">

                        <div class="inbox-content">
                            <div class="row">
                                <form class="inbox-compose form-horizontal" id="compose_form" action="send" method="post">
                                    <div class="inbox-form-group mail-to">
                                        <label class="control-label">إلى</label>
                                        <div class="controls controls-to">
                                            <select name="to" id="selectize_compose">
                                                {% if draft is defined%}
                                                <option value="{{draft.receiver.ID}}" selected>{{draft.receiver.Title}}</option>
                                                {% elseif reply_to is defined%}
                                                <option value="{{reply_to.ID}}" selected>{{reply_to.Title}}</option>
                                                {% endif %}
                                            </select>
                                        </div>
                                    </div>

                                    <div class="inbox-form-group subject">
                                        <label class="control-label">الموضوع:</label>
                                        <div class="controls">
                                            <input type="text" class="form-control" name="subject" data-dpmaxz-eid="13"
                                            {% if draft.subject is defined%}
                                            value="{{draft.subject}}" 
                                            {% endif %}
                                            >
                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <div class="editorHtmL" id="app" >
                                            <textarea id="message_body" class="" name="message">
                                            {% if draft.Content is defined%}
                                                {{draft.Content}}
                                            {% endif %}
                                            </textarea>
                                        </div>
                                    </div>

                                    <div class="inbox-compose-btn">
                                        <button class="btn green" data-dpmaxz-eid="17">
                                            <i class="fa fa-check"></i>ارسال</button>
                                        <a href="{{url("messages")}}" class="btn default" data-dpmaxz-eid="18" >الغاء</a>
                                        <button type="button" id="save_draft" class="btn default">حفظ فى الارشيف</button>
                                    </div>
                                </form>
                            </div>
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