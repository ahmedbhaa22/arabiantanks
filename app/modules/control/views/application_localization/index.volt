<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <a href="{{url()}}">{{ translate._('Control Panel')}}</a>
            <i class="icon-arrow-left"></i>
        </li>
        <li>
            <span>{{ translate._('Content Localization')}} </span>
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
                                   {{ translate._('Languages')}}
                                </span>
        </div>

        <div class="actions btn-group btn-group-lg btn-group-solid margin-bottom-10 ">
            <a type="button" href="{{url('application_localization/newLang')}}" data-toggle="modal" class="btn btn-edit-my-data dark" data-target=".new_lang">
                {{ translate._('Add Language')}}
            </a>
        </div>
    </div></div>

<!-- Modal _ New Lang -->
<div class="new_lang modal fade" tabindex="-1" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog ">
        <div class="modal-content">

        </div>
    </div>
</div>
<!---- end modal new --->


<div class="portlet light bordered">
    <!--<div class="row">-->
    <!--    <nav>-->
    <!--        <ul class="pager">-->
    <!--            <li class="next">--><!--</li>-->
    <!--        </ul>-->
    <!--    </nav>-->
    <!--</div>-->
    <div class="portlet-title">
        


    </div>


    <div class="portlet-body">
        <div id="sample_1_wrapper">

            <div class="clearfix"></div>
            <div class="table-scrollable">

                <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer">
                    <thead>
                    <th>{{ translate._('Language')}}</th>
                    <th>{{ translate._('Code')}}</th>
                    <th>{{ translate._('Edit/Delete')}}</th>
                    </thead>
                    <tbody>
                    {% for app_lang in app_langs %}
                    <tr>
                        <td>{{ app_lang.LangDetails.title }} {%if(app_lang.is_default==1)%} (Default){%endif%}</td>
                        <td>{{ app_lang.LangDetails.code }}</td>
                        <td><div class="btn-group" style="position:relative">
                                <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">
{{ translate._('Edit/Delete')}}
<i class="fa fa-angle-down"></i>
                                </button>
                                <ul class="dropdown-menu" role="menu">

                                    <li>
                                        <a href="{{ url('application_localization/langEdit/' ~app_lang.id) }}" data-toggle="modal">
                                            <i class="icon-tag"></i>{{ translate._('Edit')}}</a>
                                    </li>
<!--                                    <li>-->
<!--                                        <a href="{{ url('menus/delete/' ~item.id) }}" data-toggle="modal">-->
<!--                                            <i class="icon-tag"></i>{{ translate._('Delete')}}</a>-->
<!--                                    </li>-->


                                </ul>
                            </div></td>
                    </tr>
                    {% endfor %}
                    </tbody>
                </table>

            </div>


        </div>
    </div>


</div>