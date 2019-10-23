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
                <div class="col-md-2">
                    {{partial('shared/side_menu')}}
                </div>
                <div class="col-md-10">
                    <div class="inbox-body">
                        <!-- <div class="inbox-header">
                            <h1 class="pull-left">Trashed</h1>
                        </div> -->
                        <div class="inbox-content">
                            <table class="table table-striped table-bordered table-hover table-checkable order-column"  id="sample_1">
                                <thead>
                                    <tr>
                                        <th style="width: 2%;">
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="group-checkable"
                                                       data-set="#sample_1 .checkboxes"/>
                                                <span></span>
                                            </label>
                                        </th>
                                        <th> الرسالة </th>
                                        <th> وارد من</th>
                                        <th> التاريخ</th>
                                        <th> إجراءات</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {% for msg in messages %}
                                    <tr class="odd gradeX">
                                        <td>
                                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                                <input type="checkbox" class="checkboxes" value="1"/>
                                                <span></span>
                                            </label>
                                        </td>

                                        <td>{{msg.message.subject | striptags}}</td>

                                        <td>
                                            <a href="#">
                                            {% if msg.sender != false %}
                                            {{msg.sender.Title}}
                                            {% endif %}
                                            </a>
                                        </td>

                                        <td class="center"> {{date("Y-m-d", msg.message.DateTime)}}</td>

                                        <td>
                                            <div class="btn-group">
                                                <!-- <button class="btn btn-xs dark dropdown-toggle" type="button"
                                                        data-toggle="dropdown" aria-expanded="false"> إجراء
                                                    <i class="fa fa-angle-down"></i>
                                                </button>
                                                <ul class="dropdown-menu" role="menu">
                                                    <li>
                                                        <a href="{{url('index/view/') ~ msg.ID}}">
                                                            <i class="icon-docs"></i> مشاهده </a>
                                                    </li>

                                                    <li>
                                                        <a onclick="deleteMessage({{msg.ID}})">
                                                            <i class="icon-user"></i>للأبد حذف </a>
                                                    </li>
                                                </ul> -->

                                                <a href="{{url('index/view/') ~ msg.ID}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                                                <a onclick="deleteMessage({{msg.ID}})" class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </a>
                                            </div>
                                        </td>
                                    </tr>
                                    {% endfor %}
                                </tbody>
                            </table>
                            <!-- <div class="btn-group">
                                <a href="javascript:;" class="btn btn-xs btn-danger">
                                    <i class="fa fa-trash-o" aria-hidden="true"></i> حذف المحدد
                                </a>
                            </div> -->

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function deleteMessage(id) {
    if(confirm("Are you sure you want to delete this message?")){
        window.location = "{{url('index/delete')}}" + "/" + id;
    }
}
</script>