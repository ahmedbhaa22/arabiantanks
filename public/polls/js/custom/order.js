var current_url = $('#current_url').val();

// --------------Ajax Requests----------------
function getCountryCities(country_id) {
	return $.getJSON(current_url + '/estateproject/ajax/country-cities/' + country_id);
}

function getCityRegions(city_id){
	return $.getJSON(current_url+'/estateproject/ajax/city-regions/' + city_id);
}

function getOrderData(policy_number = "") {
	return $.getJSON(current_url + "/estateproject/ajax/orders/policy/" + policy_number );
}

// --------------initialization----------------
$(document).ready(function () {
	senderCitySelect = $("#sender_city").select2();
	senderRegionSelect = $("#sender_region").select2();
	receiverCitySelect = $("#receiver_city").select2();
	receiverRegionSelect = $("#receiver_region").select2();

	if(!$("#sender_city").val().length){
		$("#sender_country").change();
	}

	if(!$("#receiver_city").val().length){
		$("#receiver_country").change();
	}

	$(".sender_city_div").focusin(function(){
		senderCitySelect.select2('open');
	})

	$(".sender_region_div").focusin(function(){
		senderRegionSelect.select2('open');
	})

	$(".receiver_city_div").focusin(function(){
		receiverCitySelect.select2('open');
	})

	$(".receiver_region_div").focusin(function(){
		receiverRegionSelect.select2('open');
	})
})

// --------------event listeners----------------
window.preVal = '';
$("input[name='sender_name']").change(function(e){

	// console.log(window.preVal);
    if(window.preVal == '' && $("input[name='SenderClientExistsID']").val()){
    	window.preVal = $(this).val();
    	return;
    }
	window.preVal = $(this).val();

	if($("input[name='SenderClientExistsID']").val()){
		console.log('clearSenderData');
		clearSenderData();
	}
});

$("input[name='sender_name']").focusout(function(e){
	console.log("focusing out");
	if(identifyBrowser(navigator.userAgent, 1) != "Firefox" && window.preVal == ''){
		console.log("not Firefox and not preval");
		// $(this).change();
	}
});

$("input[name='account_number']").change(function(){
	// if(!$("input[name='sender_account_number']").val().length)
	// 	return;
	console.log("changed");
	if($("input[name='SenderClientExistsID']").val()){
		// clearSenderData();
	}
});

$("input[name='receiver_name']").change(function(){
	if($("input[name='ReceiverClientExistsID']").val()){
		clearReceiverData();
	}
});

$("#sender_country").change(function(){
	var req = getCountryCities($(this).val());

	req.done(function(response){
		loadSelectOptions($("#sender_city"), response);

		$("#sender_city").trigger('change'); // trigger city select event so that it updates the regions
		// $("#new_order_form").valid();
	});
});

$("#sender_city").change(function(){
	var req = getCityRegions($(this).val());

	req.done(function(response){
		loadSelectOptions($("#sender_region"), response);
		// $("#new_order_form").valid();
	});
});

$("#receiver_country").change(function(){
	var req = getCountryCities($(this).val());

	req.done(function(response){
		loadSelectOptions($("#receiver_city"), response);

		$("#receiver_city").trigger('change'); // trigger city select event so that it updates the regions
		// $("#new_order_form").valid();
	});
});

$("#receiver_city").change(function(){
	var req = getCityRegions($(this).val());

	req.done(function(response){
		loadSelectOptions($("#receiver_region"), response);
		// $("#new_order_form").valid();
	});
});

$("input[name='payment_method_id']").change(function(){
	
	$(".payment_info").val('');
	$(".payment_info").prop('disabled', true);
	
	enablePaymentMethod($(this).val());
});

$("#policy_number").focusout(function () {
	if(!$("#data_entry").length){
		getOrderData($(this).val())
			.success(function (response) {
				$("#policy_number").val('');
				alert('رقم بوليصة مكرر');
			})
			.error(function(error){
				
			});
		return;
	}

	if(!$("#policy_number").val().length)
		return;

	console.log("aa");
	getOrderData($(this).val())
		.done(function (response) {
			//changes the form url to update
			changeFormUrl(response.id);

			//fills order data
			fillFormData(response);
			$(".help-block").remove()
			$(".has-error").removeClass('has-error')
			$("#new_order_form").valid();
		})
		.error(function(error){
			alert("تأكد من تواجد الشحنة بالمكتب");
		});
})

