    
<div class="col-lg-12">
    <div class="row">
        {% if settings.banner_image %}
        <div class="text-center banner" style=" background: url({{url.getStatic(settings.banner_image)}}) center no-repeat; background-size: contain;">
        </div>
        {% else %}
        <div class="text-center banner" style=" background: url({{url.getStatic('ropo_app/img/robo-ads.png')}}) center no-repeat; background-size: contain;">
        </div>
        {% endif %}
    </div>
</div>

<div class="portlet light bordered">

<div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Ads"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="{{ url('index/create')}}" class="btn btn-edit-my-data green-jungle btn-outline btn-block">
                <?php echo $translate->_("Add Ad"); ?>
            </a>
        </div>

</div>



<div class="portlet-body">
    <div id="sample_1_wrapper">
        <div class="table-scrollable">
            <table class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer" id="sample_1" role="grid" aria-describedby="sample_1_info">
                <thead>
                <tr role="row">
                    <th class="sorting"><?php echo $translate->_("Add Ad"); ?></th>
                    {% if settings.enable_picture %}
                    <th class="sorting"><?php echo $translate->_("Picture"); ?></th>
                    {% endif %}
                    <th class="sorting"><?php echo $translate->_("Title"); ?></th>
                    {% if settings.enable_content %}
                    <th class="sorting"><?php echo $translate->_("Desc"); ?></th>
                    {% endif %}
                    <th class="sorting"><?php echo $translate->_("Link"); ?></th>
                    {% if settings.enable_height %}
                    <th class="sorting"><?php echo $translate->_("Height"); ?></th>
                    {% endif %}
                    {% if settings.enable_width %}
                    <th class="sorting"><?php echo $translate->_("Width"); ?></th>
                    {% endif %}

                    <th class="sorting"><?php echo $translate->_("Edit/Delete"); ?></th>

                </tr>
                </thead>
                <tbody>
                {% for ad in page.items %}
                    <tr class="gradeX" id="ad{{ad.id}}">
                        <td>{{ ad.id }}</td>
                        {% if settings.enable_picture %}
                        <td>
                            <img src="{{ url.getStatic(ad.img) }}" width="50" height="50" style="width: 50px;height: 50px; display: block !important;">
                        </td>
                        {% endif %}
                        <td>{{ ad.title }}</td>
                        {% if settings.enable_content %}
                        <td>{{ ad.des }}</td>
                        {% endif %}
                        <td><a href="{{ ad.link }}" target="_blank">{{ ad.link }}</a></td>
                        {% if settings.enable_height %}
                        <td>{{ ad.height }}</td>
                        {% endif %}
                        {% if settings.enable_width %}
                        <td>{{ ad.width }}</td>
                        {% endif %}

                        <td>
                            <div class="btn-group" style="position:relative">
                                <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> <?php echo $translate->_("Edit/Delete"); ?>
                                    <i class="fa fa-angle-down"></i>
                                </button>
                                <ul class="dropdown-menu" role="menu">
                                    <!-- <li>
                                        <a href="_client_profile.html">
                                            <i class="icon-docs"></i> مشاهده </a>
                                    </li> -->

                                    <li>
                                        <a href="{{ url('index/edit/') ~ ad.id}}" data-toggle="modal">
                                            <i class="icon-tag"></i> <?php echo $translate->_("Edit"); ?> </a>
                                    </li>

                                    <li>
                                        <a onclick="deleteAd({{ad.id}})" data-toggle="modal">
                                            <i class="icon-tag"></i> <?php echo $translate->_("Delete"); ?> </a>
                                    </li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                {% endfor %}
                </tbody>
            </table>
        </div>

        <!-- <div class="row">
            <div class="col-md-5 col-sm-5">
                <div class="dataTables_info" id="sample_1_info" role="status" aria-live="polite">
                    <?php echo $page->current, "/", $page->total_pages ?>
                </div>
            </div>
            <div class="col-md-7 col-sm-7"><div class="dataTables_paginate paging_bootstrap_full_number" id="sample_1_paginate">
                    <ul class="pagination" style="visibility: visible;">
                        <li><?php echo $this->tag->linkTo("ads", $translate->_("First")) ?></li>
                        <li><?php echo $this->tag->linkTo("ads?page=" . $page->before, $translate->_("Back")) ?></li>
                        <li><?php echo $this->tag->linkTo("ads?page=" . $page->next, $translate->_("Next")) ?></li>
                        <li><?php echo $this->tag->linkTo("ads?page=" . $page->last, $translate->_("Last")) ?></li>
                    </ul>
                </div>
            </div>
        </div> -->

    </div>
</div>

    </div>

<script type="text/javascript">
function deleteAd(id) {
    {% if(this.session.get('auth-identity')['Lang']!=='ar') %}
    var message = "Are you sure you want to delete this ad?";
    {% else %}
    var message = "هل انت متأكد من الغاء هذا الاعلان?";
    {% endif %}
    if(confirm(message)){
        window.location = "{{url('index/delete/')}}" + id; 
    }
}
</script>