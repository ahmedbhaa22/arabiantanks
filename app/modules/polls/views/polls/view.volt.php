<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="<?= $this->url->get('index') ?>"> الإستفتاءات </a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            عرض الاستفتاء 
        </li>
    </ul>
</div>

<div class="col-lg-12">
    <div class=" ">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('<?= $this->url->getStatic('polls/img/banners/poll.png') ?>') center center no-repeat ; background-size: contain"></div>
            </div>

        </div>
    </div>

</div>

<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-list-ul"></i>
            <span class="caption-subject bold uppercase">
               <?= $poll->name ?>
            </span>
        </div>
        
    </div>
    <div class="portlet-body">
        <?php foreach ($poll->questions as $question) { ?>
        <div class="row gap">
            <div class="col-md-12 no-padding bold">
                <?= $question->text ?>
            </div>
            <?php foreach ($question->answers as $answer) { ?>
            <div class="col-md-12 no-padding gap funkyradio">
                <div class="col-md-3">
                <?php if ($answer->photo) { ?>
                    <img src="<?= $this->url->getStatic($answer->photo) ?>" class="img-responsive">
                <?php } else { ?>
                    <img src="<?= $this->url->getStatic('polls/img/image_placeholder.png') ?>" class="img-responsive">
                <?php } ?>
                </div>
                <div class="funkyradio-primary">
                    <!-- <input type="radio" name="radio" id="radio1" /> -->
                    <label for="radio1"><?= $answer->text ?></label>
                </div>
            </div>
            <?php } ?>
        </div>
        <?php } ?>

        <!-- <div class="row gap">
            <div class="col-md-12 no-padding bold">
                سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء سؤال الإستفتاء                                 
                </div>
            <div class="col-md-12 no-padding gap funkyradio">
                <div class="funkyradio-primary">
                    <input type="radio" name="radio" id="radio3" />
                    <label for="radio3">
                            <img class="thumb" src="https://x1.xingassets.com/assets/frontend_minified/img/users/nobody_m.original.jpg">
                            Option 1
                    </label>
                </div>
                <div class="funkyradio-primary">
                    <input type="radio" name="radio" id="radio4"/>
                    <label for="radio4">
                            <img class="thumb" src="https://x1.xingassets.com/assets/frontend_minified/img/users/nobody_m.original.jpg">
                            Option 2
                    </label>
                </div>
                <div class="funkyradio-primary">
                    <input type="radio" name="radio" id="radio5" />
                    <label for="radio5">
                            <img class="thumb" src="https://x1.xingassets.com/assets/frontend_minified/img/users/nobody_m.original.jpg">
                            Option 3
                    </label>
                </div>
                <div class="funkyradio-primary">
                    <input type="radio" name="radio" id="radio6"/>
                    <label for="radio6">
                            <img class="thumb" src="https://x1.xingassets.com/assets/frontend_minified/img/users/nobody_m.original.jpg">
                            Option 4
                    </label>
                </div>
            </div>
        </div> -->

        <div class="row gap">
            <div class="col-md-12 no-padding">
                <!-- <button type="button" class="btn btn-primary">ارسال</button> -->
                <a href="<?= $this->url->get('polls/results/') . $poll->id ?>" class="btn btn-success">نتيجة الإستفتاء</a>
            </div>

        </div>
        <div class="clearfix"></div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD