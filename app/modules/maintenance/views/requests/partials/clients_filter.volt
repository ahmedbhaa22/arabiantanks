<div class="panel panel-info">
    <div class="panel-heading">
        <h4 class="panel-title">
            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#client_filter_container">
                <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
            </a>
        </h4>
    </div>

    <div id="client_filter_container" class="panel-collapse collapse">
        <div class="panel-body">

            <div class="row">
                <div class="col-sm-2">
                    <div class="form-group">
                        <label class=" control-label">اسم العميل </label>
                        <input type="text" class="form-control" name="client_name" id="client_name">
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="form-group">
                        <label class=" control-label">الجوال</label>
                        <input type="text" class="form-control" name="client_mobile" id="client_mobile">
                    </div>
                </div>

            </div>
            <button class="btn btn-primary" id="client_filter_action">فلتر</button>

        </div>
    </div>
</div>






<script>
    $("#client_filter_action").click(function(e) {
        e.preventDefault();
        var url = "{{url('maintenance_module/requests/getClientsAjax')}}"; // the script where you handle the form input.
        var client_name=$("#client_name").val();
        var client_mobile=$("#client_mobile").val();
        var data = {
            'client_name': client_name,
            'client_mobile': client_mobile
        };
        $.ajax({
            type: "POST",
            url: url,
            data: data, // serializes the form's elements.
            success: function (response)
            {

                $("#clients_content").html(response);
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>