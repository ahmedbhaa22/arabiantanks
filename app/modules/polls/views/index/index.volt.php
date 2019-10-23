<div class="col-lg-12">
    <div class=" ">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <?php if ($settings->banner_image) { ?>
                <div class=""
                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic($settings->banner_image) ?>) center center no-repeat ; background-size: contain"></div>
                <?php } else { ?>
                <div class=""
                     style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic('polls/img/banners/poll.png') ?>) center center no-repeat ; background-size: contain"></div>
                <?php } ?>
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
            <a type="button" href="<?= $this->url->get('polls/create') ?>" class="btn btn-edit-my-data green-jungle btn-outline btn-block">استبيان جديد</a>
        </div>
        <div class="actions">
            <a type="button" href="<?= $this->url->get('polls/ask') ?>" class="btn btn-edit-my-data green-jungle btn-outline btn-block"> إستبيان عميل جديد</a>
        </div>
        
    </div>
    <div class="portlet-body">
        <!-- <div class=" col-xs-12 no-padding">
            <select class="form-control" id="dep-select">
                <?php if ($this->length($departments) > 0) { ?>
                <?php foreach ($departments as $dep) { ?>
                <option value="<?= $dep->ID ?>"><?= $dep->Title ?></option>
                <?php } ?>
                <?php } ?>
            </select>
        </div> -->
        <div id="polls_table">
            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
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

                    <?php foreach ($polls as $poll) { ?>
                    <tr>
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                <input type="checkbox" class="checkboxes" value="1"/>
                                <span></span>
                            </label>
                        </td>
                        <td> <a class="bold" href="<?= $this->url->get('polls/view/') . $poll->id ?>"> <?= $poll->name ?> </a></td>
                        <td> <?= $poll->getAnswersCount() ?> </td>
                        <td> 

                            <a href="<?= $this->url->get('polls/view/') . $poll->id ?>" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                            <a href="<?= $this->url->get('polls/edit/') . $poll->id ?>" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>

                            <button onclick="deletePoll(<?= $poll->id ?>, this)" class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                    </tr>
                    <?php } ?>

                    <tr>
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                <input type="checkbox" class="checkboxes" value="1"/>
                                <span></span>
                            </label>
                        </td>
                        <td> <a class="bold" href="view-poll.html"> Test2 </a></td>
                        <td> 13 </td>
                        <td> 

                            <button class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </button>

                            <button class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

                            <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
        <div class="clearfix"></div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->

<script type="text/javascript">

$("#dep-select").change(function () {
    $.ajax({
        method: "GET",
        url: "",
        success: function (response) {
            if(response.success){
                $("#polls_table").html(response.view);
            }
        }
    }) 
});

function deletePoll(id, el) {
    if(confirm("Are you sure?")){
        window.location = "<?= $this->url->get('polls/delete/') ?>" + id;
    }
}

</script>