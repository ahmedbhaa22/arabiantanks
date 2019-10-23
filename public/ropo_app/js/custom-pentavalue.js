

//*******************app.js************************//
var App = function () {
    var t, e = !1, o = !1, a = !1, i = !1, n = [], l = "../assets/", s = "global/img/", r = "global/plugins/", c = "global/css/", d = {
        blue: "#89C4F4",
        red: "#F3565D",
        green: "#1bbc9b",
        purple: "#9b59b6",
        grey: "#95a5a6",
        yellow: "#F8CB00"
    }, p = function () {
        "rtl" === $("body").css("direction") && (e = !0), o = !!navigator.userAgent.match(/MSIE 8.0/), a = !!navigator.userAgent.match(/MSIE 9.0/), i = !!navigator.userAgent.match(/MSIE 10.0/), i && $("html").addClass("ie10"), (i || a || o) && $("html").addClass("ie")
    }, h = function () {
        for (var t = 0; t < n.length; t++) {
            var e = n[t];
            e.call()
        }
    }, u = function () {
        var t;
        if (o) {
            var e;
            $(window).resize(function () {
                e != document.documentElement.clientHeight && (t && clearTimeout(t), t = setTimeout(function () {
                    h()
                }, 50), e = document.documentElement.clientHeight)
            })
        } else $(window).resize(function () {
            t && clearTimeout(t), t = setTimeout(function () {
                h()
            }, 50)
        })
    }, f = function () {
        $("body").on("click", ".portlet > .portlet-title > .tools > a.remove", function (t) {
            t.preventDefault();
            var e = $(this).closest(".portlet");
            $("body").hasClass("page-portlet-fullscreen") && $("body").removeClass("page-portlet-fullscreen"), e.find(".portlet-title .fullscreen").tooltip("destroy"), e.find(".portlet-title > .tools > .reload").tooltip("destroy"), e.find(".portlet-title > .tools > .remove").tooltip("destroy"), e.find(".portlet-title > .tools > .config").tooltip("destroy"), e.find(".portlet-title > .tools > .collapse, .portlet > .portlet-title > .tools > .expand").tooltip("destroy"), e.remove()
        }), $("body").on("click", ".portlet > .portlet-title .fullscreen", function (t) {
            t.preventDefault();
            var e = $(this).closest(".portlet");
            if (e.hasClass("portlet-fullscreen"))$(this).removeClass("on"), e.removeClass("portlet-fullscreen"), $("body").removeClass("page-portlet-fullscreen"), e.children(".portlet-body").css("height", "auto"); else {
                var o = App.getViewPort().height - e.children(".portlet-title").outerHeight() - parseInt(e.children(".portlet-body").css("padding-top")) - parseInt(e.children(".portlet-body").css("padding-bottom"));
                $(this).addClass("on"), e.addClass("portlet-fullscreen"), $("body").addClass("page-portlet-fullscreen"), e.children(".portlet-body").css("height", o)
            }
        }), $("body").on("click", ".portlet > .portlet-title > .tools > a.reload", function (t) {
            t.preventDefault();
            var e = $(this).closest(".portlet").children(".portlet-body"), o = $(this).attr("data-url"), a = $(this).attr("data-error-display");
            o ? (App.blockUI({target: e, animate: !0, overlayColor: "none"}), $.ajax({
                type: "GET",
                cache: !1,
                url: o,
                dataType: "html",
                success: function (t) {
                    App.unblockUI(e), e.html(t), App.initAjax()
                },
                error: function (t, o, i) {
                    App.unblockUI(e);
                    var n = "Error on reloading the content. Please check your connection and try again.";
                    "toastr" == a && toastr ? toastr.error(n) : "notific8" == a && $.notific8 ? ($.notific8("zindex", 11500), $.notific8(n, {
                        theme: "ruby",
                        life: 3e3
                    })) : alert(n)
                }
            })) : (App.blockUI({target: e, animate: !0, overlayColor: "none"}), window.setTimeout(function () {
                App.unblockUI(e)
            }, 1e3))
        }), $('.portlet .portlet-title a.reload[data-load="true"]').click(), $("body").on("click", ".portlet > .portlet-title > .tools > .collapse, .portlet .portlet-title > .tools > .expand", function (t) {
            t.preventDefault();
            var e = $(this).closest(".portlet").children(".portlet-body");
            $(this).hasClass("collapse") ? ($(this).removeClass("collapse").addClass("expand"), e.slideUp(200)) : ($(this).removeClass("expand").addClass("collapse"), e.slideDown(200))
        })
    }, b = function () {
        if ($("body").on("click", ".md-checkbox > label, .md-radio > label", function () {
                var t = $(this), e = $(this).children("span:first-child");
                e.addClass("inc");
                var o = e.clone(!0);
                e.before(o), $("." + e.attr("class") + ":last", t).remove()
            }), $("body").hasClass("page-md")) {
            var t, e, o, a, i;
            $("body").on("click", "a.btn, button.btn, input.btn, label.btn", function (n) {
                t = $(this), 0 == t.find(".md-click-circle").length && t.prepend("<span class='md-click-circle'></span>"), e = t.find(".md-click-circle"), e.removeClass("md-click-animate"), e.height() || e.width() || (o = Math.max(t.outerWidth(), t.outerHeight()), e.css({
                    height: o,
                    width: o
                })), a = n.pageX - t.offset().left - e.width() / 2, i = n.pageY - t.offset().top - e.height() / 2, e.css({
                    top: i + "px",
                    left: a + "px"
                }).addClass("md-click-animate"), setTimeout(function () {
                    e.remove()
                }, 1e3)
            })
        }
        var n = function (t) {
            "" != t.val() ? t.addClass("edited") : t.removeClass("edited")
        };
        $("body").on("keydown", ".form-md-floating-label .form-control", function (t) {
            n($(this))
        }), $("body").on("blur", ".form-md-floating-label .form-control", function (t) {
            n($(this))
        }), $(".form-md-floating-label .form-control").each(function () {
            $(this).val().length > 0 && $(this).addClass("edited")
        })
    }, g = function () {
        $().iCheck && $(".icheck").each(function () {
            var t = $(this).attr("data-checkbox") ? $(this).attr("data-checkbox") : "icheckbox_minimal-grey", e = $(this).attr("data-radio") ? $(this).attr("data-radio") : "iradio_minimal-grey";
            t.indexOf("_line") > -1 || e.indexOf("_line") > -1 ? $(this).iCheck({
                checkboxClass: t,
                radioClass: e,
                insert: '<div class="icheck_line-icon"></div>' + $(this).attr("data-label")
            }) : $(this).iCheck({checkboxClass: t, radioClass: e})
        })
    }, m = function () {
        $().bootstrapSwitch && $(".make-switch").bootstrapSwitch()
    }, v = function () {
        $().confirmation && $("[data-toggle=confirmation]").confirmation({
            btnOkClass: "btn btn-sm btn-success",
            btnCancelClass: "btn btn-sm btn-danger"
        })
    }, y = function () {
        $("body").on("shown.bs.collapse", ".accordion.scrollable", function (t) {
            App.scrollTo($(t.target))
        })
    }, C = function () {
        if (location.hash) {
            var t = encodeURI(location.hash.substr(1));
            $('a[href="#' + t + '"]').parents(".tab-pane:hidden").each(function () {
                var t = $(this).attr("id");
                $('a[href="#' + t + '"]').click()
            }), $('a[href="#' + t + '"]').click()
        }
        $().tabdrop && $(".tabbable-tabdrop .nav-pills, .tabbable-tabdrop .nav-tabs").tabdrop({text: '<i class="fa fa-ellipsis-v"></i>&nbsp;<i class="fa fa-angle-down"></i>'})
    }, x = function () {
        $("body").on("hide.bs.modal", function () {
            $(".modal:visible").size() > 1 && $("html").hasClass("modal-open") === !1 ? $("html").addClass("modal-open") : $(".modal:visible").size() <= 1 && $("html").removeClass("modal-open")
        }), $("body").on("show.bs.modal", ".modal", function () {
            $(this).hasClass("modal-scroll") && $("body").addClass("modal-open-noscroll")
        }), $("body").on("hidden.bs.modal", ".modal", function () {
            $("body").removeClass("modal-open-noscroll")
        }), $("body").on("hidden.bs.modal", ".modal:not(.modal-cached)", function () {
            $(this).removeData("bs.modal")
        })
    }, w = function () {
        $(".tooltips").tooltip(), $(".portlet > .portlet-title .fullscreen").tooltip({
            trigger: "hover",
            container: "body",
            title: "Fullscreen"
        }), $(".portlet > .portlet-title > .tools > .reload").tooltip({
            trigger: "hover",
            container: "body",
            title: "Reload"
        }), $(".portlet > .portlet-title > .tools > .remove").tooltip({
            trigger: "hover",
            container: "body",
            title: "Remove"
        }), $(".portlet > .portlet-title > .tools > .config").tooltip({
            trigger: "hover",
            container: "body",
            title: "Settings"
        }), $(".portlet > .portlet-title > .tools > .collapse, .portlet > .portlet-title > .tools > .expand").tooltip({
            trigger: "hover",
            container: "body",
            title: "Collapse/Expand"
        })
    }, k = function () {
        $("body").on("click", ".dropdown-menu.hold-on-click", function (t) {
            t.stopPropagation()
        })
    }, I = function () {
        $("body").on("click", '[data-close="alert"]', function (t) {
            $(this).parent(".alert").hide(), $(this).closest(".note").hide(), t.preventDefault()
        }), $("body").on("click", '[data-close="note"]', function (t) {
            $(this).closest(".note").hide(), t.preventDefault()
        }), $("body").on("click", '[data-remove="note"]', function (t) {
            $(this).closest(".note").remove(), t.preventDefault()
        })
    }, A = function () {
        $('[data-hover="dropdown"]').not(".hover-initialized").each(function () {
            $(this).dropdownHover(), $(this).addClass("hover-initialized")
        })
    }, z = function () {
        "function" == typeof autosize && autosize(document.querySelector("textarea.autosizeme"))
    //}, S = function () {
    //    $(".popovers").popover(), $(document).on("click.bs.popover.data-api", function (e) {
    //        t && t.popover("hide")
    //    })
    }, P = function () {
        App.initSlimScroll(".scroller")
    }, T = function () {
        jQuery.fancybox && $(".fancybox-button").size() > 0 && $(".fancybox-button").fancybox({
            groupAttr: "data-rel",
            prevEffect: "none",
            nextEffect: "none",
            closeBtn: !0,
            helpers: {title: {type: "inside"}}
        })
    }, D = function () {
        $().counterUp && $("[data-counter='counterup']").counterUp({delay: 10, time: 1e3})
    }, U = function () {
        (o || a) && $("input[placeholder]:not(.placeholder-no-fix), textarea[placeholder]:not(.placeholder-no-fix)").each(function () {
            var t = $(this);
            "" === t.val() && "" !== t.attr("placeholder") && t.addClass("placeholder").val(t.attr("placeholder")), t.focus(function () {
                t.val() == t.attr("placeholder") && t.val("")
            }), t.blur(function () {
                "" !== t.val() && t.val() != t.attr("placeholder") || t.val(t.attr("placeholder"))
            })
        })
    }, E = function () {
        $().select2 && ($.fn.select2.defaults.set("theme", "bootstrap"), $(".select2me").select2({
            placeholder: "Select",
            width: "auto",
            allowClear: !0
        }))
    }, G = function () {
        $("[data-auto-height]").each(function () {
            var t = $(this), e = $("[data-height]", t), o = 0, a = t.attr("data-mode"), i = parseInt(t.attr("data-offset") ? t.attr("data-offset") : 0);
            e.each(function () {
                "height" == $(this).attr("data-height") ? $(this).css("height", "") : $(this).css("min-height", "");
                var t = "base-height" == a ? $(this).outerHeight() : $(this).outerHeight(!0);
                t > o && (o = t)
            }), o += i, e.each(function () {
                "height" == $(this).attr("data-height") ? $(this).css("height", o) : $(this).css("min-height", o)
            }), t.attr("data-related") && $(t.attr("data-related")).css("height", t.height())
        })
    };
    return {
        init: function () {
            p(), u(), b(), g(), m(), P(), T(), E(), f(), I(), k(), C(), w(),  this.addResizeHandler(G), U()
        }, initAjax: function () {
            g(), m(), A(), P(), E(), T(), k(), w(), S(), y(), v()
        }, initComponents: function () {
            this.initAjax()
        }, setLastPopedPopover: function (e) {
            t = e
        }, addResizeHandler: function (t) {
            n.push(t)
        }, runResizeHandlers: function () {
            h()
        }, scrollTo: function (t, e) {
            var o = t && t.size() > 0 ? t.offset().top : 0;
            t && ($("body").hasClass("page-header-fixed") ? o -= $(".page-header").height() : $("body").hasClass("page-header-top-fixed") ? o -= $(".page-header-top").height() : $("body").hasClass("page-header-menu-fixed") && (o -= $(".page-header-menu").height()), o += e ? e : -1 * t.height()), $("html,body").animate({scrollTop: o}, "slow")
        }, initSlimScroll: function (t) {
            $().slimScroll && $(t).each(function () {
                if (!$(this).attr("data-initialized")) {
                    var t;
                    t = $(this).attr("data-height") ? $(this).attr("data-height") : $(this).css("height"), $(this).slimScroll({
                        allowPageScroll: !0,
                        size: "7px",
                        color: $(this).attr("data-handle-color") ? $(this).attr("data-handle-color") : "#bbb",
                        wrapperClass: $(this).attr("data-wrapper-class") ? $(this).attr("data-wrapper-class") : "slimScrollDiv",
                        railColor: $(this).attr("data-rail-color") ? $(this).attr("data-rail-color") : "#eaeaea",
                        position: e ? "left" : "right",
                        height: t,
                        alwaysVisible: "1" == $(this).attr("data-always-visible"),
                        railVisible: "1" == $(this).attr("data-rail-visible"),
                        disableFadeOut: !0
                    }), $(this).attr("data-initialized", "1")
                }
            })
        }, destroySlimScroll: function (t) {
            $().slimScroll && $(t).each(function () {
                if ("1" === $(this).attr("data-initialized")) {
                    $(this).removeAttr("data-initialized"), $(this).removeAttr("style");
                    var t = {};
                    $(this).attr("data-handle-color") && (t["data-handle-color"] = $(this).attr("data-handle-color")), $(this).attr("data-wrapper-class") && (t["data-wrapper-class"] = $(this).attr("data-wrapper-class")), $(this).attr("data-rail-color") && (t["data-rail-color"] = $(this).attr("data-rail-color")), $(this).attr("data-always-visible") && (t["data-always-visible"] = $(this).attr("data-always-visible")), $(this).attr("data-rail-visible") && (t["data-rail-visible"] = $(this).attr("data-rail-visible")), $(this).slimScroll({
                        wrapperClass: $(this).attr("data-wrapper-class") ? $(this).attr("data-wrapper-class") : "slimScrollDiv",
                        destroy: !0
                    });
                    var e = $(this);
                    $.each(t, function (t, o) {
                        e.attr(t, o)
                    })
                }
            })
        }, scrollTop: function () {
            App.scrollTo()
        }, blockUI: function (t) {
            t = $.extend(!0, {}, t);
            var e = "";
            if (e = t.animate ? '<div class="loading-message ' + (t.boxed ? "loading-message-boxed" : "") + '"><div class="block-spinner-bar"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div></div>' : t.iconOnly ? '<div class="loading-message ' + (t.boxed ? "loading-message-boxed" : "") + '"><img src="' + this.getGlobalImgPath() + 'loading-spinner-grey.gif" align=""></div>' : t.textOnly ? '<div class="loading-message ' + (t.boxed ? "loading-message-boxed" : "") + '"><span>&nbsp;&nbsp;' + (t.message ? t.message : "LOADING...") + "</span></div>" : '<div class="loading-message ' + (t.boxed ? "loading-message-boxed" : "") + '"><img src="' + this.getGlobalImgPath() + 'loading-spinner-grey.gif" align=""><span>&nbsp;&nbsp;' + (t.message ? t.message : "LOADING...") + "</span></div>", t.target) {
                var o = $(t.target);
                o.height() <= $(window).height() && (t.cenrerY = !0), o.block({
                    message: e,
                    baseZ: t.zIndex ? t.zIndex : 1e3,
                    centerY: void 0 !== t.cenrerY ? t.cenrerY : !1,
                    css: {top: "10%", border: "0", padding: "0", backgroundColor: "none"},
                    overlayCSS: {
                        backgroundColor: t.overlayColor ? t.overlayColor : "#555",
                        opacity: t.boxed ? .05 : .1,
                        cursor: "wait"
                    }
                })
            } else $.blockUI({
                message: e,
                baseZ: t.zIndex ? t.zIndex : 1e3,
                css: {border: "0", padding: "0", backgroundColor: "none"},
                overlayCSS: {
                    backgroundColor: t.overlayColor ? t.overlayColor : "#555",
                    opacity: t.boxed ? .05 : .1,
                    cursor: "wait"
                }
            })
        }, unblockUI: function (t) {
            t ? $(t).unblock({
                onUnblock: function () {
                    $(t).css("position", ""), $(t).css("zoom", "")
                }
            }) : $.unblockUI()
        }, startPageLoading: function (t) {
            t && t.animate ? ($(".page-spinner-bar").remove(), $("body").append('<div class="page-spinner-bar"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>')) : ($(".page-loading").remove(), $("body").append('<div class="page-loading"><img src="' + this.getGlobalImgPath() + 'loading-spinner-grey.gif"/>&nbsp;&nbsp;<span>' + (t && t.message ? t.message : "Loading...") + "</span></div>"))
        }, stopPageLoading: function () {
            $(".page-loading, .page-spinner-bar").remove()
        }, alert: function (t) {
            t = $.extend(!0, {
                container: "",
                place: "append",
                type: "success",
                message: "",
                close: !0,
                reset: !0,
                focus: !0,
                closeInSeconds: 0,
                icon: ""
            }, t);
            var e = App.getUniqueID("App_alert"), o = '<div id="' + e + '" class="custom-alerts alert alert-' + t.type + ' fade in">' + (t.close ? '<button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>' : "") + ("" !== t.icon ? '<i class="fa-lg fa fa-' + t.icon + '"></i>  ' : "") + t.message + "</div>";
            return t.reset && $(".custom-alerts").remove(), t.container ? "append" == t.place ? $(t.container).append(o) : $(t.container).prepend(o) : 1 === $(".page-fixed-main-content").size() ? $(".page-fixed-main-content").prepend(o) : ($("body").hasClass("page-container-bg-solid") || $("body").hasClass("page-content-white")) && 0 === $(".page-head").size() ? $(".page-title").after(o) : $(".page-bar").size() > 0 ? $(".page-bar").after(o) : $(".page-breadcrumb, .breadcrumbs").after(o), t.focus && App.scrollTo($("#" + e)), t.closeInSeconds > 0 && setTimeout(function () {
                $("#" + e).remove()
            }, 1e3 * t.closeInSeconds), e
        }, initFancybox: function () {
            T()
        }, getActualVal: function (t) {
            return t = $(t), t.val() === t.attr("placeholder") ? "" : t.val()
        }, getURLParameter: function (t) {
            var e, o, a = window.location.search.substring(1), i = a.split("&");
            for (e = 0; e < i.length; e++)if (o = i[e].split("="), o[0] == t)return unescape(o[1]);
            return null
        }, isTouchDevice: function () {
            try {
                return document.createEvent("TouchEvent"), !0
            } catch (t) {
                return !1
            }
        }, getViewPort: function () {
            var t = window, e = "inner";
            return "innerWidth"in window || (e = "client", t = document.documentElement || document.body), {
                width: t[e + "Width"],
                height: t[e + "Height"]
            }
        }, getUniqueID: function (t) {
            return "prefix_" + Math.floor(Math.random() * (new Date).getTime())
        }, isIE8: function () {
            return o
        }, isIE9: function () {
            return a
        }, isRTL: function () {
            return e
        }, isAngularJsApp: function () {
            return "undefined" != typeof angular
        }, getAssetsPath: function () {
            return l
        }, setAssetsPath: function (t) {
            l = t
        }, setGlobalImgPath: function (t) {
            s = t
        }, getGlobalImgPath: function () {
            return l + s
        }, setGlobalPluginsPath: function (t) {
            r = t
        }, getGlobalPluginsPath: function () {
            return l + r
        }, getGlobalCssPath: function () {
            return l + c
        }, getBrandColor: function (t) {
            return d[t] ? d[t] : ""
        }, getResponsiveBreakpoint: function (t) {
            var e = {xs: 480, sm: 768, md: 992, lg: 1200};
            return e[t] ? e[t] : 0
        }
    }
}();
jQuery(document).ready(function () {
    App.init()
});

