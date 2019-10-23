<div class="portlet light bordered">


    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Content Details"); ?></span>
        </div>

        <div class="actions">
            <a type="button" href="{{url('content/index/' ~Module_ID)}}" data-toggle="modal"
               class="btn green-jungle btn-outline">
                <?php echo $translate->_("Back"); ?>
            </a>
        </div>

    </div>

    <!--tabs-->

    <div class="container">
        <?php
        echo $this->tag->form(
            [
                "content/search",
                "autocomplete" => "off",
                "class" => "form-horizontal paymentForm",
                "role" => "form",
                "style" => "display:block",
                "method"=>"post",
                "enctype" => "multipart/form-data",
                "id" => "newContent",

            ]
        );
        ?>
        <div id="sample_1_wrapper">
            <div class="col-md-12 col-xs-12">
                <div class="form-group">
                    <label for="fieldTitle" class="col-sm-2 "><?php echo $translate->_("Content Contains"); ?></label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["Content", "size" => 30, "class" => "form-control", "id" => "fieldContent",]) ?>
                    </div>
                </div>
            </div>

            <div class="col-md-12 col-xs-12">
                <div class="form-group">
                    <label for="fieldTitle" class="col-sm-2 "><?php echo $translate->_("Title Contains"); ?></label>
                    <div class="col-sm-10">
                        <?php echo $this->tag->textField(["Title", "size" => 30, "class" => "form-control", "id" => "fieldTitle",]) ?>
                    </div>
                </div>
            </div>

            <div class="col-md-6 col-xs-6">
                <div class="form-group">
                    <label for="fieldActive" class="col-sm-2 "><?php echo $translate->_("Departments"); ?></label>
                    <div class="col-sm-10 dept_tree">

                        <ul>
                            <?php
                            $cats = new \Models\Content();
                            $main_depts = DataCmsDepts::find(array("Module_ID={$Module_ID}"));
                            foreach ($main_depts as $main_dept) {
                                ?>
                                <div>
                                    <?php
                                    echo $main_dept->Title
                                    ?>
                                </div>
                                <?php
                                $cats->buildTree(\DataCmsDeptsRel::find([
                                    "Core_Depts_ID=" . $main_dept->ID
                                ]), 0,$lang_id);
                            }

                            ?>
                        </ul>

                    </div>
                </div>
            </div>
            <div class="col-md-6 col-xs-6">
                <div class="form-group">
                    <div class="col-md-12">
                        <label class="control-label col-md-2  col-sm-2"><?php echo $translate->_("Date From"); ?></label>
                        <div class="col-md-10 col-sm-10">
                            <input type="text" name="date_from" class="form-control" id="date_from" />
                        </div>
                    </div>

                </div>
                <div class="form-group">
                    <div class="col-md-12">
                        <label class="control-label col-md-2  col-sm-2"><?php echo $translate->_("Date To"); ?></label>
                        <div class="col-md-10 col-sm-10">
                            <input type="text" name="date_to" class="form-control" id="date_to" />
                        </div>
                    </div>

                </div>
                <div class="form-group">
            <div class="col-md-12">
            <title>Language</title>
            <select id="dynamic_select" name="lang"> 
                
                <option value="0" >Default Content</option>
                {%for lang in langs%}
                <option value="{{lang.lang_id}}">{{lang.LangDetails.title}}</option>
                {%endfor%}
            </select>
            </div>
        </div>
            </div>

            <div class="clearfix"></div>


            <!-- START KEY VALUE -->
            <div class="row">
                <?php

                $groupname = "";
                foreach ($keyValueData as $data):
                    if ($groupname !== $data['GroupName']):
                        ?>
                        <div class="kv-group-title"><h2><?php echo $data['GroupName'] ?></h2></div>
                        <?php
                        $groupname = $data['GroupName'];?>

                    <?php endif;?>
                    <div class="bg-dark btn-circle text-center" style="padding: 2px ; color: #fff;">
                        <div class="light text-uppercase"><?php echo $data['KeyValueTitle'] ; ?></div>
                    </div>
                    <div class="col-sm-6">
                        <div class="form-group">
                            <label for="keyvalue" class="col-sm-2 control-label"><?php echo $translate->_("Value"); ?></label>
                            <div class="col-sm-10">
                                <input type="text" name="kv_field" class="kv" data-kv_id="{{ data['KV_ID'] }}">
                            </div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <?php if($data['Add']==1): ?>
                    <input type="hidden" id="kv-ids" name="kvAddIDs[]" value="<?php echo $data['KV_ID'] ?>"/>
                <?php endif; ?>
                <?php endforeach; ?>
                <input type="hidden" name="Module_ID" value="<?php echo $Module_ID ?>"/>
            </div>
            <!-- END KEY VALUE -->

            <div class="form-group">
                <div class="col-sm-12">
                    <?php echo $this->tag->submitButton(["Search", "class" => "btn green-jungle", "value" => $translate->_("Search")]) ?>
                    <!--        <input type='button' value='Submit form' onClick='submitDetailsForm()' class="btn green-jungle" id="post"/>-->
                    <!--        <input type='button' value='Test' class="btn green-jungle" id="testpost"/>-->
                    <div class="testpost"></div>
                </div>
            </div>
        </div>

    </div>


    <!-- End Form -->

    <?php echo $this->tag->endForm(); ?>

    <!--<div class="form-group">
        <label for="filter-name">{{ translate._('Filter Name') }}</label>
        <input type="text" name="filter_name" id="filter-name">
        <button class="btn btn-default" id="save-filter">{{ translate._('Save Filter') }}</button>
    </div>

    <div class="form-group">
        <label for="saved-filters">{{ translate._("Select Filter") }}</label>
        <select id="saved-filters">
            <option value="0" selected>Select filter</option>
            {% if saved_filters is defined %}
                {% for filter in saved_filters %}
                    <option value="{{ filter['id'] }}">{{ filter['name'] }}</option>
                {% endfor %}
            {% endif %}
        </select>
    </div>-->


