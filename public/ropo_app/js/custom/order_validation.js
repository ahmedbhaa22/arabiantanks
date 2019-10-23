
//validation
var FormValidation = function () {
    var e = function () {
        var e = $('#new_order_form'), r = $('.alert-danger', e), i = $('.alert-success', e);

        e.validate({
            errorElement: 'span',
            errorClass: 'help-block help-block-error',
            focusInvalid: !1,
            ignore: '',
            rules: {
                packaging_type: {required: !0},
                package_weight: {required: !0},
                total_shipments: {required: !0},
                // receiver_city_id: {required: !0},
                receiver_address1: {required: !0},
                receiver_name: {required: !0},
                // receiver_district_id: {required: !0},
                // receiver_country_id: {required: !0},

                // signaturesSenderList: {required: !0},
                // signaturesReceiverList: {required: !0},

                sender_name: {
                    required: !0, 
                    // regx: /^[a-zA-Z0-9!@#\$%\^\&*\)\(+=._-]+$/g
                },
                sender_address1: {required: !0},
                sender_mobile1: {required: !0},
                receiver_mobile1: {required: !0},
                sender_city: {required: !0},
                sender_region: {required: !0},
                receiver_region: {required: !0},
                receiver_city: {required: !0},
                // sender_district_id: {required: !0},
                // sender_country_id: {required: !0},
                // sender_city_id: {required: !0},
                "service_kind[]": {required: !0, minlength:1},
                payment_method_id: {required: !0}
            },

            errorPlacement: function(error, element) {

                  error.insertAfter(element);

            },
            messages: {
                packaging_type:{
                    required: '* مطلوب'
                },
                package_weight:{
                    required: '* مطلوب'
                },
                total_shipments:{
                    required: '* مطلوب'
                },
                receiver_city_id:{
                    required: '* مطلوب'
                },
                receiver_address1:{
                    required: '* مطلوب'
                },
                receiver_district_id:{
                    required: '* مطلوب'
                },
                receiver_country_id:{
                    required: '* مطلوب'
                },
                signaturesSenderList:{
                    required: '* مطلوب'
                },
                receiver_name:{
                    required: '* مطلوب'
                },
                signatures_distributor_id:{
                    required: '* مطلوب'
                },
                signaturesReceiverList:{
                    required: '* مطلوب'
                },
                sender_name:{
                    required: '* مطلوب'
                },
                sender_address1:{
                    required: '* مطلوب'
                },
                sender_mobile1:{
                    required: '* مطلوب'
                },
                receiver_mobile1:{
                    required: '* مطلوب'
                },
                sender_city:{
                    required: '* مطلوب'
                },
                sender_region:{
                    required: '* مطلوب'
                },
                receiver_city:{
                    required: '* مطلوب'
                },
                receiver_region:{
                    required: '* مطلوب'
                },
                sender_district_id:{
                    required: '* مطلوب'
                },
                sender_country_id:{
                    required: '* مطلوب'
                },
                sender_city_id:{
                    required: '* مطلوب'
                },
                payment_method_id:{
                    required: '* مطلوب'
                },
                "service_kind[]":{
                    required: '* مطلوب'
                }
            },

            invalidHandler: function (e, t) {
                i.hide(), r.show(), App.scrollTo(r, -200)
            },
            highlight: function (e) {
              //  debugger;
                  $(e).closest('.form-group').addClass('has-error')
            },
            unhighlight: function (e) {
                if($(e).attr('id') == "sender_address2" || $(e).attr('id') == "receiver_address2" || $(e).attr('id') == "package_weight" || $(e).attr('id') == "total_shipments" ){
                    return;
                }
                if($(e).attr('name') == "service_kind[]" ){
                    $(e).closest('.form-group').removeClass('has-error')
                }
            },
            success: function (e) {
                // $(e).closest('.form-group').removeClass('has-error')
            },
            submitHandler: function (e) {
                i.show(), r.hide(), ajaxCall_1_add_pop_up_1()
            }
        })
    }, t = function () {
        jQuery().wysihtml5 && $('.wysihtml5').size() > 0 && $('.wysihtml5').wysihtml5({stylesheets: ['/sysForm/global/plugins/bootstrap-wysihtml5/wysiwyg-color.css']})
    };
    return {
        init: function () {
            t(), e()
        }
    }
}();
jQuery(document).ready(function () {
    $.validator.addMethod("regx", function(value, element, regexpr) {
        return regexpr.test(value);
    }, "Invalid characters");
    FormValidation.init()
});
