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