$("#paymentNotes").focusout(function(e){
	//work around 
	$("#submitBtn").focus();
});

$(".dimensions").change(function(){
	var L = $("#dimensional_length").val();
	var W = $("#dimensional_width").val();
	var H = $("#dimensional_height").val();

	$("#dimensional_weight").val((L * W * H) / 5000);
});

// --------------populate select----------------
function loadSelectOptions(element, options){

	if(element.prop("tagName") != "SELECT") return;

	element.html('');
	
	$.each(options, function(key, value) 
	{
	    element.append('<option value=' + value.id + '>' + value.name + '</option>');
	});
    element.append('<option selected disabled></option>');

}

// ---------------helpers---------------
function enablePaymentMethod(method_id){
	switch (method_id) {
		case "1":
			$("#bank_info").prop('disabled', false);
			break;
		case "2":
			$("#card_info").prop('disabled', false);
			break;
		case "3":
			$("#cash_info").prop('disabled', false);
			break;
		default:
			$("#cash_info").prop('disabled', false);
	}
}

function clearSenderData() {
	$("input[name='SenderClientExistsID']").remove();
	$("#sender_account_number").val('');
	$("#holder_sender_name").val('');
	$("#sender_company_name").val('');
	$("#sender_address1").val('');
	$("#sender_address2").val('');
	$("#sender_mobile1").val('');
	$("#sender_mobile2").val('');
	$("#sender_postal").val('');
	$("#sender_city").val('');
	$("#sender_region").val('');
}

function clearReceiverData() {
	$("input[name='ReceiverClientExistsID']").remove();
	$("#holder_receiver_name").val('');
	$("#receiver_company_name").val('');
	$("#receiver_address1").val('');
	$("#receiver_address2").val('');
	$("#receiver_mobile1").val('');
	$("#receiver_mobile2").val('');
	$("#receiver_postal").val('');
	$("#receiver_city").val('');
	$("#receiver_region").val('');
}

function changeFormUrl(order_id){
	$("#new_order_form").attr('action', current_url + "/estateproject/updateOrder/" + order_id);
}

