<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="maintenance.html"><span> الصيانة </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span>محتوى</span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url('img/banners/banner-maint.png')}}') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-times font-dark"></i>
            <span class="caption-subject bold uppercase">عرض مشكلة صيانة  </span>
        </div>
        <div class="actions">
            <a type="button" class="btn btn-xs btn-danger" href="{{url('maintenance_module/problems/delete/') ~problem['id']}}">
                <i class="fa fa-trash-o" aria-hidden="true"></i> حذف المشكلة
            </a>
        </div>
    </div>
    <div class="portlet-body">
        <div class="row space">
            <div class="col-md-8">
                <table class="table">
                    <tr>
                        <td>نوع المنتج</td>
                        <td>{{problem["department_name"]}}</td>
                    </tr>
                </table>

                <div class="panel panel-info">
                    <div class="panel-heading">
                        <div class="panel-title">مشاكل المنتج</div>
                    </div>
                    <div class="panel-body">
                        <!-- START list group-->
                        <!-- <div data-height="180" data-scrollable="" class="list-group"> -->
                        <div class="scroller" style="height: 410px;" data-always-visible="1" data-rail-visible1="0" data-handle-color="#D7DCE2">
                            <div class="todo-tasklist">
                                {%for details in problem['details']%}
                                <div class="todo-tasklist-item">

                                    <div class="todo-tasklist-item-title">
                                        رقم
                                        <span class="label label-primary">{{details['spot_on_photo']}}</span>
                                        {{details['name']}}                                    </div>
                                </div>
                                {%endfor%}

                            </div>
                        </div>
                        <!-- END list group-->

                    </div>
                    <form method="post" action="" id="addProblemForm">
                        <input type="hidden" name="ticket_id" value="{{details['ticket_id']}}" />
                    <div class="col-xs-12 gap divider">
                        <h4> إضافة مشكلة جديدة في هذا المنتج</h4>
                    </div>
                    <div class="form-group col-md-12 no-padding">

                            <div class="col-xs-10 form-group no-padding" id="repeatTHIS">
                                <div class="col-xs-4 form-group" >
                                    <label class="control-label">رقم مكان الشكلة على الصورة</label>
                                    <input type="number" name="problem_spot[]" min="1" class="form-control">
                                </div>
                                <div class="col-xs-8 form-group" >
                                    <label class="control-label"> إسم المشكلة </label>
                                    <input type="text" name="problem_name[]" class="form-control">
                                </div>
                            </div>
                            <div class="col-xs-2 gap">
                                <a class="btn btn-xs btn-info" onclick="repeat()">
                                    <i class="fa fa-plus-circle" aria-hidden="true"></i> اضافة المزيد</a>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <div class="col-md-4 bordered">
                <div class="row">
                    <img src="{{this.url_shared.get('uploads/') ~problem['photo']}}" class="img-responsive" />
                </div>
                <div class="row" >
                    <form method="post" action="{{url('maintenance_module/problems/createDetails')}}" enctype="multipart/form-data" >
                        <label class="control-label"> تحديث صورة المنتج </label>
                        <input type="file"  class="form-control" name="img">
                        <input type="hidden" name="update_pic" value="1" />
                        <input type="hidden" name="ticket_id" value="{{details['ticket_id']}}" />
                        <input type="submit" class="btn btn-success btn-md"/>
                    </form>

                </div>
            </div>

            <div class="col-xs-12">
                <button class="btn btn-success btn-md" id="addProblemBtn">
                    <i class="fa fa-save" aria-hidden="true"></i>
                    حفظ
                </button>

            </div>

        </div>
    </div>


</div>

<script type="text/javascript">
    var i = 0;
    var original = document.getElementById('repeatTHIS');

    function repeat() {
        var clone = original.cloneNode(true);
        clone.id = "repeatTHIS" + ++i;
        original.parentNode.appendChild(clone);
    }

    $("#addProblemBtn").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/problems/createDetails')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#addProblemForm").serialize(), // serializes the form's elements.
            success: function (response)
            {

                location.reload();
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>