</div>

<script type="text/javascript">
    $( document ).ready(function() {
        $('#date_from').datepicker({
            format: "yyyy-mm-dd"
        });
        $('#date_to').datepicker({
            format: "yyyy-mm-dd"
        });

        var filter_json = {};
        var save_fltr_btn = $("#save-filter");

        save_fltr_btn.click(function()
        {
            var filter_name = $("#filter-name");

            if(filter_name.val().length > 0)
            {
                filter_json = structureFilterJSON(filter_name.val());

                $.ajax({
                    type: 'POST',
                    url: '{{ url('content/saveFilter') }}',
                    data: {json_filter: filter_json},
                    success: function(response)
                    {
                        response = JSON.parse(response);
                        switch(response.status)
                        {
                            case 0:
                                    alert('error saving your filter, please try again');
                                    console.log(response.messages);
                                break;
                            case 1:
                                    $("#newContent").submit();
                                break;
                        }
                    }
                });
            }
            else
            {
                filter_name.focus();
            }
        });

        var saved_filters_select = $('#saved-filters');

        saved_filters_select.change(function()
        {
            $.ajax({
                type: 'get',
                url: '{{ url('content/getJsonFilter/') }}' + $(this).val() ,
                success: function(response)
                {
                    response = JSON.parse(response);

                    switch(response.status)
                    {
                        case 0:
                            break;
                        case 1:
                                var content = JSON.parse(response.content);
                                loadFilterData(content);
                            break;
                    }
                }
            });
        });
    });

    function loadFilterData(content)
    {
        if(content.hasOwnProperty("filter_name"))
        {
            $('#filter-name').val(content.filter_name);
        }

        if(content.hasOwnProperty("content"))
        {
            $('#fieldContent').val(content.content);
        }

        if(content.hasOwnProperty("title"))
        {
            $('#fieldTitle').val(content.title);
        }

        if(content.hasOwnProperty("date_from"))
        {
            $('#date_from').val(content.date_from);
        }

        if(content.hasOwnProperty("date_to"))
        {
            $('#date_to').val(content.date_to);
        }

        if(content.hasOwnProperty("lang_id"))
        {
            $('#dynamic_select').val(content.lang_id);
        }

        if(content.hasOwnProperty("depts_ids"))
        {
            for(var i=0; i<content.depts_ids.length; i++)
            {
                $('.dept-item[value='+content.depts_ids[i]+']').prop('checked', true);
            }
        }

        if(content.hasOwnProperty('kv_fields'))
        {
            for(var i=0; i<content.kv_fields.length; i++)
            {
                $('.kv[data-kv_id='+content.kv_fields[i].kv_id+']').val(content.kv_fields[i].kv_val);
            }
        }
    }

    function structureFilterJSON(filter_name)
    {
        var filter_json = {};

        var content = $("#fieldContent");
        var title = $("#fieldTitle");
        var date_from = $('#date_from');
        var date_to = $('#date_to');
        var lang = $("#dynamic_select");
        var depts = $("input:checkbox:checked").map(function()
        {
            return $(this).val();
        }).get();
        var kv_fields = $(".kv").map(function()
        {
            return {kv_id: $(this).data('kv_id'), kv_val: $(this).val()};
        }).get();

        var module_id = "{{ Module_ID }}";

        filter_json.filter_name = filter_name;
        filter_json.module_id   = module_id;

        if(content.val().length)
        {
            filter_json.content = content.val();
        }

        if(title.val().length)
        {
            filter_json.title = title.val();
        }

        if(date_from.val().length)
        {
            filter_json.date_from = date_from.val();
        }

        if(date_to.val().length)
        {
            filter_json.date_to = date_to.val();
        }

        if(lang.val() != '0')
        {
            filter_json.lang_id = lang.val();
        }

        if(depts.length)
        {
            filter_json.depts_ids = depts;
        }

        if(kv_fields.length)
        {
            filter_json.kv_fields = kv_fields;
        }

        return filter_json;
    }

</script>
<!--end tabs-->
<hr>