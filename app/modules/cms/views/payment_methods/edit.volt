<div class="">
    <div class="page-bar " style="position: relative">
         <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url.getStatic('cms_module/home/index/1')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
             <li>
                <a href="{{url.getStatic('cms_module/home/index/3')}}"><span> التحكم في الويبسايت </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <a href="{{url.getStatic('cms_module/payment_methods/index')}}"><span> طرق الدفع / البنوك </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li> إضافة بنك جديد </li>
        </ul>
    </div>
    <div class="clearfix"></div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/clients/new-employees.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
    <div class="portlet light clearfix">
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-user-plus font-dark"></i>
                <span class="caption-subject bold uppercase">  اضافة بنك جديد</span>
            </div>
            <div>
                {% if session.get('error_msgs')|length %}
                <ul style="color:red;float:left;">
                    {% for msg in session.get('error_msgs') %}
                        <li style="float:left;">{{msg['field']}} : {{msg['message']}}</li><br>
                        <?php $this->session->set('error_msgs', []) ?>
                    {% endfor %}
                </ul>
                {% endif %}
            </div>
        </div>
        <div class="portlet-body">
            <div class="row">
                <form action="{{url.getStatic('cms_module/payment_methods/save/'~bank.id)}}" 
                 role="form" method="post" enctype="multipart/form-data" id="edit-bank-form">
                 <input type="hidden" name="from_action" value="edit">
                    <div class="col-sm-3">
                        <div class="form-group">
                            <label class=" control-label">أسم البنك </label>
                            <input required name="bank_name" type="text" class="form-control" 
                            value="{{bank.bank_name}}">
                        </div>
                    </div>
                    <div class=" col-sm-3">
                        <div class="form-group">
                            <label class=" control-label"> أسم الحساب </label>
                            <input required name="account_name" type="text" class="form-control" 
                            value="{{bank.account_name}}">
                        </div>
                    </div>
                    <div class=" col-sm-3">
                        <div class="form-group">
                            <label class=" control-label"> رقم الحساب </label>
                            <input required name="account_number" type="text" class="form-control" 
                            value="{{bank.account_number}}">
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <button type="submit" id="submit_btn" class="btn btn-primary">تعديل</button>
                        <button class="btn dark">إلغاء</button>
                    </div>
            </form>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript">
    $(document).ready(function()
    {
       jQuery.extend(jQuery.validator.messages, {
        required: 'هذا الحقل مطلوب',
        email: 'أدخل صيغة بريد إلكتروني صحيحة',
        min: jQuery.validator.format('هذا الحقل يجب أن يكون على الأقل {0} أحرف'),
        max: jQuery.validator.format('هذا الحقل يجب أن يكون على الأكثر {0} أحرف'),
    });

    $('#edit-bank-form').validate(); 
    });
</script>