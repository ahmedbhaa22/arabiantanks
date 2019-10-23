$(document).ready(function() {
    $("#newContent").validate({
        ignore: [],

    });
    $(document).ready(function(){
        tinymce.init({
            selector: '#fieldContent'
        });
    });

    //content delete ajax


});
function confirm_delete() {
   return confirm("هل أنت متأكد ؟");
}




$("#filter-toggle-btn").click(function(){
    $("#filter-toggle").toggle();
});

$(".kv-group-title h2").click(function(){
    $("#filter-toggle").toggle();
});
