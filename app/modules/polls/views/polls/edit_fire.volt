<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="poll.html"> الإستفتاءات </a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            استفتاء جديد 
        </li>
    </ul>

</div>

<div class="col-lg-12">
    <div class=" ">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('polls/img/banners/poll.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>

        </div>
    </div>

</div>

<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-plus"></i>
            <span class="caption-subject bold uppercase">
               إستفتاء جديد
            </span>
        </div>
        
    </div>
    <div class="portlet-body">


        <div class="row">
            <form method="post" action="{{url('polls/update_fire/') ~ event_id}}" enctype="multipart/form-data">
                <div class="col-xs-12 no-padding">
                    
                    <div class="col-xs-10">
                        <!-- <input type="text" class="form-control bg-info" name="name" placeholder="عنوان القسم" required value="{{poll.name}}"> -->
                    </div>

                    <div class="col-xs-2 nopadding-r" id="fixed-button"> <!-- required for floating -->
                        <button class="form-control btn-primary" type="button" onclick="newQuestion()">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i>  أضف سؤال
                        </button>
                    </div>

                    
                    <div class="row gap" id="questions_div">

                        {% for key, question in questions %}
                        
                        <div class="row gap" id="repeatTHISQ">
                            <div class="col-xs-12">
                                <!-- <legend>السؤال رقم 2</legend> -->
                                <div class="col-xs-12 no-padding">
                                    <textarea class="form-control" name="questions[{{loop.index}}][text]" placeholder="أكتب السؤال">{{key}}</textarea>
                                    <input type="hidden" name="questions[{{loop.index}}][id]" value="{{key}}">
                                </div>
                                
                                <div class="gap">
                                    <div class="">
                                        <!-- <div class="col-sm-12 no-padding" id="repeatTHISA">
                                            <div class="col-md-10 col-sm-8 col-xs-7 nopadding-r funkyradio">
                                                <div class="funkyradio-primary">
                                                    <input type="radio" name="radio">
                                                    <label><input type="text" class="form-control no-margin" name="questions[{{loop.index}}][answers][0]" placeholder="أكتب إجابة"></label>
                                                </div>
                                            </div>
                                            <div class="col-md-2 col-sm-4 col-xs-5 no-padding">
                                                <button class="btn-info" type="button">
                                                    <i class="fa fa-upload" aria-hidden="true"></i> صورة
                                                </button>
                                                <input type="file" class="btn-info" name="questions[{{loop.index}}][answers][0]" required>
                                            
                                                <button class="btn-danger" type="button">
                                                    <i class="fa fa-times" aria-hidden="true"></i> 
                                                </button>
                                            </div>
                                        </div> -->

                                        <div class="answers_div">
                                        {% set qIndex = loop.index %}
                                        {% for key, answer in question %}
                                        {% if key != "event_id" %}
                                            <div class="col-sm-12 no-padding" id="repeatTHISA">
                                                <div class="col-md-10 col-sm-8 col-xs-7 nopadding-r funkyradio">
                                                    <div class="funkyradio-primary">
                                                        <input type="radio" name="radio">
                                                        <label><input type="text" class="form-control no-margin" name="questions[{{qIndex}}][answers][{{loop.index}}][text]" placeholder="أكتب إجابة" required value="{{answer["name"]}}"></label>
                                                        <input type="hidden" name="questions[{{qIndex}}][answers][{{loop.index}}][id]" value="{{key}}">
                                                        <input type="hidden" name="questions[{{qIndex}}][answers][{{loop.index}}][rate]" value="{{answer['rate']}}">
                                                    </div>
                                                </div>
                                                <div class="col-md-2 col-sm-4 col-xs-5 no-padding">
                                                    <button class="btn-info">
                                                        <i class="fa fa-upload" aria-hidden="true"></i> صورة
                                                    </button>
                                                    <input type="file" class="btn-info" name="questions[{{qIndex}}][answers][{{loop.index}}]">
                                                    
                                                    <button class="btn-danger" type="button">
                                                        <i class="fa fa-times" aria-hidden="true"></i> 
                                                    </button>
                                                </div>
                                            </div>
                                            {% endif %}
                                        {% endfor %}
                                        </div>
                                        
                                    </div>

                                    <button class="btn btn-xs btn-primary" type="button" onclick="newAnswer(this, {{loop.index}})">
                                        <i class="fa fa-plus-circle" aria-hidden="true"></i>  أضف إجابة
                                    </button>
                                </div>
                            </div>
                        </div>
                        {% endfor %}

                    </div>

                    <div class="col-sm-12 gap">
                        <button class="form-control btn-success gap">
                            <i class="fa fa-floppy-o" aria-hidden="true"></i>
                            حفظ
                        </button>
                    </div>
                </div>
            </form>


            <script type="text/javascript">
                var i = 0;
                var original = document.getElementById('repeatTHISA');

                function repeat() {
                  var clone = original.cloneNode(true);
                  clone.id = "repeatTHISA" + ++i;
                  original.parentNode.appendChild(clone);
                }
            </script>
        </div>
        <div class="clearfix"></div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->

<script type="text/javascript">
var questions = 0;
var answers = 0;

function newQuestion() {
    questions++;
    var source   = $("#questions-template").html();
    var template = Handlebars.compile(source);
    var html = template({questions: questions});
    $("#questions_div").append(html);
}

function newAnswer(el, question) {
    answers++;
    var source   = $("#answers-template").html();
    var template = Handlebars.compile(source);
    var html = template({answers: answers, question: question});
    $(el).closest(".gap").find(".answers_div").append(html);
}

function removeQuestion(el) {
    
}

$(document).ready(function(){
    $.ajax({
        method: "get",
        url: "{{url.getStatic('polls/js/templates.html')}}",
        success: function(response){
            $("body").append(response);
        }
    })
});
</script>

