<div class="portlet light clearfix">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="fa fa-tag font-dark"></i>
            <span class="caption-subject bold uppercase"> {{translate._("Add New Offer")}}</span>
        </div>
    </div>
    <div class="portlet-body">
        <div class="row">
            <form role="form" action="{{this.url_shared.get('offers_module/index/create')}}" method="post"
                  enctype="multipart/form-data">

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Title")}} - العربيه</label>
                        <input type="text" class="form-control" name="offer_name" required>
                    </div>

                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Title")}} - English</label>
                        <input type="text" class="form-control" name="offer_name_en" required>
                    </div>
                </div>

                <div class=" col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Discount Ratio")}}</label>
                        <input type="text" class="form-control" name="discount_ratio" required>
                    </div>
                </div>

                <div class=" col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Price")}}</label>
                        <input type="number" class="form-control" name="offer_price" required>
                    </div>
                </div>

                <div class="col-sm-3 ">
                    <label class=" control-label">{{translate._("Show in Home Page")}}</label>
                    <div class="col-xs-12 no-padding funkyradio">
                        <div class="funkyradio-success">
                            <input type="checkbox" name="show_home_page" id="checkbox3"/>
                            <label for="checkbox3"> {{translate._("Show")}} </label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> {{translate._("Offer Picture")}} - العربية</label>
                        <input type="file" class="form-control" name="offer_picture" required>
                    </div>

                    <div class="form-group">
                        <label class=" control-label"> {{translate._("Offer Picture")}} - English</label>
                        <input type="file" class="form-control" name="offer_picture_en">
                    </div>
                </div>

                <div class="col-sm-3 ">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Offer Tax Percentage")}}</label>
                        <input type="number" class="form-control" name="tax_percentage" required>
                    </div>

                </div>

                <label class="col-xs-12 bold">{{translate._("Offer Length")}} </label>
                <div class="col-xs-3 funkyradio ">
                    <div class="funkyradio-info">
                        <input type="checkbox" name="offer_duration1" id="checkbox1" checked>
                        <label for="checkbox1">{{translate._("Until Quantity")}}</label>
                    </div>
                </div>
                <div class="col-xs-3 funkyradio ">
                    <div class="funkyradio-info">
                        <input type="checkbox" name="offer_duration2" id="checkbox2">
                        <label for="checkbox2">{{translate._("Fixed Time")}}</label>
                    </div>

                </div>
                <div class="col-xs-6 no-padding">
                    <div class="form-group">
                        <label class="col-xs-1 control-label">{{translate._("From")}}</label>
                        <div class="col-xs-5">
                            <input type="date" class="form-control" name="date_from">
                        </div>
                        <label class="col-xs-1 control-label">{{translate._("To")}}</label>
                        <div class="col-xs-5">
                            <input type="date" class="form-control" name="date_to">
                        </div>
                    </div>
                </div>

                <div class="row"></div>

                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="control-label">{{translate._("Offer Description")}} - العربية </label>
                        <textarea class="form-control" name="offer_des_en" required></textarea>
                    </div>

                    <div class="form-group">
                        <label class="control-label">{{translate._("Offer Description")}} - English</label>
                        <textarea class="form-control" name="offer_des" required></textarea>
                    </div>
                </div>

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Regions")}}</label>
                        <select class="" multiple="multiple" name="regions[]">
                            {%for region in regions%}
                            <option value="{{region.id}}">{{region.name}}</option>
                            {%endfor%}
                        </select>
                    </div>
                </div>

                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">{{translate._("Delivery Places")}}</label>
                        <select class="" multiple="multiple" name="delivery_places[]">
                            {%for branch in delivery_places%}
                            <option value="{{branch.id}}">{{branch.name}}</option>
                            {%endfor%}
                        </select>
                    </div>
                </div>

                <div class="col-sm-12">
                    <button class="btn btn-primary">{{translate._("Add")}}</button>
                    <button class="btn dark">{{translate._("Cancel")}}</button>
                </div>
            </form>
        </div>

    </div>
</div>