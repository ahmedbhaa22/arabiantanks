<div class="portlet light bordered">
    <div class="portlet-title">
        <p><?php $this->flashSession->output() ?></p>
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase">تعديل خيارات أبليكيشن  : {{application.Title}}</span>
        </div>

        <div class="actions">
            <a type="button" href="{{url()}}" data-toggle="modal" class="btn green-jungle btn-outline">
                {{ translate._("Back")}}
            </a>
        </div>

        <div class="actions">
            <a type="button" href="{{url('application_settings/deleteApplication')}}" class="btn green-jungle btn-outline"  onclick="return confirm('Are you sure ?')">
                {{ translate._("Delete Application")}}
            </a>
        </div>
    </div>
    <div class="portlet-body">
        <?php
        echo $this->tag->form(
            [
                "application_settings/save",
                "autocomplete" => "off",
                "class" => "form-horizontal paymentForm",
                "role" => "form",
                "style" => "display:block",
                "enctype" => "multipart/form-data"
            ]
        );
        ?>
         <div class="bar bg-blue-chambray gap clearfix">
            <div class="col-md-4 col-xs-6">
                <div class="form-group">
                    <label for="AppBanner" class="control-label"><b>Application Banner</b></label>
                    <input type="file" name="App_Banner" value="" class="form-control">
                    <div><img src="{{this.url_shared.get()}}uploads/modules_pics/2b5ca6f7-7ec7-47a6-901f-625cc6607f1d.png"> </div>
                </div>

            </div>
            
        </div>
        <div class="gap"></div>

        <div class="col-sm-2" id="application_menus" style="">
            <div class="form-group">
                <label for="fieldTitle" class="control-label col-xs-12 no-padding">{{translate._('Main Menu')}} </label>
                <?php echo Phalcon\Tag::select([
                    "MainMenu",
                    $application_menus,
                    "using" => ["id", "menu_name"] ]);
                ?>
                <div class="clearfix"></div>


            </div>


        </div>

        <div class="col-md-12 col-xs-12">
            
            <div class="form-group">
                <div class="col-sm-12 text-center">
                	<input type="hidden" name="Application_ID" value="{{application.ID}}"/>
                    <?php echo $this->tag->submitButton(["Save", "class" => "btn green-jungle"]) ?>
                </div>
            </div>

            <?php echo $this->tag->endForm(); ?>

        </div>
        <div class="clearfix"></div>
        <?php echo $this->tag->endForm(); ?>

    </div>
</div>
