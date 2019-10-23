<h3 class="page-title"> صفحتى الشخصية
    <small></small>
</h3>
<!-- END PAGE TITLE-->
<!-- END PAGE HEADER-->
<div class="row">
    <div class="col-lg-12">
        <div class="portlet light">
            <div class="row">
                <div class="col-lg-2 col-md-3 col-xs-12">
                    <div class="img-holder img-thumbnail"
                         style="width: 180px; margin-top: 15px ; height: 180px; overflow: hidden ; background: url('http://cdn.playbuzz.com/cdn/7a4e3ba7-7b50-4ae6-8c37-4264abef50f1/ebeb714e-4067-42f0-beb8-c98c296dbd12.gif') center center no-repeat ; background-size: cover"></div>

                </div>
                <div class="col-lg-10 col-md-9 col-xs-12">
                    <div class="row">
                        <div class="col-md-9">
                            <h3 class="page-title"><?= $user->Title ?></h3>
                        </div>
                        <div class="col-md-3">

                        </div>
                    </div>
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <td>الايميل</td>
                            <td><?= $user->Mail ?></td>
                        </tr>
                        <tr>
                            <td>اسم المستخدم</td>
                            <td><?= $user->User ?></td>
                        </tr>
                        <tr>
                            <td>كلمة المرور</td>
                            <td><a href="<?= $this->url->get('cp_users/changePass') ?>" class="btn btn-info btn-xs" data-toggle="modal" data-target="#change_pass">
                                   تغيير كلمة المرور
                                </a></td>
                        </tr>

                        </tbody>
                    </table>
                </div>

            </div>
        </div>

    </div>


</div>
<!-- END PAGE HEADER-->
<!-- BEGIN DASHBOARD STATS 1-->

<div class="clearfix"></div>

<div class="modal fade" tabindex="1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" id="change_pass">
    <div class="modal-dialog">
        <div class="modal-content">

        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>