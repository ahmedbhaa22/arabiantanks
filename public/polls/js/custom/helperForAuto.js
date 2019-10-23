//autocomplete for receiver fielsds
var current_url = $('#current_url').val();

$(function () {
    'use strict';
    var receiver_field = $('#receiver_name');
    var q = "";

    receiver_field.change(function(){
        var q = receiver_field.val();
    });

    $.getJSON(current_url + '/estateproject/getClientDetails?q=' + q, function (clientsList) {
        $(function () {
            'use strict';
            // Initialize ajax autocomplete:
            receiver_field.autocomplete({
                tabDisabled: true,
                lookup: clientsList,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    // suggestion.data=q;
                    var re = new RegExp($.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi');
                    return re.test(suggestion.value);
                },
                onSelect: function (suggestion) {
                    //fire custom function to fill another details
                    //console.log(suggestion.id);
                    $.getJSON(current_url + '/estateproject/getClientBranches?client_id=' + suggestion.id, function (clientData) {
                        $.map(clientData, function (clientBranchesDetails, index) {
                            fillFieldsData(clientBranchesDetails);
                        });

                        $("input[name='ReceiverClientExistsID']").remove();

                        $('.hiddenField').append("<input type='hidden' name='ReceiverClientExistsID' value='" + suggestion.id + "'/>");
                        // $("#new_order_form").valid();
                        $("input[name='receiver_address1']").valid();
                        $("input[name='receiver_mobile1']").valid();
                    });

                },
                onHint: function (hint) {
                    // console.log(hint);
                    //$('#autocomplete-ajax').val(hint);
                },
                onInvalidateSelection: function () {
                }
            });
        });
    });

});
//autocomplete for sender fields
$(function () {
    'use strict';
    var sender_field = $('#sender_name');
    var q = "";
    sender_field.change(function(){
        q = sender_field.val();
       
    });
     $.getJSON(current_url + '/estateproject/getClientDetails?q=' + q, function (clientsList) {
        
        $(function () {
            'use strict';
            // Initialize ajax autocomplete:
            sender_field.autocomplete({
                tabDisabled: true,
                lookup: clientsList,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    // suggestion.data=q;
                    var re = new RegExp($.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi');
                    return re.test(suggestion.value);
                },
                onSelect: function (suggestion) {
                    //fire custom function to fill another details
                    //console.log(suggestion.id);
                    window.h = 1;
                    $.getJSON(
                        current_url + '/estateproject/getClientBranches?client_id=' + suggestion.id, 
                        function (clientData) {
                            $.map(clientData, function (clientBranchesDetails, index) {
                                
                            fillFieldsData(clientBranchesDetails, 1);
                        });

                        $("input[name='SenderClientExistsID']").remove();

                        $('.hiddenField').append("<input type='hidden' name='SenderClientExistsID' value='" + suggestion.id + "'/>");
                        // $("#new_order_form").valid();
                        $("input[name='sender_address1']").valid();
                        $("input[name='sender_mobile1']").valid();
                    });

                },
                onInvalidateSelection: function () {
                }
            });

            $("#sender_account_number").on('focusout', function(){
                if(!$("input[name='sender_account_number']").val())
                    return;
                if($("input[name='SenderClientExistsID']").length)
                    return;
                var match = $.grep(clientsList, function(value){
                    return (value.account_number == $("#sender_account_number").val());
                })

                if(match.length){
                    $.getJSON(
                        current_url + '/estateproject/getClientBranches?client_id=' + match[0].id, 
                        function (clientData) {
                            $.map(clientData, function (clientBranchesDetails, index) {
                                
                            fillFieldsData(clientBranchesDetails, 1);
                        });

                        $("input[name='SenderClientExistsID']").remove();

                        $('.hiddenField').append("<input type='hidden' name='SenderClientExistsID' value='" + match[0].id + "'/>");
                    });
                }

            });
        });
    });
    //var q = sender_field.val();
   

});


