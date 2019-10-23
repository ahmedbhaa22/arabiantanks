<?php
/*
 * Define custom routes. File gets included in the router service definition.
 */
$router = new Phalcon\Mvc\Router();

$router->add('/cms_module/:controller', [
    'module'     => 'cms',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);
$router->add('/cms_module/:controller/:action/:params', [
    'module'     => 'cms',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/geo_module/:controller', [
    'module'     => 'geo',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);

$router->add('/geo_module/:controller/:action/:params', [
    'module'     => 'geo',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/confirm/{code}/{email}', [
    'controller' => 'user_control',
    'action' => 'confirmEmail'
]);

$router->add('/reset-password/{code}/{email}', [
    'controller' => 'user_control',
    'action' => 'resetPassword'
]);

//Control Routes
$router->add('/control_module/:controller', [
    'module'     => 'control',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);
$router->add('/control_module/:controller/:action/:params', [
    'module'     => 'control',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/control_module/', [
    'module' => 'control',
    'controller' => 'control_home',
    'action' => 'index'
]);

// Offers
$router->add('/offers_module/', [
    'module'     => 'offers',
    'controller' => 'index',
    'action'     => 'index'
]);

$router->add('/offers_module', [
    'module'     => 'offers',
    'controller' => 'index',
    'action'     => 'index'
]);

$router->add('/offers_module/:controller', [
    'module'     => 'offers',
    'controller' => 1,
    'action'     => 'index'
]);

$router->add('/offers_module/:controller/', [
    'module'     => 'offers',
    'controller' => 1,
    'action'     => 'index'
]);

$router->add('/offers_module/:controller/:action', [
    'module'     => 'offers',
    'controller' => 1,
    'action'     => 2
]);

$router->add('/offers_module/:controller/:action/', [
    'module'     => 'offers',
    'controller' => 1,
    'action'     => 2
]);

$router->add('/offers_module/:controller/:action/:params', [
    'module'     => 'offers',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/offers_module/:controller/:action/:params/', [
    'module'     => 'offers',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

// Discounts
$router->add('/discounts_module/', [
    'module'     => 'discounts',
    'controller' => 'index',
    'action'     => 'index'
]);

$router->add('/discounts_module', [
    'module'     => 'discounts',
    'controller' => 'index',
    'action'     => 'index'
]);

$router->add('/discounts_module/:controller', [
    'module'     => 'discounts',
    'controller' => 1,
    'action'     => 'index'
]);

$router->add('/discounts_module/:controller/', [
    'module'     => 'discounts',
    'controller' => 1,
    'action'     => 'index'
]);

$router->add('/discounts_module/:controller/:action', [
    'module'     => 'discounts',
    'controller' => 1,
    'action'     => 2
]);

$router->add('/discounts_module/:controller/:action/', [
    'module'     => 'discounts',
    'controller' => 1,
    'action'     => 2
]);

$router->add('/discounts_module/:controller/:action/:params', [
    'module'     => 'discounts',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/discounts_module/:controller/:action/:params/', [
    'module'     => 'discounts',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

//Cart
$router->add('/cart_module/', [
    'module'     => 'cart',
    'controller' => 'index',
    'action'     => 'index'
]);

$router->add('/cart_module', [
    'module'     => 'cart',
    'controller' => 'index',
    'action'     => 'index'
]);

$router->add('/cart_module/:controller', [
    'module'     => 'cart',
    'controller' => 1,
    'action'     => 'index'
]);

$router->add('/cart_module/:controller/', [
    'module'     => 'cart',
    'controller' => 1,
    'action'     => 'index'
]);

$router->add('/cart_module/:controller/:action', [
    'module'     => 'cart',
    'controller' => 1,
    'action'     => 2
]);

$router->add('/cart_module/:controller/:action/', [
    'module'     => 'cart',
    'controller' => 1,
    'action'     => 2
]);

$router->add('/cart_module/:controller/:action/:params', [
    'module'     => 'cart',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/cart_module/:controller/:action/:params/', [
    'module'     => 'cart',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

// Users
$router->add('/users_module/', [
    'module' => 'users',
    'controller' => 'index',
    'action' => 'index'
]);

$router->add('/users_module', [
    'module'     => 'users',
    'controller' => 'index',
    'action'     => 'index'
]);

$router->add('/users_module/auth', [
    'module'     => 'users',
    'controller' => 'auth',
    'action'     => 'index'
]);

$router->add('/users_module/auth/', [
    'module'     => 'users',
    'controller' => 'auth',
    'action'     => 'index'
]);

$router->add('/users_module/:controller/', [
    'module'     => 'users',
    'controller' => 1,
    'action'     => 'index'
]);

$router->add('/users_module/:controller/:action/', [
    'module'     => 'users',
    'controller' => 1,
    'action'     => 2
]);

$router->add('/users_module/:controller/:action/:params', [
    'module'     => 'users',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/ads_module/:controller', [
    'module'     => 'ads',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);

$router->add('/ads_module/:controller/:action/:params', [
    'module'     => 'ads',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/notifications_module/:controller', [
    'module'     => 'notifications',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);


$router->add('/notifications_module/:controller/:action/:params', [
    'module'     => 'notifications',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/polls_module/:controller', [
    'module'     => 'polls',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);

$router->add('/polls_module/:controller/:action/:params', [
    'module'     => 'polls',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/polls_module/:controller', [
    'module'     => 'polls',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);

$router->add('/messages_module/:controller', [
    'module'     => 'messages',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);

$router->add('/messages_module/:controller/:action/:params', [
    'module'     => 'messages',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/messages_module/:controller', [
    'module'     => 'messages',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);

$router->add('/maintenance_module/:controller/:action/:params', [
    'module'     => 'maintenance',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/maintenance_module/:controller', [
    'module'     => 'maintenance',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);

$router->add('/sales_visits_module/:controller/:action/:params', [
    'module'     => 'sales_visits',
    'controller' => 1,
    'action'     => 2,
    'params'     => 3
]);

$router->add('/sales_visits_module/:controller', [
    'module'     => 'sales_visits',
    'controller' => 1,
    // 'action'     => 2,
    // 'params'     => 3
]);

return $router;
