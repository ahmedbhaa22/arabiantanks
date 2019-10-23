<div class="panel panel-success clearfix">
    <div class="panel-heading">
        <div class="panel-title">
<?= $item['name'] ?>
        </div>
    </div>
    <?php foreach ($item['questions'] as $question) { ?>
    <div class="panel-body">
        <div class="row gap">
            <div class="col-md-12 no-padding bold">
              <?= $question['text'] ?>
            </div>
            <div class="col-md-12 no-padding gap funkyradio">
                <?php foreach ($question['answers'] as $answer) { ?>
                <div class="funkyradio-primary">
                    <input type="radio" name="answers_question<?= $question['id'] ?>[]" id="radio<?= $answer['id'] ?>" class="oneanswer" value="<?= $answer['id'] ?>"  />
                    <label for="radio<?= $answer['id'] ?>"> <?= $answer['text'] ?> </label>
                </div>
                <?php } ?>

            </div>
        </div>


    </div>
    <?php } ?>

</div>