function fillFieldsData(clientBranchesDetails, isSender) {
    //console.log(clientBranchesDetails);
    isSender = isSender || 0;
    var targetField = '';
    if (isSender) {
        targetField = 'sender'
    } else {
        targetField = 'receiver'
    }
    //fill fields
    $('#payment_method_info').val('');
    $('#holder_'+targetField+'_name').val('');

    $('#holder_'+targetField+'_name').val(clientBranchesDetails.name);
    $('#' + targetField +'_name').val(clientBranchesDetails.name);
    $('#' + targetField + '_account_number').val(clientBranchesDetails.account_number);
    $('#' + targetField + '_postal').val(clientBranchesDetails.postal);
    $('#' + targetField + '_company_name').val(clientBranchesDetails.company);
    $('#' + targetField + '_address1').val(clientBranchesDetails.address);
    $('#' + targetField + '_address2').val(clientBranchesDetails.address2);
    $('#' + targetField + '_mobile1').val(clientBranchesDetails.mobile1);
    $('#' + targetField + '_mobile2').val(clientBranchesDetails.mobile2);

    if(clientBranchesDetails.country_id){
        //change event is triggered to load the cities
        $("#" + targetField + "_country").val(clientBranchesDetails.country_id).change();
        if(clientBranchesDetails.city_id){
            //timeout for the cities to be loaded from the server dynamically and same for the districts
            setTimeout(function(){
                $("#" + targetField + "_city").val(clientBranchesDetails.city_id).change();
                $("#" +targetField+ "_city").valid();
                if(clientBranchesDetails.district_id){
                    setTimeout(function(){
                        console.log(clientBranchesDetails.district_id);
                        $("#" + targetField + "_region").val(clientBranchesDetails.district_id).change();
                        $("#" +targetField+ "_region").valid();
                    }, 1500)
                }
            }, 1500);
        }
    }
    // $('.' + targetField + '_district_id').text(clientBranchesDetails.region_name);
    // $('.' + targetField + '_district_id').val(clientBranchesDetails.region_name);
    // $('.' + targetField + '_city_id').val(clientBranchesDetails.city_name);
    // $('.' + targetField + '_city_id').text(clientBranchesDetails.city_name);
}



$(function () {
    'use strict';
    var signaturesDistributorField = $('#signatures_distributor_id');
    var query = signaturesDistributorField.val();

    $.getJSON(current_url + '/estateproject/getSuggestedDistributor?q=' + query, function (clientsList) {
        $(function () {
            'use strict';
            // Initialize ajax autocomplete:
            signaturesDistributorField.autocomplete({
                lookup: clientsList,
                lookupFilter: function (suggestion, originalQuery, queryLowerCase) {
                    var re = new RegExp($.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi');
                    return re.test(suggestion.value);
                },

                onSelect: function (suggestion) {
                    $('.hiddenField').append("<input type='hidden' name='signatures_distributor_id' value='" + suggestion.id + " '/>");
                }
            });
        });
    });

});


$.getJSON(current_url+'/estateproject/get_shipment_methods', function (shipment_methods) {
    // $("#shipping_method").select2({
    //     placeholder: "طريقة الشحن",
    //     data: shipment_methods
    // });
});


$.getJSON(current_url+'/estateproject/getEgyptCities', function (cities) {
    $(".cities_select2").select2({
        placeholder: "المدينه",
        data: cities
    });
});

$.getJSON(current_url+'/estateproject/getRegions', function (regions) {
    $(".regions_select2").select2({
        placeholder: "المنطقه",
        data: regions
    });
});

// $.getJSON(current_url+'/estateproject/getExpressClients', function (clientsList) {
//     $(".sender_auto_complete").select2({
//         placeholder: "الراسل",
//         data: clientsList
//     });
// });

// $.getJSON(current_url+'/estateproject/getExpressClients', function (clientsList) {
//     $(".receiver_auto_complete").select2({
//         placeholder: "المرسل اليه",
//         data: clientsList
//     });
// });

// //TODO lazy load on key change
// $.getJSON(current_url+'/estateproject/getSuggestedDistributor', function (distributors) {
//     $(".distributor_auto_complete").select2({
//         placeholder: "الموزع",
//         data: distributors
//     });
// });