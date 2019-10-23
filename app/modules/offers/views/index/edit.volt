<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class=""
                 style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get()}}img/alarabiatanks.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-tag font-dark"></i>
            <span class="caption-subject bold uppercase"> {{translate._("Edit Offer")}}</span>
        </div>
    </div>
    <div class="portlet-body">
        <div class="row">
            <form role="form" action="{{this.url_shared.get('offers_module/index/save')}}" method="post" enctype="multipart/form-data">

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Title")}} - العربية</label>
                        <input type="text" class="form-control" name="offer_name" value="{{offer.name}}">
                    </div>

                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Title")}} - English</label>
                        <input type="text" class="form-control" name="offer_name_eng" value="{{offer.lang.name}}">
                    </div>
                </div>

                <div class=" col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Discount Ratio")}}</label>
                        <input type="text" class="form-control" name="discount_ratio" value="{{offer.discount_percent}}">
                    </div>
                </div>



                <div class="col-sm-3 ">
                    <label class=" control-label">{{translate._("Show in Home Page")}}</label>
                    <div class="col-xs-12 no-padding funkyradio">
                        <div class="funkyradio-success">
                            <input type="checkbox" name="show_home_page" id="checkbox3" {%if(offer.show_in_homepage==1)%}checked{%endif%} />
                            <label for="checkbox3"> {{translate._("Show")}} </label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> {{translate._("Offer Picture")}} - العربية</label>
                        <input type="file" class="form-control" name="offer_picture" value="">
                        <a href="{{url('uploads/') ~offer.image}}" target="_blank">{{translate._("View Picture")}}</a>
                    </div>

                    <div class="form-group">
                        <label class=" control-label"> {{translate._("Offer Picture")}} - English</label>
                        <input type="file" class="form-control" name="offer_picture_eng" value="">
                        <a href="{{url('uploads/') ~offer.lang.img}}" target="_blank">{{translate._("View Picture")}}</a>
                    </div>
                </div>
                <div class=" col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Price")}}</label>
                        <input type="number" class="form-control" name="offer_price" value="{{offer.price}}">
                    </div>
                </div>

                <label class="col-xs-12 bold">{{translate._("Offer Length")}} </label>
                <div class="col-xs-3 funkyradio ">
                    <div class="funkyradio-info">
                        {%for rel_type in offer_rel_type%}
                        {%if(rel_type.type_id==1)%}
                        <input type="checkbox" name="offer_duration1" id="checkbox1" checked>
                        {%else%}
                        <input type="checkbox" name="offer_duration1" id="checkbox1">
                        {%endif%}
                        {%endfor%}

                        <label for="checkbox1">{{translate._("Until Quantity")}}</label>
                    </div>
                </div>
                <div class="col-xs-3 funkyradio ">
                    <div class="funkyradio-info">
                        {%for rel_type in offer_rel_type%}
                        {%if(rel_type.type_id==2)%}
                        <input type="checkbox" name="offer_duration2" id="checkbox2" checked >
                        {%else%}
                        <input type="checkbox" name="offer_duration2" id="checkbox2" >
                        {%endif%}
                        {%endfor%}
                        <label for="checkbox2">{{translate._("Fixed Time")}}</label>
                    </div>

                </div>
                <div class="col-xs-6 no-padding">
                    <div class="form-group">
                        {%for rel_type in offer_rel_type%}
                        {%if(rel_type.type_id==2)%}
                        <label class="col-xs-1 control-label">{{translate._("From")}}</label>
                        <div class="col-xs-5">
                            <input type="date" class="form-control" name="date_from" value="{{ date('Y-m-d', rel_type.start_date) }}">
                        </div>
                        <label class="col-xs-1 control-label">{{translate._("To")}}</label>
                        <div class="col-xs-5">
                            <input type="date" class="form-control" name="date_to" value="{{ date('Y-m-d', rel_type.end_date) }}">
                        </div>
                        {%else%}
                        <label class="col-xs-1 control-label">{{translate._("From")}}</label>
                        <div class="col-xs-5">
                            <input type="date" class="form-control" name="date_from">
                        </div>
                        <label class="col-xs-1 control-label">{{translate._("To")}}</label>
                        <div class="col-xs-5">
                            <input type="date" class="form-control" name="date_to">
                        </div>
                        {%endif%}

                        {%endfor%}


                    </div>
                </div>

                <div class="row"></div>

                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="control-label">{{translate._("Offer Description")}} - العربية</label>
                        <textarea class="form-control" name="offer_des">{{offer.description}}</textarea>
                    </div>

                    <div class="form-group">
                        <label class="control-label">{{translate._("Offer Description")}} - English</label>
                        <textarea class="form-control" name="offer_des_eng">{{offer.lang.description}}</textarea>
                    </div>
                </div>

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Regions")}}</label>
                        <select class="" multiple="multiple" name="regions[]">
                            {%for city in cities%}
                            <option value="{{city.id}}"
                                    <?php if(in_array($city->id,$offer_regions)):?>
                                selected
                                    <?php endif; ?>

                            >{{city.name}}</option>
                            {%endfor%}
                        </select>
                    </div>
                </div>

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Delivery Places")}}</label>
                        <select class="" multiple="multiple" name="delivery_places[]">
                            {%for branch in delivery_places%}
                            <option value="{{branch.id}}"
                                <?php if(in_array($branch->id,$offer_delivery_places)):?>
                                    selected
                                <?php endif; ?>
                            >{{branch.name}}</option>
                            {%endfor%}
                        </select>
                    </div>
                </div>

                <div class="col-sm-12">
                    <input type="hidden" value="{{offer.id}}" name="offer_id" />
                    <button class="btn btn-primary" type="submit">{{translate._("Save")}}</button>
                </div>
            </form>
        </div>

    </div>
</div>