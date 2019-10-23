
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
                package_weight: {required: !0},
                total_shipments: {required: !0},
                // receiver_city_id: {required: !0},
                receiver_address: {required: !0},
                // receiver_district_id: {required: !0},
                // receiver_country_id: {required: !0},


                sender_address: {required: !0},
                // sender_district_id: {required: !0},
                // sender_country_id: {required: !0},
                // sender_city_id: {required: !0},
                "service_kind[]": {required: !0, minlength:1},
                payment_method_id: {required: !0}
            },

            messages: {
                package_weight:{
                    required:'هذا الحقل مطلوب'
                },
                total_shipments:{
                    required:'هذا الحقل مطلوب'
                },
                receiver_city_id:{
                    required:'هذا الحقل مطلوب'
                },
                receiver_address:{
                    required:'هذا الحقل مطلوب'
                },
                receiver_district_id:{
                    required:'هذا الحقل مطلوب'
                },
                receiver_country_id:{
                    required:'هذا الحقل مطلوب'
                },
                signaturesSenderList:{
                    required:'هذا الحقل مطلوب'
                },
                receiver_name:{
                    required:'هذا الحقل مطلوب'
                },
                signatures_distributor_id:{
                    required:'هذا الحقل مطلوب'
                },
                signaturesReceiverList:{
                    required:'هذا الحقل مطلوب'
                },
                sender_name:{
                    required:'هذا الحقل مطلوب'
                },
                sender_address:{
                    required:'هذا الحقل مطلوب'
                },
                sender_district_id:{
                    required:'هذا الحقل مطلوب'
                },
                sender_country_id:{
                    required:'هذا الحقل مطلوب'
                },
                sender_city_id:{
                    required:'هذا الحقل مطلوب'
                },
                payment_method_id:{
                    required:'هذا الحقل مطلوب'
                },
                "service_kind[]":{
                    required:'هذا الحقل مطلوب'
                }
            },

            invalidHandler: function (e, t) {
                i.hide(), r.show(), App.scrollTo(r, -200)
            },
            highlight: function (e) {
                $(e).closest('.form-group').addClass('has-error')
            },
            unhighlight: function (e) {
                $(e).closest('.form-group').removeClass('has-error')
            },
            success: function (e) {
                e.closest('.form-group').removeClass('has-error')
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
    FormValidation.init()
});
