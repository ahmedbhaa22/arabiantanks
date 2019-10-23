<form role="form" id="ask_clients_filter">
    <div class="row">
        <div class="col-sm-3">
            <div class="form-group">
                <label class=" control-label"> تصنيف العميل </label>
                <select class="form-control" id="sel1" name="category_id">
                    <option></option>
                    {%for cat in client_categories%}
                    <option value="{{cat.id}}">{{cat.name}}</option>
                   {%endfor%}
                </select>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="form-group">
                <label class=" control-label"> اسم العميل</label>
                <input type="text" class="form-control" name="client_name">
            </div>
        </div>
        <div class=" col-sm-3">
            <div class="form-group">
                <label class=" control-label"> البريد الالكترونى</label>
                <input type="email" class="form-control" name="email">
            </div>
        </div>
        <div class="col-sm-3">
            <div class="form-group">
                <label class=" control-label"> تاريخ آخر نشاط للعميل</label>
                <input type="date" class="form-control" name="last_login">
            </div>
        </div>
        <div class="col-sm-3">
            <div class="form-group">
                <label class=" control-label">الشركة</label>
                <input type="text" class="form-control" name="company_name">
            </div>
        </div>
        <div class="col-sm-3">
            <div class="form-group">
                <label class=" control-label"> الهاتف</label>
                <input type="tel" class="form-control" name="mobile">
            </div>
        </div>
        <div class=" col-sm-2">
            <div class="form-group">
                <label class=" control-label">الرمز البريدى</label>
                <input type="email" class="form-control" name="client_postal_code">
            </div>
        </div>
        <div class="col-sm-4">
            <label class=""> نشاط العملاء</label>
            <div class="col-xs-12 no-padding funkyradio">
                <div class="col-xs-6 funkyradio-success">
                    <input type="checkbox" name="is_active" id="checkbox1">
                    <label for="checkbox1"> نشط </label>
                </div>
                <div class="col-xs-6 funkyradio-success">
                    <input type="checkbox" name="client_noactive" id="checkbox2">
                    <label for="checkbox2"> غير نشط </label>
                </div>
            </div>
        </div>
    </div>
    <input type="submit" value="فلتر العملاء" class="btn btn-info"/>
</form>

<script>
    $("#ask_clients_filter").submit(function(e) {
        e.preventDefault();
        var url = "{{url('polls/clients_table')}}"; // the script where you handle the form input.

        $.ajax({
            type: "POST",
            url: url,
            data: $("#ask_clients_filter").serialize(), // serializes the form's elements.
            success: function (response)
            {

                $("#clients_table").html(response);
            }
        });

        // avoid to execute the actual submit of the form.
    });
</script>