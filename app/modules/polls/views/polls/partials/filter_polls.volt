<div id="collapse-clients-filter" class="panel-collapse collapse">
    <div class="panel-body">
        <form role="form" id="sales_reports_filter">

            <div class="row">


                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> اسم العميل </label>
                        <input type="text" class="form-control" name="client_name" value="{{filter['client_name']}}">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> تليفون </label>
                        <input type="number" class="form-control" min="1" name="client_mobile" value="{{filter['client_mobile']}}">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> نوع العميل</label>
                        <select name="client_category">
                            <option value="0">كل الأنواع</option>

                            {% for client_category in client_categories %}
                            {%set selected=""%}
                            {%if(filter['client_category']==client_category.id)%}
                            {%set selected="selected"%}
                            {%endif%}
                            <option value="{{ client_category.id }}" {{selected}}>{{ client_category.name }}</option>
                            {% endfor %}
                        </select>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label"> مندوب المبيعات </label>
                        <select name="sales_person">
                            <option value="0">جميع المندوبين</option>
                            {% for sales_person in sales_persons %}
                            {%if(!sales_person.User)%}
                            {%continue%}
                            {%endif%}
                            {%set selected=""%}
                            {%if(filter['sales_person']==sales_person.id)%}
                            {%set selected="selected"%}
                            {%endif%}
                                <option value="{{ sales_person.user_id }}" {{selected}}>{{ sales_person.User.Title }}</option>
                            {% endfor %}
                        </select>
                    </div>
                </div>

                <div class="clearfix"></div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">تاريخ من </label>
                        <input type="date" class="form-control" name="date_from" value="{{filter['date_from']}}">
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="form-group">
                        <label class=" control-label">تاريخ الى </label>
                        <input type="date" class="form-control" min="1" name="date_to" value="{{filter['date_to']}}">
                    </div>
                </div>



            </div>

             <button class="btn btn-primary">فلتر</button>
            <a class="btn btn-danger" id="polls_reports_export">Export</a>
        </form>
    </div>
</div>


<script>

</script>
