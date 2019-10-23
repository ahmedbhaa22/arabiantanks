<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="{{url('maintenance_module/requests/index')}}"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <a href="{{url('maintenance_module/requests/index')}}">
                <span>طلبات الصيانة</span>
            </a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <a href="{{url('maintenance_module/requests/index')}}">
                <span>محتوى الصيانة</span>
            </a>
            <i class="fa fa-angle-left"></i>
        </li>
        <li>
            <span>انشاء تذكرة</span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url('img/banners/')}}banner.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-ticket font-dark"></i>
            <span class="caption-subject bold uppercase"> انشاء تذكرة</span>
        </div>

    </div>
    <div class="portlet-body">
        <div id="timeline-h" class="panel">
            <section class="cd-horizontal-timeline">


                <div class="panel-heading">
                    <div class="timeline">
                        <div class="events-wrapper">
                            <div class="events" style="width: 100% !important; ">
                                <ol style="width: 100% !important; ">
                                    <li><a href="#0" data-date="01/03/2014" class="selected"> بيانات العميل </a></li>
                                    <li><a href="#0" data-date="01/06/2014"> تحديد المنتج </a></li>
                                    <li><a href="#0" data-date="01/09/2014">بيانات الشراء</a></li>
                                    <li class="last_step"><a href="#0" data-date="01/12/2014">ملخص</a></li>
                                </ol>

                                <span class="filling-line" aria-hidden="true"></span>
                            </div>
                            <!-- .events -->
                        </div>
                        <!-- .events-wrapper -->

                        <!-- .cd-timeline-navigation -->
                    </div>
                    <!-- .timeline -->
                </div>


                <div class="events-content">
                    <ol>
                        <form method="post" action="{{url('maintenance_module/requests/createRequest')}}" enctype="multipart/form-data">
                        <li class="selected"  data-date="01/03/2014">
                            <div class="panel-body">
                                {% if session.get('error_msgs')|length %}
                                <ul style="color:red;float:left;">
                                    {% for msg in session.get('error_msgs') %}
                                    <li style="float:left;">{{msg['field']}} : {{msg['message']}}</li><br>
                                    <?php $this->session->set('error_msgs', []) ?>
                                    {% endfor %}
                                </ul>
                                {% endif %}

                                    <h4>بيانات العميل</h4>
                                <a type="button" href="" class="btn green-jungle btn-outline pull-right md-skip" data-toggle="modal" data-target="#newClientModal">
                                    <i class="fa fa-plus" aria-hidden="true"></i>إضافة عميل
                                </a>

                                <div class="clearfix"></div>
                                <div class="col-md-12 "></div>

                                {%if(client_exists)%}
                                <div class="col-md-3">{{ client_exists.Title }}</div>
                                <div class="col-md-3">{{ client_exists.Mobile }}</div>
                                <div class="col-md-3">
                                    <input type="radio" name="client_choose" class="client_choose" value="{{ client_exists.ID }}" checked />
                                </div>
                                {%else%}
                                <div class="client_filter space">
                                    {{partial("requests/partials/clients_filter")}}
                                </div>
                                <div id="clients_content">


                                </div>
                                {%endif%}


                            </div>

                            <div class="form-group col-md-6">
                                <label>ملاحظات</label>
                                <textarea type="text" class="form-control" name="report_notes" id="report_notes"></textarea>
                            </div>
                        </li>

                        <li data-date="01/06/2014">
                            {{ partial("requests/partials/requests_product_select", ['main_cats': main_cats]) }}
                        </li>

                        <li data-date="01/09/2014">
                            {{ partial("requests/partials/requests_purchase_details", ['all_branches': all_branches]) }}

                        </li>

                        <li data-date="01/12/2014">
                            {{ partial("requests/partials/requests_revise", ['all_branches': all_branches]) }}


                            <div class="col-xs-12">
                                <input type="submit" class=" btn btn-success btn-md" value="انشاء تذكرة"/>

                            </div>
                        </li>
                            <input type="hidden" name="<?php echo $this->security->getTokenKey() ?>"
                                   value="<?php echo $this->security->getToken() ?>"/>
                        </form>
                    </ol>
                </div>
                <!-- .events-content -->
            </section>
        </div>
    </div>
</div>


