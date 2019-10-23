$(document).ready(function() {
    $('#sample_1 tfoot th.filter').each( function () {
        var title = $(this).text();
        $(this).html( '<input type="text" placeholder="'+title+'" />' );
    } );
    var table = $('#sample_1').DataTable({
        "order": [[ 0, "desc" ]],
        serverSide: true,
        "oLanguage": {
            "sSearch": fast_search_str,
            "sLengthMenu": "_MENU_ " + records_str,
            "sInfo": got_total_str+" _TOTAL_ "+records_str+" "+to_show_str+" _START_ "+to_str+" _END_"
        },
        ajax: {
            url: main_url + 'cms_module/cp_users/ajaxContent',
            method: 'POST'
        },

        columns: [
            {
                data: "id", searchable: false,orderable:false,
                "render": function (data, type, full, meta) {
                    return checkReturn(data);
                }
            },
            {data: "title"},
            {data: "user"},
            {data: "mail", searchable: false},
            {data: "join_date"},
            {data: "time_date"},
            {
                data: "active",
                "render": function (data, type, full, meta) {
                    return activeReturn(data);
                }
            },
            {
                data: "id", searchable: false,
                "render": function (data, type, full, meta) {
                    return createBtn(data);
                }
            }

        ],
        // initComplete: function () {
        //     this.api().column(4).every( function () {
        //         var column = this;
        //         var select = $('<select><option value=""></option></select>')
        //             .appendTo( $(column.footer()).empty() )
        //             .on( 'change', function () {
        //                 var val = $.fn.dataTable.util.escapeRegex(
        //                     $(this).val()
        //                 );
        //
        //                 column
        //                     .search( val ? '^'+val+'$' : '', true, false )
        //                     .draw();
        //             } );
        //
        //         column.data().unique().sort().each( function ( d, j ) {
        //             select.append( '<option value="'+d+'">'+d+'</option>' )
        //         } );
        //     } );
        // }
    });
    table.columns().every( function () {
        var that = this;

        $('input', this.footer()).on('keydown change', function () {
            if (that.search() !== this.value) {
                that
                    .search(this.value)
                    .draw();
            }
        });
    });

    $('#reset-table').on('click',function () {
        //alert("sssss");
        $('#sample_1').dataTable().fnDestroy();

    });
    $('#select-all').on('click', function(){
        // Get all rows with search applied
        var rows = table.rows({ 'search': 'applied' }).nodes();
        // Check/uncheck checkboxes for all rows in the table
        $('input[type="checkbox"]', rows).prop('checked', this.checked);
    });
    $('#sample_1 tbody').on('change', 'input[type="checkbox"]', function(){
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
            '<button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> إجراء' +
            '<i class="fa fa-angle-down"></i></button><ul class="dropdown-menu" role="menu"><li>' +
            '<a href="' + main_url + 'cms_module/cp_users/edit/' + data + '" data-toggle="modal"><i class="icon-tag"></i> تعديل </a></li>' +
            '<li><a onclick="return confirm_delete()" href="' + main_url + 'cms_module/cp_users/delete/' + data + '"><i class="icon-user"></i> حذف </a></li></ul></div>';
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

    //Handle Checkboxes Delete
    $( ".deactive-btn" ).on( "click", function() {
        event.preventDefault();
        //alert("sssss");
        var checkedValues = $('input[name="deleteCheckbox[]"]:checked').map(function() {
            return this.value;
        }).get();

        if ($('input[name="deleteCheckbox[]"]:checked').length<1){
            alert("لابد أن تختار على الأقل حقل واحد");
            return false;
        }
        console.log(checkedValues);
        //return;

        $.ajax({
            type        : 'post', // define the type of HTTP verb we want to use (POST for our form)
            url: main_url + 'cms_module/cp_users/ajaxDeactive', // the url where we want to POST
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
            alert("لابد أن تختار على الأقل حقل واحد");
            return false;
        }
        console.log(checkedValues);
        //return;

        $.ajax({
            type        : 'post', // define the type of HTTP verb we want to use (POST for our form)
            url: main_url + 'cms_module/cp_users/ajaxActive', // the url where we want to POST
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
    $( ".delete-btn" ).on( "click", function() {
        event.preventDefault();
        //alert("sssss");
        var checkedValues = $('input[name="deleteCheckbox[]"]:checked').map(function() {
            return this.value;
        }).get();

        if ($('input[name="deleteCheckbox[]"]:checked').length<1){
            alert("لابد أن تختار على الأقل حقل واحد");
            return false;
        }
        console.log(checkedValues);
        //return;

        $.ajax({
            type        : 'post', // define the type of HTTP verb we want to use (POST for our form)
            url: main_url + 'cms_module/cp_users/ajaxDelete', // the url where we want to POST
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

});