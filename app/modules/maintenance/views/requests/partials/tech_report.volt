<div class="portlet-title">
    <div class="caption font-dark">
        <i class="fa fa-file font-dark"></i>
        <span class="caption-subject bold uppercase"> التقرير الفني </span>
    </div>
</div>
{%for tech_report in content["tech_reports"]%}

<div class="portlet-body">
    <div class="row">

        <table class="table table-bordered">
            <tbody>
            <tr>
                <td> سنة الصنع</td>
                <td>{{tech_report["manufacturing_year"]}}</td>
            </tr>
            <tr>
                <td> رقم المنتج</td>
                <td>{{tech_report["product_number"]}}</td>
            </tr>
            <tr>
                <td>حالة الضمان</td>
                {%if(tech_report["in_gurantee"]==1)%}
                <td>داخل الضمان</td>
                {%else%}
                <td>خارج الضمان</td>
                {%endif%}

            </tr>

            <tr>
                <td>ملاحظات</td>
                <td>
                    {%if(tech_report["notes"]|length > 0)%}
                    <ul>
                        {%for item in tech_report["notes"] %}
                        <li>{{item['note']}}</li>
                        {%endfor%}
                    </ul>
                    {%endif%}
                </td>
            </tr>
            <tr>
                <td>الصور</td>
                <td>


                    <a type="button" href="" class="btn btn-md btn-info" data-toggle="modal"
                       data-target="#techReportPhotoModal{{tech_report['id']}}">
                        <i class="fa fa-file" aria-hidden="true"></i>إضافة صور أخرى
                    </a>
                    <div class="clearfix"></div>
                    <div class="report_photos">
                        {%if(tech_report["photos"]|length > 0)%}
                        <ul>
                            {%for item in tech_report["photos"] %}
                            <li style="float:right">
                                <a onclick="return confirm('هل أنت متأكد ؟');" href="{{url('maintenance_module/requests/tech_report_photo_delete/') ~item['id']}}"><i class="fa fa-times"></i> </a>

                                <div class="bordered"> <a href="{{url('uploads/') ~item['photo']}}" target="_blank">
                                    <img src="{{url('uploads/') ~item['photo']}}" width="100" height="100"/>
                                    </a>
                                </div>
                                    </li>
                            {%endfor%}
                        </ul>
                        {%endif%}
                    </div>

                </td>
            </tr>

            </tbody>
        </table>

    </div>


</div>


<div id="techReportPhotoModal{{tech_report['id']}}" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title"> إضافة صور في التقرير الفني </h4>
            </div>
            <form role="form" action="{{url('maintenance_module/requests/add_tech_report_photo/') ~tech_report['id']}}"
                  id="" enctype="multipart/form-data" method="post">

                <div class="modal-body">

                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="control-label"> الصور </label>
                            <input type="file" class="form-control custom-file-input" multiple name="report_pics[]"
                                   required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-success"> حفظ</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
                </div>
            </form>

        </div>

    </div>
</div>

{%endfor%}