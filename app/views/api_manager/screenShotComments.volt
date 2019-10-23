<div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">SCREEN NAME</h4>
    </div>
    <div class="modal-body block-section">
        <div class="col-xs-3">
            <img src="{{url('uploads/' ~screen_shot)}}">
        </div>

        <div class="col-xs-9">

            <div class="block-comments gap" >


                {%for comment in comments%}
                <div class="col-xs-12 no-pad">
                    <div class="col-xs-1 no-pad">
                        <div class="thumbnail">
                            <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                        </div><!-- /thumbnail -->
                    </div><!-- /col-sm-1 -->

                    <div class="col-xs-11">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <strong>{{comment.title}}</strong>
                                <span class="text-muted">{{comment.created_date}}</span>
                            </div>
                            <div class="panel-body">
                                {{comment.comment}}
                            </div><!-- /panel-body -->
                        </div><!-- /panel panel-default -->
                    </div><!-- /col-sm-11 -->
                </div>
                {%endfor%}

            </div>
        </div>
    </div>
    <div class="modal-footer">
        <div class="col-xs-12 no-pad">
            <div class="col-sm-1 no-pad">
                <div class="thumbnail">
                    <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                </div><!-- /thumbnail -->
            </div><!-- /col-sm-1 -->
            <form action="{{url('api_manager/addCommentAjax')}}" method="post">
                <div class="col-md-11 col-sm-11">
                    <input type="text" class="form-control comment" placeholder="Add Comment Title" name="title" id="title" required=""></textarea>
                </div>
                <div class="col-md-11 col-sm-11">
                    <textarea class="form-control comment" name="comment" id="comment" placeholder="Add Comment body" required=""></textarea>
                </div>
                <input type="hidden" value="{{screenshot_id}}" name="screenshot_id" id="screenshot_id"/>
                <button type="submit" class="btn btn-info" id="submit">Add Comment</button>
            </form>
        </div>

        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
</div>

<script>
    //$('.block-comments').load('{{url("api_manager/screenShotsCommentsAjax/" ~screenshot_id)}}');

    $("#submit").click(function(){
            var comment = $("#comment").val();
            var title = $("#title").val();
            var screenshot_id = $("#screenshot_id").val();
// Returns successful data submission message when the entered information is stored in database.
            var dataString = 'comment='+ comment + '&title='+ title + '&screenshot_id='+ screenshot_id ;
            if(comment==''||title=='')
            {
                alert("Please Fill All Fields");
            }
            else
            {
// AJAX Code To Submit Form.
                $.ajax({
                    type: "POST",
                    url: "{{url('api_manager/addCommentAjax')}}",
                    data: dataString,
                    cache: false,
                    success: function(result){
                        $('.block-comments').html('');
                        $('.block-comments').load('{{url("api_manager/screenShotsCommentsAjax/" ~screenshot_id)}}');
                    }
                });
            }
            return false;
        });

</script>