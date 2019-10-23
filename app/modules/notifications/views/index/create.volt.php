    <!-- High Chart -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="index.html">Notification</a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <span> <?php echo $translate->_("Create New Notification"); ?> </span>
        </li>
    </ul>

</div>

<div class="col-lg-12">
    <div class=" ">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url(<?= $this->url->getStatic('img/notification.png') ?>) center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
</div>


<div class="clearfix"></div>
<div class="portlet light">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-ticket" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase">
               <?php echo $translate->_("New Notification"); ?>
            </span>
        </div>
    </div>
    <div class="portlet-body">
        <form role="form" action="<?= $this->url->get('index/store') ?>" id="send_notification" method="post">
        <div class="one-log">
            <div class="form-group clearfix">
                <div class="log-profile text-primary col-sm-3 col-xs-12">
                    <label>
                        <?php echo $translate->_("Age"); ?>
                    </label>
                    <input type="number" name="age" class="form-control">
                </div>

                <?php if ($settings->enable_schedueling) { ?>
                <div class="log-profile text-primary col-sm-3 col-xs-12">
                    <label>
                        <?= $translate->_('Send Time') ?>
                    </label>
                    <input type="date" placeholder="Send time" id="send_time" name="send_time" class="form-control datepicker" required />
                </div>
                <?php } ?>

                <div class="log-profile text-primary col-sm-6 col-xs-12">
                    <label><?= $translate->_('Choose Notification Type') ?></label>
                    <select name="notification_type[]" id="notification_type"  required>
                        <option value="1"><?= $translate->_('iOS') ?></option>
                        <option value="2"><?= $translate->_('Android') ?></option>
                        <option value="3"><?= $translate->_('Mail') ?></option>
                        <option value="4"><?= $translate->_('Message') ?></option>
                        <option value="5"><?= $translate->_('Chrome') ?></option>
                    </select>
                </div>
            </div>
            <div class="form-group clearfix">
                <div class="col-sm-6 col-xs-12">
                    <label><?= $translate->_('Module') ?></label>
                    <select name="module_id" id="module" class="form-control">
                        <option value=""><?= $translate->_('Choose Module') ?></option>
                        <?php foreach ($modules as $module) { ?>
                            <option value="<?= $module->id ?>"><?= $module->title ?></option>
                        <?php } ?>
                    </select>
                </div>
                <div class="col-sm-6 col-xs-12">
                    <label><?= $translate->_('Choose Topic') ?></label>
                    <select name="topic_id" id="topic_id" class="selectize">

                    </select>
                </div>
            </div>
            <?php if ($settings->use_default_kv != 1) { ?>
            <div class="form-group clearfix">
                <label>Key Value pairs</label>
                <button type="button" onclick="addKV()" class="btn btn-default">Add</button>
                <div class="col-sm-12 col-xs-12 kv-div">
                    <div class="col-md-12 temp-kv kv" id="temp-kv" style="display:none;">
                        <div class="log-profile text-primary col-sm-3 col-xs-12">
                            <label>
                                <!-- Notification No.  -->
                                <?php echo $translate->_("Key"); ?>
                            </label>
                            <input type="text" name="key[]" class="form-control">
                        </div>

                        <div class="log-profile text-primary col-sm-3 col-xs-12">
                            <label>
                                <?= $translate->_('Value') ?>
                            </label>
                            <input type="text" placeholder="Value" id="value" name="value[]" class="form-control"/>
                        </div>
                        <button type="btn btn-danger" onclick="removeKV(this)">Remove</button>
                    </div>
                    <div class="col-md-12 kv">
                        <div class="log-profile text-primary col-sm-3 col-xs-12">
                            <label>
                                <!-- Notification No.  -->
                                <?php echo $translate->_("Key"); ?>
                            </label>
                            <input type="text" name="key[]" class="form-control">
                        </div>

                        <div class="log-profile text-primary col-sm-3 col-xs-12">
                            <label>
                                <?= $translate->_('Value') ?>
                            </label>
                            <input type="text" placeholder="Value" id="value" name="value[]" class="form-control"/>
                        </div>
                        <button type="btn btn-danger" onclick="removeKV(this)">Remove</button>
                    </div>
                </div>
            </div>
            <?php } ?>
            <div class="divider col-xs-12 text-primary gap ">
                <div class="form-group clearfix">
                    <label>
                        <i class="fa fa-pencil" aria-hidden="true"></i> <?= $translate->_('Choose Message') ?>
                    </label>
                    <input maxlength="100" type="text" placeholder="message" value="" name="message" class="form-control" required/>
                </div>
            </div>
            <div class="divider col-xs-12 gap ">
                <!-- <label class=" text-primary">
                   <i class="fa fa-filter" aria-hidden="true"></i> <?= $translate->_('Filter') ?> 
                </label> -->
                <div class="form-group funkyradio">

                    <?php if ($settings->filter_mf) { ?>
                    <div class="funkyradio-success col-sm-5 col-xs-11">
                        <input type="checkbox" name="male" id="male"  class="form-control" value="1"/>
                        <label for="male"><?= $translate->_('Male') ?></label>
                    </div>
                    <div class="col-xs-1 bg-primary btn-sm">
                        <?= $translate->_('Male') ?> <span class="filter-span filter-male"></span>
                    </div>

                    <div class="funkyradio-success col-sm-5 col-xs-11">
                        <input type="checkbox" name="female" id="female"  class="form-control" value="1" />
                        <label for="female"><?= $translate->_('Female') ?></label>
                    </div>
                    <div class="col-xs-1 bg-primary btn-sm">
                        <?= $translate->_('Female') ?> <span class="filter-span filter-female"></span>
                    </div>
                    <?php } ?>

                    <hr>
                    <?php foreach ($follow_types as $type) { ?>
                    <?php if ($settings->hasPermission($type)) { ?>
                    <div class="funkyradio-success col-sm-5 col-xs-11 custom-filters" style="display:none">
                        <input type="checkbox" name="filter[]" value="<?= $type->id ?>" id="<?= $type->type ?>"  class="form-control filter-radio"/>
                        <label for="<?= $type->type ?>"><?= $translate->_($type->type) ?></label>
                    </div>
                    <div class="col-xs-1 bg-primary btn-sm custom-filters" style="display:none">
                        <?= $translate->_($type->type) ?> <span class="filter-span filter-<?= $type->id ?>"></span>
                    </div>
                    <?php } ?>
                    <?php } ?>
                    <hr>


                    <?php if ($settings->filter_guests) { ?>
                    <div class="funkyradio-success col-sm-5 col-xs-11">
                        <input type="checkbox" name="send_to_guests" value="1" id="send_to_guests"  class="form-control"/>
                        <label for="send_to_guests"><?= $translate->_('Include Guests') ?></label>
                    </div>
                    <div class="col-xs-1 bg-primary btn-sm">
                         <?= $translate->_('Include Guests') ?> <span class="filter-span filter-guests"></span>
                    </div>
                    <?php } ?>

                </div>
            </div>
            <div class="col-sm-6 col-sm-offset-3 text-center">
               <!-------- pie char -->
                <?php if ($settings->enable_statistics == 1) { ?>
                <div id="container" style="min-width:310px; height:500px; max-width:600px; margin: 0 auto; direction:ltr;">
                <?php } ?>
                <!-------- end pie chart-->
            </div>
        </div>

        <div class="col-md-12 col-xs-12 no-padding">
            <input type="submit" class="btn green-jungle " value="<?= $translate->_('Send') ?>">

            <input type="" class="btn green-jungle " value="">
        </div>

        </form>
        <!-- end Help Desk-->
        <div class="clearfix"></div>
    </div>