<div id="newClientModal" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">×</button>
                <h4 class="modal-title"> إضافة عميل </h4>
            </div>
            <form role="form" action="{{url('maintenance_module/requests/add_fast_client')}}" id="msg" enctype="multipart/form-data" method="post">

                <div class="modal-body">

                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">اسم العميل</label>
                            <input type="text" class="form-control" name="name" required/>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">البريد الالكتروني</label>
                            <input type="email" class="form-control" name="email"/>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label class="control-label">الهاتف الجوال</label>
                            <input type="text" class="form-control" name="mobile" required/>
                        </div>

                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">المنطقة</label>
                            <select name="region">
                                {% for region in regions %}
                                <option value="{{region.id}}">{{region.name}}</option>
                                {% endfor %}
                            </select>
                            </div>
                        </div>





                </div>

                <div class="modal-footer">
                    <button type="submit" class="btn btn-success"> حفظ</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">اغلاق</button>
                </div>
            </form>

        </div>

    </div>
</div>



{{ stylesheet_link('ropo_app/css/create-ticket.css') }}
<script type="text/javascript">
    var i = 0;
    var original = document.getElementById('repeatTHIS');

    function repeat() {
        var clone = original.cloneNode(true);
        clone.id = "repeatTHIS" + ++i;
        original.parentNode.appendChild(clone);
    }
</script>

