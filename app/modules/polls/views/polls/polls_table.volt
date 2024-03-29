<div class="panel panel-info">
    <div class="panel-heading">
        <div class="panel-title">
            <span class="label label-info circle bold">2</span>
            إختر إستبيان العميل المختار
        </div>
    </div>
    <div class="panel-body">
        <form role="form">
            <div class="col-sm-12">
                <div class="form-group">
                    <label class=" control-label"> عنوان الإستبيان </label>
                    <input type="text" class="form-control">
                </div>
            </div>
            <button class="btn btn-info">فلتر </button>
        </form>
    </div>
</div>
<table class="table table-striped table-bordered table-hover table-checkable order-column"
       id="sample_2">
    <thead>
    <tr>
        <th class="small-col">ID</th>
        <th> عنوان الإستبيان</th>
        <th style="width: 5%;"> عدد العملاء</th>
        <th style="width: 15%;"> إجراءات</th>
    </tr>
    </thead>
    <tbody>
    {%for item in items["items"]%}
    <tr>
        <td class="small-col">{{item['id']}}</td>
        <td>{{item["name"]}}</td>
        <td>  </td>
        <td class="funkyradio" style="width: 15%">
            <div class="funkyradio-info">
                <input type="radio" name="chosen_poll" id="product{{item['id']}}" class="chosen_poll" value="{{item['id']}}">
                <label for="product{{item['id']}}"> إختيار الإستبيان </label>
            </div>
        </td>
    </tr>
    {%endfor%}


    </tbody>
</table>
<div class="row">
    <div class="col-md-5 col-sm-5">
        <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
            {{items["current"]}}/{{items["total_pages"]}}          </div>
    </div>
    <div class="col-md-7 col-sm-7">
        <div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
            <ul class="pagination" style="visibility: visible;">
                <li class='ask_client_page'><a href="1">الأول</a></li>
                <li class='ask_client_page'><a href="{{items['before']}}">السابق</a></li>
                <li class='ask_client_page'><a href="{{items['next']}}">التالي</a></li>
                <li class='ask_client_page'><a href="{{items['last']}}">الأخير</a></li>
            </ul>
        </div>
    </div>
</div>



<div class="clearfix"></div>


<script>

    $(".chosen_poll").change(function() {
        var poll = $("input[class='chosen_poll']:checked").val();
        $("#poll_val").val(poll);
        var poll_details_url= "{{this.url_shared.get('polls_module/polls/poll_details/')}}"+poll;
        if(this.checked) {
            $("#poll_details").load(poll_details_url);
        }
    });
</script>