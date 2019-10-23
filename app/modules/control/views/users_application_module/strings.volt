<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="{{url()}}">{{translate._("Control Panel")}}</a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <span>{{translate._("Languages")}} </span>
        </li>
    </ul>

</div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get("ropo_app/")}}img/banners/banner.png') center center no-repeat ; background-size: contain"></div>
    </div>
</div>
</div>

<div class="clearfix"></div>
<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-language font-dark"></i>
            <span class="caption-subject bold uppercase">
                                   {{translate._("Languages")}}
                                </span>
        </div>


    </div>
    <div class="portlet-body">
        <?php $this->flashSession->output() ?>
        <div class="gap">
            <form action="{{url('users_application_module/stringCreate')}}" method="post">
            <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
                <thead>
                <th>
                    <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                        <input type="checkbox" class="group-checkable"
                               data-set=".checkboxes"/>
                        <span></span>
                    </label>
                </th>
                <th class="bg-info">
                    String
                </th>
                {% for app_lang in app_langs %}
                <th>
                    {{ app_lang.LangDetails.title }}
                </th>
                {%endfor%}
                <th>
                	{{translate._("Department")}}
                </th>
                <th> {{translate._("Edit/Delete")}} </th>
                </thead>
                <thead>
                <th></th>
                <th class="bg-info">
                    <input type="text" name="word_key" placeholder="Word">
                </th>
                {% for app_lang in app_langs %}
                <th>
                    <input type="text" name="Lang{{app_lang.lang_id}}" placeholder="{{app_lang.LangDetails.title}}">
                </th>
                {%endfor%}
                <th><?php echo Phalcon\Tag::select([
                                                        "core_dept_id",
                                                        $main_depts,
                                                        "using" => ["ID", "Title"],
                                                        "useEmpty"  =>  true,
                                                        "emptyValue" => 0,
                                                        "emptyText" => "Choose",
                                                        ]);
														
                                                    ?></th>
                <th> <input type="submit" class="btn btn-info btn-sm" value="أضافة"/></th>

                </thead>
                <tbody>
                <?php foreach ($strings as $string): ?>
                  <tr>
                    <td>
                        <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                            <input type="checkbox" class="checkboxes" value="1"/>
                            <span></span>
                        </label>
                    </td>
                    <td class="bg-info">
                        <?php echo $string->word_key ?>
                    </td>
                      <?php foreach ($app_langs as $app_lang): ?>
                          <?php
                          $string_lang = \CpModulesTranslation::findFirst(["word_key='{$string->word_key}' and lang_id={$app_lang->lang_id} and module_id={$Module_ID}"]);
                          if(!$string_lang){
                              $translation= "";
                          }else{
                              $translation=$string_lang->value;
                          }
                          ?>
                          <td><?php echo $translation ?></td>
                      <?php endforeach; ?>
                      <td><?php echo $string->core_dept_id ?></td>
                      <td>
                          <div class="btn-group">
                              <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> إجراء
                                  <i class="fa fa-angle-down"></i>
                              </button>
                              <ul class="dropdown-menu" role="menu">
                                  <li>
                                      <a href="{{url('users_application_module/stringEdit/' ~Module_ID)}}&word={{string.word_key|url_encode}}" data-toggle="modal" data-target="#editWord{{string.id}}">
                                          <i class="icon-note"></i> {{translate._("Edit")}} </a>
                                  </li>
                                  <li>
                                      <a href="{{url('users_application_module/stringDelete/' ~Module_ID)}}&word_key={{string.word_key|url_encode}}" class="">
                                      <i class="icon-user"></i> {{translate._("Delete")}} </a>
                                  </li>
                              </ul>
                          </div>

                          <div class="modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false" id="editWord{{string.id}}">
                              <div class="modal-dialog ">
                                  <div class="modal-content">

                                  </div>
                              </div>
                          </div>
                      </td>


                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
                <input type="hidden" name="Module_ID" value="{{Module_ID}}">
            </form>
        </div>
        <div class="clearfix"></div>
    </div>
</div>

<!-- Modal _ New Lang -->
<div class="new_lang modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">

        </div>
    </div>
</div>
<!---- end modal new --->

