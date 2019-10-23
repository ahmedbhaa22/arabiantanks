<div class="col-lg-12">
    <div class=" ">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                {% if settings.banner_image %}
                <div class=""
                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url({{url.getStatic(settings.banner_image)}}) center center no-repeat ; background-size: contain"></div>
                {% else %}
                <div class=""
                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url({{url.getStatic('polls/img/banners/poll.png')}}) center center no-repeat ; background-size: contain"></div>
                {% endif %}
            </div>

        </div>
    </div>

</div>
<!-- BEGIN THEME PANEL -->

<!-- END THEME PANEL -->


<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-list-ul"></i>
            <span class="caption-subject bold uppercase">
                الإستفتاءات
            </span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('polls/create_fire')}}" class="btn btn-edit-my-data green-jungle btn-outline btn-block">استفتاء جديد</a>
        </div>
        
    </div>
    <div class="portlet-body">
        <div class=" col-xs-12 no-padding">
            <select class="form-control">
                <option value="0">أختر قسم</option>
                <option value="Sectio1">القسم الأول</option>
                <option value="Sectio2">القسم الثاني</option>
                <option value="Sectio3">القسم الثالث</option>
                <option value="Sectio4">القسم الرابع</option>
            </select>
        </div>
        <table class="table table-striped table-bordered table-hover table-checkable order-column"
                   id="sample_1">
                <thead>
                <tr>
                    <th style="width: 2%;">
                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" class="group-checkable"
                                   data-set="#sample_1 .checkboxes"/>
                            <span></span>
                        </label>
                    </th>
                    <th>اسم الإستفتاء</th>
                    <th style="width: 5%;"> عدد الإجابات</th>
                    <th style="width: 15%;"> إجراءات</th>
                </tr>
                </thead>
                <tbody>
                    <?php foreach($questions as $key => $question){ ?>
                    <tr>
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                <input type="checkbox" class="checkboxes" value="1"/>
                                <span></span>
                            </label>
                        </td>
                        <td> <a class="bold" href="{{url('polls/view/')}}"> Event {{key}} </a></td>
                        <td>  </td>
                        <td> 

                            <a href="{{url('polls/view_fire/') ~ key}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                            <a href="{{url('polls/edit_fire/') ~ key}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>

                            <button onclick="deletePoll({{key}}, this)" class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                    </tr>
                    <?php } ?>

                </tbody>
            </table>
        <div class="clearfix"></div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->

<script type="text/javascript">

function deletePoll(id, el) {
    if(confirm("Are you sure?")){
        window.location = "{{url('polls/delete_fire/')}}" + id;
    }
}

</script>