</div>
<script type="text/javascript">
function addKV() {
    console.log("fdsa");
    var temp = $("#temp-kv").clone().appendTo(".kv-div").show();
    // $(".kv-div").append(temp);
}

function removeKV(el) {
    $(el).closest(".kv").remove();
}

function loadSelectOptions(element, options){

    if(element.prop("tagName") != "SELECT") return;

    element.html('');
    
    $.each(options, function(key, value) 
    {
        element.append('<option value=' + value.id + '>' + value.title + '</option>');
    });
    element.prepend('<option value="" selected></option>');

}

// $(document).ready(function () {

//     // Build the chart
//     Highcharts.chart('container', {
//         chart: {
//             plotBackgroundColor: null,
//             plotBorderWidth: null,
//             plotShadow: false,
//             type: 'pie'
//         },
//         title: {
//             text: 'filters'
//         },
//         plotOptions: {
//             pie: {
//                 allowPointSelect: true,
//                 cursor: 'pointer',
//                 dataLabels: {
//                     enabled: false
//                 },
//                 showInLegend: true
//             }
//         },
//         series: [{
//             name: 'Numbers',
//             colorByPoint: true,
//             data: [{
//                 name: 'Male',
//                 y: 56.33
//             }, {
//                 name: 'Female',
//                 y: 24.03,
//                 sliced: true,
//                 selected: true
//             }, {
//                 name: 'Like',
//                 y: 10.38
//             }, {
//                 name: 'Favourite',
//                 y: 4.77
//             }]
//         }]
//     });
// });

$("select[name='module_id']").change(function(){
    if($("select[name='module_id']").val()){
        $(".custom-filters").show();
    }else{
        $(".custom-filters").hide();
    }

    if($("select[name='module_id']").val()){
        $.ajax({
            url: "<?= $this->url->get('index/fetch_topics?module_id=') ?>" + $("select[name='module_id']").val(),
            method: "GET",
            success: function(response){
                console.log(response);
                loadSelectOptions($("#topic_id"), response);
                // $(".select2").select2();
                $(".selectize").selectize({
                    create: false,
                });

            }
        })
    }
});

$("#send_notification").change(function(){
    $(".filter-span").text("0");
    var datastring = $("#send_notification").serialize();
    $.ajax({
        type: "POST",
        url: "<?= $this->url->get('statistics/ajax') ?>",
        data: datastring,
        dataType: "json",
        success: function(data) {
            var chartData = [];

            // male and female
            if($("input[name='male']:checked").val()){
                $(".filter-male").text(data.male);
                chartData.push({
                    name: "Male",
                    y: data.male
                });
            }

            if($("input[name='female']:checked").val()){
                $(".filter-female").text(data.female);
                chartData.push({
                    name: "Female",
                    y: data.female
                });
            }

            if($("input[name='send_to_guests']:checked").val()){
                $(".filter-guests").text(data.guests);
                chartData.push({
                    name: "Guests",
                    y: data.guests
                });
            }

            // custom filters
            if(data.filter){
                for (filter in data.filter){
                    $(".filter-" + filter).text(data.filter[filter]);
                    var filterName = $("input[value='"+filter+"'].filter-radio").attr('id');
                    chartData.push({
                        name: filterName,
                        y: data.filter[filter]
                    });
                }
            }
            console.log(chartData);
            buildChart(chartData);
        },
        error: function() {
            alert('error handing here');
        }
    });
});

function buildChart(data) {
    Highcharts.chart('container', {
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            type: 'pie'
        },
        title: {
            text: 'filters'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                showInLegend: true
            }
        },
        series: [{
            name: 'Numbers',
            colorByPoint: true,
            data: data
        }]
    });
}

</script>