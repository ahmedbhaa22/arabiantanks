<div class="panel-body">
    <form role="form" method="post" action="" id="requests_filter_pumps">
        <div class="row">
            <div class="col-sm-2">
                <div class="form-group">
                    <label class=" control-label">  رقم الطلب </label>
                    <input type="number" class="form-control" min="1" name="ticket_number" value="{{filter['ticket_number']}}">
                </div>
            </div>
            <div class="col-sm-2">
                <div class="form-group">
                    <label class=" control-label">تاريخ من</label>
                    <input type="date" class="form-control" name="date_from" value="{{filter['date_from']}}">
                </div>
            </div>
            <div class="col-sm-2">
                <div class="form-group">
                    <label class=" control-label">تاريخ الى</label>
                    <input type="date" class="form-control" name="date_to" value="{{filter['date_to']}}">
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label"> حالة الطلب </label>
                    {{ select('ticket_status_id', problem_statuses, 'using': ['id', 'status_name'],
                    'useEmpty': true, 'emptyText': '', 'emptyValue': '','class':'form-control') }}
                </div>
            </div>

            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label">  اسم المنتج  </label>
                    <input type="text" class="form-control" name="product_name" value="{{filter['product_name']}}">
                </div>
            </div>

            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label"> اسم العميل  </label>
                    <input type="text" class="form-control" name="client_name" value="{{filter['client_name']}}">
                </div>
            </div>
            <div class="col-sm-3">
                <div class="form-group">
                    <label class=" control-label">  تليفون  </label>
                    <input type="number" class="form-control" min="1" name="client_mobile" value="{{filter['client_mobile']}}">
                </div>
            </div>

            <div class="col-sm-6">
                <div class="form-group">
                    <label class=" control-label"> الصياانة المطلوبة </label>

                        {{ select('ticket_problem_id', all_problems, 'using': ['id', 'name'],
                        'useEmpty': true, 'emptyText': '', 'emptyValue': '') }}


                </div>
            </div>


        </div>
        <button class="btn btn-primary" type="submit">فلتر</button>
    </form>
</div>