//*******************profile.js************************//
//var Profile = function () {
//    return {
//        init: function () {
//            Profile.initMiniCharts()
//        }, initMiniCharts: function () {
//            App.isIE8() && !Function.prototype.bind && (Function.prototype.bind = function (t) {
//                if ("function" != typeof this)throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
//                var i = Array.prototype.slice.call(arguments, 1), r = this, n = function () {
//                }, o = function () {
//                    return r.apply(this instanceof n && t ? this : t, i.concat(Array.prototype.slice.call(arguments)))
//                };
//                return n.prototype = this.prototype, o.prototype = new n, o
//            }), $("#sparkline_bar").sparkline([8, 9, 10, 11, 10, 10, 12, 10, 10, 11, 9, 12, 11], {
//                type: "bar",
//                width: "100",
//                barWidth: 6,
//                height: "45",
//                barColor: "#F36A5B",
//                negBarColor: "#e02222"
//            }), $("#sparkline_bar2").sparkline([9, 11, 12, 13, 12, 13, 10, 14, 13, 11, 11, 12, 11], {
//                type: "bar",
//                width: "100",
//                barWidth: 6,
//                height: "45",
//                barColor: "#5C9BD1",
//                negBarColor: "#e02222"
//            })
//        }
//    }
//}();
//App.isAngularJsApp() === !1 && jQuery(document).ready(function () {
//    Profile.init()
//});

