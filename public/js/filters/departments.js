$(document).ready(function() {
    $('#sample_depts tfoot th.filter').each( function () {
        var title = $(this).text();
        $(this).html( '<input type="text" placeholder="'+title+'" />' );
    } );
    var table = $('#sample_depts').DataTable({
        "searching": false,
        //"pageLength": 20,
        // "oLanguage": {
        //     "sSearch": "Search"
        // },
        "deferRender": true,
        "order": [[ 0, "desc" ]],
        "oLanguage": {
            "sSearch": fast_search_str,
            "sLengthMenu": "_MENU_ " + records_str,
            "sInfo": got_total_str+" _TOTAL_ "+records_str+" "+to_show_str+" _START_ "+to_str+" _END_"
        },
        serverSide: true,
        ajax: {
            url: main_url+'cms_module/departments/ajaxContent/'+main_dept,
            method: 'POST'
        },

        columns: [
            {
                data: "ID", searchable: false,orderable:false,
                "render": function (data, type, full, meta) {
                    return checkReturn(data);
                }
            },
            {data: "Title"},
            {data: "Des"},

            {
                data: "Orders",
            },
            {
                data: "Active",
                "render": function (data, type, full, meta) {
                    return activeReturn(data);
                }
            },
            {
                data: "ID", searchable: false,
                "render": function (data, type, full, meta) {
                    return createBtn(data);
                }
            }

        ],



    });

    // Resest Table on Click
    $('#reset-table').on('click',function () {
        //alert("sssss");
        $('#sample_depts').dataTable().fnDestroy();

    });
    $('#select-all').on('click', function(){
        // Get all rows with search applied
        var rows = table.rows({ 'search': 'applied' }).nodes();
        // Check/uncheck checkboxes for all rows in the table
        $('input[type="checkbox"]', rows).prop('checked', this.checked);
    });
    $('#sample_depts tbody').on('change', 'input[type="checkbox"]', function(){
        // If checkbox is not checked
        if(!this.checked){
            var el = $('#select-all').get(0);
            // If "Select all" control is checked and has 'indeterminate' property
            if(el && el.checked && ('indeterminate' in el)){
                // Set visual state of "Select all" control
                // as 'indeterminate'
                el.indeterminate = true;
            }
        }
    });
    function createBtn(data) {
        return '<div class="btn-group" style="position:relative">' +
            '<button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">' + operation_str +
            '<i class="fa fa-angle-down"></i></button><ul class="dropdown-menu" role="menu"><li>' +
            '<a href="'+main_url+'cms_module/departments/edit/' + data + '" data-toggle="modal"><i class="icon-tag"></i> '+edit_str+' </a></li>' +
            '<li><a href="'+main_url+'cms_module/departments/delete/' + data + '"><i class="icon-user"></i> '+delete_str+' </a></li></ul></div>';
    }

    function activeReturn(data) {
        if (data == 1) {
            return '<i class="text-success glyphicon glyphicon-ok" aria-hidden="true"></i>';
        } else {
            return '<i class="text-warning glyphicon glyphicon-remove" aria-hidden="true"></i>';
        }
    }
    function imgReturn(data) {
        return '<img src="'+main_url+'uploads/'+data+'" style="width: 50px;height: 50px;">';
    }
    function checkReturn(data) {
        return '<label class="mt-checkbox mt-checkbox-single mt-checkbox-outline"><input type="checkbox" name="deleteCheckbox[]" class="checkboxes" value="'+data+'"><span></span></label>';
    }
    function genderReturn(data) {
        if (data == 1) {
            return 'Female';
        } else if(data == 0) {
            return 'Male';
        }
        else{
            return 'Male';
        }
    }

    $( ".deactive-btn" ).on( "click", function() {
        event.preventDefault();
        //alert("sssss");
        var checkedValues = $('input[name="deleteCheckbox[]"]:checked').map(function() {
            return this.value;
        }).get();

        if ($('input[name="deleteCheckbox[]"]:checked').length<1){
            alert("You Must Choose at least one");
            return false;
        }
        console.log(checkedValues);
        //return;

        $.ajax({
            type        : 'post', // define the type of HTTP verb we want to use (POST for our form)
            url         : main_url+'cms_module/departments/ajaxDeactive', // the url where we want to POST
            data        : { checkboxes : checkedValues }, // our data object

        })
        // using the done promise callback
            .done(function(data) {
                if(data==1){
                    console.log(data);
                    location.reload();
                }
                else {
                    console.log(data);
                    alert("حدث خطأ");
                }
                // log data to the console so we can see


                // here we will handle errors and validation messages
            });
    });
    $( ".active-btn" ).on( "click", function() {
        event.preventDefault();
        //alert("sssss");
        var checkedValues = $('input[name="deleteCheckbox[]"]:checked').map(function() {
            return this.value;
        }).get();

        if ($('input[name="deleteCheckbox[]"]:checked').length<1){
            alert("You Must Choose at least one");
            return false;
        }
        console.log(checkedValues);
        //return;

        $.ajax({
            type        : 'post', // define the type of HTTP verb we want to use (POST for our form)
            url         : main_url+'cms_module/departments/ajaxActive', // the url where we want to POST
            data        : { checkboxes : checkedValues }, // our data object

        })
        // using the done promise callback
            .done(function(data) {
                if(data==1){
                    console.log(data);
                    location.reload();
                }
                else {
                    console.log(data);
                    alert("Error Happened");
                }
                // log data to the console so we can see


                // here we will handle errors and validation messages
            });
    });
    $( ".delete-btn" ).on( "click", function() {
        event.preventDefault();
        //alert("sssss");
        var checkedValues = $('input[name="deleteCheckbox[]"]:checked').map(function() {
            return this.value;
        }).get();

        if ($('input[name="deleteCheckbox[]"]:checked').length<1){
            alert("You Must Choose at least one");
            return false;
        }
        console.log(checkedValues);
        //return;

        $.ajax({
            type        : 'post', // define the type of HTTP verb we want to use (POST for our form)
            url         : main_url+'cms_module/departments/ajaxDelete', // the url where we want to POST
            data        : { checkboxes : checkedValues }, // our data object

        })
        // using the done promise callback
            .done(function(data) {
                if(data==1){
                    console.log(data);
                    location.reload();
                }
                else {
                    console.log(data);
                    alert("Error Happened");
                }
                // log data to the console so we can see


                // here we will handle errors and validation messages
            });
    });
});