<script>
    jQuery(document).ready(function ($) {
        var timelines = $('.cd-horizontal-timeline'),
            eventsMinDistance = 145;

        (timelines.length > 0) && initTimeline(timelines);

        function initTimeline(timelines) {
            timelines.each(function () {
                var timeline = $(this),
                    timelineComponents = {};
                //cache timeline components
                timelineComponents['timelineWrapper'] = timeline.find('.events-wrapper');
                timelineComponents['eventsWrapper'] = timelineComponents['timelineWrapper'].children('.events');
                timelineComponents['fillingLine'] = timelineComponents['eventsWrapper'].children('.filling-line');
                timelineComponents['timelineEvents'] = timelineComponents['eventsWrapper'].find('a');
                timelineComponents['timelineDates'] = parseDate(timelineComponents['timelineEvents']);
                timelineComponents['eventsMinLapse'] = minLapse(timelineComponents['timelineDates']);
                timelineComponents['timelineNavigation'] = timeline.find('.cd-timeline-navigation');
                timelineComponents['eventsContent'] = timeline.children('.events-content');

                //assign a left postion to the single events along the timeline
                setDatePosition(timelineComponents, eventsMinDistance);
                //assign a width to the timeline
                var timelineTotWidth = setTimelineWidth(timelineComponents, eventsMinDistance);
                //the timeline has been initialize - show it
                timeline.addClass('loaded');

                //detect click on the next arrow
                timelineComponents['timelineNavigation'].on('click', '.next', function (event) {
                    event.preventDefault();
                    updateSlide(timelineComponents, timelineTotWidth, 'next');
                });
                //detect click on the prev arrow
                timelineComponents['timelineNavigation'].on('click', '.prev', function (event) {
                    event.preventDefault();
                    updateSlide(timelineComponents, timelineTotWidth, 'prev');
                });
                //detect click on the a single event - show new event content
                timelineComponents['eventsWrapper'].on('click', 'a', function (event) {
                    event.preventDefault();
                    timelineComponents['timelineEvents'].removeClass('selected');
                    $(this).addClass('selected');
                    updateOlderEvents($(this));
                    updateFilling($(this), timelineComponents['fillingLine'], timelineTotWidth);
                    updateVisibleContent($(this), timelineComponents['eventsContent']);
                });

                //on swipe, show next/prev event content
                timelineComponents['eventsContent'].on('swipeleft', function () {
                    var mq = checkMQ();
                    (mq == 'mobile') && showNewContent(timelineComponents, timelineTotWidth, 'next');
                });
                timelineComponents['eventsContent'].on('swiperight', function () {
                    var mq = checkMQ();
                    (mq == 'mobile') && showNewContent(timelineComponents, timelineTotWidth, 'prev');
                });

                //keyboard navigation
                $(document).keyup(function (event) {
                    if (event.which == '37' && elementInViewport(timeline.get(0))) {
                        showNewContent(timelineComponents, timelineTotWidth, 'prev');
                    } else if (event.which == '39' && elementInViewport(timeline.get(0))) {
                        showNewContent(timelineComponents, timelineTotWidth, 'next');
                    }
                });
            });
        }

        function updateSlide(timelineComponents, timelineTotWidth, string) {
            //retrieve translateX value of timelineComponents['eventsWrapper']
            var translateValue = getTranslateValue(timelineComponents['eventsWrapper']),
                wrapperWidth = Number(timelineComponents['timelineWrapper'].css('width').replace('px', ''));
            //translate the timeline to the left('next')/right('prev')
            (string == 'next')
                ? translateTimeline(timelineComponents, translateValue - wrapperWidth + eventsMinDistance, wrapperWidth - timelineTotWidth)
                : translateTimeline(timelineComponents, translateValue + wrapperWidth - eventsMinDistance);
        }

        function showNewContent(timelineComponents, timelineTotWidth, string) {
            //go from one event to the next/previous one
            var visibleContent = timelineComponents['eventsContent'].find('.selected'),
                newContent = (string == 'next') ? visibleContent.next() : visibleContent.prev();

            if (newContent.length > 0) { //if there's a next/prev event - show it
                var selectedDate = timelineComponents['eventsWrapper'].find('.selected'),
                    newEvent = (string == 'next') ? selectedDate.parent('li').next('li').children('a') : selectedDate.parent('li').prev('li').children('a');

                updateFilling(newEvent, timelineComponents['fillingLine'], timelineTotWidth);
                updateVisibleContent(newEvent, timelineComponents['eventsContent']);
                newEvent.addClass('selected');
                selectedDate.removeClass('selected');
                updateOlderEvents(newEvent);
                updateTimelinePosition(string, newEvent, timelineComponents, timelineTotWidth);
            }
        }

        function updateTimelinePosition(string, event, timelineComponents, timelineTotWidth) {
            //translate timeline to the left/right according to the position of the selected event
            var eventStyle = window.getComputedStyle(event.get(0), null),
                eventLeft = Number(eventStyle.getPropertyValue("right").replace('px', '')),
                timelineWidth = Number(timelineComponents['timelineWrapper'].css('width').replace('px', '')),
                timelineTotWidth = Number(timelineComponents['eventsWrapper'].css('width').replace('px', ''));
            var timelineTranslate = getTranslateValue(timelineComponents['eventsWrapper']);

            if ((string == 'next' && eventLeft > timelineWidth - timelineTranslate) || (string == 'prev' && eventLeft < - timelineTranslate)) {
                translateTimeline(timelineComponents, - eventLeft + timelineWidth / 2, timelineWidth - timelineTotWidth);
            }
        }

        function translateTimeline(timelineComponents, value, totWidth) {
            var eventsWrapper = timelineComponents['eventsWrapper'].get(0);
            value = (value > 0) ? 0 : value; //only negative translate value
            value = (!(typeof totWidth === 'undefined') && value < totWidth) ? totWidth : value; //do not translate more than timeline width
            setTransformValue(eventsWrapper, 'translateX', value + 'px');
            //update navigation arrows visibility
            (value == 0) ? timelineComponents['timelineNavigation'].find('.prev').addClass('inactive') : timelineComponents['timelineNavigation'].find('.prev').removeClass('inactive');
            (value == totWidth) ? timelineComponents['timelineNavigation'].find('.next').addClass('inactive') : timelineComponents['timelineNavigation'].find('.next').removeClass('inactive');
        }

        function updateFilling(selectedEvent, filling, totWidth) {
            //change .filling-line length according to the selected event
            var eventStyle = window.getComputedStyle(selectedEvent.get(0), null),
                eventLeft = eventStyle.getPropertyValue("right"),
                eventWidth = eventStyle.getPropertyValue("width");
            eventLeft = Number(eventLeft.replace('px', '')) + Number(eventWidth.replace('px', '')) / 2;
            var scaleValue = eventLeft / totWidth;
            setTransformValue(filling.get(0), 'scaleX', scaleValue);
        }

        function setDatePosition(timelineComponents, min) {
            for (i = 0; i < timelineComponents['timelineDates'].length; i++) {
                var distance = daydiff(timelineComponents['timelineDates'][0], timelineComponents['timelineDates'][i]),
                    distanceNorm = Math.round(distance / timelineComponents['eventsMinLapse']) + 2;
                timelineComponents['timelineEvents'].eq(i).css('right', distanceNorm * min + 'px');
            }
        }

        function setTimelineWidth(timelineComponents, width) {
            var timeSpan = daydiff(timelineComponents['timelineDates'][0], timelineComponents['timelineDates'][timelineComponents['timelineDates'].length - 1]),
                timeSpanNorm = timeSpan / timelineComponents['eventsMinLapse'],
                timeSpanNorm = Math.round(timeSpanNorm) + 4,
                totalWidth = timeSpanNorm * width;
            timelineComponents['eventsWrapper'].width('100%');
            updateFilling(timelineComponents['timelineEvents'].eq(0), timelineComponents['fillingLine'], totalWidth);

            return totalWidth;
        }

        function updateVisibleContent(event, eventsContent) {
            var eventDate = event.data('date'),
                visibleContent = eventsContent.find('.selected'),
                selectedContent = eventsContent.find('[data-date="' + eventDate + '"]'),
                selectedContentHeight = selectedContent.height();

            if (selectedContent.index() > visibleContent.index()) {
                var classEnetering = 'selected enter-right',
                    classLeaving = 'leave-left';
            } else {
                var classEnetering = 'selected enter-left',
                    classLeaving = 'leave-right';
            }

            selectedContent.attr('class', classEnetering);
            visibleContent.attr('class', classLeaving).one('webkitAnimationEnd oanimationend msAnimationEnd animationend', function () {
                visibleContent.removeClass('leave-right leave-left');
                selectedContent.removeClass('enter-left enter-right');
            });
            eventsContent.css('height', selectedContentHeight + 'px');
        }

        function updateOlderEvents(event) {
            event.parent('li').prevAll('li').children('a').addClass('older-event').end().end().nextAll('li').children('a').removeClass('older-event');
        }

        function getTranslateValue(timeline) {
            var timelineStyle = window.getComputedStyle(timeline.get(0), null),
                timelineTranslate = timelineStyle.getPropertyValue("-webkit-transform") ||
                    timelineStyle.getPropertyValue("-moz-transform") ||
                    timelineStyle.getPropertyValue("-ms-transform") ||
                    timelineStyle.getPropertyValue("-o-transform") ||
                    timelineStyle.getPropertyValue("transform");

            if (timelineTranslate.indexOf('(') >= 0) {
                var timelineTranslate = timelineTranslate.split('(')[1];
                timelineTranslate = timelineTranslate.split(')')[0];
                timelineTranslate = timelineTranslate.split(',');
                var translateValue = timelineTranslate[4];
            } else {
                var translateValue = 0;
            }

            return Number(translateValue);
        }

        function setTransformValue(element, property, value) {
            element.style["-webkit-transform"] = property + "(" + value + ")";
            element.style["-moz-transform"] = property + "(" + value + ")";
            element.style["-ms-transform"] = property + "(" + value + ")";
            element.style["-o-transform"] = property + "(" + value + ")";
            element.style["transform"] = property + "(" + value + ")";
        }

        //based on http://stackoverflow.com/questions/542938/how-do-i-get-the-number-of-days-between-two-dates-in-javascript
        function parseDate(events) {
            var dateArrays = [];
            events.each(function () {
                var dateComp = $(this).data('date').split('/'),
                    newDate = new Date(dateComp[2], dateComp[1] - 1, dateComp[0]);
                dateArrays.push(newDate);
            });
            return dateArrays;
        }

        function parseDate2(events) {
            var dateArrays = [];
            events.each(function () {
                var singleDate = $(this),
                    dateComp = singleDate.data('date').split('T');
                if (dateComp.length > 1) { //both DD/MM/YEAR and time are provided
                    var dayComp = dateComp[0].split('/'),
                        timeComp = dateComp[1].split(':');
                } else if (dateComp[0].indexOf(':') >= 0) { //only time is provide
                    var dayComp = ["2000", "0", "0"],
                        timeComp = dateComp[0].split(':');
                } else { //only DD/MM/YEAR
                    var dayComp = dateComp[0].split('/'),
                        timeComp = ["0", "0"];
                }
                var newDate = new Date(dayComp[2], dayComp[1] - 1, dayComp[0], timeComp[0], timeComp[1]);
                dateArrays.push(newDate);
            });
            return dateArrays;
        }

        function daydiff(first, second) {
            return Math.round((second - first));
        }

        function minLapse(dates) {
            //determine the minimum distance among events
            var dateDistances = [];
            for (i = 1; i < dates.length; i++) {
                var distance = daydiff(dates[i - 1], dates[i]);
                dateDistances.push(distance);
            }
            return Math.min.apply(null, dateDistances);
        }

        /*
         How to tell if a DOM element is visible in the current viewport?
         http://stackoverflow.com/questions/123999/how-to-tell-if-a-dom-element-is-visible-in-the-current-viewport
         */
        function elementInViewport(el) {
            var top = el.offsetTop;
            var left = el.offsetLeft;
            var width = el.offsetWidth;
            var height = el.offsetHeight;

            while (el.offsetParent) {
                el = el.offsetParent;
                top += el.offsetTop;
                right += el.offsetLeft;
            }

            return (
                top < (window.pageYOffset + window.innerHeight) &&
                right < (window.pageXOffset + window.innerWidth) &&
                (top + height) > window.pageYOffset &&
                (right + width) > window.pageXOffset
            );
        }

        function checkMQ() {
            //check if mobile or desktop device
            return window.getComputedStyle(document.querySelector('.cd-horizontal-timeline'), '::before').getPropertyValue('content').replace(/'/g, "").replace(/"/g, "");
        }
    });
</script>


<script>
    var url= "{{url('maintenance_module/requests/getClientsAjax')}}";
    $("#clients_content").load(url);


    $('#report_notes').change(function() {
        $('#revise_client_notes').text($(this).val());
    });


</script>