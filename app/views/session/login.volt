{{content()}}
<!-- BEGIN LOGIN FORM -->
{{ form('class': 'login-form') }}
<form class="login-form" action="index.html" method="post">
    <h3 class="form-title font-green-jungle">
        خزانات

    </h3>
    <div class="alert alert-danger display-hide">
        <button class="close" data-close="alert"></button>
        <span> أدخل أسم المستخدم وكلمة المرور </span>
    </div>
    <div class="form-group">
        <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
        <label class="control-label visible-ie8 visible-ie9">أسم المستخدم</label>
        {{ form.render('User') }}
    </div>
    <div class="form-group">
        <label class="control-label visible-ie8 visible-ie9">كلمة المرور</label>
        {{ form.render('Pass')}}
     </div>
    <div class="form-group">
        <label class="control-label visible-ie8 visible-ie9">النظام</label>
        <select id="system" name="system" class="form-control">
            <option value="1">الادارة</option>
            <option value="2">الصيانة وخدمة العملاء</option>
            <option value="3">الزيارات</option>

        </select>


    </div>
    <div class="form-group">
        <input type="hidden" name="Application_ID" value="1" />

        
    </div>

    <div class="form-actions">
        <button type="submit" class="btn green-jungle  uppercase">تسجيل الدخول</button>
<!--        <label class="rememberme check mt-checkbox mt-checkbox-outline">-->
<!--            <input type="checkbox" name="remember" value="yes" />تذكرنى-->
<!--            <span></span>-->
<!--        </label>-->
<!--        <a href="javascript:;" id="forget-password" class="forget-password"> هل فقدت كلمة المرور</a>-->
    </div>
    <div class="login-options">
        <!-- <h4>أو سجل دخولك عبر </h4>
        <ul class="social-icons">
            <li>
                <a class=" social-icon-color facebook " data-original-title="facebook" href="javascript:;"> <i class="fa fa-facebook"></i></a>
            </li>
            <li>
                <a class="social-icon-color twitter" data-original-title="Twitter" href="javascript:;"></a>
            </li>
            <li>
                <a class="social-icon-color googleplus" data-original-title="Goole Plus" href="javascript:;"></a>
            </li>
            </ul> -->
            {{ form.render('csrf', ['value': security.getToken()]) }}
        
    </div>
     {%if(app==0)%}
<!--    <div class="login-options">-->
<!--       <a href="{{ url('users_application/new')}}">اضافة تطبيق جديد</a>-->
<!--    </div>-->
    {%endif%}
</form>
<!-- END LOGIN FORM -->
<!-- BEGIN FORGOT PASSWORD FORM -->
<!--<form class="forget-form" action="#.html" method="post">-->
<!--    <h3 class=" font-green-jungle">أسترجع كلمة المرور ؟</h3>-->
<!--    <p> أدخل بريدك الالكترونى لضبط كلمة المرور </p>-->
<!--    <div class="form-group">-->
<!--        <input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="البريد الالكترونى" name="email" /> </div>-->
<!--    <div class="form-actions">-->
<!--        <button type="button" id="back-btn" class="btn green-jungle btn-outline">العوده</button>-->
<!--        <button type="submit" class="btn green-jungle uppercase pull-right">ضبط</button>-->
<!--    </div>-->
<!--</form>-->
<!-- END FORGOT PASSWORD FORM -->