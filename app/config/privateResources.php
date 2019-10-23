<?php

use Phalcon\Config;
use Phalcon\Logger;

return new Config([
    'privateResources' => [
        'users' => [
            'index',
            'search',
            'edit',
            'create',
            'delete',
            'changePassword'
        ],
        'profiles' => [
            'index',
            'search',
            'edit',
            'create',
            'delete'
        ],
        'permissions' => [
            'index'
        ],
        'content' => [
            'index',
            'edit',
            'new',
            'editmedia',
            'save',
            'create',
            'media',
            'addmedia',
            'createmedia',
            'delete',
            'deletemedia',
            'main',
            'mediaMultiUpload',
            'mediaDelUpload',
            'statistics',
            'filterStat',
            'toggleDisplay',
            'filterByDept',
            'ajaxDelete',
            'advancedSearch',
            'advancedPost',
            'ajaxContent',
            'addbulk',
            'ajaxActive',
            'ajaxDeactive',
            'filterContent',
            'viewRelatedContent'
        ],
        'departments' => [
            'index',
            'edit',
            'new',
            'save',
            'delete',
            'create',
            'ajaxContent',
            'ajaxDelete',
            'ajaxDeactive',
            'ajaxActive',
            'search'

        ],
        'main-departments' => [
            'index',
            'edit',
            'new',
            'delete',
            'create',
            'save',
        ],
        'ads' => [
            'index',
            'create',
            'store',
            'edit',
            'update',
            'delete',
            'getDepartmentsAjax',
            'getAjaxContentBuModule',
            'getAjaxContentByModule'

        ],
        'users_application_statistics' => [
            'index',
        ],
        'mobile_users' => [
            'index',
            'statistics',
            'edit',
            'save',
            'mail',
            'sendmail',
            'ajaxContent',
            'ajaxDelete',
            'filterUsers'

        ],
        'data_forms'=>[
            'index',
            'search',
            'create',
            'edit',
            'save',
            'delete'

        ],
        'data_forms_response'=>[
            'index',
            'edit',
            'create',
            'delete',
            'view',
            'save',
            'new',
            'replayform',
            'search',
        ],
        'data_forms_lang'=>[
                'index',
                'search',
                'new',
                'edit',
                'create',
                'save',
                'delete'
        ],
        'cp_users'=>[
            'index',
            'new',
            'create',
            'edit',
            'delete',
            'save',
            'lang',
            'store',
            'scheme',
            'ajaxContent',
            'ajaxDelete',
            'delete',
            'ajaxDeactive',
            'ajaxActive'
        ],
        'users_application_module'=>[
            'index',
            'search',
            'new',
            'edit',
            'create',
            'save',
            'delete',
            'settings',
            'settingssave',
            'additionalSettings',
            'additionalSave',
            'additionalDefault',
            'additionalDefaultSave',
            'moduleTranslation',
            'moduleHome'
        ],
        'import_data'=>[
            'index',
            'edit',
            'create',
            'save',
            'delete',

        ],
        'menus'=>[
            'index',
            'edit',
            'create',
            'save',
            'delete',
            'new'

        ],
        


    ]
]);
