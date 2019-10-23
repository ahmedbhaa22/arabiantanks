<div class="panel-group accordion" id="accordion1">
    <div class="panel panel-info">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">
                    <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
                </a>
            </h4>
        </div>
        <div id="collapse-clients-filter" class="panel-collapse collapse">
            <div class="panel-body">
                <!-- <form role="form" method="post" action="{{url('content/productsList')}}" enctype="multipart/form-data"> -->
                <div class="row">
                    <div class="col-sm-5 no-padding">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class=" control-label">اسم المنتج</label>
                                <input id="product_name" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class=" control-label"> اسم الشركة المصنعة </label>
                                <select id="manfcts" class="" multiple="multiple">
                                    {% for manfact in manufacturers%}
                                    <option value="{{manfact.ID}}">{{manfact.Title}}</option>
                                    {% endfor %}
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-xs-2 no-padding control-label"> سعر المنتج </label>
                                <div class="col-xs-10 no-padding">
                                    <label class="col-xs-2 control-label"> من </label>
                                    <div class="col-xs-4 no-padding">
                                        <input id="price_from" type="number" class="form-control" min="1">
                                    </div>
                                    <label class="col-xs-2 control-label"> الي </label>
                                    <div class="col-xs-4 no-padding">
                                        <input id="price_to" type="number" class="form-control" min="1">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="col-sm-5">
                        <div class="form-group">
                            <label class="col-sm-2 control-label"> التصنيف </label>
                            <div class="col-sm-10 dept_tree">
                                {{cats_tree}}
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12" style="vertical-align: bottom">
                        <button type="button" id="filter_products" class="btn btn-primary">فلتر</button>
                    </div>

                    <!--
                                                            <div class="col-sm-4">
                                                                <label class=" control-label">اللغة الرسمية</label>
                                                                <input type="checkbox" class="make-switch" checked data-on-text="العربية" data-off-text="English">
                                                            </div>
                    -->
                </div>

                <!-- </form> -->
            </div>
        </div>
    </div>
</div>