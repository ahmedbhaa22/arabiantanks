<!-- BEGIN PAGE HEADER-->
<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="<?= $this->url->get('index') ?>"> الإستفتاءات </a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <a href="<?= $this->url->get('polls/view/') . $poll->id ?>">عرض الاستفتاء </a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            نتائج عنوان الإستفتاء
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
            <table class="table poll-result">
                <thead>
                    <tr>
                        <th colspan="2">
                            <?= $question->text ?>   
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($question->answers as $answer) { ?>
                    <tr>
                        <td>
                            <?= $answer->text ?> 
                        </td>
                        <td>
                            <?= $answer->getPercentage() ?>%
                            <div class="progress poll-progress">
                                <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="<?= $answer->getPercentage() ?>" aria-valuemin="0" aria-valuemax="100" style="width:<?= $answer->getPercentage() ?>%">
                                <?= $answer->getPercentage() ?>%
                                </div>
                            </div>
                        </td>
                    </tr>
                    <?php } ?>

                  

                    <tr>
                        <td colspan="2">
                            <a href="<?= $this->url->get('polls/details/') . $question->id ?>" class="text-success bold">
                                <i class="fa fa-info-circle" aria-hidden="true"></i> تفاصيل الإجابات
                            </a>  
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <?php } ?>


        
        <div class="clearfix"></div>
    </div>
</div>

<div class="clearfix"></div>
<!-- END DASHBOARD -->