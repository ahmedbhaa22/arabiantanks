<div class="page-content-wrapper">
    <div class="page-content">
        <div class="mail__inbox">
            <div class="row">
                <div class="col-md-2">
                    <div class="inbox-sidebar ">
                        <a href="{{url('messages/compose')}}" data-title="Compose" class="btn green compose-btn btn-block">
                            <i class="fa fa-edit"></i> Compose </a>
                        <ul class="inbox-nav">
                            <li class="active">
                                <a href="javascript:;" data-type="inbox" data-title="Inbox"> Inbox
                                    <span class="badge badge-success">3</span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" data-type="important" data-title="Inbox"> Important </a>
                            </li>
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
                            <li>
                                <a href="javascript:;" data-type="inbox" data-title="Promotions"> Promotions
                                    <span class="badge badge-success">2</span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;" data-type="inbox" data-title="News"> News </a>
                            </li>
                        </ul>
                        <ul class="inbox-contacts">
                            <li>
                                <a href="javascript:;">
                                    <img class="contact-pic" src="http://www.avatarsdb.com/avatars/eminem1.jpg">
                                    <span class="contact-name">Adam Stone</span>
                                    <span class="contact-status bg-green"></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;">
                                    <img class="contact-pic" src="http://www.avatarsdb.com/avatars/eminem1.jpg">
                                    <span class="contact-name">Lisa Wong</span>
                                    <span class="contact-status bg-red"></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;">
                                    <img class="contact-pic" src="http://www.avatarsdb.com/avatars/eminem1.jpg">
                                    <span class="contact-name">Nick Strong</span>
                                    <span class="contact-status bg-green"></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;">
                                    <img class="contact-pic" src="http://www.avatarsdb.com/avatars/eminem1.jpg">
                                    <span class="contact-name">Anna Bold</span>
                                    <span class="contact-status bg-yellow"></span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;">
                                    <img class="contact-pic" src="http://www.avatarsdb.com/avatars/eminem1.jpg">
                                    <span class="contact-name">Richard Nilson</span>
                                    <span class="contact-status bg-green"></span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="inbox-body">
                        {% for msg in messages %}
                        <div class="inbox-content" dir="ltr">
                            <div class="row">
                                <h3 class="email--title">{{msg.message.subject}}</h3>
                                <div class="col-lg-12">
                                    <div class="inbox-view-info">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <img  src="http://keenthemes.com/preview/metronic/theme/assets/pages/media/users/avatar1.jpg" class="inbox-author">
                                                <span class="sbold">{{ msg.sender.Title }} </span>
                                                <span>&lt;{{msg.sender.Mail}}&gt; </span> to
                                                <span class="sbold"> {{msg.receiver.Title}} </span> on {{date("H:i A d M Y", msg.message.DateTime)}}
                                            </div>
                                            <div class="col-md-3 inbox-info-btn">
                                                <div class="btn-group">
                                                    <a data-messageid="23" class="btn green reply-btn" href="{{url('messages/compose')}}?reply_to={{msg.sender.Mail}}">
                                                        <i class="fa fa-reply"></i> Reply
                                                        <i class="fa fa-angle-down"></i>
                                                    </a>
                                                    <ul class="dropdown-menu pull-right">
                                                        <li>
                                                            <a href="javascript:;" data-messageid="23" class="reply-btn">
                                                                <i class="fa fa-reply"></i> Reply </a>
                                                        </li>
                                                        <li>
                                                            <a href="javascript:;">
                                                                <i class="fa fa-arrow-right reply-btn"></i> Forward </a>
                                                        </li>
                                                        <li>
                                                            <a href="javascript:;">
                                                                <i class="fa fa-print"></i> Print </a>
                                                        </li>
                                                        <li class="divider"></li>
                                                        <li>
                                                            <a href="javascript:;">
                                                                <i class="fa fa-ban"></i> Spam </a>
                                                        </li>
                                                        <li>
                                                            <a href="javascript:;">
                                                                <i class="fa fa-trash-o"></i> Delete </a>
                                                        </li>
                                                        <li>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-12">
                                            {{msg.message.Content}}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <hr/>
                                </div>
                            </div>
                        </div>
                        {% endfor %}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>