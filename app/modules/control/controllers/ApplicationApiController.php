<?php
namespace Vokuro\Control\Controllers;



use Vokuro\Models\Api\FieldValidation;
use Vokuro\Models\Api\FieldValidationActions;
use Vokuro\Models\Api\FieldValidationSettings;
use Vokuro\Models\Api\FieldValidationSpecificActions;
use Vokuro\Models\SetupEntities;

class ApplicationApiController extends ModuleBase
{

	public function indexAction(){

    }
    public function newAction($specific_action_id=null){
        if($specific_action_id==null&&$this->request->isGet()){
            die("get out");
        }
        $this->view->specific_action_id = $specific_action_id;
        $selected_specific_action=FieldValidationSpecificActions::findFirst(["id={$specific_action_id}"]);
        $this->view->selected_specific_action = $selected_specific_action;
        $specific_actions = FieldValidationSpecificActions::find();
        $this->view->specific_actions = $specific_actions;
        $get_entities = SetupEntities::find();
        $this->view->entities = $get_entities;
    }
    public function getModelFieldsAction($entity_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $get_entitiy = SetupEntities::findFirst(["id={$entity_id}"]);
        $model_name = $get_entitiy->model_name;
        $model = new $model_name();
        $model_fields = get_object_vars($model);
        $this->view->model_fields = $model_fields;
        $this->view->uid = $this->request->getQuery("uid");
    }
    public function getEntitiesAction(){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $get_entities = SetupEntities::find();
        $this->view->entities = $get_entities;
        $this->view->ruid = $this->request->getQuery("uid");
    }
    public function getRelatedEntityFieldsAction($entity_id){
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $get_entitiy = SetupEntities::findFirst(["id={$entity_id}"]);
        $model_name = $get_entitiy->model_name;
        $model = new $model_name();
        $model_fields = get_object_vars($model);
        $this->view->model_fields = $model_fields;
        $this->view->ruid = $this->request->getQuery("uid");
        $this->view->entity_id= $entity_id;
    }
    public function newactionAction(){
        $main_actions = FieldValidationActions::find();
        $this->view->main_actions = $main_actions;
    }
    public function action_createAction(){
        if(!$this->request->isPost()){
            die();
        }
        $action_name = $this->request->getPost("name");
        $main_action_id = $this->request->getPost("main_action");
        $specific_action = new FieldValidationSpecificActions();
        $specific_action->name = $action_name;
        $specific_action->general_action_id = $main_action_id;
        $specific_action->save();
        $this->flashSession->success("Saved Action !");
        return $this->response->redirect("application_api/new/".$specific_action->id);
    }
    public function createAction(){
        $this->view->disable();
        if(!$this->request->isPost()){
            die();
        }
       //print_r($_POST);die;

        $entity_root_id = $this->request->getPost("entity");
        foreach ($this->request->getPost("param_root") as $param_num){
            $settings = new FieldValidationSettings();
            $settings->action_id = $this->request->getPost("main_action");
            $settings->app_id = $this->session->get('auth-identity')['Application_ID'];
            $settings->entity_id = $this->request->getPost("entity");
            $settings->entity_field_name = $this->request->getPost("entity_fields_{$param_num}");
            $settings->field_name = $this->request->getPost("parameter_{$param_num}");
            $settings->entity_is_root = 1;
            $settings->specific_action_id = $this->request->getPost("specific_action");
            if(!$settings->save()){
                print_r($settings->getMessages());
                die;
            }else{
                //check validation
                if($this->request->getPost("validation_passwordConfirm_{$param_num}")){
                    $confirm_pass_field = $this->request->getPost("confirm_password_{$param_num}");
                    $setup_validation = new FieldValidation();
                    $setup_validation->field_setting_id = $settings->id;
                    $setup_validation->confirm_password_field_name = $confirm_pass_field;
                    $setup_validation->validation_rule_id = 4;
                    $setup_validation->save();
                }
                if($this->request->getPost("validation_email_{$param_num}")){
                    $setup_validation = new FieldValidation();
                    $setup_validation->field_setting_id = $settings->id;
                    $setup_validation->validation_rule_id = 2;
                    $setup_validation->save();
                }
                if($this->request->getPost("validation_alnum_{$param_num}")){
                    $setup_validation = new FieldValidation();
                    $setup_validation->field_setting_id = $settings->id;
                    $setup_validation->validation_rule_id = 3;
                    $setup_validation->save();
                }
                if($this->request->getPost("validation_required_{$param_num}")){
                    $setup_validation = new FieldValidation();
                    $setup_validation->field_setting_id = $settings->id;
                    $setup_validation->validation_rule_id = 1;
                    $setup_validation->save();
                }
                if($this->request->getPost("validation_string_legnth_{$param_num}")){
                    $min= $this->request->getPost("min_{$param_num}");
                    $max= $this->request->getPost("max_{$param_num}");
                    $setup_validation = new FieldValidation();
                    $setup_validation->field_setting_id = $settings->id;
                    $setup_validation->validation_rule_id = 5;
                    $setup_validation->min_value = $min;
                    $setup_validation->max_value= $max;
                    $setup_validation->save();
                }
                echo "Saved Main Entity";
            }
        }
        if($this->request->getPost("related_entities")){
            foreach ($this->request->getPost("related_entities") as $related_entity_num){
                $entity = SetupEntities::findFirst("id={$related_entity_num}");
                $settings = new FieldValidationSettings();
                $settings->action_id = $this->request->getPost("main_action");
                $settings->app_id = $this->session->get('auth-identity')['Application_ID'];;
                $settings->entity_id = $entity_root_id;
                $settings->entity_field_name = $entity->model_name;
                $settings->field_name = $entity->model_name;
                $settings->entity_is_root = 1;
                $settings->specific_action_id = $this->request->getPost("specific_action");
                if(!$settings->save()){
                    print_r($settings->getMessages());
                    die;
                }
            }


            foreach ($this->request->getPost("related_entities") as $related_entity_num){
                foreach ($this->request->getPost("param_related_{$related_entity_num}") as $param_num){
                    $settings = new FieldValidationSettings();
                    $settings->action_id = $this->request->getPost("main_action");
                    $settings->app_id = $this->session->get('auth-identity')['Application_ID'];;
                    $settings->entity_id = $related_entity_num;
                    $settings->entity_field_name = $this->request->getPost("related_entity_fields_{$related_entity_num}_{$param_num}");
                    $settings->field_name = $this->request->getPost("related_parameter_{$related_entity_num}_{$param_num}");
                    $settings->entity_is_root = 0;
                    $settings->related_entity_id = $entity_root_id;
                    $settings->specific_action_id = $this->request->getPost("specific_action");
                    if(!$settings->save()){
                        print_r($settings->getMessages());
                        die;
                    }else{
                        //check validation
                        if($this->request->getPost("related_validation_passwordConfirm_{$related_entity_num}_{$param_num}")){
                            $confirm_pass_field = $this->request->getPost("confirm_password_{$related_entity_num}_{$param_num}");
                            $setup_validation = new FieldValidation();
                            $setup_validation->field_setting_id = $settings->id;
                            $setup_validation->confirm_password_field_name = $confirm_pass_field;
                            $setup_validation->validation_rule_id = 4;
                            $setup_validation->save();
                        }
                        if($this->request->getPost("related_validation_email_{$related_entity_num}_{$param_num}")){
                            $setup_validation = new FieldValidation();
                            $setup_validation->field_setting_id = $settings->id;
                            $setup_validation->validation_rule_id = 2;
                            $setup_validation->save();
                        }
                        if($this->request->getPost("related_validation_alnum_{$related_entity_num}_{$param_num}")){
                            $setup_validation = new FieldValidation();
                            $setup_validation->field_setting_id = $settings->id;
                            $setup_validation->validation_rule_id = 3;
                            $setup_validation->save();
                        }
                        if($this->request->getPost("related_validation_required_{$related_entity_num}_{$param_num}")){
                            $setup_validation = new FieldValidation();
                            $setup_validation->field_setting_id = $settings->id;
                            $setup_validation->validation_rule_id = 1;
                            $setup_validation->save();
                        }
                        if($this->request->getPost("related_validation_string_legnth_{$related_entity_num}_{$param_num}")){
                            $min= $this->request->getPost("min_{$related_entity_num}_{$param_num}");
                            $max= $this->request->getPost("max_{$related_entity_num}_{$param_num}");
                            $setup_validation = new FieldValidation();
                            $setup_validation->field_setting_id = $settings->id;
                            $setup_validation->validation_rule_id = 5;
                            $setup_validation->min_value = $min;
                            $setup_validation->max_value= $max;
                            $setup_validation->save();
                        }
                        echo "Saved Related Entity";
                    }
                }
            }
        }

        $this->flashSession->success("API Created !");
        return $this->response->redirect("application_api/index/");

    }
    public function dashesToCamelCase($string, $capitalizeFirstCharacter = false)
    {
        $string = str_replace('-', '_', $string);
        $str = str_replace(' ', '', ucwords(str_replace('_', ' ', $string)));

        if (!$capitalizeFirstCharacter) {
            $str[0] = strtolower($str[0]);
        }

        return $str;
    }
}