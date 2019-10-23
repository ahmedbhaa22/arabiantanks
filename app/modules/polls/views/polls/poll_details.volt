<div class="panel panel-success clearfix">
    <div class="panel-heading">
        <div class="panel-title">
{{item['name']}}
        </div>
    </div>
    {%for question in item['questions']%}
    <div class="panel-body">
        <div class="row gap">
            <div class="col-md-12 no-padding bold">
              {{question['text']}}
            </div>
            <div class="col-md-12 no-padding gap funkyradio">
                {%for answer in question['answers']%}
                <div class="funkyradio-primary">
                    <input type="radio" name="answers_question{{question['id']}}[]" id="radio{{answer['id']}}" class="oneanswer" value="{{answer['id']}}"  />
                    <label for="radio{{answer['id']}}"> {{answer['text']}} </label>
                </div>
                {%endfor%}

            </div>
        </div>


    </div>
    {%endfor%}

</div>