<?php

namespace Vokuro\Cms\Controllers;

use Models\DataCmsSavedFilter;
use Models\EntityTags;
use Phalcon\Mvc\Model\Resultset\Simple;
use Vokuro\Controllers\ControllerBase;

use Models\Content;
use Models\DataCmsFilterSearch;
use Phalcon\Http\Request;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Mvc\Url;
use Vokuro\Forms\AdvancedSearchForm;
use Vokuro\Models\ProductExtraFields;
use Vokuro\Models\Tags;
use Vokuro\Models\TanksMostSellingProducts;
use Vokuro\Pentavalue\Keyvalue;
use Phalcon\Mvc\Model\Query\Builder;
use DataTables\DataTable;
use \DataKeyvalueGroup;
use \DataKeyvalueGroupLang;
use \DataCmsLang;

use Models\GoappDataCmsZones;
use Vokuro\Geo\Models\GeoRegions;
use Vokuro\Geo\Models\GeoRegionsLang;
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;
use Vokuro\Pentavalue\BuildDeptsTree;
use Vokuro\Discounts\Models\Discounts;
use Vokuro\Discounts\Models\DiscountRelItems;
use Vokuro\Pentavalue\RequestValidation;
use Vokuro\Maintenance\Models\TicketProblemsStatus;

class ContentController extends ControllerBase
{

    const UPLOAD_LOCATION = 'uploads/';
    const UPLOAD_TEMP = 'uploads/temp/';

    protected $all_manfacts;

    public function initialize()
    {
        parent::initialize();
        $this->redirectService->setControllerObj($this);
    }

    // ** ASH
    public function importContentAction($module_id)
    {
        if ($this->request->hasFiles()) {
            foreach ($this->request->getUploadedFiles() as $file) {
                if (strlen($file->getName()) > 0) {
                    try {
                        $input_file_type = \PHPExcel_IOFactory::identify($file->getTempName());
                        $object_reader = \PHPExcel_IOFactory::createReader($input_file_type);
                        $php_excel = $object_reader->load($file->getTempName());
                    } catch (\Exception $e) {
                        $this->flashSession->error($e->getMessage());
                        $this->redirectBack();
                    }

                    $sheet = $php_excel->getSheet();
                    $highest_row = $sheet->getHighestRow();
                    $highest_column = $sheet->getHighestColumn();

                    $rows = [];

                    for ($row = 1; $row <= $highest_row; $row++) {
                        $rows[] = $sheet->rangeToArray('A' . $row . ':' . $highest_column . $row, NULL,
                            TRUE, FALSE)[0];
                    }

                    $data_cms_columns = [];
                    $data_cms_vars = get_class_vars(Content::class);

                    foreach ($data_cms_vars as $var_key => $var_val) {
                        $data_cms_columns[] = $var_key;
                    }

                    $data_cms_insert_columns = [];

                    foreach ($rows[0] as $item_key => $item_val) {
                        if (in_array($item_val, $data_cms_columns)) {
                            $data_cms_insert_columns['basic'][$item_key] = $item_val;
                        } else {
                            $module_key_value = \DataKeyvalue::find([
                                'Module_ID = {module_id}',
                                'bind' => [
                                    'module_id' => $module_id
                                ]
                            ]);

                            if (count($module_key_value)) {
                                $key_value_fields = [];

                                foreach ($module_key_value as $kv) {
                                    $key_value_fields[] = $kv->Paramter;
                                }

                                if (in_array($item_val, $key_value_fields)) {
                                    $data_cms_insert_columns['kv'][$item_key] = $item_val;
                                }
                            }
                        }
                    }

                    $stop_at = count($data_cms_insert_columns['basic']);
                    $insert_basic_fields = [];
                    $insert_kv_fields = [];

                    for ($j = 1; $j < count($rows); $j++) {
                        for ($i = 0; $i < count($rows[$j]); $i++) {
                            if ($i < $stop_at) {
                                $insert_basic_fields[$j][$data_cms_insert_columns['basic'][$i]] = $rows[$j][$i];
                            } else {
                                $insert_kv_fields[$j][$data_cms_insert_columns['kv'][$i]] = $rows[$j][$i];
                            }
                        }
                    }

                    foreach ($insert_basic_fields as $key => $insert_arr) {
                        $new_content = new Content();

                        $insert_arr['Key_1'] = 0;
                        $insert_arr['Key_2'] = 0;
                        $insert_arr['Key_3'] = 0;
                        $insert_arr['Key_4'] = 0;
                        $insert_arr['Key_5'] = 0;

                        $new_content->Title = (array_has($insert_arr, 'Title')) ? $insert_arr['Title'] : '';
                        $new_content->Des = (array_has($insert_arr, 'Des')) ? $insert_arr['Des'] : '';
                        $new_content->Content = (array_has($insert_arr, 'Content')) ? $insert_arr['Content'] : '';
                        $new_content->Order = (array_has($insert_arr, 'Order')) ? $insert_arr['Order'] : 0;
                        $new_content->User_ID = $this->session->get('auth-identity')['id'];
                        $new_content->Img = 'noimage.png';
                        $new_content->Visit_Num = (array_has($insert_arr, 'Visit_Num')) ? $insert_arr['Visit_Num'] : 0;
                        $new_content->DateTime = time();
                        $new_content->Active = 1;
                        $new_content->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                        $new_content->Module_ID = $module_id;
                        $new_content->Lang_ID = (array_has($insert_arr, 'Lang_ID')) ? $insert_arr['Lang_ID'] : 1;
                        $new_content->Key_1 = 0;
                        $new_content->Key_2 = 0;
                        $new_content->Key_3 = 0;
                        $new_content->Key_4 = 0;
                        $new_content->Key_5 = 0;

                        if ($new_content->save()) {
                            foreach ($insert_kv_fields[$key] as $kv_key => $kv_val) {
                                $kv_id = \DataKeyvalue::findFirst([
                                    'Paramter = {param} and Module_ID = {module_id}',
                                    'bind' => [
                                        'param' => $kv_key,
                                        'module_id' => $module_id
                                    ]
                                ])->ID;

                                $new_kv_data = new \DataKeyvalueUserdata();

                                $new_kv_data->Title = '';
                                $new_kv_data->Des = '';
                                $new_kv_data->Img = '';
                                $new_kv_data->Value = $kv_val;
                                $new_kv_data->Time = time();
                                $new_kv_data->DKV_ID = $kv_id;
                                $new_kv_data->Item_ID = $new_content->ID;
                                $new_kv_data->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                                $new_kv_data->Module_ID = $module_id;
                                $new_kv_data->Lang_ID = 1;

                                $new_kv_data->save();
                            }
                        } else {
                            var_dump($new_content->getMessages());
                            die;
                            $this->flashSession->error('Error inserting data');
                            return $this->redirectBack();
                        }
                    }
                } else {
                    $this->flashSession->error('Please choose file');
                    return $this->redirectBack();
                }
            }
        } else {
            $this->flashSession->error('Please choose file to upload!');
            return $this->redirectBack();
        }

        $this->flashSession->success('Importing data successfully');
        return $this->redirectBack();
    }

