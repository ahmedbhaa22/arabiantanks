<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="index.html"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="production.html"><span> المنتجات </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="sales.html"><span> المبيعات </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="polls.html"><span>إستبيان  </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span> إنشاء إستبيان </span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>
<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('img/banners/poll.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->
<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-question-circle" aria-hidden="true"></i>
            <span class="caption-subject bold uppercase">
                                إنشاء إستبيان
                          </span>
        </div>
    </div>
    <div class="portlet-body">
        <form method="post" action="{{url('polls/save')}}" role="form" enctype="multipart/form-data">
            <div class="row" >

            <div class="col-xs-10">
                <input required type="text" class="form-control bg-info" name="poll_title" placeholder="عنوان الإستبيان">
            </div>

            <div class="col-xs-2 nopadding-r" id="fixed-button"> <!-- required for floating -->
                <button type="button" class="form-control btn-primary" id="add_question" onclick="repeatQuestion()">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>  أضف سؤال
                </button>
            </div>

<div id="questions_container">
    <div class="row gap" id="repeated_q">
        <div class="col-xs-12">
            <legend>السؤال رقم 1</legend>
            <div class="row">
                <textarea name="poll[sections][1][question]" class="form-control" placeholder="أكتب السؤال"></textarea>
            </div>

            <div class="gap">
                <div class="" id="answers_container">
                    <div class="row repeated_answer" data-index="1">
                        <div class="col-md-10 col-sm-8 col-xs-7 nopadding-r funkyradio">
                            <div class="funkyradio-primary">
                                <input type="radio" name="radio">
                                <label><input type="text" class="form-control no-margin" name="poll[sections][1][answers][a_1][text]" placeholder="أكتب إجابة"></label>
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-4 col-xs-5 no-padding">
                            <input type="file" name="poll[sections][1][answers][a_1][file]" accept="image/*, .png, .jpg, .jpeg">
                            <!-- <button class="btn-info">
                                <i class="fa fa-upload" aria-hidden="true"></i> صورة
                            </button> -->
                            <button type="button" data-index="1" class="btn-danger remove-answer">
                                <i class="fa fa-times" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>

                </div>

                <button data-index="1" type="button" class="btn btn-xs btn-primary add-answer">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>  أضف إجابة
                </button>
            </div>
        </div>
    </div>
</div>



            <div class="col-sm-12 gap">
                <button type="submit" class="form-control btn-success">
                    <i class="fa fa-floppy-o" aria-hidden="true"></i>
                    حفظ
                </button>
            </div>
        </div>
        </form>

 <div class="row" id="repeated_answer_model" style="display:none;">
    <div class="col-md-10 col-sm-8 col-xs-7 nopadding-r funkyradio">
        <div class="funkyradio-primary">
            <input type="radio" name="radio">
            <label><input type="text" class="form-control no-margin" name="poll[sections][1][answers][a_1][text]" placeholder="أكتب إجابة"></label>
        </div>
    </div>
    <div class="col-md-2 col-sm-4 col-xs-5 no-padding">
        <input type="file" name="poll[sections][1][answers][a_1][file]" accept="image/*, .png, .jpg, .jpeg">
        <!-- <button class="btn-info">
            <i class="fa fa-upload" aria-hidden="true"></i> صورة
        </button> -->
        <button type="button" data-index="1" class="btn-danger remove-answer">
            <i class="fa fa-times" aria-hidden="true"></i>
        </button>
    </div>
</div>

        <script type="text/javascript">
            var i = 1;
            var j = 1;

            function repeatQuestion()
            {
                i += 1;

                var original = $('#repeated_q');
                var original_id = original.attr('id');

                var clone = original.clone(true).attr('id', original_id + i);
                clone.find('legend').text('السؤال رقم ' + i);
                clone.find('textarea').attr('name', 'poll[sections]['+i+'][question]').val('');
                clone.find('input:text').attr('name', 'poll[sections]['+i+'][answers][a_'+i+'][text]');
                clone.find('input:file').attr('name', 'poll[sections]['+i+'][answers][a_'+i+'][file]');
                clone.find('div#answers_container').html('');
                clone.find('div#answers_container').attr('id', 'answers_container'+i);
                clone.find('button.add-answer').data('index', i);
                // clone.find('#repeated_answer').attr('id', 'repeated_answer'+i);
                clone.appendTo('#questions_container');
                
            }

            $('.add-answer').on('click', function()
            {
                j += 1;

                 var index = $(this).data('index');
                 var clone = $('#repeated_answer_model').clone(true);
                 clone.addClass('repeated_answer');
                 clone.attr('id', '');
                 clone.css({display:'block'});
                 clone.data('index', j);

                 clone.find('textarea').attr('name', 'poll[sections]['+index+'][question]');
                 clone.find('input:text').attr('name', 'poll[sections]['+index+'][answers][a_'+(j+1)+'][text]');
                 clone.find('input:file').attr('name', 'poll[sections]['+index+'][answers][a_'+(j+1)+'][file]');

                 switch(index)
                 {
                    case 1:
                    clone.appendTo('#answers_container');
                    break;
                    default:
                    clone.appendTo('#answers_container'+index);
                    break;
                 }
            });

            $('.remove-answer').on('click', function()
            {
                $(this).parent().parent().remove();
            });
        </script>

<!--

        // <script type="text/javascript">
        //     var i = 0;
        //     var original = document.getElementById('repeatTHISA');

        //     function repeat_a(q_name) {
        //         var clone = original.cloneNode(true);
        //         var i = $('.item').length;
        //         var original = document.getElementById(q_name+'_container');
        //         clone.id = "q_name_a" + ++i;
        //         clone.name = "q_name_a" + ++i;
        //         original.parentNode.appendChild(clone);
        //     }
        // </script>

        // <script>
        //     var question = $("#add_question");
        //     var questionCount = 1;
        //     $(question).click(function() {
        //         questionCount++;
        //         var num_answers = 1;
        //         var q_name= "q"+questionCount;
        //             $("#questions_container").append('<div class="row gap" id="'+q_name+'"><div class="col-xs-12"><legend>السؤال رقم 2</legend><div class="row"><textarea class="form-control" placeholder="أكتب السؤال" name="'+q_name+'"></textarea></div><div class="gap"><div class="" id="'+q_name+'_container"><div class="row" id="repeatTHISA"><div class="col-md-10 col-sm-8 col-xs-7 nopadding-r funkyradio"><div class="funkyradio-primary"> <input type="radio" name="radio"> <label><input type="text" class="form-control no-margin" name="'+q_name+'_a" placeholder="أكتب إجابة" class="'+q_name+'_a"></label></div></div><div class="col-md-2 col-sm-4 col-xs-5 no-padding"> <button class="btn-info"> <i class="fa fa-upload" aria-hidden="true"></i> صورة </button><button class="btn-danger"> <i class="fa fa-times" aria-hidden="true"></i> </button></div></div></div><a class="btn btn-xs btn-primary" onclick="repeat_a(q_name);"> <i class="fa fa-plus-circle" aria-hidden="true"></i> أضف إجابة </a></div></div></div>');


        //         return false;
        //     });
        // </script> -->
        <div class="clearfix"></div>
    </div>

</div>