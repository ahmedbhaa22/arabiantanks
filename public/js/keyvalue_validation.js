//.KvDate 
$('.KvDate').datepicker({

	format: 'dd-mm-yyyy',

});



//.KvNumber
$('.KvNumber').attr('type', 'number');




//.KvMobile
$('.KvMobile').attr('type', 'mobile');





//.KvMail
$('.KvMail').attr('type', 'email');





//.KvDateTime
$('.KvDateTime').datetimepicker();





//.KvPassword
$('.KvPassword').attr('type', 'password');





//.KvTime
$('.KvTime').datetimepicker({
	datepicker: false,
	format: 'H:i'
});




//.KvLink
$('.KvLink').attr('type', 'url');




//.KvGMap



jQuery.validator.addClassRules("KvRequired", {
	required: true,
});

jQuery.validator.addClassRules("checkMoodLength", {
	required: true,

});

//goAPP special cases
// $("#newContent20195").submit(function(e){
// 	if ($('.checkMoodLength:checked').length < 3) {
// 		alert("Check At Least 3 Moods");
// 		return false;
// 	}
// 	if ($('.checkTypeLength:checked').length < 3) {
// 		alert("Check At Least 3 People Types");
// 		return false;
// 	}
// 	if ($('.checkOutInLength:checked').length < 1) {
// 		alert("Check At Least one outdoor/indoor");
// 		return false;
// 	}
//
//
// });
//
// $("#editContent20195").submit(function(e){
// 	if ($('.checkMoodLength:checked').length < 3) {
// 		alert("Check At Least 3 Moods");
// 		return false;
// 	}
// 	if ($('.checkTypeLength:checked').length < 3) {
// 		alert("Check At Least 3 People Types");
// 		return false;
// 	}
// 	if ($('.checkOutInLength:checked').length < 1) {
// 		alert("Check At Least  one outdoor/indoor");
// 		return false;
// 	}
//
// });

