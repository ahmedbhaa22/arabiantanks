$(document).ready(function() {

    // process the form
    $('#form_reponse_replay').submit(function(event) {

        // get the form data
        // there are many ways to get this data using jQuery (you can use the class or id also)
        var formData = {
            'Replay'              : $('#fieldReplay').val(),
            'Email'             : $('#fieldEmail').val(),
            'ID' : $("#ID").val(),
        };

        // process the form
        $.ajax({
            type        : 'POST', // define the type of HTTP verb we want to use (POST for our form)
            url         : main_url+"data_forms_response/replayform/'", // the url where we want to POST
            data        : formData, // our data object
        })
        // using the done promise callback
            .done(function(data) {

                // log data to the console so we can see
                console.log(data);
                $('.ajax-messages').val(data);
                location.reload();




                // here we will handle errors and validation messages
            });

        // stop the form from submitting the normal way and refreshing the page
        event.preventDefault();
    });

});