//*******************table-datattable************************//
var TableDatatablesManaged = function () {

    var initTable1 = function () {

        var table = $('#sample_1');

        // begin first table
        table.dataTable({

            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "No data available in table",
                "info": "Showing _START_ to _END_ of _TOTAL_ records",
                "infoEmpty": "No records found",
                "infoFiltered": "(filtered1 from _MAX_ total records)",
                "lengthMenu": "Show _MENU_",
                "search": "Search:",
                "zeroRecords": "No matching records found",
                "paginate": {
                    "previous":"Prev",
                    "next": "Next",
                    "last": "Last",
                    "first": "First"
                }
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
            // So when dropdowns used the scrollable div should be removed.
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

            "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.

            "columnDefs": [ {
                "targets": 0,
                "orderable": false,
                "searchable": false
            }],

            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": 5,
            "pagingType": "bootstrap_full_number",
            "columnDefs": [{  // set default column settings
                'orderable': false,
                'targets': [0]
            }, {
                "searchable": false,
                "targets": [0]
            }],
            "order": [
                [1, "asc"]
            ] // set first column as a default sort by asc
        });

        var tableWrapper = jQuery('#sample_1_wrapper');

        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });
    }

    var initTable2 = function () {

        var table = $('#sample_2');

        table.dataTable({

            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "No data available in table",
                "info": "Showing _START_ to _END_ of _TOTAL_ records",
                "infoEmpty": "No records found",
                "infoFiltered": "(filtered1 from _MAX_ total records)",
                "lengthMenu": "Show _MENU_",
                "search": "Search:",
                "zeroRecords": "No matching records found",
                "paginate": {
                    "previous":"Prev",
                    "next": "Next",
                    "last": "Last",
                    "first": "First"
                }
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
            // So when dropdowns used the scrollable div should be removed.
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

            "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.

            "columnDefs": [ {
                "targets": 0,
                "orderable": false,
                "searchable": false
            }],

            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": 5,
            "pagingType": "bootstrap_full_number",
            "columnDefs": [{  // set default column settings
                'orderable': false,
                'targets': [0]
            }, {
                "searchable": false,
                "targets": [0]
            }],
            "order": [
                [1, "asc"]
            ] // set first column as a default sort by asc
        });

        var tableWrapper = jQuery('#sample_2_wrapper');

        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });
    }

    var initTable3 = function () {

        var table = $('#sample_3');

        // begin: third table
        table.dataTable({

            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "No data available in table",
                "info": "Showing _START_ to _END_ of _TOTAL_ records",
                "infoEmpty": "No records found",
                "infoFiltered": "(filtered1 from _MAX_ total records)",
                "lengthMenu": "Show _MENU_",
                "search": "Search:",
                "zeroRecords": "No matching records found",
                "paginate": {
                    "previous":"Prev",
                    "next": "Next",
                    "last": "Last",
                    "first": "First"
                }
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
            // So when dropdowns used the scrollable div should be removed.
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

            "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.

            "columnDefs": [ {
                "targets": 0,
                "orderable": false,
                "searchable": false
            }],

            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": 5,
            "pagingType": "bootstrap_full_number",
            "columnDefs": [{  // set default column settings
                'orderable': false,
                'targets': [0]
            }, {
                "searchable": false,
                "targets": [0]
            }],
            "order": [
                [1, "asc"]
            ] // set first column as a default sort by asc
        });

        var tableWrapper = jQuery('#sample_3_wrapper');

        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });

    }

    var initTable4 = function () {

        var table = $('#sample_4');

        // begin: third table
        table.dataTable({

            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "No data available in table",
                "info": "Showing _START_ to _END_ of _TOTAL_ records",
                "infoEmpty": "No records found",
                "infoFiltered": "(filtered1 from _MAX_ total records)",
                "lengthMenu": "Show _MENU_",
                "search": "Search:",
                "zeroRecords": "No matching records found",
                "paginate": {
                    "previous":"Prev",
                    "next": "Next",
                    "last": "Last",
                    "first": "First"
                }
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
            // So when dropdowns used the scrollable div should be removed.
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

            "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.

            "columnDefs": [ {
                "targets": 0,
                "orderable": false,
                "searchable": false
            }],

            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": 5,
            "pagingType": "bootstrap_full_number",
            "columnDefs": [{  // set default column settings
                'orderable': false,
                'targets': [0]
            }, {
                "searchable": false,
                "targets": [0]
            }],
            "order": [
                [1, "asc"]
            ] // set first column as a default sort by asc
        });

        var tableWrapper = jQuery('#sample_4_wrapper');

        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });

    }

    var initTable5 = function () {

        var table = $('#sample_5');

        // begin: third table
        table.dataTable({

            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "No data available in table",
                "info": "Showing _START_ to _END_ of _TOTAL_ records",
                "infoEmpty": "No records found",
                "infoFiltered": "(filtered1 from _MAX_ total records)",
                "lengthMenu": "Show _MENU_",
                "search": "Search:",
                "zeroRecords": "No matching records found",
                "paginate": {
                    "previous":"Prev",
                    "next": "Next",
                    "last": "Last",
                    "first": "First"
                }
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
            // So when dropdowns used the scrollable div should be removed.
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

            "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.

            "columnDefs": [ {
                "targets": 0,
                "orderable": false,
                "searchable": false
            }],

            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": 5,
            "pagingType": "bootstrap_full_number",
            "columnDefs": [{  // set default column settings
                'orderable': false,
                'targets': [0]
            }, {
                "searchable": false,
                "targets": [0]
            }],
            "order": [
                [1, "asc"]
            ] // set first column as a default sort by asc
        });

        var tableWrapper = jQuery('#sample_5_wrapper');

        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });

    }

    var initTable6 = function () {

        var table = $('#sample_6');

        // begin first table
        table.dataTable({

            // Internationalisation. For more info refer to http://datatables.net/manual/i18n
            "language": {
                "aria": {
                    "sortAscending": ": activate to sort column ascending",
                    "sortDescending": ": activate to sort column descending"
                },
                "emptyTable": "No data available in table",
                "info": "Showing _START_ to _END_ of _TOTAL_ records",
                "infoEmpty": "No records found",
                "infoFiltered": "(filtered1 from _MAX_ total records)",
                "lengthMenu": "Show _MENU_",
                "search": "Search:",
                "zeroRecords": "No matching records found",
                "paginate": {
                    "previous":"Prev",
                    "next": "Next",
                    "last": "Last",
                    "first": "First"
                }
            },

            // Or you can use remote translation file
            //"language": {
            //   url: '//cdn.datatables.net/plug-ins/3cfcc339e89/i18n/Portuguese.json'
            //},

            // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
            // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
            // So when dropdowns used the scrollable div should be removed.
            //"dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

            "bStateSave": true, // save datatable state(pagination, sort, etc) in cookie.

            "columnDefs": [ {
                "targets": 0,
                "orderable": false,
                "searchable": false
            }],

            "lengthMenu": [
                [5, 15, 20, -1],
                [5, 15, 20, "All"] // change per page values here
            ],
            // set the initial value
            "pageLength": 5,
            "pagingType": "bootstrap_full_number",
            "columnDefs": [{  // set default column settings
                'orderable': false,
                'targets': [0]
            }, {
                "searchable": false,
                "targets": [0]
            }],
            "order": [
                [1, "asc"]
            ] // set first column as a default sort by asc
        });

        var tableWrapper = jQuery('#sample_6_wrapper');

        table.find('.group-checkable').change(function () {
            var set = jQuery(this).attr("data-set");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });
        });

        table.on('change', 'tbody tr .checkboxes', function () {
            $(this).parents('tr').toggleClass("active");
        });
    }

    return {

        //main function to initiate the module
        init: function () {
            if (!jQuery().dataTable) {
                return;
            }
            initTable1();
            initTable2();
            initTable3();
            initTable4();
            initTable5();
            initTable6();
        }

    };

}();

if (App.isAngularJsApp() === false) {
    jQuery(document).ready(function() {
        TableDatatablesManaged.init();
    });
}