    public function exportContentAction($module_id)
    {
        $export_data = $this->request->getPost('export_data');
        $kv_fields_titles = [];

        $grid = \CpModulesSettings::findFirst(array("Module_ID ={$module_id}"));
        $export_fields = ($grid->export_fields_json) ? \GuzzleHttp\json_decode($grid->export_fields_json) : null;

        if ($export_fields) {
            $basic_fields = $export_fields->fields->basic;
            $kv_fields = $export_fields->fields->key_value;

            foreach ($kv_fields as $kv_field) {
                $kv_fields_titles[] = $kv_field->param;
            }
        } else {
            $content_fields = get_object_vars(new Content());
            $content_fields_arr = [];

            foreach ($content_fields as $key => $value) {
                if ($key !== 'ID' && $key !== 'Order') {
                    $content_fields_arr[] = $key;
                }
            }

            $basic_fields = $content_fields_arr;

            $kv_fields = \DataKeyvalue::find([
                'Module_ID = {module_id}',
                'bind' => [
                    'module_id' => $module_id
                ]
            ]);

            foreach ($kv_fields as $kv_field) {
                $kv_fields_titles[] = $kv_field->Paramter;
            }
        }

        // exporting data
        $phpexcel = new \PHPExcel();

        $phpexcel->getProperties()->setCreator('Appox');
        $phpexcel->getProperties()->setTitle('Content');
        $phpexcel->getProperties()->setSubject('Export Content');
        $phpexcel->setActiveSheetIndex(0);

        $header_fields = array_merge($basic_fields, $kv_fields_titles);

        $file_header = $this->createFileHeader();

        for ($i = 0; $i < count($header_fields); $i++) {
            $phpexcel->getActiveSheet()->setCellValue($file_header[$i], $header_fields[$i]);
            $phpexcel->getActiveSheet()->getStyle($file_header[$i])->applyFromArray([
                'fill' => [
                    'type' => \PHPExcel_Style_Fill::FILL_SOLID,
                    'color' => [
                        'rgb' => 'FF0000'
                    ]
                ]
            ]);
        }

        $row = 2;

        foreach ($export_data as $items) {
            $col = 0;
            foreach ($items as $key => $val) {
                if ($key !== 'ID' && $key !== 'Order') {
                    if ($key === 'kv') {
                        foreach ($val as $kv_key => $kv_val) {
                            $kv_field_value = ($kv_val !== "false") ? $kv_val['Value'] : '';

                            $phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, $kv_field_value);
                            $col++;
                        }
                    } else {
                        if ($key == 'Content') {
                            $val = $this->filterString($val);
                        }
                        $phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $row, $val);
                        $col++;
                    }
                }
            }
            $row++;
        }

        $obj_writer = new \PHPExcel_Writer_Excel2007($phpexcel);
        $file_name = date('Y-m-d H-i-s') . '.xlsx';
        $file_path = BASE_PATH . '/public/cms/files/' . $file_name;

        ob_clean();
        $obj_writer->save($file_path);
        return json_encode(['status' => 'success', 'file_name' => $file_name]);
    }

    private function filterString($str)
    {
        $str = strip_tags(html_entity_decode($str));
        $str = str_replace('&nbsp;', ' ', $str);
        $str = str_replace('&lt;', '', $str);
        $str = str_replace('p&gt;', '', $str);
        $str = str_replace('&amp;', '', $str);
        $str = str_replace('nbsp;', '', $str);
        $str = str_replace('&lt;', '', $str);
        $str = str_replace('/p&gt;', '', $str);

        return $str;
    }

    private function createFileHeader($start_index = -1, $header = [])
    {
        $chars = range('A', 'Z');
        $header = $header;

        if ($start_index === -1) {
            foreach ($chars as $char) {
                $header[] = $char . '1';
            }

            $this->createFileHeader($start_index + 1, $header);
        } elseif ($start_index !== 26) {
            foreach ($chars as $char) {
                $header[] = $chars[$start_index] . $char . '1';
            }

            $this->createFileHeader($start_index + 1, $header);
        }

        return $header;
    }

    // ** ASH

    public function indexAction($Module_ID)
    {
        $this->persistent->parameters = null;

        $this->view->Module_ID = $Module_ID;

        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'Content', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }
        // LANGUAGES FOR filter

        $Application = \UsersApplication::findFirst(["ID= {$this->session->get('auth-identity')['Application_ID']}"]);
        $this->view->langs = $Application->getLangs(["is_default=0"]);;
        //        $parameters = $this->persistent->parameters;
        //        if (!is_array($parameters)) {
        //            $parameters = [];
        //        }
        //        $parameters["order"] = "ID DESC";
        //        //$parameters["where"] = "ID!=8";
        //        $parameters[$Module_ID] = "Module_ID";

        $parameters["order"] = "ID DESC";

        //for langs
        $language = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$language}'"]);
        if ($lang) {
            $this->view->lang_id = $lang->id;
        } else {
            $this->view->lang_id = 1;
        }
        $access = $this->checkAccess('index');

        //Content With pagination

        $content_builder = $this->modelsManager->createBuilder()
            ->from("Models\Content")
            ->andWhere("Models\Content.Module_ID={$Module_ID}")
            ->orderBy("Models\Content.ID DESC");
        if ($access === 'only') {
            $content_builder = $this->modelsManager->createBuilder()
                ->from("Models\Content")
                ->andWhere("Models\Content.Module_ID={$Module_ID}")
                ->andWhere("Models\Content.Module_ID AND User_ID={$this->session->get('auth-identity')['id']}")
                ->orderBy("Models\Content.ID DESC");
        }

        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $content_builder,
                "limit"   => 8,
                "page"    => $numberPage,
            ]
        );
        $this->view->page = $paginator->getPaginate();


        //toggle
        $grid = \CpModulesSettings::findFirst(array("Module_ID ={$Module_ID}"));
        // ** ASH
        $this->view->impexp_enabled = $grid->import_export_enabled;
        $export_fields = ($grid->export_fields_json) ? \GuzzleHttp\json_decode($grid->export_fields_json) : null;

        if ($export_fields) {
            $basic_fields_string = '';
            $kv_fields_string = '';
            $basic_fields = $export_fields->fields->basic;
            $kv_fields = $export_fields->fields->key_value;
            $kv_fields = $export_fields->fields->key_value;
            $kv_fields_titles = [];

            if (count($basic_fields)) {
                $basic_fields_string = implode(',', $basic_fields);
                $basic_fields_query = Content::find([
                    'conditions' => 'Module_ID = {module}',
                    'columns' => 'ID,' . $basic_fields_string,
                    'bind' => [
                        'module' => $Module_ID
                    ]
                ]);

                if (count($kv_fields)) {
                    foreach ($kv_fields as $kv_field) {
                        $kv_fields_titles[] = $kv_field->param;
                    }

                    $basic_fields_data_arr = $basic_fields_query->toArray();
                    $holder_arr = [];

                    foreach ($basic_fields_data_arr as $item_array) {
                        foreach ($kv_fields as $kv) {
                            $kv_data = \DataKeyvalueUserdata::findFirst([
                                'Module_ID = {module_id} and DKV_ID = {dkv_id} and Item_ID = {item_id}',
                                'bind' => [
                                    'module_id' => $Module_ID,
                                    'dkv_id' => $kv->id,
                                    'item_id' => $item_array['ID']
                                ]
                            ]);

                            $item_array['kv'][$kv->param] = ($kv_data) ? $kv_data->toArray() : $kv_data;
                        }

                        $holder_arr[] = $item_array;
                    }

                    if (count($holder_arr)) {
                        $this->view->exportData = json_encode($holder_arr);
                    }
                }
            }
        } else {
            $content_fields = get_object_vars(new Content());
            $content_fields_arr = [];

            foreach ($content_fields as $key => $value) {
                if ($key !== 'ID' && $key !== 'Order') {
                    $content_fields_arr[] = $key;
                }
            }

            $basic_fields = $content_fields_arr;
            $basic_fields_string = implode(',', $basic_fields);

            $basic_fields_query = Content::find([
                'conditions' => 'Module_ID = {module}',
                'columns' => 'ID,' . $basic_fields_string,
                'bind' => [
                    'module' => $Module_ID
                ]
            ]);

            $kv_fields = \DataKeyvalue::find([
                'Module_ID = {module_id}',
                'bind' => [
                    'module_id' => $Module_ID
                ]
            ]);


            if (count($kv_fields)) {
                foreach ($kv_fields as $kv_field) {
                    $kv_fields_titles[] = $kv_field->Paramter;
                }

                $basic_fields_data_arr = $basic_fields_query->toArray();
                $holder_arr = [];

                foreach ($basic_fields_data_arr as $item_array) {
                    foreach ($kv_fields as $kv) {
                        $kv_data = \DataKeyvalueUserdata::findFirst([
                            'Module_ID = {module_id} and DKV_ID = {dkv_id} and Item_ID = {item_id}',
                            'bind' => [
                                'module_id' => $Module_ID,
                                'dkv_id' => $kv->ID,
                                'item_id' => $item_array['ID']
                            ]
                        ]);

                        $item_array['kv'][$kv->Paramter] = ($kv_data) ? $kv_data->toArray() : $kv_data;
                    }

                    $holder_arr[] = $item_array;
                }

                if (count($holder_arr)) {
                    $this->view->exportData = json_encode($holder_arr);
                    $this->view->Module_ID = $Module_ID;
                }
            }

        }
        // ** ASH
        if (count($grid) == 0) {
            $this->view->Toggle_Grid = 0;
        } else {
            $this->view->Toggle_Grid = $grid->Toggle_Grid;
        }

        $this->view->page = $paginator->getPaginate();
        $this->view->base_uri = $this->config->application->baseUri;
        $get_main_depts = \DataCmsDepts::find(["Module_ID=" . $Module_ID,]);
        $main_depts = array();
        foreach ($get_main_depts as $main_dept) {
            $main_depts[] = $main_dept;
        }
        $this->view->main_depts = $get_main_depts;
        $this->view->Module_ID = $Module_ID;

        //list_settings
        $list_settings = \DataCmsListSettings::findFirst(array("Module_ID={$Module_ID}"));
        if (!$list_settings) {
            unset($list_settings);
            $list_settings = new \DataCmsListSettings();
            $list_settings->Module_ID = $Module_ID;
            $list_settings->Application_ID = $this->session->get('auth-identity')['Application_ID'];
            $list_settings->save();
            unset($list_settings);
            $list_settings = \DataCmsListSettings::findFirst(array("Module_ID={$Module_ID}"));
            $this->view->list_settings = $list_settings;
        } else {
            $this->view->list_settings = $list_settings;
        }

        $dkvs = \DataKeyvalue::find(array("Module_ID={$Module_ID} AND Show=1 And Depts_ID=0"));
        $this->view->dkvs = $dkvs;
        //$module =  \UsersApplicationModule::findFirst(["ID={$Module_ID}"]);
        $this->view->Module_Title = $module->Title;
        //Content Settings
        $content_settings = \CpModuleContentSetting::findFirst(["Module_ID={$Module_ID}"]);
        $this->view->content_settings = $content_settings;
        $module_setting = \CpModulesSettings::findFirst(array("Module_ID={$Module_ID}"));
        if (!$module_setting) {
            $module_setting = new \CpModulesSettings();
            $module_setting->Module_ID = $Module_ID;
            $module_setting->save();
        }
        $this->view->module_setting = $module_setting;
        $get_module = \UsersApplicationModule::findFirst(["ID={$Module_ID}"]);
        $language = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$language}'"]);
        $lang_id = $lang->id;
        $module = [];

        $module['mod_id'] = $get_module->ID;
        $get_title = \UsersApplicationModuleLang::findFirst(["lang_id={$lang_id} and module_id={$get_module->ID}"]);
        if ($get_title) {
            $module['mod_title'] = $get_title->title;
        } else {
            $module['mod_title'] = $get_module->Title;
        }
        $module['mod_img'] = $get_module->Settings->Img;

        $this->view->module = $module;
    }

    public function editAction($ID)
    {
        $content = Content::findFirstByID($ID);
        $this->checkAccess('edit', $content);
        if (!$this->request->isPost()) {
            //get language id


            if (!$content) {
                $this->flash->error("content was not found");

                $this->dispatcher->forward(['controller' => "content", 'action' => 'index']);

                return;
            }
            //Get Language Options If Any
            $Application = \UsersApplication::findFirst(["ID= {$content->Application_ID}"]);
            $this->view->content_id = $ID;
            if (count($Application->Langs) == 0) {
                $this->view->has_langs = 0;
            } else {
                $this->view->has_langs = 1;
                $this->view->langs = $Application->getLangs(["is_default=0"]);
                $this->view->app_langs = $Application->getLangs(["is_default=0"]);
                $content_langs = [];
                foreach ($Application->Langs as $lang) {
                    $data_cms_lang = \DataCmsLang::findFirst(["data_cms_id={$ID} AND lang_id={$lang->lang_id}"]);
                    if (!$data_cms_lang) {
                        $content_langs[$lang->lang_id]['Lang_Title'] = $lang->LangDetails->title;
                        $content_langs[$lang->lang_id]['Lang_ID'] = $lang->lang_id;
                        $content_langs[$lang->lang_id]['Title'] = 'Enter Title';
                        $content_langs[$lang->lang_id]['Des'] = 'Enter Des';
                        $content_langs[$lang->lang_id]['Content'] = 'Enter Content';
                    } else {
                        $content_langs[$lang->lang_id]['Lang_Title'] = $lang->LangDetails->title;
                        $content_langs[$lang->lang_id]['Lang_ID'] = $lang->lang_id;
                        $content_langs[$lang->lang_id]['Title'] = $data_cms_lang->title;
                        $content_langs[$lang->lang_id]['Des'] = $data_cms_lang->des;
                        $content_langs[$lang->lang_id]['Content'] = $data_cms_lang->content;
                    }
                }
                $this->view->content_langs = $content_langs;
            }
            if (isset($_GET["lang_id"])) {
                $this->view->lang_id_checked = $_GET["lang_id"];
            } else {
                $this->view->lang_id_checked = 0;
            }
            $this->assets->addJs("js/cms_validation.js");
            $this->assets->addJs("js/customized_uploader.js");

            $this->view->ID = $content->ID;
            $this->view->mediaImages = \DataCmsMedia::find(["Item_ID = {$ID} AND Type = 'Img'",]);
            $this->view->mediaMenus = \DataCmsMedia::find(["Item_ID = {$ID} AND Type = 'Menu'",]);
            $this->view->Module_ID = $content->Module_ID;
            $dept = new Content();
            //$this->view->dept = $dept->getDeptByID($content->ID);
            //die(var_dump($dept->getDeptByID($content->ID)));
            $this->tag->setDefault("ID", $content->ID);
            $this->tag->setDefault("Title", $content->Title);
            $this->tag->setDefault("Des", $content->Des);
            $this->tag->setDefault("Content", $content->Content);
            $this->tag->setDefault("Order", $content->Order);
            //            $this->tag->setDefault("User_ID", $content->User_ID);
            $this->tag->setDefault("Img", $content->Img);
            //            $this->tag->setDefault("Visit_Num", $content->Visit_Num);
            $this->tag->setDefault("DateTime", $content->DateTime);

            $this->tag->setDefault("Application_ID", $content->Application_ID);
            $this->tag->setDefault("Module_ID", $content->Module_ID);
            $videos = \DataCmsMedia::find(["Item_ID = {$ID} AND Type='Video'"]);
            $this->view->videos = $videos;
            //16/4/2017 if no image ?
            if ($content->Img == "noimage.png") {
                $this->tag->setDefault("NoImg", "Y");
            }
            $this->view->main_pic = $content->Img;
            if ($content->Active == 1) {
                //$this->view->Active = $content->Active;
                $this->tag->setDefault("Active", "Y");
            }
            $get_department = \DataCmsDeptsRelItem::findFirst(["Item_ID=$content->ID"]);
            $core_dept = $get_department->DeptDetails->Core_Depts_ID;

            $lang_code = $this->session->get('auth-identity')['Lang'];
            $lang = \Languages::findFirst(["code='{$lang_code}'"]);
            $this->view->lang_id = $lang->id;
            //KeyValue
            $keyvalues = new Keyvalue();
            $this->view->keyvalues = $keyvalues->getKeyvalues($content->Module_ID, null, null, null, $lang->id);
            $this->view->attributes = $keyvalues->getKeyvalues($content->Module_ID, 2, $core_dept, $get_department->Depts_ID, $lang->id);
            //set existing keyvalues
            foreach ($keyvalues->getKeyvalueUserdata($content->ID) as $keyvalue) {
                if ($keyvalue['kv_type_id'] == 3 || $keyvalue['kv_type_id'] == 8) {
                    $selected_options = explode(',', $keyvalue['value']);
                    $kv_checked_elements[$keyvalue['kv_id']] = $selected_options;
                    $this->view->kv_checked_elements = $kv_checked_elements;
//                    foreach ($selected_options as $selected_option){
//                        $kv_element= "keyvalue_value_default{$keyvalue['kv_id']}";
//                        $this->tag->setDefault("keyvalue_value_default{$keyvalue['kv_id']}", $selected_option);
//                    }
                } else {
                    $this->tag->setDefault("keyvalue_value_default{$keyvalue['kv_id']}", $keyvalue['value']);
                    $this->tag->setDefault("keyvalue_des_default{$keyvalue['kv_id']}", $keyvalue['des']);
                    $this->tag->setDefault("keyvalue_title_default{$keyvalue['kv_id']}", $keyvalue['title']);
                    if ($keyvalue['has_langs'] == 1) {
                        foreach ($keyvalue['langs'] as $lang_value) {
                            $this->tag->setDefault("keyvalue_value_lang{$keyvalue['kv_id']}_{$lang_value['lang_id']}", $lang_value['value']);
                            $this->tag->setDefault("keyvalue_des_lang{$keyvalue['kv_id']}_{$lang_value['lang_id']}", $lang_value['des']);
                            $this->tag->setDefault("keyvalue_title_lang{$keyvalue['kv_id']}_{$lang_value['lang_id']}", $lang_value['title']);
                        }
                    }
                }
            }
            $this->view->settings = $this->contentSettings($content->Module_ID);
            //get module child
            $relation = \DataModuleRelations::findFirst(["module_one={$content->Module_ID}"]);
            if (!$relation) {
                $this->view->hasRel = 0;

            } elseif ($relation->model_two == 0) {
                $this->view->hasRel = 0;
            } else {
                $this->view->hasRel = 1;
                $this->view->moduleRelated = $relation->model_two;
                $this->view->related_module_title = $relation->RelatedModuleInfo->Title;

            }
            if (isset($_GET['lang_id'])) {
                $lang_id = $_GET['lang_id'];
                $data_cms_lang = \DataCmsLang::findFirst(["data_cms_id={$ID} AND lang_id={$lang_id}"]);
                $this->tag->setDefault("Title", $data_cms_lang->title);
                $this->tag->setDefault("Des", $data_cms_lang->des);
                $this->tag->setDefault("Content", $data_cms_lang->content);

            }

        }

        $Module_ID = $content->Module_ID;
        $get_module = \UsersApplicationModule::findFirst(["ID={$Module_ID}"]);
        $language = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$language}'"]);
        $lang_id = $lang->id;
        $module = [];

        $module['mod_id'] = $get_module->ID;
        $get_title = \UsersApplicationModuleLang::findFirst(["lang_id={$lang_id} and module_id={$get_module->ID}"]);
        if ($get_title) {
            $module['mod_title'] = $get_title->title;
        } else {
            $module['mod_title'] = $get_module->Title;
        }
        $module['mod_img'] = $get_module->Settings->Img;

        $this->view->module = $module;
        $module_setting = \CpModulesSettings::findFirst(array("Module_ID={$content->Module_ID}"));
        if (!$module_setting) {
            $module_setting = new \CpModulesSettings();
            $module_setting->Module_ID = $Module_ID;
            $module_setting->save();
        }
        $this->view->module_setting = $module_setting;
        //special case
        $zones_q = GeoRegions::find("application_id={$this->session->get('auth-identity')['Application_ID']}");
        foreach ($zones_q as $key => $value) {
            foreach ($value->getLangs(["lang_id={$lang_id}"]) as $value) {
                $zones[$value->region_id] = $value->name;
            };

        }
        $this->view->zones = $zones;
        $get_zone = GoappDataCmsZones::findfirst(["data_cms_id={$content->ID}"]);
        if ($get_zone) {
            $this->tag->setDefault("zones", $get_zone->zone_id);
        }

        $this->assets->addJs("js/keyvalue_validation.js");

        $lang_code = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$lang_code}'"]);
        $this->view->lang_id = $lang->id;
        //Extra Fields
        $extra_fields = [];
        if ($Module_ID == 8) {
            $product_extra_fields = new ProductExtraFields();
            $extra_fields = $product_extra_fields->returnExtra();
            $existed_extra_values = ProductExtraFields::findFirst(["item_id={$content->ID}"]);
            foreach ($existed_extra_values as $k => $extra_field) {
                $this->tag->setDefault("extra_field_{$k}", $extra_field);
            }
        }
        $this->view->extra_fields = $extra_fields;

        //Tags
        $assigned_tags = [];
        $entity_tags = EntityTags::find(["entity_id=1 AND item_id={$content->ID}"]);
        foreach ($entity_tags as $tag) {
            $assigned_tags[] = $tag->Tag->name;
        }
        $this->view->assigned_tags = $assigned_tags;

        //Most Selling
        $most_selling = TanksMostSellingProducts::findFirst(["product_id={$content->ID}"]);
        if($most_selling){
            $this->tag->setDefault("most_selling", "Y");
        }

    }

    public function saveAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward(['controller' => "content", 'action' => 'index']);

            return;
        }
        //print_r($_POST);die;
        // Store Content Details

        $ID = $this->request->getPost("ID");
        $content = Content::findFirstByID($ID);

        $this->checkAccess('edit', $content);
        //die($this->request->getPost("Active"));
        if (!$content) {
            $this->flash->error("content does not exist " . $ID);

            $this->dispatcher->forward(['controller' => "content", 'action' => 'index']);

            return;
        }
        $this->checkAccess('edit', $content);
        if ($this->request->getPost("Active") != null) {
            $content_active = 1;
        } else {
            $content_active = 0;
        };

        $content->Active = $content_active;
        if (isset($_GET['lang_id'])) {
            $lang_id = $_GET['lang_id'];
            $data_cms_lang = \DataCmsLang::findFirst("data_cms_id={$ID} AND lang_id={$lang_id}");
            if ($data_cms_lang) {
                $data_cms_lang->title = $this->request->getPost("Title") ?: "";
                $data_cms_lang->des = $this->request->getPost("Des") ?: "";
                $data_cms_lang->content = $this->request->getPost("Content") ?: "";
                if (!$data_cms_lang->save()) {
                    foreach ($data_cms_lang->getMessages() as $msg) {
                        foreach ($data_cms_lang->getMessages() as $message) {
                            $this->flashSession->error($message);
                        }
                    }
                }
            } else {
                $data_cms_lang = new \DataCmsLang();
                $data_cms_lang->lang_id = $lang_id;
                $data_cms_lang->title = $this->request->getPost("Title") ?: "";
                $data_cms_lang->des = $this->request->getPost("Des") ?: "";
                $data_cms_lang->content = $this->request->getPost("Content") ?: "";
                $data_cms_lang->data_cms_id = $ID;
                if (!$data_cms_lang->save()) {
                    foreach ($data_cms_lang->getMessages() as $message) {
                        $this->flashSession->error($message);
                    }
                }

            }

        } else {
            $content->Title = $this->request->getPost("Title");

            $content->Des = $this->request->getPost("Des");
            $content->Content = $this->request->getPost("Content");
        }

        $content->Order = $this->request->getPost("Order");
        //        $content->User_ID = $this->request->getPost("User_ID");
        if ($this->request->getPost("NoImg") != null) {
            $content->Img = "noimage.png";
        } else {
            if ($this->request->hasFiles() == true) {
                foreach ($this->request->getUploadedFiles() as $file) {
                    if ($file->getKey() == "Img") {
                        $random = new Random();
                        $random_name = $random->uuid() . "." . $file->getExtension();
                        if ($file->getName() != "") {
                            $content->Img = $random_name;
                            $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                        }
                    }

                }

            }
        };

        if (isset($_POST['DateTime'])) {
            $content->DateTime = $this->request->getPost("DateTime");
        } else {
            $content->DateTime = time();
        }
        //$content->Active = $this->request->getPost("Active");
        $content->Application_ID = $this->session->get('auth-identity')['Application_ID'];

        $content->Lang_ID = 1;
        $content->Key_1 = 1;
        $content->Key_2 = 1;
        $content->Key_3 = 1;
        $content->Key_4 = 1;
        $content->Key_5 = 1;
        if (!$content->save()) {

            foreach ($content->getMessages() as $message) {
                $this->flashSession->error($message);
            }


        }
        // Store Departments
        if (isset($_POST["Depts_ID"])) {
            $dept_rel = \DataCmsDeptsRelItem::find("Item_ID = $ID");
            if (!$dept_rel) {

            } else {
                foreach ($dept_rel as $dept_item) {
                    $dept_item->delete();
                }
            }
            $depts = $this->request->getPost("Depts_ID");
            foreach ($depts as $dept) {
                $dept_rel = new \DataCmsDeptsRelItem();
                $dept_rel->Item_ID = $content->ID;
                $dept_rel->Depts_ID = $dept;
                $dept_rel->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $dept_rel->Module_ID = $content->Module_ID;
                $dept_rel->save();
                unset($dept_rel);
            }

        }

        //Store Media Images
        if (isset($_POST["mediaImages"])) {
            $mediaImages = $this->request->getPost("mediaImages");
            foreach ($mediaImages as $Img) {
                $media = new \DataCmsMedia();
                $media->Type = 'Img';
                $media->Item_ID = $content->ID;
                $media->Module_ID = $content->Module_ID;
                $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $media->Img = $Img;
                $media->Link = " ";
                $media->save();
                unset($media);
            }
        }
        if (isset($_POST["deletedMedia"])) {
            foreach ($this->request->getPost("deletedMedia") as $deletedMedia) {
                if ($deletedMedia != "undefined") {
                    $media = new \DataCmsMedia();
                    $media->ID = $deletedMedia;
                    $media->delete();
                    unset($media);
                }
            }
        }
        if (isset($_POST["deletedMediaMenus"])) {
            foreach ($this->request->getPost("deletedMediaMenus") as $deletedMedia) {
                if ($deletedMedia != "undefined") {
                    $media = new \DataCmsMedia();
                    $media->ID = $deletedMedia;
                    $media->delete();
                    unset($media);
                }
            }
        }
        if (isset($_POST["deleteVideo"])) {
            foreach ($this->request->getPost("deleteVideo") as $deletedMedia) {

                $media = \DataCmsMedia::findFirst(array("Link = '{$deletedMedia}' AND Item_ID={$ID}"));
                if ($media) {
                    $media->delete();
                    unset($media);
                }

            }
        }
        //Store Media Videos
        if (isset($_POST["mediaVideos"])) {
            foreach ($this->request->getPost("mediaVideos") as $link) {
                $media = new \DataCmsMedia();
                $media->Type = 'Video';
                $media->Item_ID = $content->ID;
                $media->Module_ID = $content->Module_ID;
                $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $media->Img = " ";
                $media->Link = $link;
                $media->save();
                unset($media);

            }
        }

        // Store Media (Menus) For GoApp Only Module 20195
        if (isset($_POST['mediaMenus'])) {
            foreach ($this->request->getPost("mediaMenus") as $img) {
                $media = new \DataCmsMedia();
                $media->Type = 'Menu';
                $media->Item_ID = $content->ID;
                $media->Module_ID = $content->Module_ID;
                $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $media->Img = $img;
                $media->Link = " ";
                $media->save();
                unset($media);

            }
        }

        if (isset($_POST['zones'])) {
            $get_zone = GoappDataCmsZones::findfirst(["data_cms_id={$content->ID}"]);
            $get_zone->zone_id = $_POST['zones'];
            $get_zone->save();
        }

        $keyvalue = new Keyvalue();
        if (!$keyvalue->setKeyvalueUserdata($content->ID, $content->Module_ID)) {
            die("Error Saving Keyvalue");
        };

        //Extra Fields
        $extra_fields = [];
        if ($content->Module_ID == 8) {
            $product_extra_fields = new ProductExtraFields();
            $extra_fields = $product_extra_fields->returnExtra();
            $existed_extra_values = ProductExtraFields::findFirst(["item_id={$content->ID}"]);
            if (!$existed_extra_values) {
                $existed_extra_values = new ProductExtraFields();
                $existed_extra_values->item_id = $content->ID;
                $existed_extra_values->module_id = $content->Module_ID;
            }
            foreach ($extra_fields as $extra_field) {
                $existed_extra_values->{$extra_field} = $this->request->getPost("extra_field_{$extra_field}");
            }
            if (!$existed_extra_values->save()) {
                foreach ($existed_extra_values->getMessages() as $e) {
                    $this->flashSession->error("Error In Extra Fields: " . $e);
                }
            };
        }

        //Handling Tags
        $entity_tags = EntityTags::find(["entity_id=1 AND item_id={$content->ID} and module_id={$content->Module_ID}"]);
        foreach ($entity_tags as $tag) {
            $tag->delete();
        }
        if ($this->request->getPost("tags")) {
            foreach ($this->request->getPost("tags") as $tag) {
                $check_tag = Tags::findFirst(["name='{$tag}'"]);
                if (!$check_tag) {
                    $check_tag = new Tags();
                    $check_tag->name = $tag;
                    if (!$check_tag->save()) {
                        foreach ($check_tag->getMessages() as $e) {
                            $this->flashSession->error("Check Tag: " . $e);
                        }
                    };
                }
                $entity_tag = new EntityTags();
                $entity_tag->tag_id = $check_tag->id;
                $entity_tag->item_id = $content->ID;
                $entity_tag->entity_id = 1;
                $entity_tag->module_id = $content->Module_ID;
                if (!$entity_tag->save()) {
                    foreach ($entity_tag->getMessages() as $e) {
                        $this->flashSession->error("Entity Tag: " . $e);
                    }
                };


            }
        }

        // Most Selling
        if ($this->request->getPost("most_selling") != null) {
            $most_selling = 1;
            $setMostSelling = $this->setMostSelling($content->ID,1);

        } else {
            $setMostSelling = $this->setMostSelling($content->ID,0);
        };



        $this->flashSession->success($this->getTranslation()->_("Content was edited successfully"));

        return $this->response->redirect($_SERVER['HTTP_REFERER']);
        //        $this->dispatcher->forward([
        //            'controller' => "content",
        //            'action' => 'edit',
        //            'ID' => [$content->ID],
        //        ]);

    }

    public function createAction()
    {
        // var_dump($this->request->getPost());die;
        $this->checkAccess('add');
        if (!$this->request->isPost()) {
            $this->dispatcher->forward(['controller' => "content", 'action' => 'index']);

            return;
        }
        // Go App Special Case
        if ($this->request->getPost("Module_ID") == 20195) {
            // if (!isset($_POST['keyvalueAdd121']) || !isset($_POST['keyvalueAdd122']) || !isset($_POST['keyvalueAdd123'])) {
            // $this->flashSession->error("You Must Choose The three Moods");
            // return $this->response->redirect($_SERVER['HTTP_REFERER']);
            // }
            // if ($_POST['keyvalueAdd121'] == $_POST['keyvalueAdd122'] || $_POST['keyvalueAdd122'] == $_POST['keyvalueAdd123'] || $_POST['keyvalueAdd121'] == $_POST['keyvalueAdd123']) {
            // $this->flashSession->error("You Cannot Choose The same mood");
            // return $this->response->redirect($_SERVER['HTTP_REFERER']);
            // }
        }

        //Check If All Content Languages Are Required:
        if ($this->request->getPost("LangsRequired") == 1) {
            //check post for Languages
            $application_languages = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND is_default=0"]);
            foreach ($application_languages as $app_lang) {
                if (empty($_POST["Title_{$app_lang->lang_id}"]) || empty($_POST["Content_{$app_lang->lang_id}"])) {
                    $this->flashSession->error("You Must Enter All Languages");
                    return $this->response->redirect($_SERVER['HTTP_REFERER']);
                }
            }

        }

        // Content Details Store
        $content = new Content();
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                if ($file->getKey() == "Img") {
                    //die("Islam");
                    $random = new Random();
                    $random_name = $random->uuid() . "." . $file->getExtension();

                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                    $content->Img = $random_name;

                }
            }

        }

        $content->Title = $this->request->getPost("Title");
        $content->Des = $this->request->getPost("Des");
        $content->Content = $this->request->getPost("Content");
        $content->Order = $this->request->getPost("Order");
        if (isset($_POST['DateTime'])) {
            $content->DateTime = $this->request->getPost("DateTime");
        } else {
            $content->DateTime = time();
        }
        $content->Active = $this->request->getPost("Active");

        if (isset($_POST["Active"])) {
            $content->Active = 1;
        } else {
            $content->Active = 0;
        }

        $content->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        $content->User_ID = $this->session->get('auth-identity')['id'];
        $content->Visit_Num = 0;
        $content->Module_ID = $this->request->getPost("Module_ID");
        $content->Lang_ID = 1;
        $content->Key_1 = 0;
        $content->Key_2 = 0;
        $content->Key_3 = 0;
        $content->Key_4 = 0;
        $content->Key_5 = 0;

        if (!$content->save()) {

            foreach ($content->getMessages() as $message) {
                $this->flashSession->error($message);
            }
            return $this->response->redirect($_SERVER['HTTP_REFERER']);
            return;
        }
        // Store Departments
        if (isset($_POST["Depts_ID"])) {

            $depts = $this->request->getPost("Depts_ID");
            foreach ($depts as $dept) {
                $dept_rel = new \DataCmsDeptsRelItem();
                $dept_rel->Item_ID = $content->ID;
                $dept_rel->Depts_ID = $dept;
                $dept_rel->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $dept_rel->Module_ID = $content->Module_ID;
                $dept_rel->save();
                unset($dept_rel);

            }
        }

        if(isset($_POST['Manfct_Depts_ID']))
        {
            $manfcts = $this->request->getPost('Manfct_Depts_ID');
            foreach($manfcts as $manfct)
            {
                $dept_rel = new \DataCmsDeptsRelItem();
                $dept_rel->Item_ID = $content->ID;
                $dept_rel->Depts_ID = $manfct;
                $dept_rel->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $dept_rel->Module_ID = $content->Module_ID;
                $dept_rel->save();
                unset($dept_rel);
            }
        }
        // Store Media (Pictures)
        if (isset($_POST['mediaImages'])) {
            foreach ($this->request->getPost("mediaImages") as $img) {
                $media = new \DataCmsMedia();
                $media->Type = 'Img';
                $media->Item_ID = $content->ID;
                $media->Module_ID = $content->Module_ID;
                $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $media->Img = $img;
                $media->Link = " ";
                $media->save();
                unset($media);

            }
        }
        // Store Media (Videos)
        if (isset($_POST['mediaVideos'])) {
            foreach ($this->request->getPost("mediaVideos") as $link) {
                $media = new \DataCmsMedia();
                $media->Type = 'Video';
                $media->Item_ID = $content->ID;
                $media->Module_ID = $content->Module_ID;
                $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $media->Img = " ";
                $media->Link = $link;
                $media->save();
                unset($media);

            }
        }

        // Store Media (Menus) For GoApp Only Module 20195
        if (isset($_POST['mediaMenus'])) {
            foreach ($this->request->getPost("mediaMenus") as $img) {
                $media = new \DataCmsMedia();
                $media->Type = 'Menu';
                $media->Item_ID = $content->ID;
                $media->Module_ID = $content->Module_ID;
                $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                $media->Img = $img;
                $media->Link = " ";
                $media->save();
                unset($media);

            }
        }


        $keyvalue = new Keyvalue();
        if (!$keyvalue->setKeyvalueUserdata($content->ID, $content->Module_ID)) {
            die("Error Saving Keyvalue");
        };
        //check if parent then add relation
        if ($this->request->getPost("isParent") !== 0) {
            $relation = new \DataModuleRelationsCms();
            $relation->rel_id = 4;
            $relation->parent_cms_id = $this->request->getPost("isParent");
            $relation->item_cms_one = $content->ID;
            if (!$relation->save()) {
                $this->flashSession->success($this->getTranslation()->_("Error in Saving Relation"));
                return $this->response->redirect($_SERVER['HTTP_REFERER']);
            }
        }

        $this->flashSession->success($this->getTranslation()->_("Content was created successfully"));

        //special cases
        if ($this->session->get('auth-identity')['Application_ID'] == 593) {
            $zone = $this->request->getPost("zones");
            $geo_city = new GoappDataCmsZones();
            $geo_city->data_cms_id = $content->ID;
            $geo_city->module_id = $content->Module_ID;
            $geo_city->application_id = $content->Application_ID;
            $geo_city->zone_id = $zone;
            if (!$geo_city->save()) {
                print_r($geo_city->getMessages);
                die();
            }
        }



        //Deal With Languages Content
        //check post for Languages
        $application_languages = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND is_default=0"]);
        foreach ($application_languages as $app_lang) {
            $content_lang = new DataCmsLang();
            $content_lang->data_cms_id = $content->ID;
            $content_lang->lang_id = $app_lang->lang_id;
            $content_lang->title = $this->request->getPost("Title_{$app_lang->lang_id}");
            $content_lang->content = $this->request->getPost("Content_{$app_lang->lang_id}");
            $content_lang->des = $this->request->getPost("Des_{$app_lang->lang_id}");
            $content_lang->save();
        }

        //Extra Fields
        $extra_fields = [];
        if ($content->Module_ID == 8) {
            $product_extra_fields = new ProductExtraFields();
            $extra_fields = $product_extra_fields->returnExtra();
            $existed_extra_values = new ProductExtraFields();
            $existed_extra_values->item_id = $content->ID;
            $existed_extra_values->module_id = $content->Module_ID;

            foreach ($extra_fields as $extra_field) {
                $existed_extra_values->{$extra_field} = $this->request->getPost("extra_field_{$extra_field}");
            }
            if (!$existed_extra_values->save()) {
                foreach ($existed_extra_values->getMessages() as $e) {
                    $this->flashSession->error("Error In Extra Fields: " . $e);
                }
            };
        }

        //Handling Tags
        if ($this->request->getPost("tags")) {
            foreach ($this->request->getPost("tags") as $tag) {
                $check_tag = Tags::findFirst(["name='{$tag}'"]);
                if (!$check_tag) {
                    $check_tag = new Tags();
                    $check_tag->name = $tag;
                    if (!$check_tag->save()) {
                        foreach ($check_tag->getMessages() as $e) {
                            $this->flashSession->error("Check Tag: " . $e);
                        }
                    };
                }
                //check if assigned to data_cms already
                $entity_tag = EntityTags::findFirst(["entity_id=1 AND item_id={$content->ID} AND tag_id={$check_tag->id}"]);
                if (!$entity_tag) {
                    $entity_tag = new EntityTags();
                    $entity_tag->tag_id = $check_tag->id;
                    $entity_tag->item_id = $content->ID;
                    $entity_tag->entity_id = 1;
                    $entity_tag->module_id = $content->Module_ID;
                    if (!$entity_tag->save()) {
                        foreach ($entity_tag->getMessages() as $e) {
                            $this->flashSession->error("Entity Tag: " . $e);
                        }
                    };
                }

            }
        }


        return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }

    public function mediaAction($id)
    {
        $this->view->Item_ID = $id;
        $this->view->content = \DataCmsMedia::find("Item_ID = $id");
    }

    public function addmediaAction($contentid)
    {

        $this->view->hiddenID = $contentid;

    }

    public function createmediaAction()
    {
        if (!$this->request->isPost()) {
            $this->dispatcher->forward(['controller' => "content", 'action' => 'index']);

            return;
        }
        $media = new \DataCmsMedia();
        $media->Link = $this->request->getPost("Link");
        if ($this->request->hasFiles() == true) {
            foreach ($this->request->getUploadedFiles() as $file) {
                $random = new Random();
                $random_name = $random->uuid() . "." . $file->getExtension();
                if ($file->getName() != "") {
                    $media->Img = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                }

            }

        } else {
            $media->Img = $this->request->getPost("Img");
        }
        $media->Type = $this->request->getPost("Type");
        $media->Item_ID = $this->request->getPost("Item_ID");
        $media->Module_ID = "20002";
        $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
        if (!$media->save()) {
            foreach ($media->getMessages() as $message) {
                $this->flash->error($message);
            }
            return;
        }
        $this->flash->success("media was created successfully");

    }

    public function editMediaAction($media_id)
    {

        if (!$this->request->isPost()) {

            $media = \DataCmsMedia::findFirst($media_id);
            if (!$media) {
                $this->flash->error("media was not found");

                $this->dispatcher->forward(['controller' => "content/media", 'action' => 'index']);

                return;
            }

            $this->view->ID = $media->ID;
            $this->tag->setDefault("ID", $media->ID);
            $this->tag->setDefault("Link", $media->Link);
            $this->tag->setDefault("Img", $media->Img);
            $this->tag->setDefault("Item_ID", $media->Item_ID);
        }

    }

    public function deletemediaAction($media_id)
    {
        $media = \DataCmsMedia::findFirstByID($media_id);
        if (!$media) {
            $this->flash->error("Media was not found");

            $this->dispatcher->forward(['controller' => "content", 'action' => 'index']);

            return;
        }

        if (!$media->delete()) {

            foreach ($media->getMessages() as $message) {
                $this->flash->error($message);
            }

            return;
        }

        $this->flash->success("media was deleted successfully");

        //        $this->dispatcher->forward([
        //            'controller' => "content",
        //            'action' => "index"
        //        ]);
    }

    public function newAction($Module_ID)
    {
        $access = $this->checkAccess('add');

        $this->tag->setDefault("Module_ID", $Module_ID);
        $this->view->Module_ID = $Module_ID;
        $this->assets->addJs("js/customized_uploader.js");
        $this->view->settings = $this->contentSettings($Module_ID);
        $depts = \DataCmsDeptsRel::find(array("Module_ID=20002 Order BY Core_Depts_ID"))->toArray();
        $content = new Content();
        $depts_array = $content->deptsTree($depts);
        if ($this->request->getQuery('parent')) {
            $this->view->parent = $this->request->getQuery('parent');
            $data_cms_parent = Content::findFirst("ID={$this->request->getQuery('parent')}");
            $parent_name = $data_cms_parent->Title;
            $this->view->parent_name = $parent_name;
        } else {
            $this->view->parent = 0;
        }
        //        print_r($depts_array);
        //        die();
        //$module =  \UsersApplicationModule::findFirst(["ID={$Module_ID}"]);
        //$this->view->Module_Title = $module->Title;
        //$this->view->module= $module;
        $module_setting = \CpModulesSettings::findFirst(array("Module_ID={$Module_ID}"));
        if (!$module_setting) {
            $module_setting = new \CpModulesSettings();
            $module_setting->Module_ID = $Module_ID;
            $module_setting->save();
        }
        $this->view->module_setting = $module_setting;

        $get_module = \UsersApplicationModule::findFirst(["ID={$Module_ID}"]);
        $language = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$language}'"]);
        $lang_id = $lang->id;
        $module = [];

        $module['mod_id'] = $get_module->ID;
        $get_title = \UsersApplicationModuleLang::findFirst(["lang_id={$lang_id} and module_id={$get_module->ID}"]);
        if ($get_title) {
            $module['mod_title'] = $get_title->title;
        } else {
            $module['mod_title'] = $get_module->Title;
        }
        $module['mod_img'] = $get_module->Settings->Img;

        $this->view->module = $module;
        $zones_q = GeoRegions::find("application_id={$this->session->get('auth-identity')['Application_ID']}");
        foreach ($zones_q as $key => $value) {
            foreach ($value->getLangs(["lang_id={$lang_id}"]) as $value) {
                $zones[$value->region_id] = $value->name;
            };

        }

        $this->view->zones = $zones;
        $this->assets->addJs("js/keyvalue_validation.js");
        //New Language Settings
        //get other languages which are not default
        $application_languages = \ApplicationCmsLang::find(["application_id={$this->session->get('auth-identity')['Application_ID']} AND is_default=0"]);

        $this->view->app_langs = $application_languages;

        //language id for view language
        $lang_code = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$lang_code}'"]);
        $this->view->lang = $lang->id;

        //KeyValue
        $keyvalues = new Keyvalue();
        $this->view->keyvalues = $keyvalues->getKeyvalues($Module_ID, null, null, null, $lang->id);

        //Extra Fields
        $extra_fields = [];
        if ($Module_ID == 8) {
            $product_extra_fields = new ProductExtraFields();
            $extra_fields = $product_extra_fields->returnExtra();
        }
        $this->view->extra_fields = $extra_fields;


    }

    public function deleteAction($ID)
    {
        $content = Content::findFirstByID($ID);
        $this->checkAccess('delete', $content);
        if (!$content) {
            $this->flash->error("Content does not exist " . $ID);

            return $this->response->redirect($_SERVER['HTTP_REFERER']);
        }
        $content->delete();
        //Delete Langugaes
        $langs = \DataCmsLang::find("data_cms_id={$ID}");
        if (count($langs) != 0) {
            foreach ($langs as $lang) {
                $lang->delete();
            }
        }
        $relations = \DataCmsDeptsRelItem::find(["Item_ID = $ID"]);

        if (count($relations) > 0) {
            foreach ($relations as $relation) {
                $relation->delete();
            }
        }

        //Code To Delete Keyvalue
        $get_key_value = \DataKeyvalueUserdata::find(array("Item_ID = {$ID}"));
        if (count($get_key_value) > 0) {
            foreach ($get_key_value as $kv_data) {
                $kv_data->delete();
            }
        }
        ///
        if ($this->request->isAjax()) {
            return;
        }
        $this->flashSession->success("Content was deleted successfully");
        return $this->response->redirect($_SERVER['HTTP_REFERER']);

    }

    public function mainAction($Module_ID)
    {
        if (in_array($Module_ID, $this->getModules())) {
            $depts = \DataCmsDepts::find(["Module_ID = $Module_ID"]);
            $language = $this->session->get('auth-identity')['Lang'];
            $lang = \Languages::findFirst(["code='{$language}'"]);
            $lang_id = $lang->id;
            $departments = [];
            foreach ($depts as $dept) {
                $row['ID'] = $dept->ID;
                $row['Img'] = $dept->Img;
                $get_title = \DataCmsDeptsLang::findFirst(["core_dept_id={$dept->ID} AND lang_id={$lang_id}"]);
                $title = $get_title->title ?: $dept->Title;
                $row['Title'] = $title;
                $departments[] = $row;
            }
            $this->view->departments = $departments;
            $this->view->depts = $depts;
            $this->view->Module_ID = $Module_ID;
            $module_setting = \CpModulesSettings::findFirst(array("Module_ID={$Module_ID}"));
            if (!$module_setting) {
                $module_setting = new \CpModulesSettings();
                $module_setting->Module_ID = $Module_ID;
                $module_setting->save();
            }
            $this->view->module_setting = $module_setting;

            if (Content::findFirst(array("Module_ID ={$Module_ID}"))) {
                $this->view->Content_Found = 1;
            } else {
                $this->view->Content_Found = 0;
            }
            $get_module = \UsersApplicationModule::findFirst(["ID={$Module_ID}"]);
            $language = $this->session->get('auth-identity')['Lang'];
            $lang = \Languages::findFirst(["code='{$language}'"]);
            $lang_id = $lang->id;
            $module = [];

            $module['mod_id'] = $module->ID;
            $get_title = \UsersApplicationModuleLang::findFirst(["lang_id={$lang_id} and module_id={$get_module->ID}"]);
            if ($get_title) {
                $module['mod_title'] = $get_title->title;
            } else {
                $module['mod_title'] = $get_module->Title;
            }
            $module['mod_img'] = $get_module->Settings->Img;

            $this->view->module = $module;

        } else {
            die("Not Allowed");
        }
        //get some translations
        $this->view->trans_Content = $this->getAdvancedTranslation($Module_ID, "Content");
        $this->view->trans_Content_Stat = $this->getAdvancedTranslation($Module_ID, "Content Statistics");

        //content_settings
        $content_settings = \CpModuleContentSetting::findFirst(["Module_ID={$Module_ID}"]);
        $this->view->content_settings = $content_settings;
    }

    public function mediaMultiUploadAction()
    {

        if ($this->request->hasFiles() == true) {
            $files = array();
            foreach ($this->request->getUploadedFiles() as $file) {
                $random = new Random();
                $random_name = $random->uuid() . "." . $file->getExtension();
                if ($file->getName() != "") {
                    $files[] = $random_name;
                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                }

            }

            return json_encode($files);

        }
    }

    public function mediaDelUploadAction()
    {
        if ($this->request->isPost()) {
            //die(var_dump($_POST));
            $ID = $this->request->getPost("file");
            $media = \DataCmsMedia::find(["ID =$ID",]);

            if ($media->delete()) {
                return json_encode("True");
            } else {
                return json_encode("false");
            }

        }

    }

    public function statisticsAction($Module_ID)
    {

        $this->view->content_active = count(Content::find(array("Application_ID={$this->session->get('auth-identity')['Application_ID']} AND Module_ID={$Module_ID} AND Active = 1")));
        $this->view->content_nonActive = count(Content::find(array("Application_ID={$this->session->get('auth-identity')['Application_ID']} AND Module_ID={$Module_ID} AND Active != 1")));
        $depts = \DataCmsDeptsRel::find(array("Application_ID={$this->session->get('auth-identity')['Application_ID']} AND Module_ID={$Module_ID}"));
        $data = array();
        $depts_active = array();
        foreach ($depts as $dept) {
            $items = \DataCmsDeptsRelItem::find(array("Depts_ID = {$dept->ID} AND Application_ID={$this->session->get('auth-identity')['Application_ID']} AND Module_ID={$Module_ID}"));

            foreach ($items as $item) {
                $dept_lang = $dept->getDeptRelLang(["lang_id={$this->session->get('auth-identity')['Lang_ID']}"]);
                if ($dept_lang) {
                    $data[$dept_lang->title][] = $item->Item_ID;
                    $data[$dept_lang->title]['Dept_ID'] = $dept->ID;
                } else {
                    $data[$dept->Title][] = $item->Item_ID;
                    $data[$dept->Title]['Dept_ID'] = $dept->ID;
                }


            }


        }
        //die(var_dump($data));
        $this->view->depts_stats = $data;
        $this->view->Module_ID = $Module_ID;

    }

    public function filterStatAction($Module_ID)
    {

        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'Content', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters["order"] = "ID DESC";
        $content = Content::find(array("Module_ID={$Module_ID}", "order" => "ID Desc"));

        if (count($content) == 0) {

        }

        //toggle
        $grid = \CpModulesSettings::findFirst(array("Module_ID ={$Module_ID}"));
        if (count($grid) == 0) {
            $this->view->Toggle_Grid = 0;
        } else {
            $this->view->Toggle_Grid = $grid->Toggle_Grid;
        }
        $paginator = new Paginator(['data' => $content, 'limit' => 8, 'page' => $numberPage]);

        $this->view->page = $paginator->getPaginate();
        $this->view->base_uri = $this->config->application->baseUri;
        $get_main_depts = \DataCmsDepts::find(["Module_ID=" . $Module_ID,]);
        $main_depts = array();
        foreach ($get_main_depts as $main_dept) {
            $main_depts[] = $main_dept;
        }
        $this->view->main_depts = $get_main_depts;
        $this->view->Module_ID = $Module_ID;

    }

    public function filterByDeptAction($Dept_ID)
    {
        $depts = \DataCmsDeptsRelItem::find(array("Depts_ID={$Dept_ID}"));
        $module_id = $depts[0]->Module_ID;
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            $query = Criteria::fromInput($this->di, 'DataCmsDeptsRelItem', $_POST);
            $this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }

        $parameters["order"] = "ID DESC";
        $content = \DataCmsDeptsRelItem::find(array("Depts_ID={$Dept_ID} Order BY Item_ID DESC"));
        //die(count($content));

        if (count($content) == 0) {

        }

        //toggle

        $this->view->Toggle_Grid = 0;

        $paginator = new Paginator(['data' => $content, 'limit' => 8, 'page' => $numberPage]);

        $this->view->page = $paginator->getPaginate();
        $this->view->base_uri = $this->config->application->baseUri;
        $this->view->Module_ID = $module_id;
        $this->view->Dept_ID = $Dept_ID;
        ///////


        //Settings Part For View///
        $Application = $this->session->get('auth-identity')['Application_ID'];
        //list_settings
        $list_settings = \DataCmsListSettings::findFirst(array("Module_ID={$module_id}"));
        if (!$list_settings) {
            unset($list_settings);
            $list_settings = new \DataCmsListSettings();
            $list_settings->Module_ID = $module_id;
            $list_settings->Application_ID = $this->session->get('auth-identity')['Application_ID'];
            $list_settings->save();
            unset($list_settings);
            $list_settings = \DataCmsListSettings::findFirst(array("Module_ID={$module_id}"));
            $this->view->list_settings = $list_settings;
        } else {
            $this->view->list_settings = $list_settings;
        }
        //Content Settings
        $content_settings = \CpModuleContentSetting::findFirst(["Module_ID={$module_id}"]);
        $this->view->content_settings = $content_settings;

        $dkvs = \DataKeyvalue::find(array("Module_ID={$module_id} AND Show=1"));
        $this->view->dkvs = $dkvs;

        $this->view->langs = $Application->Langs;

        //for langs
        $language = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$language}'"]);
        if ($lang) {
            $this->view->lang_id = $lang->id;
        } else {
            $this->view->lang_id = 1;
        }
        $lang_id = $lang->id;
        $module = [];

        $module['mod_id'] = $module_id;
        $get_title = \UsersApplicationModuleLang::findFirst(["lang_id={$lang_id} and module_id={$module_id}"]);
        $get_module = \UsersApplicationModule::findFirst(["ID={$module_id}"]);
        if ($get_title) {
            $module['mod_title'] = $get_title->title;
        } else {
            $module['mod_title'] = $get_module->Title;
        }
        $module['mod_img'] = $get_module->Settings->Img;

        $this->view->module = $module;

    }

    public function toggleDisplayAction($ModuleID)
    {

        $settings = \CpModulesSettings::findFirstByModule_ID($ModuleID);
        if (!$settings) {
            $create_settings = new \CpModulesSettings();
            $create_settings->Module_ID = $ModuleID;
            $create_settings->Toggle_Grid = $this->request->getQuery("Toggle_Grid");
            $create_settings->save();
            $this->dispatcher->forward(['controller' => "content", 'action' => 'index', 'params' => array($ModuleID)]);
            return;

        }
        $settings->Toggle_Grid = $this->request->getQuery("Toggle_Grid");
        if ($settings->save()) {
            $this->dispatcher->forward(['controller' => "content", 'action' => 'index', 'params' => array($ModuleID)]);
            return;
        }

    }

    public function ajaxDeleteAction()
    {
        if ($this->request->isAjax()) {
            //die(var_dump($_POST['deleteCheckbox']));
            if (isset($_POST['checkboxes'])) {
                foreach ($this->request->getPost("checkboxes") as $ID) {
                    $this->deleteAction($ID);
                }
                return "1";
            } else {
                return "0";
            }

        }

    }

    public function advancedSearchAction($Module_ID)
    {

        $user_id = $this->session->get('auth-identity')['id'];

        $this->view->saved_filters = DataCmsSavedFilter::get($user_id, $Module_ID);

        $Application = \UsersApplication::findFirst(["ID= {$this->session->get('auth-identity')['Application_ID']}"]);
        $this->view->langs = $Application->Langs;

        $this->view->Module_ID = $Module_ID;

        //for langs
        $language = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$language}'"]);
        if ($lang) {
            $this->view->lang_id = $lang->id;
        } else {
            $this->view->lang_id = 1;
        }
        $big_array = array();
        $groups = \DataKeyvalueGroup::find(array("Module_ID={$Module_ID} AND Is_Dept=0 AND Core='no'"));
        foreach ($groups as $group) {
            //echo $group->GroupLang->Title."<br>";
            $dkvs = \DataKeyvalue::find(array("Group_ID={$group->ID}"));
            foreach ($dkvs as $dkv) {
                if ($dkv->CoreKeyvalueType->ID == 4 || $dkv->CoreKeyvalueType->ID == 7) {
                    continue;
                };
                $ad_kv = new Keyvalue();
                $big_array[] = array("GroupName" => "{$group->GroupLang->Title}", "KeyValueTitle" => $dkv->DataKeyvalueLang->Title, "ControlValue" => $ad_kv->keyvalueAddTags($dkv->CoreKeyvalueType->ID, "", $dkv->ID), "Title" => $this->tag->textField(["KVAdd{$dkv->ID}Title", "type" => "text", "class" => "form-control", "id" => "fieldKVTitle"]), "Des" => $this->tag->textField(["KVAdd{$dkv->ID}Des", "type" => "text", "class" => "form-control", "id" => "fieldKVDes"]),
                    //"Img" => $this->tag->fileField(["KVAdd{$dkv->ID}Img", "type" => "text", "class" => "form-control", "id" => "fieldKVImg"]),
                    "Add" => "1", "KV_ID" => $dkv->ID);
                unset($ad_kv);
            }
        }

        $this->view->keyValueData = $big_array;
        $this->view->Module_ID = $Module_ID;
    }

    public function advancedPostAction()
    {
        $lang = $this->request->getPost('lang');
        if ($lang) {
            $this->view->lang_id = $lang;
        } else {
            $this->view->lang_id = 1;
        }
        if ($lang == 0) {
            $Content = $this->request->getPost("Content");
            $Title = $this->request->getPost("Title");
            $Module_ID = $this->request->getPost("Module_ID");
            $content = $this->modelsManager->createBuilder()->from("Models\Content")->innerJoin("DataCmsDeptsRelItem")->andwhere("Models\Content.Title like '%{$Title}%'")->andWhere("Models\Content.Content like '%{$Content}%'")->andWhere("Models\Content.Module_ID like '%{$Module_ID}%'");

            if ($this->request->getPost('date_from') !== "" && $this->request->getPost('date_to') !== "") {
                $date_from = strtotime($this->request->getPost('date_from'));
                $date_to = strtotime($this->request->getPost('date_to'));
                $content->betweenWhere("Models\Content.DateTime", $date_from, $date_to);
            }

            if (isset($_POST['Depts_ID']) && count($_POST['Depts_ID']) > 0) {
                $Depts = $this->request->getPost("Depts_ID");
                $Depts_IDs = join("','", $_POST['Depts_ID']);
                $content->inWhere("DataCmsDeptsRelItem.Depts_ID", [$Depts_IDs]);
            }
            $content->groupBy(array('Models\Content.ID'));

            $result = $content->getQuery()->execute();

            $this->view->Module_ID = $Module_ID;
            $this->view->items = $result;
            $this->view->lang_id = $lang;
        } else {
            $Content = $this->request->getPost("Content");
            $Title = $this->request->getPost("Title");
            $Module_ID = $this->request->getPost("Module_ID");
            $content = $this->modelsManager->createBuilder()->from("DataCmsLang")->join("Models\Content")->andwhere("DataCmsLang.title like '%{$Title}%'")->andWhere("DataCmsLang.content like '%{$Content}%'")->andWhere("DataCmsLang.lang_id ={$lang}")->andWhere("Models\Content.Module_ID like '%{$Module_ID}%'");

            if ($this->request->getPost('date_from') !== "" && $this->request->getPost('date_to') !== "") {
                $date_from = strtotime($this->request->getPost('date_from'));
                $date_to = strtotime($this->request->getPost('date_to'));
                $content->betweenWhere("Models\Content.DateTime", $date_from, $date_to);
            }

            if (isset($_POST['Depts_ID']) && count($_POST['Depts_ID']) > 0) {
                $Depts = $this->request->getPost("Depts_ID");
                $Depts_IDs = join("','", $_POST['Depts_ID']);
                $content->inWhere("DataCmsDeptsRelItem.Depts_ID", [$Depts_IDs]);
            }
            $content->groupBy(array('Models\Content.ID'));

            $result = $content->getQuery()->execute();

            $this->view->Module_ID = $Module_ID;
            $this->view->items = $result;
            $this->view->lang_id = $lang;
        }

    }

    public function ajaxContentAction($Module_ID)
    {
        if ($this->request->isAjax()) {
            $array = $this->modelsManager->createQuery("SELECT * FROM Models\Content WHERE Module_ID = $Module_ID")->execute()->toArray();
            foreach ($array as $k => $v) {
                $array[$k]["Date"] = date('m/d/Y', $v["DateTime"]);
                $array[$k]["Time"] = date('H:i:s', $v["DateTime"]);
            }
            $dataTables = new DataTable();
            // die(print_R( $array ));
            $dataTables->fromArray($array)->sendResponse();
        }

    }

    public function ajaxActiveAction()
    {
        if ($this->request->isAjax()) {
            if (isset($_POST['checkboxes'])) {
                foreach ($this->request->getPost("checkboxes") as $ID) {
                    $content = Content::findFirst(array("ID={$ID}"));
                    $content->Active = 1;
                    $content->save();
                }
                return "1";
            } else {
                return "0";
            }

        }

    }

    public function ajaxDeactiveAction()
    {
        if ($this->request->isAjax()) {
            if (isset($_POST['checkboxes'])) {
                foreach ($this->request->getPost("checkboxes") as $ID) {
                    $content = Content::findFirst(array("ID={$ID}"));
                    $content->Active = 0;
                    $content->save();
                }
                return "1";
            } else {
                return "0";
            }

        }

    }

    public function filterContentAction()
    {
        //if this is a new filter
        if ($this->request->get('is_first') == 0) {
            $lang = $this->request->getPost('lang');
            // check language
            if ($lang) {
                $this->view->lang_id = $lang;
            } else {
                $this->view->lang_id = 0;
            }
            //save search paramters in the database
            $filter_param = new DataCmsFilterSearch();
            $filter_param->content = $this->request->getPost("Content");
            $filter_param->title = $this->request->getPost("Title");
            if (isset($_POST['Depts_ID']) && count($_POST['Depts_ID']) > 0) {
                $filter_param->depts = join("','", $_POST['Depts_ID']);
            } else {
                $filter_param->depts = 0;
            }

            $filter_param->date_from = $this->request->getPost('date_from');
            $filter_param->date_to = $this->request->getPost('date_to');
            $filter_param->lang_id = $lang;
            $filter_param->user_id = $this->session->get('auth-identity')['id'];
            $filter_param->application_id = $this->session->get('auth-identity')['Application_ID'];
            $filter_param->module_id = $this->request->getPost("Module_ID");
            $filter_param->active = $this->request->getPost("Active");
            if (!$filter_param->save()) {
                die(print_r($filter_param->getMessages()));
            };

            //if langugae is default
            if ($lang == 0) {
                $content = $this->request->getPost("Content");
                $title = $this->request->getPost("Title");
                $module_id = $this->request->getPost("Module_ID");
                $date_from = "";
                $date_to = "";
                $depts = 0;
                if ($filter_param->depts !== 0) {
                    $depts = $filter_param->depts;
                }
                if ($this->request->getPost('date_from') != "") {
                    $date_from = strtotime($this->request->getPost('date_from'));
                }
                if ($this->request->getPost('date_to') != "") {
                    $date_to = strtotime($this->request->getPost('date_from'));
                }
                $currentPage = 1;
                if (isset($_GET["page"])) {
                    $currentPage = (int)$_GET["page"];
                }


// The data set to paginate
                $result = $this->filterContentLang($date_from, $date_to, $depts, $filter_param->user_id, $lang, $filter_param->application_id, $module_id, $content, $title, $filter_param->active);


// Create a Model paginator, show 10 rows by page starting from $currentPage
                $paginator = new Paginator(
                    [
                        "data" => $result,
                        "limit" => 20,
                        "page" => $currentPage,
                    ]
                );

// Get the paginated results
                $page = $paginator->getPaginate();

                $this->view->Module_ID = $module_id;
                $this->view->items = $page;
                $this->view->lang_id = $lang;
                $this->view->is_first = $filter_param->id;
            } //if (lang is not the default)
            else {
                $date_from = "";
                $date_to = "";
                $depts = 0;
                if ($filter_param->depts !== 0) {
                    $depts = $filter_param->depts;
                }
                if ($this->request->getPost('date_from') != "") {
                    $date_from = strtotime($this->request->getPost('date_from'));
                }
                if ($this->request->getPost('date_to') != "") {
                    $date_to = strtotime($this->request->getPost('date_from'));
                }
                $result = $this->filterContentLang($date_from, $date_to, $depts, $filter_param->user_id, $filter_param->lang_id, $filter_param->application_id, $filter_param->module_id, $filter_param->content, $filter_param->title, $filter_param->active);

                if (isset($_GET["page"])) {
                    $currentPage = (int)$_GET["page"];
                }


// Create a Model paginator, show 10 rows by page starting from $currentPage
                $paginator = new Paginator(
                    [
                        "data" => $result,
                        "limit" => 10,
                        "page" => $currentPage,
                    ]
                );

// Get the paginated results
                $page = $paginator->getPaginate();

                $this->view->Module_ID = $filter_param->module_id;
                $this->view->items = $page;
                $this->view->lang_id = $lang;
                $this->view->is_first = $filter_param->id;

            }
        } else {
            $filter_id = $this->request->get("is_first");
            $filter_param = DataCmsFilterSearch::findFirst(["id={$filter_id}"]);
            $lang = $filter_param->lang_id;
            if ($lang == 0) {
                $Content = $filter_param->content;
                $Title = $filter_param->title;
                $Module_ID = $filter_param->module_id;
                $date_from = "";
                $date_to = "";
                $depts = 0;
                if ($filter_param->date_from !== "" && $filter_param->date_to !== "") {
                    $date_from = strtotime($filter_param->date_from);
                    $date_to = strtotime($filter_param->date_to);
                }
                //retreive depts
                if ($filter_param->depts != 0) {
                    $depts_array = explode(",", $filter_param->depts);
                    if (count($depts_array) > 0) {
                        $Depts_IDs = $filter_param->depts;
                    }
                }

                $currentPage = 1;
                if (isset($_GET["page"])) {
                    $currentPage = (int)$_GET["page"];
                }


// The data set to paginate
                $result = $this->filterContentLang($date_from, $date_to, $depts, $filter_param->user_id, $lang, $filter_param->application_id, $Module_ID, $Content, $Title, $filter_param->active);


// Create a Model paginator, show 10 rows by page starting from $currentPage
                $paginator = new Paginator(
                    [
                        "data" => $result,
                        "limit" => 10,
                        "page" => $currentPage,
                    ]
                );

// Get the paginated results
                $page = $paginator->getPaginate();

                $this->view->Module_ID = $Module_ID;
                $this->view->items = $page;
                $this->view->lang_id = $lang;
                $this->view->is_first = $filter_param->id;
            } else {
                $Content = $filter_param->content;
                $Title = $filter_param->title;
                $Module_ID = $filter_param->module_id;
                $date_from = "";
                $date_to = "";
                $depts = 0;
                if ($filter_param->date_from !== "" && $filter_param->date_to !== "") {
                    $date_from = strtotime($filter_param->date_from);
                    $date_to = strtotime($filter_param->date_to);
                }
                //retreive depts
                if ($filter_param->depts != 0) {
                    $depts_array = explode(",", $filter_param->depts);
                    if (count($depts_array) > 0) {
                        $Depts_IDs = $filter_param->depts;
                    }
                }

                $currentPage = 1;
                if (isset($_GET["page"])) {
                    $currentPage = (int)$_GET["page"];
                }


// The data set to paginate
                $result = $this->filterContentLang($date_from, $date_to, $depts, $filter_param->user_id, $lang, $filter_param->application_id, $Module_ID, $Content, $Title, $filter_param->active);


// Create a Model paginator, show 10 rows by page starting from $currentPage
                $paginator = new Paginator(
                    [
                        "data" => $result,
                        "limit" => 10,
                        "page" => $currentPage,
                    ]
                );

// Get the paginated results
                $page = $paginator->getPaginate();

                $this->view->Module_ID = $Module_ID;
                $this->view->items = $page;
                $this->view->lang_id = $lang;
                $this->view->is_first = $filter_param->id;
            }

        }

    }

    public function testSearchAction()
    {
        $this->view->disable();
        //$filter = json_decode(file_get_contents("php://input"),true);
        $this->response->setContentType('application/json', 'UTF-8');
        //echo json_encode($this->ApiFactory->getDataCmsKeyValues(387));
        echo json_encode($this->CmsSearch->search());
        // echo json_encode($this->CmsSearch->searchInAction('allCmsFollowed'));

        //echo json_encode($this->CmsSearch->switchSearchAction('content_search',$search_param));
    }

    public function searchAction()
    {
        if (!$this->request->get('Module_ID')) {
            $this->flashSession->error("Please Renter Your Search Criteria");
            return $this->response->redirect("users_application_module");
        }
        $module_id = $this->request->get('Module_ID');
        $module_setting = \CpModulesSettings::findFirst(array("Module_ID={$module_id}"));
        if (!$module_setting) {
            $module_setting = new \CpModulesSettings();
            $module_setting->Module_ID = $module_id;
            $module_setting->save();
        }
        $this->view->module_setting = $module_setting;
        $Application = \UsersApplication::findFirst(["ID={$this->session->get('auth-identity')['Application_ID']}"]);
        $this->view->Module_ID = $module_id;
        $content = $this->request->getPost('Content');
        $title = $this->request->getPost('Title');
        $filter = [
            "application_id" => $this->session->get('auth-identity')['Application_ID'],
            "module_id" => $module_id,
            "action" => "content_search",
            "name" => $title,
//            "pagination"=>[
//                "page"=>1,
//                "num_rec"=>5
//            ]
        ];
        if (isset($_POST['Depts_ID']) && count($_POST['Depts_ID']) > 0) {
            foreach ($_POST['Depts_ID'] as $dept) {
                $filter['departments'][] = $dept;
            }
        }
        if ($this->request->getPost('date_from') != "" && $this->request->getPost('date_to') != "") {
            $filter['date_from'] = $this->request->getPost('date_from');
            $filter['date_to'] = $this->request->getPost('date_to');
        }
        if (isset($_POST['kvAddIDs'])) {
            foreach ($_POST['kvAddIDs'] as $dkv_id) {
                if ($this->request->getPost("keyvalueAdd{$dkv_id}") != "") {
                    $filter['more'][] = [
                        "value" => "{$this->request->getPost("keyvalueAdd{$dkv_id}")}",
                        "dkv_id" => $dkv_id
                    ];
                }

            }
        }
        if (isset($_REQUEST['Active'])) {
            $filter['active'] = $_REQUEST['Active'];
        }


//        print_r($filter);
//        die();
        //$this->response->setContentType('application/json', 'UTF-8');
        $this->view->items = $this->CmsSearch->switchSearchAction('content_search', $filter);

        //Settings Part For View///

        //list_settings
        $list_settings = \DataCmsListSettings::findFirst(array("Module_ID={$module_id}"));
        if (!$list_settings) {
            unset($list_settings);
            $list_settings = new \DataCmsListSettings();
            $list_settings->Module_ID = $module_id;
            $list_settings->Application_ID = $this->session->get('auth-identity')['Application_ID'];
            $list_settings->save();
            unset($list_settings);
            $list_settings = \DataCmsListSettings::findFirst(array("Module_ID={$module_id}"));
            $this->view->list_settings = $list_settings;
        } else {
            $this->view->list_settings = $list_settings;
        }
        //Content Settings
        $content_settings = \CpModuleContentSetting::findFirst(["Module_ID={$module_id}"]);
        $this->view->content_settings = $content_settings;

        $dkvs = \DataKeyvalue::find(array("Module_ID={$module_id} AND Show=1"));
        $this->view->dkvs = $dkvs;

        $this->view->langs = $Application->Langs;

        //for langs
        $language = $this->session->get('auth-identity')['Lang'];
        $lang = \Languages::findFirst(["code='{$language}'"]);
        if ($lang) {
            $this->view->lang_id = $lang->id;
        } else {
            $this->view->lang_id = 1;
        }
        $lang_id = $lang->id;
        $module = [];

        $module['mod_id'] = $module_id;
        $get_title = \UsersApplicationModuleLang::findFirst(["lang_id={$lang_id} and module_id={$module_id}"]);
        $get_module = \UsersApplicationModule::findFirst(["ID={$module_id}"]);
        if ($get_title) {
            $module['mod_title'] = $get_title->title;
        } else {
            $module['mod_title'] = $get_module->Title;
        }
        $module['mod_img'] = $get_module->Settings->Img;

        $this->view->module = $module;

    }

    //Get Fields On/Off Values And Content Settings
    protected function contentSettings($ModuleID)
    {
        $module_settings = \CpModuleContentSetting::findFirst(array("Module_ID={$ModuleID} AND Application_ID={$this->session->get('auth-identity')['Application_ID']}"));
        return $module_settings;
    }

    //For Test Purpose ADD Dummy Content
    public function addbulkAction()
    {
        for ($i = 0; $i <= 30; $i++) {
            $content = new Content();
            if ($this->request->hasFiles() == true) {
                foreach ($this->request->getUploadedFiles() as $file) {
                    if ($file->getKey() == "Img") {
                        //die("Islam");
                        $random = new Random();
                        $random_name = $random->uuid() . "." . $file->getExtension();

                        $file->moveTo(static::UPLOAD_LOCATION . $random_name);
                        $content->Img = $random_name;

                    }
                }

            }

            $content->Title = $this->request->getPost("Title");
            $content->Des = $this->request->getPost("Des");
            $content->Content = $this->request->getPost("Content");
            $content->Order = $this->request->getPost("Order");
            if (isset($_POST['DateTime'])) {
                $content->DateTime = $this->request->getPost("DateTime");
            } else {
                $content->DateTime = time();
            }
            $content->Active = $this->request->getPost("Active");
            $content->Application_ID = $this->session->get('auth-identity')['Application_ID'];
            $content->Visit_Num = 0;
            $content->Module_ID = $this->request->getPost("Module_ID");
            $content->Lang_ID = 1;
            $content->Key_1 = 0;
            $content->Key_2 = 0;
            $content->Key_3 = 0;
            $content->Key_4 = 0;
            $content->Key_5 = 0;

            $content->save();

            //        if (!$content->save()) {
            //
            //            foreach ($content->getMessages() as $message) {
            //                $this->flash->error($message);
            //            }
            //
            //            $this->dispatcher->forward([
            //                'controller' => "content",
            //                'action' => 'edit',
            //                'params' => [$content->ID]
            //            ]);
            //
            //            return;
            //        }
            // Store Departments
            if (isset($_POST["Depts_ID"])) {

                $depts = $this->request->getPost("Depts_ID");
                foreach ($depts as $dept) {
                    $dept_rel = new \DataCmsDeptsRelItem();
                    $dept_rel->Item_ID = $content->ID;
                    $dept_rel->Depts_ID = $dept;
                    $dept_rel->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                    $dept_rel->Module_ID = $content->Module_ID;
                    $dept_rel->save();
                    unset($dept_rel);

                }
            }
            // Store Media (Pictures)
            if (isset($_POST['mediaImages'])) {
                foreach ($this->request->getPost("mediaImages") as $img) {
                    $media = new \DataCmsMedia();
                    $media->Type = 'Img';
                    $media->Item_ID = $content->ID;
                    $media->Module_ID = $content->Module_ID;
                    $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                    $media->Img = $img;
                    $media->Link = " ";
                    $media->save();
                    unset($media);

                }
            }
            // Store Media (Videos)
            if (isset($_POST['mediaVideos'])) {
                foreach ($this->request->getPost("mediaVideos") as $link) {
                    $media = new \DataCmsMedia();
                    $media->Type = 'Video';
                    $media->Item_ID = $content->ID;
                    $media->Module_ID = $content->Module_ID;
                    $media->Application_ID = $this->session->get('auth-identity')['Application_ID'];
                    $media->Img = " ";
                    $media->Link = $link;
                    $media->save();
                    unset($media);

                }
            }

            $keyvalue = new Keyvalue();
            $keyvalue->saveKeyvalue($content->ID);
            unset($content);
            unset($keyvalue);
        }
    }

    public function viewRelatedContentAction()
    {
        $parent_id = $this->request->getQuery("parent");
        $Module_ID = $this->request->getQuery("child_module");
        $this->view->parent_id = $parent_id;
        $this->persistent->parameters = null;
        $numberPage = 1;
        if ($this->request->isPost()) {
            //$query = Criteria::fromInput($this->di, 'Content', $_POST);
            //$this->persistent->parameters = $query->getParams();
        } else {
            $numberPage = $this->request->getQuery("page", "int");
        }
        $content = \DataModuleRelationsCms::find(array("parent_cms_id={$parent_id} "));

        if (count($content) == 0) {

        }

        //toggle
        $grid = \CpModulesSettings::findFirst(array("Module_ID ={$Module_ID}"));
        if (count($grid) == 0) {
            $this->view->Toggle_Grid = 0;
        } else {
            $this->view->Toggle_Grid = $grid->Toggle_Grid;
        }

        $paginator = new Paginator(['data' => $content, 'limit' => 2000, 'page' => $numberPage]);

        $this->view->page = $paginator->getPaginate();
        $this->view->base_uri = $this->config->application->baseUri;
        $get_main_depts = \DataCmsDepts::find(["Module_ID=" . $Module_ID,]);
        $main_depts = array();
        foreach ($get_main_depts as $main_dept) {
            $main_depts[] = $main_dept;
        }
        $this->view->main_depts = $get_main_depts;
        $this->view->Module_ID = $Module_ID;

        //list_settings
        $list_settings = \DataCmsListSettings::findFirst(array("Module_ID={$Module_ID}"));
        if (!$list_settings) {
            unset($list_settings);
            $list_settings = new \DataCmsListSettings();
            $list_settings->Module_ID = $Module_ID;
            $list_settings->Application_ID = $this->session->get('auth-identity')['Application_ID'];
            $list_settings->save();
            unset($list_settings);
            $list_settings = \DataCmsListSettings::findFirst(array("Module_ID={$Module_ID}"));
            $this->view->list_settings = $list_settings;
        } else {
            $this->view->list_settings = $list_settings;
        }

        $dkvs = \DataKeyvalue::find(array("Module_ID={$Module_ID} AND Show=1"));
        $this->view->dkvs = $dkvs;

        $relation = \DataModuleRelations::findFirst(["model_two={$Module_ID}"]);
        $parent_module = \UsersApplicationModule::findFirst(["ID={$relation->module_one}"]);
        $this->view->parent_module = $parent_module;
    }

    public function getKeyValueGroupLang(\DataKeyvalueGroup $group)
    {
        $Application = \UsersApplication::findFirst(["ID={$this->session->get('auth-identity')['Application_ID']}"]);
        if (count($Application->Langs) == 0) {
            return $group->GroupLang->Title;
        } else {


            $lang_id = $this->session->get('auth-identity')['Lang_ID'];
            $group_lang = DataKeyvalueGroupLang::findFirst(["Group_ID={$group->ID} AND Lang_ID={$lang_id}"]);
            if (!$group_lang) {
                return $group->GroupLang->Title;
            }
            return $group_lang->Title;

        }

    }

    public function getKeyValueLang(\DataKeyvalue $kv)
    {
        $Application = \UsersApplication::findFirst(["ID={$this->session->get('auth-identity')['Application_ID']}"]);
        if (count($Application->Langs) == 0) {
            return $kv->DataKeyvalueLang->Title;

        } else {
            // //for edit section
            // if (isset($_GET['lang_id'])) {
            // $lang_id = $_GET['lang_id'];
            // $kv_lang = \DataKeyvalueLang::findFirst(["DKV_ID={$kv->ID} AND Lang_ID={$lang_id}"]);
            // if (!$kv_lang) {
            // return $kv->DataKeyvalueLang->Title;
            // }
            // return $kv_lang->Title;
//
            // } else {
            // $app_def_lang = \ApplicationCmsLang::findFirst(["is_default=1 and application_id={$this->session->get('auth-identity')['Application_ID']}"]);
            // if($app_def_lang){
            // $kv_lang_title = $kv->getDataKeyvalueLang(["Lang_ID={$app_def_lang->lang_id}"]);
            // if($kv_lang_title){
            // return $kv_lang_title->Title;
            // }else{
            // return $kv->DataKeyvalueLang->Title;
            // }
            // }
            // return $kv->DataKeyvalueLang->Title;
            // }
        }
        // for view in add

        $lang_id = $this->session->get('auth-identity')['Lang_ID'];

        $kv_lang = \DataKeyvalueLang::findFirst(["DKV_ID={$kv->ID} AND Lang_ID={$lang_id}"]);
        if (!$kv_lang) {
            return $kv->DataKeyvalueLang->Title;
        }
        return $kv_lang->Title;


        $app_def_lang = \ApplicationCmsLang::findFirst(["is_default=1 and application_id={$this->session->get('auth-identity')['Application_ID']}"]);
        if ($app_def_lang) {
            $kv_lang_title = $kv->getDataKeyvalueLang(["Lang_ID={$app_def_lang->lang_id}"]);
            if ($kv_lang_title) {
                return $kv_lang_title->Title;
            } else {
                return $kv->DataKeyvalueLang->Title;
            }
        }
        return $kv->DataKeyvalueLang->Title;


    }

    public function filterContentLang($date_from, $date_to, $depts, $user_id, $lang_id, $app_id, $module_id, $content, $title, $active)
    {
        if ($lang_id == 0) {

            $content_search = $this->modelsManager->createBuilder()->from("Models\Content")
                ->innerJoin("DataCmsDeptsRelItem")
                ->andWhere("Models\Content.Title like '%{$title}%'")
                ->andWhere("Models\Content.Content like '%{$content}%'")
                ->andWhere("Models\Content.Module_ID like '%{$module_id}%'")
                ->andWhere("Models\Content.Application_ID like '%{$app_id}%'");
            if ($date_from !== "" && $date_to !== "") {
                $date_from = strtotime($date_from);
                $date_to = strtotime($date_to);
                $content_search->betweenWhere("Models\Content.DateTime", $date_from, $date_to);
            }
            if ($depts != 0) {
                $content_search->inWhere("DataCmsDeptsRelItem.Depts_ID", [$depts]);
            }
            $content_search->andWhere("Models\Content.Active={$active}");
            $content_search->groupBy(array('Models\Content.ID'));
        } else {

            $content_search = $this->modelsManager->createBuilder()
                ->from("DataCmsLang")
                ->join("Models\Content")
                ->andWhere("DataCmsLang.title like '%{$title}%'")
                ->andWhere("DataCmsLang.content like '%{$content}%'")
                ->andWhere("DataCmsLang.lang_id ={$lang_id}")
                ->andWhere("Models\Content.Module_ID like '%{$module_id}%'");

            if ($date_from != "" && $date_to != "") {
                $date_from = strtotime($date_from);
                $date_to = strtotime($date_to);
                $content_search->betweenWhere("Models\Content.DateTime", $date_from, $date_to);
            }
            if ($depts != 0) {
                //$content_search->inWhere("DataCmsDeptsRelItem.Depts_ID", [$depts]);
            }
            $content_search->andWhere("Models\Content.Active=$active");
            $content_search->groupBy(array('Models\Content.ID'));
        };
        $result = $content_search->getQuery()->execute();
        //var_dump($result);exit;
        return $result;

    }

    public function checkAccess($action, $content = NULL)
    {
        $user_id = $this->session->get('auth-identity')['id'];
        $is_admin = $this->session->get('auth-identity')['is_admin'];
        $rules = $this->session->get('auth-identity')['rules'];
        if ($is_admin) {
            return true;
        }
        $check_access = false;
        if ($action == 'add') {
            $permissions = ['sub_admin', 'data_entry', 'sales'];
            $intersection = array_intersect($permissions, $rules);

            if (!empty($intersection)) {
                $check_access = true;
            }
        } else if ($action == 'edit') {
            if (in_array('sales', $rules) || in_array('client', $rules)) {
                if ($content->User_ID == $user_id) {
                    $check_access = true;
                }
            } else {
                $permissions = ['sub_admin', 'data_entry'];
                $intersection = array_intersect($permissions, $rules);
                if (!empty($intersection)) {
                    $check_access = true;
                }
            }
        } else if ($action == 'delete') {
            if (in_array('sales', $rules) || in_array('client', $rules)) {
                if ($content->User_ID == $user_id) {
                    $check_access = true;
                }
            } else {
                $permissions = ['sub_admin', 'data_entry'];
                $intersection = array_intersect($permissions, $rules);
                if (!empty($intersection)) {
                    $check_access = true;
                }
            }
        } else if ($action == 'index') {
            if (in_array('sales', $rules) || in_array('client', $rules)) {
                //if($content->User_ID == $user_id) {
                $check_access = 'only';
                // }
            } else {
                $permissions = ['sub_admin', 'data_entry'];
                $intersection = array_intersect($permissions, $rules);
                if (!empty($intersection)) {
                    $check_access = true;
                }
            }
        }
        if ($check_access == false) {
            return $this->response->redirect("index/noaccess");
        }
        return $check_access;
    }

    public function saveFilterAction()
    {
        $response['status'] = 1;
        $response['messages'] = [];

        $filter_json = $this->request->getPost('json_filter');
        $filter_encoded = json_encode($filter_json);
        $filter_decoded = \GuzzleHttp\json_decode($filter_encoded);

        $filter = new DataCmsSavedFilter();

        $filter->filter = $filter_encoded;
        $filter->name = $filter_decoded->filter_name;
        $filter->action = 'content_search';
        $filter->user_id = $this->session->get('auth-identity')['id'];
        $filter->application_id = $this->session->get('auth-identity')['Application_ID'];
        $filter->module_id = $filter_decoded->module_id;

        if (!$filter->save()) {
            $response['status'] = 0;
            $response['messages'] = $filter->getMessages();
        }

        return json_encode($response);
    }

    public function getJsonFilterAction($filter_id)
    {
        $response['status'] = 1;
        $response['content'] = '';
        $response['messages'] = [];

        $filter = DataCmsSavedFilter::findFirst($filter_id);

        if ($filter) {
            $response['content'] = $filter->filter;
        } else {
            $response['status'] = 0;
            $response['messages'] = $filter->getMessages();
        }

        return json_encode($response);
    }

    public function attributesViewAction($dept_id)
    {
        $lang_id = $this->session->get('auth-identity')['Lang_ID'];
        $this->view->setRenderLevel(\Phalcon\Mvc\View::LEVEL_ACTION_VIEW);
        $get_module = \DataCmsDeptsRel::findFirst("ID={$dept_id}");
        $module_id = $get_module->Module_ID;
        $core_dept_id = $get_module->Core_Depts_ID;
        $this->view->dept_id = $dept_id;
        $keyvalues = new Keyvalue();
        $this->view->attributes = $keyvalues->getKeyvalues($module_id, 2, $core_dept_id, $dept_id, $lang_id);

    }

    public function kvAction($module_id)
    {
        $this->view->disable();
        $kv = new Keyvalue();
        print_r($kv->getKeyvalues(0, 2, 16));

    }

    public function kvitemAction($item_id)
    {
        $this->view->disable();
        $kv = new Keyvalue();
        print_r($kv->getKeyvalueUserdata($item_id));

    }

    public function extraTestAction()
    {
        $this->view->disable();
        $test = new ProductExtraFields();
        print_r($test->returnExtra(3, 8));
    }

    public function testpageAction(){
        $builder = $this->modelsManager->createBuilder()
            ->from("Models\Content");

        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $builder,
                "limit"   => 8,
                "page"    => 1,
            ]
        );
        $page = $paginator->getPaginate();
        return;
    }

    public function productsListAction()
    {
        $products_builder = $this->getProductsBuilder();

        $page = $this->request->get('page');
        $page = isset($page)?$page:1;

        $paginator = new PaginatorQueryBuilder([
            'builder' => $products_builder,
            'limit'   => 20,
            'page'    => $page
            ]);

        $export_builder = $this->getProductsBuilder();

        $ids = [];
        $all_products_ids = $export_builder->columns('ID')->getQuery()->execute();

        foreach($all_products_ids as $pID)
        {
            $ids[] = current($pID);
        }

        $manufacturers = \DataCmsDeptsRel::find([
            'Core_Depts_ID = :core_dept:',
            'bind' => [
                'core_dept' => 5
            ]
            ]);

        $root_categories = \DataCmsDeptsRel::find([
            'Core_Depts_ID = :core_dept: and Parent_Depts_ID = 0',
            'bind' => [
                'core_dept' => 4
            ]
            ]);

        $build_tree = new \Vokuro\Pentavalue\BuildDeptsTree($root_categories);

        $categories_tree_partial = $this->view->getRender('partials', 'catsTree', [
            'tree' => $build_tree->tree]);

        $this->all_manfacts = $manufacturers;

        $this->view->page = $paginator->getPaginate();
        $this->view->ids  = json_encode($ids);
        $this->view->manufacturers = $manufacturers;
        $this->view->cats_tree = $categories_tree_partial;
    }

    private function getProductsBuilder()
    {
        $builder = $this->modelsManager->createBuilder()->from(['product'=>Content::class])
        ->where('product.Module_ID = :module_id:', ['module_id' => 8])
        ->orderBy("product.ID DESC");

        return $builder;
    }

    public function filterProductsAction()
    {
        $page = $this->request->getPost('page');
        $page = isset($page)?$page:1;

        $builder        = $this->getProductsBuilder();
        $export_builder = $this->getProductsBuilder();

        $product_name = $this->request->getPost('product_name');
        $manfacts     = $this->request->getPost('manfcts');
        $categories   = $this->request->getPost('depts_ids');
        $price_from   = $this->request->getPost('price_from');
        $price_to     = $this->request->getPost('price_to');

        if(isset($product_name) && strlen($product_name) > 0)
        {
            $builder->andWhere('product.Title like :name:', [
                'name' => '%'.$product_name.'%'
                ]);
        }

        $valid_manfacts   = (isset($manfacts) && count($manfacts) > 0 && is_array($manfacts))?true:false;
        $valid_catgs      = (isset($categories) && count($categories) > 0)?true:false;
        $valid_price_from = (isset($price_from) && strlen($price_from) > 0)?true:false;
        $valid_price_to   = (isset($price_to) && strlen($price_to) > 0)?true:false;

        if($valid_manfacts)
        {
            $builder->leftJoin(\DataCmsDeptsRelItem::class, 'product.ID = manfct_rel_item.Item_ID', 'manfct_rel_item');

            $builder->inWhere('manfct_rel_item.Depts_ID', $manfacts);

            $export_builder->leftJoin(\DataCmsDeptsRelItem::class, 'product.ID = manfct_rel_item.Item_ID', 'manfct_rel_item');

            $export_builder->inWhere('manfct_rel_item.Depts_ID', $manfacts);
        }

        if($valid_catgs)
        {
            $builder->leftJoin(\DataCmsDeptsRelItem::class, 'cat_rel_item.Item_ID = product.ID', 'cat_rel_item');

            $builder->inWhere('cat_rel_item.Depts_ID', $categories);

            $export_builder->leftJoin(\DataCmsDeptsRelItem::class, 'cat_rel_item.Item_ID = product.ID', 'cat_rel_item');

            $export_builder->inWhere('cat_rel_item.Depts_ID', $categories);
        }

        if($valid_price_from && $valid_price_to)
        {
            $builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

            $builder->betweenWhere('p_extra.price', $price_from, $price_to);

            $export_builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

            $export_builder->betweenWhere('p_extra.price', $price_from, $price_to);
        }
        elseif($valid_price_from && !$valid_price_to)
        {
            $builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

            $builder->andWhere('p_extra.price = :price_from:', ['price_from' => $price_from]);

            $export_builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

            $export_builder->andWhere('p_extra.price = :price_from:', ['price_from' => $price_from]);
        }
        elseif(!$valid_price_from && $valid_price_to)
        {
            $builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

            $builder->andWhere('p_extra.price = :price_to:', ['price_to' => $price_to]);

            $export_builder->leftJoin(ProductExtraFields::class, 'p_extra.item_id = product.ID', 'p_extra');

            $export_builder->andWhere('p_extra.price = :price_to:', ['price_to' => $price_to]);
        }

        $paginator = new PaginatorQueryBuilder([
            'builder' => $builder,
            'limit'   => 5,
            'page'    => $page
        ]);

        $ids = [];
        $all_products_ids = $export_builder->getQuery()->execute();

        foreach($all_products_ids as $pID)
        {
            $ids[] = current($pID);
        }

        $filtered_products = $this->view->getRender('content/partials', 'filteredProducts', [
            'page' => $paginator->getPaginate(),
            'ids'  => json_encode($ids)
        ]);

        return json_encode(['content' => $filtered_products]);
    }

    public function deleteProductAction($id)
    {
        $response['status'] = 0;
        $response['msg']    = '';

        $product = Content::findFirst($id);

        if(!$product)
        {
            $response['msg'] = 'Invalid product';
            return json_encode($response);
        }

        $product->deleteExtraFields();
        $product->deleteKeyValues();
        $product->deleteDeptsRel();

        if(!$product->delete())
        {
            $response['msg'] = 'Error deleteing product, please try again';
            return $json_encode($response);
        }

        $response['status'] = 1;
        $response['msg']    = 'Product deleted successfully';

        return json_encode($response);
    }

    public function deleteSelectedProductsAction()
    {
        $response['status'] = 0;
        $response['msg']    = '';

        $ids = $this->request->getPost('selected_ids');
        
        $products = Content::query()->inWhere('ID', $ids)->execute();

        foreach($products as $product)
        {
            $product->deleteExtraFields();
            $product->deleteKeyValues();
            $product->deleteDeptsRel();

            if(!$product->delete())
            {
                $response['msg'] = 'Unable to delete product, please try again';
                return json_encode($response);
            }
        }

        $response['status'] = 1;
        $response['msg']    = 'Products deleted successfully';

        return json_encode($response);
    }

    public function exportProductsExcelAction()
    {
        $ids = $this->request->getPost('all_ids');

        if(count($ids) == 0)
        {
            return json_encode(['status' => 0, 'file_name' => '']);
        }

        $products = Content::query()->inWhere('ID', $ids)->execute();

        $phpexcel = new \PHPExcel();

        $phpexcel->getProperties()->setCreator('Appox');
        $phpexcel->getProperties()->setTitle('Products');
        $phpexcel->getProperties()->setSubject('Products Data');
        $phpexcel->setActiveSheetIndex(0);
        $phpexcel->getActiveSheet()->setRightToLeft(true);

        $header_fields = ['ID', 'أسم المنتج', 'السعر', 'الوصف', 'التصنيف', 'شركة التصنيع', 'عدد مرات الشراء', 'التاريخ', 'مفعل'];

        $export_data = $this->prepareData($products);
        $file_header = $this->createFileHeader();

        for($i=0; $i < count($header_fields); $i++)
        {
            $phpexcel->getActiveSheet()->setCellValue($file_header[$i], $header_fields[$i]);
            $phpexcel->getActiveSheet()->getStyle($file_header[$i])->applyFromArray([
                'fill' => [
                    'type' => \PHPExcel_Style_Fill::FILL_SOLID,
                    'color' => [
                        'rgb' => 'D3D3D3'
                    ]
                ]
            ]);

            $phpexcel->getActiveSheet()->getStyle($file_header[$i])->getFont()->setBold(true);
        }

        $sheet_row = 2;
        foreach($export_data as $row)
        {
            $col = 0;

            foreach($row as $data)
            {
                $phpexcel->getActiveSheet()->setCellValueByColumnAndRow($col, $sheet_row, $data);
                $col++;
            }

            $sheet_row++;
        }

        $obj_writer = new \PHPExcel_Writer_Excel2007($phpexcel);
        $file_name = 'Products_Exported_' . date('Y-m-d H-i-s') . '.xlsx';

        if(!file_exists(BASE_PATH . '/public/products/'))
        {
            mkdir(BASE_PATH . '/public/products/');
        }

        $file_path = BASE_PATH . '/public/products/' . $file_name;
        ob_clean();
        $obj_writer->save($file_path);
        return json_encode(['status' => 1, 'file_name' => $file_name]);
    }

    public function removeExportedProductsFileAction()
    {
        if($this->request->isAjax())
        {
            unlink(BASE_PATH . '/public/products/' . $this->request->getPost('file_name'));
        }

    }

    private function prepareData($products)
    {
        $prepared_data = [];

        foreach($products as $product)
        {
            $categories    = '';
            $manufacturers = '';

            foreach($product->categories as $cat)
            {
                $categories .= $cat->Title.', ';
            }

            foreach($product->manufacturers as $manfc)
            {
                $manufacturers .= $manfc->Title.', ';
            }

            $prepared_data[$product->ID]['id'] = $product->ID;
            $prepared_data[$product->ID]['name'] = $product->Title;
            $prepared_data[$product->ID]['price'] = $product->extraFields->price;
            $prepared_data[$product->ID]['desc'] = $product->Des;
            $prepared_data[$product->ID]['cat'] = $categories;
            $prepared_data[$product->ID]['manfc'] = $manufacturers;
            $prepared_data[$product->ID]['purchase'] = $product->purchaseNumber();
            $prepared_data[$product->ID]['date'] = date('d/m/Y', $product->DateTime);
            $prepared_data[$product->ID]['active'] = ($product->Active == 1)?'نعم':'لا';
        }

        return $prepared_data;
    }

    public function productViewAction($id)
    {
        $product = Content::findFirst($id);
        $offers  = \Vokuro\Offers\Models\Offers::find();
        $product_offers = null;

        $offer = \Vokuro\Offers\Models\Offers::findFirst(1);

        $product_offers_ids = [];

        $product_rel_offers = \Vokuro\Offers\Models\OfferRelItems::find([
            'columns' => 'offer_id',
            'conditions' =>'data_cms_id = :product_id:',
            'bind' => [
                'product_id' => $id
            ]
            ]);

        foreach($product_rel_offers as $p_rel_offer)
        {
            $product_offers_ids[] = current($p_rel_offer);
        }

        if(count($product_offers_ids))
        {
            $product_offers = \Vokuro\Offers\Models\Offers::query()->inWhere('id', $product_offers_ids)->execute();
        }

        
        $this->view->product = $product;
        $this->view->offers  = $offers;
        $this->view->regions = GeoRegions::find();
        $this->view->product_offers  = $product_offers;
        $this->view->ticket_statuses = TicketProblemsStatus::query()->inWhere('id', [1,2,3,4,6]);
    }

    public function addProductTagsAction()
    {
        $response['status'] = 0;
        $response['msg']    = '';

        if(!$this->request->isPost())
        {
            $response['msg'] = 'Invalid request';

            return json_encode($response);
        }

        $product_id = $this->request->getPost('product_id');
        $tags = $this->request->getPost('tags');

        $product = Content::findFirst($product_id);

        if(!$product)
        {
            $response['msg'] = 'Invalid product';

            return json_encode($response);
        }

        foreach($tags as $tag)
        {
            $new_tag = new \Vokuro\Models\Tags();

            $new_tag->name = $tag;
            
            if(!$new_tag->save())
            {
                $response['msg'] = 'Error saving tag, please try again';

                return json_encode($response);
            }

            $product_rel_tag = new \Models\EntityTags();

            $product_rel_tag->tag_id    = $new_tag->id;
            $product_rel_tag->item_id   = $product_id;
            $product_rel_tag->entity_id = 1;
            $product_rel_tag->module_id = 8;
            
            if(!$product_rel_tag->save())
            {
                $response['msg'] = 'Error saving product tag, please try again';

                return $json_encode($response);
            }
        }

        $response['status'] = 1;
        $response['msg']    = 'Product tags saved successfully';

        return json_encode($response);
    }

    public function changeProductMaxPurchaseAction()
    {
        if(!$this->request->isPost())
        {
            $this->redirectService->withMessage('error', 'Invalid request', 
            $this->url->get('content/productsList'));
            return;
        }

        $product_id   = $this->request->getPost('product_id');
        $max_purchase = $this->request->getPost('quant');

        $product = Content::findFirst($product_id);

        if(!$product)
        {
            $this->redirectService->withMessage('error', 'Invalid product', 
            $this->url->get('content/productView/'.$product_id));
            return;
        }

        $product->extraFields->maximum_in_cart = $max_purchase;

        if(!$product->save())
        {
            $this->redirectService->withMessage('error', 'Error savong product, please try again', 
            $this->url->get('content/productView/'.$product_id));
            return;
        }

        $this->redirectService->withMessage('success', 'Max puurchase number updated', 
            $this->url->get('content/productView/'.$product_id));
            return;
    }

    public function addProductToOfferAction()
    {
        if(!$this->request->isPost())
        {
            $this->redirectService->withMessage('error', 'Invalid request',
            $this->url->get('content/productsList'));
            return;
        }

        $product_id = $this->request->getPost('product_id');
        $offer_id   = $this->request->getPost('offer_id');

        $offer_rel_item = new \Vokuro\Offers\Models\OfferRelItems();

        $offer_rel_item->offer_id    = $offer_id;
        $offer_rel_item->data_cms_id = $product_id;
        $offer_rel_item->created_at  = time();
        $offer_rel_item->updated_at  = time();

        if(!$offer_rel_item->save())
        {
            $this->redirectService->withMessage('error', 'Error saving product to offer, please try again', $this->url->get('content/productView/'.$product_id));
            return;
        }

        $this->redirectService->withMessage('success', 'Product addedd to offer successfully', $this->url->get('content/productView/'.$product_id));
            return;
    }

    public function addStandardSeoSettingsAction()
    {
        if(!$this->request->isPost())
        {
            $this->redirectService->withMessage('error', 'Invalid request', $this->url->get('content/productsList'));
            return;
        }

        $product_id = $this->request->getPost('product_id');
        $meta       = $this->request->getPost('meta');
        $meta_description  = $this->request->getPost('meta_description');
        $title_description = $this->request->getPost('title_description');
        $page_description  = $this->request->getPost('page_description');

        $product = Content::findFirst($product_id);

        if(!$product)
        {
            $this->redirectService->withMessage('error', 'Invalid product', $this->url->get('content/productView/'.$product_id));
            return;
        }

        $product_seo = \Models\SeoSettings::findFirst([
            'data_cms_id = :product_id:',
            'bind' => [
                'product_id' => $product_id
            ]
            ]);

        if(!$product_seo)
        {
            $product_seo = new \Models\SeoSettings;
        }

        $product_seo->data_cms_id = $product_id;
        $product_seo->meta        = $meta;
        $product_seo->meta_description  = $meta_description;
        $product_seo->title_description = $title_description;
        $product_seo->page_title        = $page_description;

        if(!$product_seo->save())
        {
            $this->redirectService->withMessage('error', 'Error saving SEO settings, please try again', $this->url->get('content/productView/'.$product_id));
            return;
        }

        $this->redirectService->withMessage('success', 'Product SEO settings saved successfully.', $this->url->get('content/productView/'.$product_id));
            return;
    }

    public function filterProductOffersAction()
    {
        // ** ashraf -- start
        // I think that this function contains shit and needs to be enhanced or refactored
        // ** ashraf -- end

        if(!$this->request->isPost())
        {
            $this->redirectService->withMessage('error', 'Invalid request', $this->url->get('content/productsList'));
            return;
        }

        $product_id = $this->request->getPost('product_id');
        $offer_name = $this->request->getPost('offer_name');
        $offer_region = $this->request->getPost('offer_region');
        $offer_from   = $this->request->getPost('offer_from');
        $offer_to     = $this->request->getPost('offer_to');

        $product = Content::findFirst($product_id);

        if(!$product)
        {
            $this->redirectService->withMessage('error', 'Invalid product', $this->url->get('content/productView/'.$product_id));
            return;
        }

        // builder for offers
        $offers_builder = $this->modelsManager->createBuilder()
        ->from(\Vokuro\Offers\Models\Offers::class);

        // builder for offers relation with items
        $offers_rel_items_builder = $this->modelsManager->createBuilder()
        ->from(\Vokuro\Offers\Models\OfferRelItems::class)
        ->where('data_cms_id = :product_id:', ['product_id' => $product_id]);

        // builder for offers relation with regions
        $offer_rel_regions_builder = $this->modelsManager->createBuilder()
        ->from(\Vokuro\Offers\Models\OfferRegions::class);

        // builder for offers relation with types
        $offer_rel_types_builder = $this->modelsManager->createBuilder()
        ->from(\Vokuro\Offers\Models\OfferRelTypes::class);


        $execute_for_regions = false;
        $execute_for_dates   = false;
        $execute_for_name    = false;

        // check offers based on name
        $valid_offer_name = (isset($offer_name) && strlen($offer_name) > 0)?true:false;

        if($valid_offer_name)
        {
            $execute_for_name = true;

            $offers_builder->where('name like :offer_name:', ['offer_name' => '%'.$offer_name.'%']);
        }

        // check offers based on region
        $valid_offer_region = (isset($offer_region) && strlen($offer_region) > 0)?true:false;

        if($valid_offer_region)
        {
            $execute_for_regions = true;
            $offer_rel_regions_builder->where('region_id = :region_id:', ['region_id' => $offer_region]);
        }

        // check offers based on start and end date
        $valid_offer_from = (isset($offer_from) && strlen($offer_from) > 0)?true:false;
        $valid_offer_to   = (isset($offer_to) && strlen($offer_to) > 0)?true:false;

        if($valid_offer_from && $valid_offer_to)
        {
            $execute_for_dates = true;
            $offer_from = date('d/m/Y', strtotime($offer_from));
            $offer_to   = date('d/m/Y', strtotime($offer_to));

            $offer_rel_types_builder->where("date_format(from_unixtime(start_date), '%d/%m/%Y') = :offer_from:",[
                'offer_from' => $offer_from
                ])
            ->andWhere("date_format(from_unixtime(end_date), '%d/%m/%Y') = :offer_to:", [
                'offer_to' => $offer_to
                ]);
        }
        elseif($valid_offer_from && !$valid_offer_to)
        {
            $execute_for_dates = true;
            $offer_from = date('d/m/Y', strtotime($offer_from));

            $offer_rel_types_builder->where("date_format(from_unixtime(start_date), '%d/%m/%Y') = :offer_from:", [
                'offer_from' => $offer_from
            ]);
        }
        elseif(!$valid_offer_from && $valid_offer_to)
        {
            $execute_for_dates = true;
            $offer_to = date('d/m/Y', strtotime($offer_to));

            $offer_rel_types_builder->where("date_format(from_unixtime(end_date), '%d/%m/%Y') = :offer_to:",[
                'offer_to' => $offer_to
                ]);
        }

        // execute builders to get offers ids
        $offers_ids = [];

        if($execute_for_regions)
        {
            $result = $offer_rel_regions_builder->columns('offer_id')->getQuery()->execute();

            foreach($result as $o_id)
            {
                if(!in_array(current($o_id), $offers_ids))
                {
                    $offers_ids[] = current($o_id);
                }
            }
        }

        if($execute_for_dates)
        {
            $result = $offer_rel_types_builder->columns('offer_id')->getQuery()->execute();

            foreach($result as $o_id)
            {
                if(!in_array(current($o_id), $offers_ids))
                {
                    $offers_ids[] = current($o_id);
                }
            }
        }

        if($execute_for_name)
        {
            $result = $offers_builder->columns('id')->getQuery()->execute();

            foreach($result as $o_id)
            {
                if(!in_array(current($o_id), $offers_ids))
                {
                    $offers_ids[] = current($o_id);
                }
            }
        }

        $offers_result = null;
        $final_offers_ids = [];
        $filtered_product_offers = null;

        if($valid_offer_name || $valid_offer_region || $valid_offer_from || $valid_offer_to)
        {
            $offers_result = $offers_rel_items_builder->inWhere('offer_id', $offers_ids)
            ->columns('offer_id')->getQuery()->execute();

            foreach($offers_result as $o_result)
            {
                $final_offers_ids[] = current($o_result);
            }
        }
        else
        {
            $offers_result = $offers_rel_items_builder->columns('offer_id')->getQuery()->execute();

            foreach($offers_result as $o_result)
            {
                $final_offers_ids[] = current($o_result);
            }
        }

        $filtered_product_offers = $this->modelsManager->createBuilder()
        ->from(\Vokuro\Offers\Models\Offers::class)
        ->inWhere('id', $final_offers_ids)->getQuery()->execute();

        $product_offers_view = $this->view->getRender('partials', 'productOffers',[
            'offers'     => $filtered_product_offers,
            'product_id' => $product_id
            ]);

        $response['content'] = $product_offers_view;

        return json_encode($response);
    }

    public function addProductToDiscountAction()
    {
        if(!$this->request->isPost())
        {
            $this->redirectService->withMessage('error', 'Invalid request', $this->url->get('content/productsList'));
            return;
        }

        $validator = new RequestValidation($this->request);

        $product_id = $this->request->getPost('product_id');

        $product = Content::query()->where('ID = :id:')
        ->columns("ID")->bind(['id' => $product_id])->execute();

        if(!$product)
        {
            $this->flashSession->error('Error fetching product');
            $this->redirectService->back();
            return;
        }

        $validation_result = $validator->required([
            'discount_name', 'discount_percent', 'discount_start_date', 'discount_end_date'
            ])->validate();

        if(count($validation_result))
        {
            $this->session->set('error_msgs', $validation_result);

            return $this->response->redirect($this->url->get('content/productView/'.$product_id));
        }

        $discount_name       = $this->request->getPost('discount_name');
        $discount_percent    = $this->request->getPost('discount_percent');
        $discount_coupon      = $this->request->getPost('discount_coupon');
        $discount_start_date = strtotime($this->request->getPost('discount_start_date'));
        $discount_end_date   = strtotime($this->request->getPost('discount_end_date'));

        $discount = new Discounts;

        $discount->name       = $discount_name;
        $discount->percentage = $discount_percent;
        $discount->coupon     = $discount_coupon;
        $discount->start_date = $discount_start_date;
        $discount->end_date   = $discount_end_date;
        $discount->active     = 1;
        $discount->created_at = time();
        $discount->updated_at = time();

        if(!$discount->save())
        {
            $this->redirectService->withMessage('error', 'Error saving discount, please try again',
            $this->url->get('content/productView/'.$product_id));
            return;
        }

        $discount_rel_items = new DiscountRelItems;

        $discount_rel_items->discount_id = $discount->id;
        $discount_rel_items->data_cms_id = $product_id;
        $discount_rel_items->created_at  = time();
        $discount_rel_items->updated_at  = time();

        if(!$discount_rel_items->save())
        {
            $thi->redirectService->withMessage('error', 'Error saving product discount, please try again', $this->url->get('content/productView/'.$product_id));
            return;
        }

        $this->redirectService->withMessage('success', 'Product discount addedd successfully',
            $this->url->get('content/productView/'.$product_id));
        return;
    }

    public function filterProductDiscountsAction()
    {
        if(!$this->request->isPost())
        {
            $this->redirectService->withMessage('error', 'Invalid request', 
                $this->url->get('content/productsList'));
            return;
        }
// var_dump($this->request->getPost());die;
        $product_id       = $this->request->getPost('product_id');
        $discount_name    = $this->request->getPost('discount_name');
        $discount_percent = $this->request->getPost('discount_percent');
        $discount_coupon  = $this->request->getPost('discount_coupon');
        $start_date       = $this->request->getPost('start_date');
        $end_date         = $this->request->getPost('end_date');

        $valid_name       = (isset($discount_name) && strlen($discount_name) > 0)?true:false;
        $valid_percent    = (isset($discount_percent) && strlen($discount_percent) > 0)?true:false;
        $valid_coupon     = (isset($discount_coupon) && strlen($discount_coupon) > 0)?true:false;
        $valid_start_date = (isset($start_date) && strlen($start_date) > 0)?true:false;
        $valid_end_date   = (isset($end_date) && strlen($end_date) > 0)?true:false;

        $discount_rel_items_builder = $this->modelsManager->createBuilder()
        ->from(DiscountRelItems::class)->columns('discount_id')
        ->where('data_cms_id = :product_id:', ['product_id' => $product_id]);

        $discounts_builder = $this->modelsManager->createBuilder()
        ->from(Discounts::class)->columns('id');

        if($valid_name)
        {
            $discounts_builder->andWhere('name like :name:', 
                ['name' => '%'.$discount_name.'%']);
        }

        if($valid_percent)
        {
            $discounts_builder->andWhere('percentage = :percent:', ['percent' => $discount_percent]);
        }

        if($valid_coupon)
        {
            $discounts_builder->andWhere('coupon = :coupon:', ['coupon' => $discount_coupon]);
        }

        if($valid_start_date)
        {
            $start_date = date('d/m/Y', strtotime($start_date));
            $discounts_builder->andWhere("date_format(from_unixtime(start_date), '%d/%m/%Y') = :start_date:", ['start_date' => $start_date]);
        }

        if($valid_end_date)
        {
            $end_date = date('d/m/Y', strtotime($end_date));
            $discounts_builder->andWhere("date_format(from_unixtime(end_date), '%d/%m/%Y') = :end_date:", ['end_date' => $end_date]);
        }

        // if($valid_name || $valid_percent || $valid_coupon || $valid_start_date || $valid_end_date)
        // {

        // }

        $discounts = $discounts_builder->getQuery()->execute()->toArray();

        $discounts_ids = [];

        foreach($discounts as $discount)
        {
            $discounts_ids[] = current($discount);
        }

        $filtered_discounts = $discount_rel_items_builder->inWhere('discount_id', $discounts_ids)
        ->getQuery()->execute()->toArray();
        $filtered_discounts_ids = [];

        foreach($filtered_discounts as $f_discount)
        {
            $filtered_discounts_ids[] = current($f_discount);
        }

        $final_discounts = Discounts::query()->inWhere('id', $filtered_discounts_ids)->execute();

        $product_discounts_view = $this->view->getRender('partials', 'productDiscounts', [
            'discounts'  => $final_discounts,
            'product_id' => $product_id
            ]);

        $response['content'] = $product_discounts_view;

        return json_encode($response);
    }

    public function setMostSelling($product_id,$active){
        $most_selling=TanksMostSellingProducts::findFirst(["product_id={$product_id}"]);
        if(!$most_selling){
            $most_selling = new TanksMostSellingProducts();
            if($active==1){
                $most_selling->product_id=$product_id;
                $most_selling->save();
            }
            return true;
        }
        else{
            if($active!=1){
                $most_selling->delete();
            }
            return true;
        }

    }
}
