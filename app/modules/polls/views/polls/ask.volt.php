<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="production.html"><span> المنتجات </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="sales.html"><span> المبيعات </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="polls.html"><span>أستبيان</span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> أستبيان عميل جديد </span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>
<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('<?= $this->url_shared->get('img') ?>/banners/poll.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-file" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase">
                                أستبيان عميل
                          </span>
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-body">
            <div class="row"><p><?php $this->flashSession->output() ?></p></div>
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <span class="label label-info circle bold">1</span> إختيار العميل
                    </h4>
                </div>
                <div class="panel-body">
                    <?= $this->partial('polls/partials/clients_filter') ?>

                </div>
            </div>
            <div id="clients_table">

            </div>



        </div>
        <hr>

        <div id="poll_choose">

        </div>

        <hr>
        <form method="post" action="<?= $this->url_shared->get('polls_module/polls/create_poll_user') ?>">

        <div id="poll_details">

        </div>

        <div class="col-sm-12">
                <input type="hidden" name="client_id" id="client_val" />
                <input type="hidden" name="poll_id" id="poll_val" />
                <button type="submit" class="btn btn-success">  إستبيان العميل المختار  </button>
<!--                <button type="reset" class="btn dark">إلغاء</button>-->


        </div>
        </form>
    </div> <!-- end portlet-->




</div>


<script>

    var clients_url="<?= $this->url_shared->get('polls_module/polls/clients_table') ?>";
    $("#clients_table").load(clients_url);

//    $("#general_reports_filter").submit(function(e) {
//        e.preventDefault();
//        var url = "<?= $this->url->get('maintenance_module/reports/general_table') ?>"; // the script where you handle the form input.
//
//        $.ajax({
//            type: "POST",
//            url: url,
//            data: $("#general_reports_filter").serialize(), // serializes the form's elements.
//            success: function (response)
//            {
//
//                $("#general_req_report").html(response);
//            }
//        });
//
//        // avoid to execute the actual submit of the form.
//    });



</script>