function fillFormData(order) {
	console.log(order);
	$("input[name='dimensional_weight']").val(order.dimensional_weight);
	$("input[name='dimensional_length']").val(order.dimensional_length);
	$("input[name='dimensional_width']").val(order.dimensional_width);
	$("input[name='dimensional_height']").val(order.dimensional_height);
	$("input[name='dimensional_size']").val(order.dimensional_size);
	$("input[name='package_weight']").val(order.package_weight);
	$("input[name='total_shipments']").val(order.total_shipments);
	$("input[name='pickupNotes']").val(order.pickup_comments);
	$("input[name='payment_method_notes']").val(order.comment);
	$("input[name='receive_from']").val(order.receive_time_from);
	$("input[name='receive_to']").val(order.receive_time_to);
	$("#shipping_method").val(order.shipping_method_id);

	$('.packaging_type input[value=' + order.packaging_type_id + ']').prop('checked', true);

	$("#notes").val(order.comment);

	$('input[value=' + order.payment_method_id + '].payment_method ').prop('checked', true).change();
	$(".payment_info" + order.payment_method_id).val(order.payment_method_info);

	if(order.service_kind)
	{
		$.each(order.service_kind.split(","), function(key, value)
		{
			$('input[value=' + value + '].service_kind ').prop('checked', true);
		});
	}

	if(order.from_client_id){
		$("input[name='SenderClientExistsID']").val(order.from_client_id);
		$("input[name='sender_name']").val(order.sender);
		$("input[name='holder_sender_name']").val(order.sender_name);
		$("input[name='account_number']").val(order.account_number);
		$("input[name='sender_company_name']").val(order.sender_company);
		$("input[name='sender_address1']").val(order.sender_address);
		$("input[name='sender_address2']").val(order.sender_address2);
		$("input[name='sender_postal']").val(order.sender_postal);
		$("input[name='sender_mobile1']").val(order.sender_mobile);

		if(order.sender_country_id){
		    //change event is triggered to load the cities
		    $("#sender_country").val(order.sender_country_id).change();
		    $("#sender_country").valid();
		    if(order.sender_city_id){
		        //timeout for the cities to be loaded from the server dynamically and same for the districts
		        setTimeout(function(){
		            $("#sender_city").val(order.sender_city_id).change();
		            $("#sender_city").valid();
		            if(order.sender_district_id){
		                setTimeout(function(){
		                    $("#sender_region").val(order.sender_district_id).change();
		                    $("#sender_region").valid();
		                }, 1500)
		            }
		        }, 1500);
		    }
		}
	}

	if(order.to_client_id){
		$("input[name='ReceiverClientExistsID']").val(order.to_client_id);
		$("input[name='receiver_name']").val(order.receiver);
		$("input[name='holder_receiver_name']").val(order.receiver_name);
		$("input[name='receiver_company_name']").val(order.receiver_company);
		$("input[name='receiver_address1']").val(order.receiver_address);
		$("input[name='receiver_address2']").val(order.receiver_address2);
		$("input[name='receiver_postal']").val(order.receiver_postal);
		$("input[name='receiver_mobile1']").val(order.receiver_mobile);

		if(order.receiver_country_id){
		    //change event is triggered to load the cities
		    $("#receiver_country").val(order.receiver_country_id).change();
		    $("#receiver_country").valid();
		    if(order.receiver_city_id){
		        //timeout for the cities to be loaded from the server dynamically and same for the districts
		        setTimeout(function(){
		            $("#receiver_city").val(order.receiver_city_id).change();
		            $("#receiver_city").valid();
		            if(order.receiver_district_id){
		                setTimeout(function(){
		                    $("#receiver_region").val(order.receiver_district_id).change();
		                    $("#receiver_region").valid();
		                }, 1500)
		            }
		        }, 1500);
		    }
		}
	}
}

$(function() {
    $("input[name='total_shipments']").bind('keyup', function(event) {
        var currValue = $(this).val();

        $(this).val(currValue.replace(/[^0-9]/, ''));
    });
});

/**
 * Extracts the browser name and version number from user agent string.
 *
 * @param userAgent
 *            The user agent string to parse. If not specified, the contents of
 *            navigator.userAgent are parsed.
 * @param elements
 *            How many elements of the version number should be returned. A
 *            value of 0 means the whole version. If not specified, defaults to
 *            2 (major and minor release number).
 * @return A string containing the browser name and version number, or null if
 *         the user agent string is unknown.
 */
function identifyBrowser(userAgent, elements) {
    var regexps = {
            'Chrome': [ /Chrome\/(\S+)/ ],
            'Firefox': [ /Firefox\/(\S+)/ ],
            'MSIE': [ /MSIE (\S+);/ ],
            'Opera': [
                /Opera\/.*?Version\/(\S+)/,     /* Opera 10 */
                /Opera\/(\S+)/                  /* Opera 9 and older */
            ],
            'Safari': [ /Version\/(\S+).*?Safari\// ]
        },
        re, m, browser, version;
 
    if (userAgent === undefined)
        userAgent = navigator.userAgent;
 
    if (elements === undefined)
        elements = 2;
    else if (elements === 0)
        elements = 1337;
 
    for (browser in regexps)
        while (re = regexps[browser].shift())
            if (m = userAgent.match(re)) {
                version = (m[1].match(new RegExp('[^.]+(?:\.[^.]+){0,' + --elements + '}')))[0];
                return browser;
            }
 
    return null;
}

$(".datetimepicker").change(function(e){
	console.log("changing");
	if(new Date($(this).val()) < new Date()){
		console.log("less");
		$(this).val(dateNow);
	}
});

$("#sender_city").change(function(){
	$("#sender_city").valid();
});

$("#sender_region").change(function(){
	$("#sender_region").valid();
});

$("#receiver_city").change(function(){
	$("#receiver_city").valid();
});

$("#receiver_region").change(function(){
	$("#receiver_region").valid();
});