//*******************Dashboard.js************************//
var Dashboard = function() {

    return {

        initJQVMAP: function() {
            if (!jQuery().vectorMap) {
                return;
            }

            var showMap = function(name) {
                jQuery('.vmaps').hide();
                jQuery('#vmap_' + name).show();
            }

            var setMap = function(name) {
                var map = jQuery('#vmap_' + name);

                if (map.size() !== 1) {
                    return;
                }

                var data = {
                    map: 'world_en',
                    backgroundColor: null,
                    borderColor: '#333333',
                    borderOpacity: 0.5,
                    borderWidth: 1,
                    color: '#c6c6c6',
                    enableZoom: true,
                    hoverColor: '#c9dfaf',
                    hoverOpacity: null,
                    values: sample_data,
                    normalizeFunction: 'linear',
                    scaleColors: ['#b6da93', '#909cae'],
                    selectedColor: '#c9dfaf',
                    selectedRegion: null,
                    showTooltip: true,
                    onLabelShow: function(event, label, code) {

                    },
                    onRegionOver: function(event, code) {
                        if (code == 'ca') {
                            event.preventDefault();
                        }
                    },
                    onRegionClick: function(element, code, region) {
                        var message = 'You clicked "' + region + '" which has the code: ' + code.toUpperCase();
                        alert(message);
                    }
                };

                data.map = name + '_en';

                map.width(map.parent().parent().width());
                map.show();
                map.vectorMap(data);
                map.hide();
            }

            setMap("world");
            setMap("usa");
            setMap("europe");
            setMap("russia");
            setMap("germany");
            showMap("world");

            jQuery('#regional_stat_world').click(function() {
                showMap("world");
            });

            jQuery('#regional_stat_usa').click(function() {
                showMap("usa");
            });

            jQuery('#regional_stat_europe').click(function() {
                showMap("europe");
            });
            jQuery('#regional_stat_russia').click(function() {
                showMap("russia");
            });
            jQuery('#regional_stat_germany').click(function() {
                showMap("germany");
            });

            $('#region_statistics_loading').hide();
            $('#region_statistics_content').show();

            App.addResizeHandler(function() {
                jQuery('.vmaps').each(function() {
                    var map = jQuery(this);
                    map.width(map.parent().width());
                });
            });
        },

        initCalendar: function() {
            if (!jQuery().fullCalendar) {
                return;
            }

            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();

            var h = {};

            if ($('#calendar').width() <= 400) {
                $('#calendar').addClass("mobile");
                h = {
                    left: 'title, prev, next',
                    center: '',
                    right: 'today,month,agendaWeek,agendaDay'
                };
            } else {
                $('#calendar').removeClass("mobile");
                if (App.isRTL()) {
                    h = {
                        right: 'title',
                        center: '',
                        left: 'prev,next,today,month,agendaWeek,agendaDay'
                    };
                } else {
                    h = {
                        left: 'title',
                        center: '',
                        right: 'prev,next,today,month,agendaWeek,agendaDay'
                    };
                }
            }



            $('#calendar').fullCalendar('destroy'); // destroy the calendar
            $('#calendar').fullCalendar({ //re-initialize the calendar
                disableDragging: false,
                header: h,
                editable: true,
                events: [{
                    title: 'All Day',
                    start: new Date(y, m, 1),
                    backgroundColor: App.getBrandColor('yellow')
                }, {
                    title: 'Long Event',
                    start: new Date(y, m, d - 5),
                    end: new Date(y, m, d - 2),
                    backgroundColor: App.getBrandColor('blue')
                }, {
                    title: 'Repeating Event',
                    start: new Date(y, m, d - 3, 16, 0),
                    allDay: false,
                    backgroundColor: App.getBrandColor('red')
                }, {
                    title: 'Repeating Event',
                    start: new Date(y, m, d + 6, 16, 0),
                    allDay: false,
                    backgroundColor: App.getBrandColor('green')
                }, {
                    title: 'Meeting',
                    start: new Date(y, m, d + 9, 10, 30),
                    allDay: false
                }, {
                    title: 'Lunch',
                    start: new Date(y, m, d, 14, 0),
                    end: new Date(y, m, d, 14, 0),
                    backgroundColor: App.getBrandColor('grey'),
                    allDay: false
                }, {
                    title: 'Birthday',
                    start: new Date(y, m, d + 1, 19, 0),
                    end: new Date(y, m, d + 1, 22, 30),
                    backgroundColor: App.getBrandColor('purple'),
                    allDay: false
                }, {
                    title: 'Click for Google',
                    start: new Date(y, m, 28),
                    end: new Date(y, m, 29),
                    backgroundColor: App.getBrandColor('yellow'),
                    url: 'http://google.com/'
                }]
            });
        },

        initCharts: function() {
            if (!jQuery.plot) {
                return;
            }

            function showChartTooltip(x, y, xValue, yValue) {
                $('<div id="tooltip" class="chart-tooltip">' + yValue + '<\/div>').css({
                    position: 'absolute',
                    display: 'none',
                    top: y - 40,
                    left: x - 40,
                    border: '0px solid #ccc',
                    padding: '2px 6px',
                    'background-color': '#fff'
                }).appendTo("body").fadeIn(200);
            }

            var data = [];
            var totalPoints = 250;

            // random data generator for plot charts

            function getRandomData() {
                if (data.length > 0) data = data.slice(1);
                // do a random walk
                while (data.length < totalPoints) {
                    var prev = data.length > 0 ? data[data.length - 1] : 50;
                    var y = prev + Math.random() * 10 - 5;
                    if (y < 0) y = 0;
                    if (y > 100) y = 100;
                    data.push(y);
                }
                // zip the generated y values with the x values
                var res = [];
                for (var i = 0; i < data.length; ++i) res.push([i, data[i]])
                return res;
            }

            function randValue() {
                return (Math.floor(Math.random() * (1 + 50 - 20))) + 10;
            }

            var visitors = [
                ['02/2013', 1500],
                ['03/2013', 2500],
                ['04/2013', 1700],
                ['05/2013', 800],
                ['06/2013', 1500],
                ['07/2013', 2350],
                ['08/2013', 1500],
                ['09/2013', 1300],
                ['10/2013', 4600]
            ];


            if ($('#site_statistics').size() != 0) {

                $('#site_statistics_loading').hide();
                $('#site_statistics_content').show();

                var plot_statistics = $.plot($("#site_statistics"), [{
                        data: visitors,
                        lines: {
                            fill: 0.6,
                            lineWidth: 0
                        },
                        color: ['#f89f9f']
                    }, {
                        data: visitors,
                        points: {
                            show: true,
                            fill: true,
                            radius: 5,
                            fillColor: "#f89f9f",
                            lineWidth: 3
                        },
                        color: '#fff',
                        shadowSize: 0
                    }],

                    {
                        xaxis: {
                            tickLength: 0,
                            tickDecimals: 0,
                            mode: "categories",
                            min: 0,
                            font: {
                                lineHeight: 14,
                                style: "normal",
                                variant: "small-caps",
                                color: "#6F7B8A"
                            }
                        },
                        yaxis: {
                            ticks: 5,
                            tickDecimals: 0,
                            tickColor: "#eee",
                            font: {
                                lineHeight: 14,
                                style: "normal",
                                variant: "small-caps",
                                color: "#6F7B8A"
                            }
                        },
                        grid: {
                            hoverable: true,
                            clickable: true,
                            tickColor: "#eee",
                            borderColor: "#eee",
                            borderWidth: 1
                        }
                    });

                var previousPoint = null;
                $("#site_statistics").bind("plothover", function(event, pos, item) {
                    $("#x").text(pos.x.toFixed(2));
                    $("#y").text(pos.y.toFixed(2));
                    if (item) {
                        if (previousPoint != item.dataIndex) {
                            previousPoint = item.dataIndex;

                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                                y = item.datapoint[1].toFixed(2);

                            showChartTooltip(item.pageX, item.pageY, item.datapoint[0], item.datapoint[1] + ' visits');
                        }
                    } else {
                        $("#tooltip").remove();
                        previousPoint = null;
                    }
                });
            }


            if ($('#site_activities').size() != 0) {
                //site activities
                var previousPoint2 = null;
                $('#site_activities_loading').hide();
                $('#site_activities_content').show();

                var data1 = [
                    ['DEC', 300],
                    ['JAN', 600],
                    ['FEB', 1100],
                    ['MAR', 1200],
                    ['APR', 860],
                    ['MAY', 1200],
                    ['JUN', 1450],
                    ['JUL', 1800],
                    ['AUG', 1200],
                    ['SEP', 600]
                ];


                var plot_statistics = $.plot($("#site_activities"),

                    [{
                        data: data1,
                        lines: {
                            fill: 0.2,
                            lineWidth: 0,
                        },
                        color: ['#BAD9F5']
                    }, {
                        data: data1,
                        points: {
                            show: true,
                            fill: true,
                            radius: 4,
                            fillColor: "#9ACAE6",
                            lineWidth: 2
                        },
                        color: '#9ACAE6',
                        shadowSize: 1
                    }, {
                        data: data1,
                        lines: {
                            show: true,
                            fill: false,
                            lineWidth: 3
                        },
                        color: '#9ACAE6',
                        shadowSize: 0
                    }],

                    {

                        xaxis: {
                            tickLength: 0,
                            tickDecimals: 0,
                            mode: "categories",
                            min: 0,
                            font: {
                                lineHeight: 18,
                                style: "normal",
                                variant: "small-caps",
                                color: "#6F7B8A"
                            }
                        },
                        yaxis: {
                            ticks: 5,
                            tickDecimals: 0,
                            tickColor: "#eee",
                            font: {
                                lineHeight: 14,
                                style: "normal",
                                variant: "small-caps",
                                color: "#6F7B8A"
                            }
                        },
                        grid: {
                            hoverable: true,
                            clickable: true,
                            tickColor: "#eee",
                            borderColor: "#eee",
                            borderWidth: 1
                        }
                    });

                $("#site_activities").bind("plothover", function(event, pos, item) {
                    $("#x").text(pos.x.toFixed(2));
                    $("#y").text(pos.y.toFixed(2));
                    if (item) {
                        if (previousPoint2 != item.dataIndex) {
                            previousPoint2 = item.dataIndex;
                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                                y = item.datapoint[1].toFixed(2);
                            showChartTooltip(item.pageX, item.pageY, item.datapoint[0], item.datapoint[1] + 'M$');
                        }
                    }
                });

                $('#site_activities').bind("mouseleave", function() {
                    $("#tooltip").remove();
                });
            }
        },

        initEasyPieCharts: function() {
            if (!jQuery().easyPieChart) {
                return;
            }

            $('.easy-pie-chart .number.transactions').easyPieChart({
                animate: 1000,
                size: 75,
                lineWidth: 3,
                barColor: App.getBrandColor('yellow')
            });

            $('.easy-pie-chart .number.visits').easyPieChart({
                animate: 1000,
                size: 75,
                lineWidth: 3,
                barColor: App.getBrandColor('green')
            });

            $('.easy-pie-chart .number.bounce').easyPieChart({
                animate: 1000,
                size: 75,
                lineWidth: 3,
                barColor: App.getBrandColor('red')
            });

            $('.easy-pie-chart-reload').click(function() {
                $('.easy-pie-chart .number').each(function() {
                    var newValue = Math.floor(100 * Math.random());
                    $(this).data('easyPieChart').update(newValue);
                    $('span', this).text(newValue);
                });
            });
        },

        initSparklineCharts: function() {
            if (!jQuery().sparkline) {
                return;
            }
            $("#sparkline_bar").sparkline([8, 9, 10, 11, 10, 10, 12, 10, 10, 11, 9, 12, 11, 10, 9, 11, 13, 13, 12], {
                type: 'bar',
                width: '100',
                barWidth: 5,
                height: '55',
                barColor: '#35aa47',
                negBarColor: '#e02222'
            });

            $("#sparkline_bar2").sparkline([9, 11, 12, 13, 12, 13, 10, 14, 13, 11, 11, 12, 11, 11, 10, 12, 11, 10], {
                type: 'bar',
                width: '100',
                barWidth: 5,
                height: '55',
                barColor: '#ffb848',
                negBarColor: '#e02222'
            });

            $("#sparkline_bar5").sparkline([8, 9, 10, 11, 10, 10, 12, 10, 10, 11, 9, 12, 11, 10, 9, 11, 13, 13, 12], {
                type: 'bar',
                width: '100',
                barWidth: 5,
                height: '55',
                barColor: '#35aa47',
                negBarColor: '#e02222'
            });

            $("#sparkline_bar6").sparkline([9, 11, 12, 13, 12, 13, 10, 14, 13, 11, 11, 12, 11, 11, 10, 12, 11, 10], {
                type: 'bar',
                width: '100',
                barWidth: 5,
                height: '55',
                barColor: '#ffb848',
                negBarColor: '#e02222'
            });

            $("#sparkline_line").sparkline([9, 10, 9, 10, 10, 11, 12, 10, 10, 11, 11, 12, 11, 10, 12, 11, 10, 12], {
                type: 'line',
                width: '100',
                height: '55',
                lineColor: '#ffb848'
            });
        },

        //initMorisCharts: function() {
        //    if (Morris.EventEmitter && $('#sales_statistics').size() > 0) {
        //        // Use Morris.Area instead of Morris.Line
        //        dashboardMainChart = Morris.Area({
        //            element: 'sales_statistics',
        //            padding: 0,
        //            behaveLikeLine: false,
        //            gridEnabled: false,
        //            gridLineColor: false,
        //            axes: false,
        //            fillOpacity: 1,
        //            data: [{
        //                period: '2011 Q1',
        //                sales: 1400,
        //                profit: 400
        //            }, {
        //                period: '2011 Q2',
        //                sales: 1100,
        //                profit: 600
        //            }, {
        //                period: '2011 Q3',
        //                sales: 1600,
        //                profit: 500
        //            }, {
        //                period: '2011 Q4',
        //                sales: 1200,
        //                profit: 400
        //            }, {
        //                period: '2012 Q1',
        //                sales: 1550,
        //                profit: 800
        //            }],
        //            lineColors: ['#399a8c', '#92e9dc'],
        //            xkey: 'period',
        //            ykeys: ['sales', 'profit'],
        //            labels: ['Sales', 'Profit'],
        //            pointSize: 0,
        //            lineWidth: 0,
        //            hideHover: 'auto',
        //            resize: true
        //        });
        //
        //    }
        //},

        initChat: function() {
            var cont = $('#chats');
            var list = $('.chats', cont);
            var form = $('.chat-form', cont);
            var input = $('input', form);
            var btn = $('.btn', form);

            var handleClick = function(e) {
                e.preventDefault();

                var text = input.val();
                if (text.length == 0) {
                    return;
                }

                var time = new Date();
                var time_str = (time.getHours() + ':' + time.getMinutes());
                var tpl = '';
                tpl += '<li class="out">';
                tpl += '<img class="avatar" alt="" src="' + Layout.getLayoutImgPath() + 'avatar1.jpg"/>';
                tpl += '<div class="message">';
                tpl += '<span class="arrow"></span>';
                tpl += '<a href="#" class="name">Bob Nilson</a>&nbsp;';
                tpl += '<span class="datetime">at ' + time_str + '</span>';
                tpl += '<span class="body">';
                tpl += text;
                tpl += '</span>';
                tpl += '</div>';
                tpl += '</li>';

                var msg = list.append(tpl);
                input.val("");

                var getLastPostPos = function() {
                    var height = 0;
                    cont.find("li.out, li.in").each(function() {
                        height = height + $(this).outerHeight();
                    });

                    return height;
                }

                cont.find('.scroller').slimScroll({
                    scrollTo: getLastPostPos()
                });
            }

            $('body').on('click', '.message .name', function(e) {
                e.preventDefault(); // prevent click event

                var name = $(this).text(); // get clicked user's full name
                input.val('@' + name + ':'); // set it into the input field
                App.scrollTo(input); // scroll to input if needed
            });

            btn.click(handleClick);

            input.keypress(function(e) {
                if (e.which == 13) {
                    handleClick(e);
                    return false; //<---- Add this line
                }
            });
        },

        initDashboardDaterange: function() {
            if (!jQuery().daterangepicker) {
                return;
            }

            $('#dashboard-report-range').daterangepicker({
                "ranges": {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
                    'Last 7 Days': [moment().subtract('days', 6), moment()],
                    'Last 30 Days': [moment().subtract('days', 29), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
                },
                "locale": {
                    "format": "MM/DD/YYYY",
                    "separator": " - ",
                    "applyLabel": "Apply",
                    "cancelLabel": "Cancel",
                    "fromLabel": "From",
                    "toLabel": "To",
                    "customRangeLabel": "Custom",
                    "daysOfWeek": [
                        "Su",
                        "Mo",
                        "Tu",
                        "We",
                        "Th",
                        "Fr",
                        "Sa"
                    ],
                    "monthNames": [
                        "January",
                        "February",
                        "March",
                        "April",
                        "May",
                        "June",
                        "July",
                        "August",
                        "September",
                        "October",
                        "November",
                        "December"
                    ],
                    "firstDay": 1
                },
                //"startDate": "11/08/2015",
                //"endDate": "11/14/2015",
                opens: (App.isRTL() ? 'right' : 'left'),
            }, function(start, end, label) {
                $('#dashboard-report-range span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
            });

            $('#dashboard-report-range span').html(moment().subtract('days', 29).format('MMMM D, YYYY') + ' - ' + moment().format('MMMM D, YYYY'));
            $('#dashboard-report-range').show();
        },

        initAmChart1: function() {
            if (typeof(AmCharts) === 'undefined' || $('#dashboard_amchart_1').size() === 0) {
                return;
            }

            var chartData = [{
                "date": "2012-01-05",
                "distance": 480,
                "townName": "Miami",
                "townName2": "Miami",
                "townSize": 10,
                "latitude": 25.83,
                "duration": 501
            }, {
                "date": "2012-01-06",
                "distance": 386,
                "townName": "Tallahassee",
                "townSize": 7,
                "latitude": 30.46,
                "duration": 443
            }, {
                "date": "2012-01-07",
                "distance": 348,
                "townName": "New Orleans",
                "townSize": 10,
                "latitude": 29.94,
                "duration": 405
            }, {
                "date": "2012-01-08",
                "distance": 238,
                "townName": "Houston",
                "townName2": "Houston",
                "townSize": 16,
                "latitude": 29.76,
                "duration": 309
            }, {
                "date": "2012-01-09",
                "distance": 218,
                "townName": "Dalas",
                "townSize": 17,
                "latitude": 32.8,
                "duration": 287
            }, {
                "date": "2012-01-10",
                "distance": 349,
                "townName": "Oklahoma City",
                "townSize": 11,
                "latitude": 35.49,
                "duration": 485
            }, {
                "date": "2012-01-11",
                "distance": 603,
                "townName": "Kansas City",
                "townSize": 10,
                "latitude": 39.1,
                "duration": 890
            }, {
                "date": "2012-01-12",
                "distance": 534,
                "townName": "Denver",
                "townName2": "Denver",
                "townSize": 18,
                "latitude": 39.74,
                "duration": 810
            }, {
                "date": "2012-01-13",
                "townName": "Salt Lake City",
                "townSize": 12,
                "distance": 425,
                "duration": 670,
                "latitude": 40.75,
                "alpha": 0.4
            }, {
                "date": "2012-01-14",
                "latitude": 36.1,
                "duration": 470,
                "townName": "Las Vegas",
                "townName2": "Las Vegas",
                "bulletClass": "lastBullet"
            }, {
                "date": "2012-01-15"
            }];
            var chart = AmCharts.makeChart("dashboard_amchart_1", {
                type: "serial",
                fontSize: 12,
                fontFamily: "Open Sans",
                dataDateFormat: "YYYY-MM-DD",
                dataProvider: chartData,

                addClassNames: true,
                startDuration: 1,
                color: "#6c7b88",
                marginLeft: 0,

                categoryField: "date",
                categoryAxis: {
                    parseDates: true,
                    minPeriod: "DD",
                    autoGridCount: false,
                    gridCount: 50,
                    gridAlpha: 0.1,
                    gridColor: "#FFFFFF",
                    axisColor: "#555555",
                    dateFormats: [{
                        period: 'DD',
                        format: 'DD'
                    }, {
                        period: 'WW',
                        format: 'MMM DD'
                    }, {
                        period: 'MM',
                        format: 'MMM'
                    }, {
                        period: 'YYYY',
                        format: 'YYYY'
                    }]
                },

                valueAxes: [{
                    id: "a1",
                    title: "distance",
                    gridAlpha: 0,
                    axisAlpha: 0
                }, {
                    id: "a2",
                    position: "right",
                    gridAlpha: 0,
                    axisAlpha: 0,
                    labelsEnabled: false
                }, {
                    id: "a3",
                    title: "duration",
                    position: "right",
                    gridAlpha: 0,
                    axisAlpha: 0,
                    inside: true,
                    duration: "mm",
                    durationUnits: {
                        DD: "d. ",
                        hh: "h ",
                        mm: "min",
                        ss: ""
                    }
                }],
                graphs: [{
                    id: "g1",
                    valueField: "distance",
                    title: "distance",
                    type: "column",
                    fillAlphas: 0.7,
                    valueAxis: "a1",
                    balloonText: "[[value]] miles",
                    legendValueText: "[[value]] mi",
                    legendPeriodValueText: "total: [[value.sum]] mi",
                    lineColor: "#08a3cc",
                    alphaField: "alpha",
                }, {
                    id: "g2",
                    valueField: "latitude",
                    classNameField: "bulletClass",
                    title: "latitude/city",
                    type: "line",
                    valueAxis: "a2",
                    lineColor: "#786c56",
                    lineThickness: 1,
                    legendValueText: "[[description]]/[[value]]",
                    descriptionField: "townName",
                    bullet: "round",
                    bulletSizeField: "townSize",
                    bulletBorderColor: "#02617a",
                    bulletBorderAlpha: 1,
                    bulletBorderThickness: 2,
                    bulletColor: "#89c4f4",
                    labelText: "[[townName2]]",
                    labelPosition: "right",
                    balloonText: "latitude:[[value]]",
                    showBalloon: true,
                    animationPlayed: true,
                }, {
                    id: "g3",
                    title: "duration",
                    valueField: "duration",
                    type: "line",
                    valueAxis: "a3",
                    lineAlpha: 0.8,
                    lineColor: "#e26a6a",
                    balloonText: "[[value]]",
                    lineThickness: 1,
                    legendValueText: "[[value]]",
                    bullet: "square",
                    bulletBorderColor: "#e26a6a",
                    bulletBorderThickness: 1,
                    bulletBorderAlpha: 0.8,
                    dashLengthField: "dashLength",
                    animationPlayed: true
                }],

                chartCursor: {
                    zoomable: false,
                    categoryBalloonDateFormat: "DD",
                    cursorAlpha: 0,
                    categoryBalloonColor: "#e26a6a",
                    categoryBalloonAlpha: 0.8,
                    valueBalloonsEnabled: false
                },
                legend: {
                    bulletType: "round",
                    equalWidths: false,
                    valueWidth: 120,
                    useGraphSettings: true,
                    color: "#6c7b88"
                }
            });
        },

        initAmChart2: function() {
            if (typeof(AmCharts) === 'undefined' || $('#dashboard_amchart_2').size() === 0) {
                return;
            }

            // svg path for target icon
            var targetSVG = "M9,0C4.029,0,0,4.029,0,9s4.029,9,9,9s9-4.029,9-9S13.971,0,9,0z M9,15.93 c-3.83,0-6.93-3.1-6.93-6.93S5.17,2.07,9,2.07s6.93,3.1,6.93,6.93S12.83,15.93,9,15.93 M12.5,9c0,1.933-1.567,3.5-3.5,3.5S5.5,10.933,5.5,9S7.067,5.5,9,5.5 S12.5,7.067,12.5,9z";
            // svg path for plane icon
            var planeSVG = "M19.671,8.11l-2.777,2.777l-3.837-0.861c0.362-0.505,0.916-1.683,0.464-2.135c-0.518-0.517-1.979,0.278-2.305,0.604l-0.913,0.913L7.614,8.804l-2.021,2.021l2.232,1.061l-0.082,0.082l1.701,1.701l0.688-0.687l3.164,1.504L9.571,18.21H6.413l-1.137,1.138l3.6,0.948l1.83,1.83l0.947,3.598l1.137-1.137V21.43l3.725-3.725l1.504,3.164l-0.687,0.687l1.702,1.701l0.081-0.081l1.062,2.231l2.02-2.02l-0.604-2.689l0.912-0.912c0.326-0.326,1.121-1.789,0.604-2.306c-0.452-0.452-1.63,0.101-2.135,0.464l-0.861-3.838l2.777-2.777c0.947-0.947,3.599-4.862,2.62-5.839C24.533,4.512,20.618,7.163,19.671,8.11z";

            var map = AmCharts.makeChart("dashboard_amchart_2", {
                type: "map",
                "theme": "light",
                pathToImages: "../assets/global/plugins/amcharts/ammap/images/",

                dataProvider: {
                    map: "worldLow",
                    linkToObject: "london",
                    images: [{
                        id: "london",
                        color: "#009dc7",
                        svgPath: targetSVG,
                        title: "London",
                        latitude: 51.5002,
                        longitude: -0.1262,
                        scale: 1.5,
                        zoomLevel: 2.74,
                        zoomLongitude: -20.1341,
                        zoomLatitude: 49.1712,

                        lines: [{
                            latitudes: [51.5002, 50.4422],
                            longitudes: [-0.1262, 30.5367]
                        }, {
                            latitudes: [51.5002, 46.9480],
                            longitudes: [-0.1262, 7.4481]
                        }, {
                            latitudes: [51.5002, 59.3328],
                            longitudes: [-0.1262, 18.0645]
                        }, {
                            latitudes: [51.5002, 40.4167],
                            longitudes: [-0.1262, -3.7033]
                        }, {
                            latitudes: [51.5002, 46.0514],
                            longitudes: [-0.1262, 14.5060]
                        }, {
                            latitudes: [51.5002, 48.2116],
                            longitudes: [-0.1262, 17.1547]
                        }, {
                            latitudes: [51.5002, 44.8048],
                            longitudes: [-0.1262, 20.4781]
                        }, {
                            latitudes: [51.5002, 55.7558],
                            longitudes: [-0.1262, 37.6176]
                        }, {
                            latitudes: [51.5002, 38.7072],
                            longitudes: [-0.1262, -9.1355]
                        }, {
                            latitudes: [51.5002, 54.6896],
                            longitudes: [-0.1262, 25.2799]
                        }, {
                            latitudes: [51.5002, 64.1353],
                            longitudes: [-0.1262, -21.8952]
                        }, {
                            latitudes: [51.5002, 40.4300],
                            longitudes: [-0.1262, -74.0000]
                        }],

                        images: [{
                            label: "Flights from London",
                            svgPath: planeSVG,
                            left: 100,
                            top: 45,
                            labelShiftY: 5,
                            color: "#d93d5e",
                            labelColor: "#d93d5e",
                            labelRollOverColor: "#d93d5e",
                            labelFontSize: 20
                        }, {
                            label: "show flights from Vilnius",
                            left: 106,
                            top: 70,
                            labelColor: "#6c7b88",
                            labelRollOverColor: "#d93d5e",
                            labelFontSize: 11,
                            linkToObject: "vilnius"
                        }]
                    },

                        {
                            id: "vilnius",
                            color: "#009dc7",
                            svgPath: targetSVG,
                            title: "Vilnius",
                            latitude: 54.6896,
                            longitude: 25.2799,
                            scale: 1.5,
                            zoomLevel: 4.92,
                            zoomLongitude: 15.4492,
                            zoomLatitude: 50.2631,

                            lines: [{
                                latitudes: [54.6896, 50.8371],
                                longitudes: [25.2799, 4.3676]
                            }, {
                                latitudes: [54.6896, 59.9138],
                                longitudes: [25.2799, 10.7387]
                            }, {
                                latitudes: [54.6896, 40.4167],
                                longitudes: [25.2799, -3.7033]
                            }, {
                                latitudes: [54.6896, 50.0878],
                                longitudes: [25.2799, 14.4205]
                            }, {
                                latitudes: [54.6896, 48.2116],
                                longitudes: [25.2799, 17.1547]
                            }, {
                                latitudes: [54.6896, 44.8048],
                                longitudes: [25.2799, 20.4781]
                            }, {
                                latitudes: [54.6896, 55.7558],
                                longitudes: [25.2799, 37.6176]
                            }, {
                                latitudes: [54.6896, 37.9792],
                                longitudes: [25.2799, 23.7166]
                            }, {
                                latitudes: [54.6896, 54.6896],
                                longitudes: [25.2799, 25.2799]
                            }, {
                                latitudes: [54.6896, 51.5002],
                                longitudes: [25.2799, -0.1262]
                            }, {
                                latitudes: [54.6896, 53.3441],
                                longitudes: [25.2799, -6.2675]
                            }],

                            images: [{
                                label: "Flights from Vilnius",
                                svgPath: planeSVG,
                                left: 100,
                                top: 45,
                                labelShiftY: 5,
                                color: "#d93d5e",
                                labelColor: "#d93d5e",
                                labelRollOverColor: "#d93d5e",
                                labelFontSize: 20
                            }, {
                                label: "show flights from London",
                                left: 106,
                                top: 70,
                                labelColor: "#009dc7",
                                labelRollOverColor: "#d93d5e",
                                labelFontSize: 11,
                                linkToObject: "london"
                            }]
                        }, {
                            svgPath: targetSVG,
                            title: "Brussels",
                            latitude: 50.8371,
                            longitude: 4.3676
                        }, {
                            svgPath: targetSVG,
                            title: "Prague",
                            latitude: 50.0878,
                            longitude: 14.4205
                        }, {
                            svgPath: targetSVG,
                            title: "Athens",
                            latitude: 37.9792,
                            longitude: 23.7166
                        }, {
                            svgPath: targetSVG,
                            title: "Reykjavik",
                            latitude: 64.1353,
                            longitude: -21.8952
                        }, {
                            svgPath: targetSVG,
                            title: "Dublin",
                            latitude: 53.3441,
                            longitude: -6.2675
                        }, {
                            svgPath: targetSVG,
                            title: "Oslo",
                            latitude: 59.9138,
                            longitude: 10.7387
                        }, {
                            svgPath: targetSVG,
                            title: "Lisbon",
                            latitude: 38.7072,
                            longitude: -9.1355
                        }, {
                            svgPath: targetSVG,
                            title: "Moscow",
                            latitude: 55.7558,
                            longitude: 37.6176
                        }, {
                            svgPath: targetSVG,
                            title: "Belgrade",
                            latitude: 44.8048,
                            longitude: 20.4781
                        }, {
                            svgPath: targetSVG,
                            title: "Bratislava",
                            latitude: 48.2116,
                            longitude: 17.1547
                        }, {
                            svgPath: targetSVG,
                            title: "Ljubljana",
                            latitude: 46.0514,
                            longitude: 14.5060
                        }, {
                            svgPath: targetSVG,
                            title: "Madrid",
                            latitude: 40.4167,
                            longitude: -3.7033
                        }, {
                            svgPath: targetSVG,
                            title: "Stockholm",
                            latitude: 59.3328,
                            longitude: 18.0645
                        }, {
                            svgPath: targetSVG,
                            title: "Bern",
                            latitude: 46.9480,
                            longitude: 7.4481
                        }, {
                            svgPath: targetSVG,
                            title: "Kiev",
                            latitude: 50.4422,
                            longitude: 30.5367
                        }, {
                            svgPath: targetSVG,
                            title: "Paris",
                            latitude: 48.8567,
                            longitude: 2.3510
                        }, {
                            svgPath: targetSVG,
                            title: "New York",
                            latitude: 40.43,
                            longitude: -74
                        }
                    ]
                },

                zoomControl: {
                    buttonFillColor: "#dddddd"
                },

                areasSettings: {
                    unlistedAreasColor: "#15A892"
                },

                imagesSettings: {
                    color: "#d93d5e",
                    rollOverColor: "#d93d5e",
                    selectedColor: "#009dc7"
                },

                linesSettings: {
                    color: "#d93d5e",
                    alpha: 0.4
                },


                backgroundZoomsToTop: true,
                linesAboveImages: true,

                "export": {
                    "enabled": true,
                    "libs": {
                        "path": "http://www.amcharts.com/lib/3/plugins/export/libs/"
                    }
                }
            });
        },

        initAmChart3: function() {
            if (typeof(AmCharts) === 'undefined' || $('#dashboard_amchart_3').size() === 0) {
                return;
            }

            var chart = AmCharts.makeChart("dashboard_amchart_3", {
                "type": "serial",
                "addClassNames": true,
                "theme": "light",
                "path": "../assets/global/plugins/amcharts/ammap/images/",
                "autoMargins": false,
                "marginLeft": 30,
                "marginRight": 8,
                "marginTop": 10,
                "marginBottom": 26,
                "balloon": {
                    "adjustBorderColor": false,
                    "horizontalPadding": 10,
                    "verticalPadding": 8,
                    "color": "#ffffff"
                },

                "dataProvider": [{
                    "year": 2009,
                    "income": 23.5,
                    "expenses": 21.1
                }, {
                    "year": 2010,
                    "income": 26.2,
                    "expenses": 30.5
                }, {
                    "year": 2011,
                    "income": 30.1,
                    "expenses": 34.9
                }, {
                    "year": 2012,
                    "income": 29.5,
                    "expenses": 31.1
                }, {
                    "year": 2013,
                    "income": 30.6,
                    "expenses": 28.2,
                }, {
                    "year": 2014,
                    "income": 34.1,
                    "expenses": 32.9,
                    "dashLengthColumn": 5,
                    "alpha": 0.2,
                    "additional": "(projection)"
                }],
                "valueAxes": [{
                    "axisAlpha": 0,
                    "position": "left"
                }],
                "startDuration": 1,
                "graphs": [{
                    "alphaField": "alpha",
                    "balloonText": "<span style='font-size:12px;'>[[title]] in [[category]]:<br><span style='font-size:20px;'>[[value]]</span> [[additional]]</span>",
                    "fillAlphas": 1,
                    "title": "Income",
                    "type": "column",
                    "valueField": "income",
                    "dashLengthField": "dashLengthColumn"
                }, {
                    "id": "graph2",
                    "balloonText": "<span style='font-size:12px;'>[[title]] in [[category]]:<br><span style='font-size:20px;'>[[value]]</span> [[additional]]</span>",
                    "bullet": "round",
                    "lineThickness": 3,
                    "bulletSize": 7,
                    "bulletBorderAlpha": 1,
                    "bulletColor": "#FFFFFF",
                    "useLineColorForBulletBorder": true,
                    "bulletBorderThickness": 3,
                    "fillAlphas": 0,
                    "lineAlpha": 1,
                    "title": "Expenses",
                    "valueField": "expenses"
                }],
                "categoryField": "year",
                "categoryAxis": {
                    "gridPosition": "start",
                    "axisAlpha": 0,
                    "tickLength": 0
                },
                "export": {
                    "enabled": true
                }
            });
        },

        initAmChart4: function() {
            if (typeof(AmCharts) === 'undefined' || $('#dashboard_amchart_4').size() === 0) {
                return;
            }

            var chart = AmCharts.makeChart("dashboard_amchart_4", {
                "type": "pie",
                "theme": "light",
                "path": "../assets/global/plugins/amcharts/ammap/images/",
                "dataProvider": [{
                    "country": "Lithuania",
                    "value": 260
                }, {
                    "country": "Ireland",
                    "value": 201
                }, {
                    "country": "Germany",
                    "value": 65
                }, {
                    "country": "Australia",
                    "value": 39
                }, {
                    "country": "UK",
                    "value": 19
                }, {
                    "country": "Latvia",
                    "value": 10
                }],
                "valueField": "value",
                "titleField": "country",
                "outlineAlpha": 0.4,
                "depth3D": 15,
                "balloonText": "[[title]]<br><span style='font-size:14px'><b>[[value]]</b> ([[percents]]%)</span>",
                "angle": 30,
                "export": {
                    "enabled": true
                }
            });
            jQuery('.chart-input').off().on('input change', function() {
                var property = jQuery(this).data('property');
                var target = chart;
                var value = Number(this.value);
                chart.startDuration = 0;

                if (property == 'innerRadius') {
                    value += "%";
                }

                target[property] = value;
                chart.validateNow();
            });
        },

        initWorldMapStats: function() {
            if ($('#mapplic').size() === 0) {
                return;
            }

            $('#mapplic').mapplic({
                source: '../assets/global/plugins/mapplic/world.json',
                height: 265,
                animate: false,
                sidebar: false,
                minimap: false,
                locations: true,
                deeplinking: true,
                fullscreen: false,
                hovertip: true,
                zoombuttons: false,
                clearbutton: false,
                developer: false,
                maxscale: 2,
                skin: 'mapplic-dark',
                zoom: true
            });

            $("#widget_sparkline_bar").sparkline([8, 7, 9, 8.5, 8, 8.2, 8, 8.5, 9, 8, 9], {
                type: 'bar',
                width: '100',
                barWidth: 5,
                height: '30',
                barColor: '#4db3a4',
                negBarColor: '#e02222'
            });

            $("#widget_sparkline_bar2").sparkline([8, 7, 9, 8.5, 8, 8.2, 8, 8.5, 9, 8, 9], {
                type: 'bar',
                width: '100',
                barWidth: 5,
                height: '30',
                barColor: '#f36a5a',
                negBarColor: '#e02222'
            });

            $("#widget_sparkline_bar3").sparkline([8, 7, 9, 8.5, 8, 8.2, 8, 8.5, 9, 8, 9], {
                type: 'bar',
                width: '100',
                barWidth: 5,
                height: '30',
                barColor: '#5b9bd1',
                negBarColor: '#e02222'
            });

            $("#widget_sparkline_bar4").sparkline([8, 7, 9, 8.5, 8, 8.2, 8, 8.5, 9, 8, 9], {
                type: 'bar',
                width: '100',
                barWidth: 5,
                height: '30',
                barColor: '#9a7caf',
                negBarColor: '#e02222'
            });
        },

        init: function() {

            this.initJQVMAP();
            this.initCalendar();
            this.initCharts();
            this.initEasyPieCharts();
            this.initSparklineCharts();
            this.initChat();
            this.initDashboardDaterange();
            //this.initMorisCharts();

            this.initAmChart1();
            this.initAmChart2();
            this.initAmChart3();
            this.initAmChart4();

            this.initWorldMapStats();
        }
    };

}();

if (App.isAngularJsApp() === false) {
    jQuery(document).ready(function() {
        Dashboard.init(); // init metronic core componets
    });
}


var swiper = new Swiper('.all-building-slider .swiper-container', {
    // Default parameters
    slidesPerView: 4,
    spaceBetween: 10,
    pagination: '.swiper-pagination',
    paginationClickable: true,
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    slidesPerColumn: 2,
    preventClicks: false,
    preventClicksPropagation: false,
    
    // Responsive breakpoints
    breakpoints: {
        // when window width is <= 320px
        320: {
            slidesPerView: 1,
            spaceBetweenSlides: 10
        },
        // when window width is <= 480px
        480: {
            slidesPerView: 1,
            spaceBetweenSlides: 10
        },
        // when window width is <= 768px
        768: {
            slidesPerView: 3,
            spaceBetweenSlides: 10
        },
        // when window width is <= 992px
        992: {
            slidesPerView: 3,
            spaceBetweenSlides: 10
        },
        // when window width is <= 1200px
        1200: {
            slidesPerView: 4,
            spaceBetweenSlides: 10
        }
    }
})




var swiper = new Swiper('.slider-one-row .swiper-container', {
    // Default parameters
    slidesPerView: 5,
    spaceBetween: 10,
    pagination: '.swiper-pagination',
    paginationClickable: true,
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
    slidesPerColumn: 1,
    preventClicks: false,
    preventClicksPropagation: false,

    // Responsive breakpoints
    breakpoints: {
        // when window width is <= 320px
        320: {
            slidesPerView: 1,
            spaceBetweenSlides: 10
        },
        // when window width is <= 480px
        480: {
            slidesPerView: 1,
            spaceBetweenSlides: 10
        },
        // when window width is <= 768px
        768: {
            slidesPerView: 3,
            spaceBetweenSlides: 10
        },
        // when window width is <= 992px
        992: {
            slidesPerView: 3,
            spaceBetweenSlides: 10
        },
        // when window width is <= 1200px
        1200: {
            slidesPerView: 5,
            spaceBetweenSlides: 10
        }
    }
})

// *******************ui-bootbox************************//

var UIBootbox = function () {
    var handleDemo = function() {
        $('.delete-general').click(function(){
            bootbox.dialog({
                message: "<h4 class=' text-center'> Â· «‰  „ √ﬂœ „‰ Õ–› Â–« «·ﬁ”„/ «·ÊÀÌﬁ… </h4>" + "<br/>" + "<div class='text-center'><img class='' width='200' style='margin:auto' src='img/delete-general.png'></div> " ,
                // title: "≈” »⁄«œ „ÊŸ›",
                buttons: {
                    success: {
                        label: " √ﬂÌœ",
                        className: "green-jungle btn-block",
                        callback: function() {
                            // alert("great success");
                        }
                    },
                    danger: {
                        label: "≈·€«¡",
                        className: " dark btn-block",
                        callback: function() {
                            // alert("uh oh, look out!");
                        }
                    }
                }
            });
        });
    }

    return {
        //main function to initiate the module
        init: function () {
            handleDemo();
        }
    };

}();

jQuery(document).ready(function() {
    UIBootbox.init();
});

//*******************Auto Complete************************//
//
//$('#client-name').typeahead({
//    local: ['«Õ„œ','”«—Â','ÃÊ—Ã','⁄»œ «·—Õ„‰ ','„Õ„œ','ﬂ„«·','‰«‰”Ï','›Œ—Ï','”·„Ï']
//});
//
//$('#all-building').typeahead({
//    local: ['⁄„«—… «Ê· „ﬂ—„','⁄„«—… «·‘—Êﬁ','⁄„«—… «·„⁄«œÏ','⁄„«—… «·œ«∆—Ï  ','«·ÃÌ“…','⁄„«—… „’ÿ›Ï «·‰Õ«”','⁄„«—… —«»⁄…','⁄„«—… ÿ—Ìﬁ «·‰’—','⁄„«—… «·⁄»Ê—']
//});
//
//$('.tt-query').css('background-color','#fff');

//////////////////////////////////////////////////////////////////////////
    
$('.btn-number').click(function(e){
    e.preventDefault();
    
    fieldName = $(this).attr('data-field');
    type      = $(this).attr('data-type');
    var input = $("input[name='"+fieldName+"']");
    var currentVal = parseInt(input.val());
    if (!isNaN(currentVal)) {
        if(type == 'minus') {
            
            if(currentVal > input.attr('min')) {
                input.val(currentVal - 1).change();
            } 
            if(parseInt(input.val()) == input.attr('min')) {
                $(this).attr('disabled', true);
            }

        } else if(type == 'plus') {

            if(currentVal < input.attr('max')) {
                input.val(currentVal + 1).change();
            }
            if(parseInt(input.val()) == input.attr('max')) {
                $(this).attr('disabled', true);
            }

        }
    } else {
        input.val(0);
    }
});
$('.input-number').focusin(function(){
   $(this).data('oldValue', $(this).val());
});
$('.input-number').change(function() {
    
    minValue =  parseInt($(this).attr('min'));
    maxValue =  parseInt($(this).attr('max'));
    valueCurrent = parseInt($(this).val());
    
    name = $(this).attr('name');
    if(valueCurrent >= minValue) {
        $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('Sorry, the minimum value was reached');
        $(this).val($(this).data('oldValue'));
    }
    if(valueCurrent <= maxValue) {
        $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('Sorry, the maximum value was reached');
        $(this).val($(this).data('oldValue'));
    }
    
    
});
//////////////////////////////////////////////////////////////////////
//*******************layout************************//
var Layout = function () {
    var e = "layouts/layout/img/", a = "layouts/layout/css/", t = App.getResponsiveBreakpoint("md"), i = function () {
        var e, a = $(".page-content"), i = $(".page-sidebar"), s = $("body");
        if (s.hasClass("page-footer-fixed") === !0 && s.hasClass("page-sidebar-fixed") === !1) {
            var o = App.getViewPort().height - $(".page-footer").outerHeight() - $(".page-header").outerHeight();
            a.height() < o && a.attr("style", "min-height:" + o + "px")
        } else {
            if (s.hasClass("page-sidebar-fixed"))e = n(), s.hasClass("page-footer-fixed") === !1 && (e -= $(".page-footer").outerHeight()); else {
                var r = $(".page-header").outerHeight(), d = $(".page-footer").outerHeight();
                e = App.getViewPort().width < t ? App.getViewPort().height - r - d : i.height() + 20, e + r + d <= App.getViewPort().height && (e = App.getViewPort().height - r - d)
            }
            a.attr("style", "min-height:" + e + "px")
        }
    }, s = function (e, a) {
        var i = location.hash.toLowerCase(), s = $(".page-sidebar-menu");
        if ("click" === e || "set" === e ? a = $(a) : "match" === e && s.find("li > a").each(function () {
                var e = $(this).attr("href").toLowerCase();
                return e.length > 1 && i.substr(1, e.length - 1) == e.substr(1) ? void(a = $(this)) : void 0
            }), a && 0 != a.size() && "javascript:;" !== a.attr("href").toLowerCase() && "#" !== a.attr("href").toLowerCase()) {
            parseInt(s.data("slide-speed")), s.data("keep-expanded");
            s.hasClass("page-sidebar-menu-hover-submenu") === !1 ? s.find("li.nav-item.open").each(function () {
                var e = !1;
                $(this).find("li").each(function () {
                    return $(this).find(" > a").attr("href") === a.attr("href") ? void(e = !0) : void 0
                }), e !== !0 && ($(this).removeClass("open"), $(this).find("> a > .arrow.open").removeClass("open"), $(this).find("> .sub-menu").slideUp())
            }) : s.find("li.open").removeClass("open"), s.find("li.active").removeClass("active"), s.find("li > a > .selected").remove(), a.parents("li").each(function () {
                $(this).addClass("active"), $(this).find("> a > span.arrow").addClass("open"), 1 === $(this).parent("ul.page-sidebar-menu").size() && $(this).find("> a").append('<span class="selected"></span>'), 1 === $(this).children("ul.sub-menu").size() && $(this).addClass("open")
            }), "click" === e && App.getViewPort().width < t && $(".page-sidebar").hasClass("in") && $(".page-header .responsive-toggler").click()
        }
    }, o = function () {
        $(".page-sidebar-menu").on("click", "li > a.nav-toggle, li > a > span.nav-toggle", function (e) {
            var a = $(this).closest(".nav-item").children(".nav-link");
            if (!(App.getViewPort().width >= t && !$(".page-sidebar-menu").attr("data-initialized") && $("body").hasClass("page-sidebar-closed") && 1 === a.parent("li").parent(".page-sidebar-menu").size())) {
                var s = a.next().hasClass("sub-menu");
                if (!(App.getViewPort().width >= t && 1 === a.parents(".page-sidebar-menu-hover-submenu").size())) {
                    if (s === !1)return void(App.getViewPort().width < t && $(".page-sidebar").hasClass("in") && $(".page-header .responsive-toggler").click());
                    var o = a.parent().parent(), n = a, r = $(".page-sidebar-menu"), d = a.next(), p = r.data("auto-scroll"), l = parseInt(r.data("slide-speed")), c = r.data("keep-expanded");
                    c || (o.children("li.open").children("a").children(".arrow").removeClass("open"), o.children("li.open").children(".sub-menu:not(.always-open)").slideUp(l), o.children("li.open").removeClass("open"));
                    var h = -200;
                    d.is(":visible") ? ($(".arrow", n).removeClass("open"), n.parent().removeClass("open"), d.slideUp(l, function () {
                        p === !0 && $("body").hasClass("page-sidebar-closed") === !1 && ($("body").hasClass("page-sidebar-fixed") ? r.slimScroll({scrollTo: n.position().top}) : App.scrollTo(n, h)), i()
                    })) : s && ($(".arrow", n).addClass("open"), n.parent().addClass("open"), d.slideDown(l, function () {
                        p === !0 && $("body").hasClass("page-sidebar-closed") === !1 && ($("body").hasClass("page-sidebar-fixed") ? r.slimScroll({scrollTo: n.position().top}) : App.scrollTo(n, h)), i()
                    })), e.preventDefault()
                }
            }
        }), App.isAngularJsApp() && $(".page-sidebar-menu li > a").on("click", function (e) {
            App.getViewPort().width < t && $(this).next().hasClass("sub-menu") === !1 && $(".page-header .responsive-toggler").click()
        }), $(".page-sidebar").on("click", " li > a.ajaxify", function (e) {
            e.preventDefault(), App.scrollTop();
            var a = $(this).attr("href"), i = $(".page-sidebar ul"), s = ($(".page-content"), $(".page-content .page-content-body"));
            i.children("li.active").removeClass("active"), i.children("arrow.open").removeClass("open"), $(this).parents("li").each(function () {
                $(this).addClass("active"), $(this).children("a > span.arrow").addClass("open")
            }), $(this).parents("li").addClass("active"), App.getViewPort().width < t && $(".page-sidebar").hasClass("in") && $(".page-header .responsive-toggler").click(), App.startPageLoading();
            var o = $(this);
            $.ajax({
                type: "GET", cache: !1, url: a, dataType: "html", success: function (e) {
                    0 === o.parents("li.open").size() && $(".page-sidebar-menu > li.open > a").click(), App.stopPageLoading(), s.html(e), Layout.fixContentHeight(), App.initAjax()
                }, error: function (e, a, t) {
                    App.stopPageLoading(), s.html("<h4>Could not load the requested content.</h4>")
                }
            })
        }), $(".page-content").on("click", ".ajaxify", function (e) {
            e.preventDefault(), App.scrollTop();
            var a = $(this).attr("href"), i = ($(".page-content"), $(".page-content .page-content-body"));
            App.startPageLoading(), App.getViewPort().width < t && $(".page-sidebar").hasClass("in") && $(".page-header .responsive-toggler").click(), $.ajax({
                type: "GET",
                cache: !1,
                url: a,
                dataType: "html",
                success: function (e) {
                    App.stopPageLoading(), i.html(e), Layout.fixContentHeight(), App.initAjax()
                },
                error: function (e, a, t) {
                    i.html("<h4>Could not load the requested content.</h4>"), App.stopPageLoading()
                }
            })
        }), $(document).on("click", ".page-header-fixed-mobile .page-header .responsive-toggler", function () {
            App.scrollTop()
        }), d(), $(".page-sidebar").on("click", ".sidebar-search .remove", function (e) {
            e.preventDefault(), $(".sidebar-search").removeClass("open")
        }), $(".page-sidebar .sidebar-search").on("keypress", "input.form-control", function (e) {
            return 13 == e.which ? ($(".sidebar-search").submit(), !1) : void 0
        }), $(".sidebar-search .submit").on("click", function (e) {
            e.preventDefault(), $("body").hasClass("page-sidebar-closed") && $(".sidebar-search").hasClass("open") === !1 ? (1 === $(".page-sidebar-fixed").size() && $(".page-sidebar .sidebar-toggler").click(), $(".sidebar-search").addClass("open")) : $(".sidebar-search").submit()
        }), 0 !== $(".sidebar-search").size() && ($(".sidebar-search .input-group").on("click", function (e) {
            e.stopPropagation()
        }), $("body").on("click", function () {
            $(".sidebar-search").hasClass("open") && $(".sidebar-search").removeClass("open")
        }))
    }, n = function () {
        var e = App.getViewPort().height - $(".page-header").outerHeight(!0);
        return $("body").hasClass("page-footer-fixed") && (e -= $(".page-footer").outerHeight()), e
    }, r = function () {
        var e = $(".page-sidebar-menu");
        return App.destroySlimScroll(e), 0 === $(".page-sidebar-fixed").size() ? void i() : void(App.getViewPort().width >= t && (e.attr("data-height", n()), App.initSlimScroll(e), i()))
    }, d = function () {
        var e = $("body");
        e.hasClass("page-sidebar-fixed") && $(".page-sidebar").on("mouseenter", function () {
            e.hasClass("page-sidebar-closed") && $(this).find(".page-sidebar-menu").removeClass("page-sidebar-menu-closed")
        }).on("mouseleave", function () {
            e.hasClass("page-sidebar-closed") && $(this).find(".page-sidebar-menu").addClass("page-sidebar-menu-closed")
        })
    }, p = function () {
        var e = $("body");
        $.cookie && "1" === $.cookie("sidebar_closed") && App.getViewPort().width >= t && ($("body").addClass("page-sidebar-closed"), $(".page-sidebar-menu").addClass("page-sidebar-menu-closed")), $("body").on("click", ".sidebar-toggler", function (a) {
            var t = $(".page-sidebar"), i = $(".page-sidebar-menu");
            $(".sidebar-search", t).removeClass("open"), e.hasClass("page-sidebar-closed") ? (e.removeClass("page-sidebar-closed"), i.removeClass("page-sidebar-menu-closed"), $.cookie && $.cookie("sidebar_closed", "0")) : (e.addClass("page-sidebar-closed"), i.addClass("page-sidebar-menu-closed"), e.hasClass("page-sidebar-fixed") && i.trigger("mouseleave"), $.cookie && $.cookie("sidebar_closed", "1")), $(window).trigger("resize")
        })
    }, l = function () {
        $(".page-header").on("click", '.hor-menu a[data-toggle="tab"]', function (e) {
            e.preventDefault();
            var a = $(".hor-menu .nav"), t = a.find("li.current");
            $("li.active", t).removeClass("active"), $(".selected", t).remove();
            var i = $(this).parents("li").last();
            i.addClass("current"), i.find("a:first").append('<span class="selected"></span>')
        }), $(".page-header").on("click", ".search-form", function (e) {
            $(this).addClass("open"), $(this).find(".form-control").focus(), $(".page-header .search-form .form-control").on("blur", function (e) {
                $(this).closest(".search-form").removeClass("open"), $(this).unbind("blur")
            })
        }), $(".page-header").on("keypress", ".hor-menu .search-form .form-control", function (e) {
            return 13 == e.which ? ($(this).closest(".search-form").submit(), !1) : void 0
        }), $(".page-header").on("mousedown", ".search-form.open .submit", function (e) {
            e.preventDefault(), e.stopPropagation(), $(this).closest(".search-form").submit()
        }), $('[data-hover="megamenu-dropdown"]').not(".hover-initialized").each(function () {
            $(this).dropdownHover(), $(this).addClass("hover-initialized")
        }), $(document).on("click", ".mega-menu-dropdown .dropdown-menu", function (e) {
            e.stopPropagation()
        })
    }, c = function () {
        $("body").on("shown.bs.tab", 'a[data-toggle="tab"]', function () {
            i()
        })
    }, h = function () {
        var e = 300, a = 500;
        navigator.userAgent.match(/iPhone|iPad|iPod/i) ? $(window).bind("touchend touchcancel touchleave", function (t) {
            $(this).scrollTop() > e ? $(".scroll-to-top").fadeIn(a) : $(".scroll-to-top").fadeOut(a)
        }) : $(window).scroll(function () {
            $(this).scrollTop() > e ? $(".scroll-to-top").fadeIn(a) : $(".scroll-to-top").fadeOut(a)
        }), $(".scroll-to-top").click(function (e) {
            return e.preventDefault(), $("html, body").animate({scrollTop: 0}, a), !1
        })
    }, g = function () {
        $(".full-height-content").each(function () {
            var e, a = $(this);
            if (e = App.getViewPort().height - $(".page-header").outerHeight(!0) - $(".page-footer").outerHeight(!0) - $(".page-title").outerHeight(!0) - $(".page-bar").outerHeight(!0), a.hasClass("portlet")) {
                var i = a.find(".portlet-body");
                App.destroySlimScroll(i.find(".full-height-content-body")), e = e - a.find(".portlet-title").outerHeight(!0) - parseInt(a.find(".portlet-body").css("padding-top")) - parseInt(a.find(".portlet-body").css("padding-bottom")) - 5, App.getViewPort().width >= t && a.hasClass("full-height-content-scrollable") ? (e -= 35, i.find(".full-height-content-body").css("height", e), App.initSlimScroll(i.find(".full-height-content-body"))) : i.css("min-height", e)
            } else App.destroySlimScroll(a.find(".full-height-content-body")), App.getViewPort().width >= t && a.hasClass("full-height-content-scrollable") ? (e -= 35, a.find(".full-height-content-body").css("height", e), App.initSlimScroll(a.find(".full-height-content-body"))) : a.css("min-height", e)
        })
    };
    return {
        initHeader: function () {
            l()
        }, setSidebarMenuActiveLink: function (e, a) {
            s(e, a)
        }, initSidebar: function () {
            r(), o(), p(), App.isAngularJsApp() && s("match"), App.addResizeHandler(r)
        }, initContent: function () {
            g(), c(), App.addResizeHandler(i), App.addResizeHandler(g)
        }, initFooter: function () {
            h()
        }, init: function () {
            this.initHeader(), this.initSidebar(), this.initContent(), this.initFooter()
        }, fixContentHeight: function () {
            i()
        }, initFixedSidebarHoverEffect: function () {
            d()
        }, initFixedSidebar: function () {
            r()
        }, getLayoutImgPath: function () {
            return App.getAssetsPath() + e
        }, getLayoutCssPath: function () {
            return App.getAssetsPath() + a
        }
    }
}();
App.isAngularJsApp() === !1 && jQuery(document).ready(function () {
    Layout.init()
});

$('textarea').removeAttr("style");

//*******************Building details  floors + units ************************//

/*Generating table from inputs*/
//String.prototype.repeat = function(n) {
//    return new Array(n + 1).join(this);
//}
//$('table').empty();
//var col = 5;
//var row = 9;
//
///*heading cells*/
//var head = "<th >Heading</th>".repeat(row);
///*heading row*/
//var tableHead = "<tr class='units-row'>" + head + "</tr>"
///*row-cells*/
//var tableData = "<td>content</td>".repeat(row);
///*row*/
//var tableRow = "<tr class='floor-row'>" + tableData + "</tr>";
//var table = tableRow;
//
//$('#units-table').append(tableHead);
//
//for (i = 0; i < col; i++) {
//    $('#units-table tr:last').after(table);
//}
//
//
///*show floor number in first of each row*/
//$('.floor-row').each(function (i) {
//    $("td:first", this).html(i);
//});
//



/***********************************************************************************/
//
//$("#foo").append("<div id='myDiv'>hello world</div>")
//
//var table = $('<table></table>').addClass('foo');
//
//for(i=0; i<3; i++){
//    var row = $('<tr></tr>').addClass('bar').text('result ' + i);
//    table.append(row);
//}
//
//
////$('#units-table').append(table);
//
//
//jQuery(document).ready(function() {
//    $('#units-table').append(table);
//});


/************************************************/

var highlighted_dates = ["20/6/2016", "22/6/2016", "24/6/2016", "25/5/2016"];

