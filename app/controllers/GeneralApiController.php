<?php

namespace Vokuro\Controllers;

use Models\Content;
use Models\DataForms;
use Models\UsersMobile;
use Phalcon\Http\Request;
use Phalcon\Paginator\Adapter\Model as Paginator;
use Phalcon\Mvc\Model\Criteria;
use Phalcon\Security;
use Phalcon\Security\Random;
use Phalcon\Mvc\Url;
use Vokuro\Forms\AdvancedSearchForm;
use Vokuro\Pentavalue\Keyvalue;
use Phalcon\Mvc\Model\Query\Builder;
use DataTables\DataTable;
use Vokuro\Pentavalue\Jsonobjects;
use Models\DataFormsResponse;

define('Application_ID', $_REQUEST['Application_ID']);
define('Module_ID', $_REQUEST['Module_ID']);
define('IMAGE_URL', "http://penta-test.com/robo_cms/uploads/");
define('SITEURL', 'URL/');
define('TIMENOW', time());
if (isset($_REQUEST['Module_Order'])) {
    define('Module_Order', $_REQUEST['Module_Order']);
}


class GeneralApiController extends ControllerApiBase
{


    public function indexAction()
    {
        $action = $this->request->getQuery('Action_ID');
        $this->view->disable();
        switch ($action) {
            case '6'://Cms Item
                $ID = $this->request->getQuery("ID");
                $this->Cms_Display($ID);
                break;
            case "3": //Depts
                $this->view->disable();
                $Depts_ID = $this->request->getQuery("Depts_ID");
                $Sub_ID = $this->request->getQuery("Sub_ID");
                $Page = $this->request->getQuery("Page");
                $this->Cms_Depts($Depts_ID, $Sub_ID, $Page);
                break;
            case "2": //contents with dept+
                $this->view->disable();
                $Depts_ID = $this->request->getQuery("Depts_ID");
                $Page = $this->request->getQuery("Page");
                $this->Cms_List($Depts_ID, $Page);
                break;
            case "33": //Get Form With ID in request
                $this->view->disable();
                $this->Cms_Form(); 
                break;
            case "34": //
                $this->view->disable();
                $this->addResponse();
                break;

            case "105": //UsersIntro
                $this->view->disable();
                $this->App_Intro();

                break;
            case "36":
                $this->view->disable();
                $this->AddFav();

                break;
            case "66":
                $this->view->disable();
                $this->registerToken();

                break;
            case "20":
                $this->view->disable();
                $this->Login();
                break;
            case "12": // Logout
                $this->view->disable();
                session_destroy();
                $Paramters = array();
                $this->Artgine_Response(1, "تم تسجيل الخروج", $Paramters);
                break;
            case "22":
                if($_REQUEST['User_ID']=='')
                    $User_ID=$_SESSION['App_User_ID'];
                IF($User_ID!='')
                {
                    $this->Profile_Str($User_ID);
                    break;
                }
                ELSE
                {
                    $Paramters[]='User_ID';
                    $this->Artgine_Response(0, "يجب ارسال ال User_ID", $Paramters);
                }
                break;

            default:

                break;
        }

    }

    public function AddFav()
    {
        if (!$this->session->get('auth-identity')['id']) {
            $userid = 0;
        } else {
            $userid = $this->session->get('auth-identity')['id'];
        }

        $Fav = \DataFav::findFirst(["Key_ID='" . $_REQUEST['ID'] . "' And Module_ID='" . Module_ID . "'"]);
        if (!$Fav) {           
            $data_fav = new \DataFav();
            $data_fav->User_ID = $userid;
            $data_fav->Key_ID = $_REQUEST['ID'];
            $data_fav->Module_ID = Module_ID;
            $data_fav->Application_ID = Application_ID;
            $data_fav->Date = time();
            $data_fav->save();

        } else {
            $Fav->delete();
        }
        $this->Artgine_Response(1, 'Done', array());
    }


    public function registerToken()
    {
        if (!$this->session->get('auth-identity')['id']) {
            $userid = 0;
        } else {
            $userid = $this->session->get('auth-identity')['id'];
        }
		$_REQUEST['Token'] = $token;
        $tokenid = \UsersToken::findFirst(["Token_MD5='" . md5($token) . "'"]);
        if (!$tokenid) {

            $tokenid = new \UsersToken();
            $tokenid->Token = $_REQUEST['Token'];
            $tokenid->Token_MD5 = md5($_REQUEST['Token']);
            $tokenid->User_ID = $userid;
            $tokenid->Type = $_REQUEST['Type'];
            $tokenid->Application_ID = Application_ID;
            $tokenid->Active = "1";
            $tokenid->save();
        }
        $this->Artgine_Response(1, 'Done', array());
    }

    public function Cms_Form()
    {
        $Form = array();
        $ID = $_REQUEST['ID'];
        $output_rel = DataForms::findFirst(["ID={$ID}"]);
        if ($output_rel) {
            $Action['Login'] = $output_rel->Login;
            $Action['Target_Module_ID'] = $output_rel->Target_Module_ID;
            $Action['Application_ID'] = $output_rel->Application_ID;
            //$Action['Action_ID'] = $output_rel->Action_ID;
            $Action['FormID'] = $output_rel->ID;
            $Action['Api'] = $output_rel->Api;
            $Action['Target_Action_ID'] = $output_rel->Target_Action_ID;
            $Form['Action'] = $Action;
        } else {
            $Form['Action'] = [];
        }


        return $Form;
    }
    public function Cms_Setting_Data($Item_ID, $Type, $Api)
    {
        $Setting_Data = array();
        $Setting_Data['Dialog'] = 0;
        $Setting_Data['Setting_ID'] = 0;
        $Setting_Data['Footer_Layout_ID'] = 0;


        $Setting_Data['Target_Color'] = "";
        $Setting_Data['Target_Bg'] = "";
        $Action_ID = $_REQUEST['Action_ID'];


        $Setting = 0;
        $settings = \DataCmsSetting::findFirst(["Type='{$Type}' AND Item_ID={$Item_ID}"]);

        IF ($settings) {
            $output = $settings->toArray();
            $Setting_Data['Dialog'] = $output['Dialog'];
            $Target_Action_ID = $output['Target_Action_ID'];
            $Setting_Data['Target_Layout_ID'] = $output['Target_Layout_ID'];
            $Target_Module_ID = $output['Target_Module_ID'];
            $Setting_Data['Target_Color'] = $output['Color'];
            $Setting_Data['Footer_Layout_ID'] = $output['Footer_Layout_ID'];
            $Setting_Data['Target_Bg'] = $output['Bg'];
            $Api_Setting_Db = $output['Api'];

            $Setting_Data['Setting_ID'] = $output['ID'];
            $Setting = 1;


            IF ($Target_Action_ID != '' && $Target_Action_ID != ' ' && $Target_Action_ID != '0') {
                $Url_Action_ID = $Target_Action_ID;
            } else {
                IF ($Setting_Data['Target_Layout_ID'] != '' && $Setting_Data['Target_Layout_ID'] != ' ' && $Setting_Data['Target_Layout_ID'] != '0') {
                    $temp_obj = \UsersApplicationModuleLayoutActionNew::findFirst(["ID = " . $Setting_Data['Target_Layout_ID'] . " "]);
                    $temp = $temp_obj->toArray();
                    $Url_Action_ID = $temp['Target_Action_ID'];

                } else {
                    $temp_obj = \UsersApplicationModuleLayoutActionNew::findFirst(["Action_ID = " . $Action_ID . " AND Module_ID = " . Module_ID . " And Main=1"]);
                    if ($temp_obj) {
                        $temp = $temp_obj->toArray();
                        $Url_Action_ID = $temp['Target_Action_ID'];
                    }

                }
            }


            IF ($Target_Module_ID != '' && $Target_Module_ID != ' ' && $Target_Module_ID != '0') {
                $Url_Module_ID = $Target_Module_ID;
            } else {

                IF ($Setting_Data['Target_Layout_ID'] != '' && $Setting_Data['Target_Layout_ID'] != ' ' && $Setting_Data['Target_Layout_ID'] != '0') {
                    $temp_obj = \UsersApplicationModuleLayoutActionNew::findFirst(["ID = " . $Setting_Data['Target_Layout_ID'] . ""]);
                    $temp = $temp_obj->toArray();
                    $Url_Module_ID = $temp['Target_Module_ID'];
                } else {

                    $temp_obj = \UsersApplicationModuleLayoutActionNew::findFirst(["Action_ID = " . $Action_ID . " AND Module_ID = " . Module_ID . " And Main=1"]);
                    if ($temp_obj) {
                        $temp = $temp_obj->toArray();
                        $Target_Action_ID = $temp['Target_Action_ID'];
                        IF ($temp['Target_Module_ID'] != '' && $temp['Target_Module_ID'] != ' ' && $temp['Target_Module_ID'] != '0') {
                            $Url_Module_ID = $temp['Target_Module_ID'];
                        } else {
                            $Url_Module_ID = Module_ID;
                        }
                    }

                }
            }

            $temp_obj = \UsersApplicationModule::findFirst(["ID={$Url_Module_ID}"]);
            $temp = $temp_obj->toArray();
            $Base_URL = $temp['Base_URL'];
            if ($Base_URL == '') {
                $Base_URL = "http://robo-apps.com/engine/api/?Str=1&";
            }
            $Api_Url = $Base_URL . "&Application_ID=" . Application_ID . '&Module_ID=' . $Url_Module_ID . "&Action_ID=" . $Url_Action_ID . '&' . $Api . '&' . $Api_Setting_Db;

            if ($Setting == 0) {
                $temp_obj = \UsersApplicationModuleLayoutActionNew::findFirst(["Main=1 and `Action_ID` = " . $Url_Action_ID . " AND Module_ID=" . $Url_Module_ID . " LIMIT 1"]);
                $temp = $temp_obj->toArray();
                $Setting_Data['Target_Layout_ID'] = $temp['ID'];
            }


            $Setting_Data['Api'] = $Api_Url;

            $Button['ID'] = "1";
            $Button['Api'] = "";
            $Button['Orders'] = "1";
            $Setting_Data['Button'][] = $Button;


            $Button['ID'] = "2";
            $Button['Api'] = "";
            $Button['Orders'] = "2";
            $Setting_Data['Button'][] = $Button;

            $Basc_Data['Button'] = $Arr_Button;

            $Arr_Footer = ARRAY();
            $rel = \DataCmsFooter::find(["Type =  '" . $Type . "' and  Item_ID='" . $Item_ID . "'"]);
            $results = $rel->toArray();
            foreach ($results as $output_rel) {
                {
                    $Footer['Target_Action_ID'] = $output_rel['Target_Action_ID'];
                    $Footer['Target_Layout_ID'] = $output_rel['Target_Layout_ID'];
                    $Footer['Title'] = $output_rel['Title'];
                    $Footer['Footer_ID'] = $output_rel['Footer_ID'];
                    $Footer['Effect_ID'] = $output_rel['Effect_ID'];
                    $Footer['Footer_Type_ID'] = $output_rel['Footer_Type_ID'];
                    $Footer['Selected_Pic'] = IMAGE_URL . $output_rel['Selected_Pic'];
                    $Footer['Api'] = $output_rel['Api'];
                    $Footer['Data'] = $output_rel['Data'];
                    $Footer['Pic'] = IMAGE_URL . $output_rel['Img'];
                    $Arr_Footer[] = $Footer;
                }

            }
            $Setting_Data['Footer'] = $Arr_Footer;

            return $Setting_Data;
        }
        return $Setting_Data = array();
    }


    public function Cms_Advanced_Data_Depts($ID)
    {
        $Arr_Advanced_Data = array();
        $sql_rel = "SELECT * FROM data_cms_depts_rel WHERE ID='" . $ID . "'";
        $output_rel = $this->connection->fetchone($sql_rel);
        if ($output_rel) {
            $Advanced_Data['ID'] = $output_rel['ID'];
            $Advanced_Data['Title'] = $output_rel['Title'];
            $Advanced_Data['Des'] = $output_rel['Des'];
            $Advanced_Data['Pic'] = IMAGE_URL . $output_rel['Img'];
            $Advanced_Data['Depts_ID'] = $output_rel['Core_Depts_ID'];
            $Arr_Advanced_Data[] = $Advanced_Data;
        }
        return $Arr_Advanced_Data;
    }


    public function Cms_Key_Others_Data($Item_ID)
    {

        $Arr_Others_Data = array();
        $Arr_Data = array();
        $results = \DataKeyvalueGroup::find(["Core = 'yes' and Application_ID='" . Application_ID . "' and Module_ID='" . Module_ID . "'"]);

        if (count($results) > 0) {
            foreach ($results as $output) {

                $Group_Title = $output->Paramter;
                $Group_ID = $output->ID;
                $resultskey = \DataKeyvalue::find(["Group_ID='" . $Group_ID . "'"]);
                $Data = array();
                if (count($resultskey) > 0) {
                    foreach ($resultskey as $outputkey) {
                        $Content['ID'] = $outputkey->ID;
                        $CKV_ID = $outputkey->CKV_ID;
                        $Paramter = $outputkey->Paramter;
                        $Data[$Paramter] = "";
                        $rkvUser = \DataKeyvalueUserdata::findFirst(["DKV_ID='" . $Content['ID'] . "' and Item_ID=" . $Item_ID . " AND Lang_ID='1'"]);
                        if ($rkvUser) {
                            $Data[$Paramter] = $rkvUser['Value'];
                        }
                    }
                    $Arr_Data[] = $Data;

                }

                $Arr_Others_Data[$Group_Title] = $Arr_Data;

            }

        }
        return $Arr_Others_Data;
    }

    public function Cms_Key_Value($Item_ID)
    {

        $Arr_Group_Data = array();
        $kv_group = \DataKeyvalueGroup::find(["Application_ID=" . Application_ID . " AND Module_ID=" . Module_ID]);
        $results = $kv_group;
        if (count($results) > 0) {
            foreach ($results as $output) {

                $Group_Data['ID'] = $output->ID;
                $Group_Data['Title'] = $output->GroupLang->Title;
                $Group_Data['Key_Value_Layout_ID'] = $output->Key_Value_Layout_ID;
                $Group_Data['Cell_Press'] = $output->Cell_Press;

                $keyvalue = \DataKeyvalue::find(["Group_ID=" . $Group_Data['ID']]);
                if (count($keyvalue) > 0) {
                    foreach ($keyvalue as $outputkey) {
                        $Data['CKV_ID'] = $outputkey->CKV_ID;
                        $Data['Pic'] = IMAGE_URL . $outputkey->Img;
                        $Content['ID'] = $outputkey->ID;
                        $KVuser = \DataKeyvalueUserdata::findFirst(["DKV_ID='" . $Content['ID'] . "' and Item_ID=" . $Item_ID . " AND Lang_ID='1'"]);
                        if ($KVuser) {
                            $Data['Title'] = $KVuser->Title;
                            $Data['Des'] = $KVuser->Des;
                            $Data['Title'] = $KVuser->Title;
                            $Data['Value'] = $KVuser->Value;
                            $Data['Img'] = IMAGE_URL . $KVuser->Img;
                        }
                    }
                    $Arr_Data[] = $Data;

                }

                $Group_Data['Control'] = $Arr_Data;

            }

            $Arr_Group_Data[] = $Group_Data;
        }
        return $Arr_Group_Data;
    }

    public function Cms_Advanced_Data($Item_ID)
    {

        $Arr_Advanced_Data = array();


        $sql = "SELECT * FROM data_cms_depts_rel_item WHERE Item_ID='" . $Item_ID . "'";
        $results = $this->connection->fetchAll($sql);
        if ($results) {
            foreach ($results as $output) {

                $ID = $output['Depts_ID'];
                $sql_rel = "SELECT * FROM data_cms_depts_rel WHERE ID='" . $ID . "'";
                $output_rel = $this->connection->fetchone($sql_rel);
                $Advanced_Data['ID'] = $output_rel['ID'];
                $Advanced_Data['Title'] = $output_rel['Title'];
                $Advanced_Data['Des'] = $output_rel['Des'];
                $Advanced_Data['Pic'] = IMAGE_URL . $output_rel['Img'];
                $Advanced_Data['Depts_ID'] = $output_rel['Core_Depts_ID'];
                $Arr_Advanced_Data[] = $Advanced_Data;

            }
        }
        return $Arr_Advanced_Data;
    }


    public function Cms_Depts($Depts_ID = 0, $Sub_ID = 0, $page = 1)
    {
        $paging = $this->More_Replace($page);
        $Arr_Data = array();
        $sql = "Application_ID=" . Application_ID . " and Module_ID=" . Module_ID . " AND Active='1' AND Lang_ID='1'";

        IF ($Depts_ID == 0) {
            $sql .= "AND Parent_Depts_ID=" . $Sub_ID;

        } ELSE {
            $sql .= "AND Core_Depts_ID=" . $Depts_ID;
        }
        //$sql .= $this->Artgine_Order('data_cms_depts_rel') . $paging;
        //$results = $this->connection->fetchAll($sql);
        $results = \DataCmsDeptsRel::find([$sql]);
        foreach ($results as $output) {
            //Basc_Data
            $Basc_Data['ID'] = $output->ID;
            $Basc_Data['Title'] = $output->Title;
            $Basc_Data['Des'] = $output->Des;
            $Parent_Depts_ID = $output->Parent_Depts_ID;
            $Basc_Data['Pic'] = IMAGE_URL . $output->Img;
//            $Basc_Data['Content'] = strip_tags($output->Content, "");
//            $Basc_Data['DateTime'] = $this->timeBetween($output->DateTime);
            $Basc_Data['Key'] = "";
            $Basc_Data['Link_Share'] = SITEURL . "news.php?ID=" . $output->ID;
            $Arr['Basc_Data'] = $Basc_Data;
            //Advanced_Data
            //  $Arr['Advanced_Data']=$this->Cms_Advanced_Data_Depts($Parent_Depts_ID);
            //Setting_Data
            $Type_Url = "Sub_ID=" . $Basc_Data['ID'];
            $Arr['Setting_Data'] = $this->Cms_Setting_Data($Basc_Data['ID'], 'Depts', $Type_Url);
            //Stat_Data
            //$Arr['Stat_Data']=$this->Cms_Stat_Data($Basc_Data['ID'],'Depts');
            //Key_Value
            $Arr['Key_Value'] = array();
            $Arr['Others_Data'] = array();
            $Arr_Data[] = $Arr;
        }
        echo json_encode($Arr_Data);

    }

    public function Cms_List($Depts_ID = 0, $page = 1)
    {
        $Final_Json = array();
        $paging = $this->More_Replace($page);
        $Data_Arr = array();
        $results = Content::find(["Lang_ID='1' and Application_ID=" . Application_ID . " and Module_ID=" . Module_ID . "
            and Active='1'"]);
        if ($Depts_ID != '' && $Depts_ID != '0' && $Depts_ID != ' ') {
            $results = $this->modelsManager->createBuilder()->from("Models\Content")
                ->join("DataCmsDeptsRelItem")
                ->where("Models\Content.Lang_ID = 1")
                ->andWhere("DataCmsDeptsRelItem.Depts_ID = :Depts_ID:", ["Depts_ID" => $Depts_ID])
                ->andWhere("Models\Content.Application_ID =" . Application_ID . "")
                ->andWhere("Models\Content.Module_ID =" . Module_ID . "")
                ->getQuery()
                ->execute();
        }
        IF (count($results) > 0) {
            foreach ($results as $output) {
                //Basc_Data
                $Arr_Key = array();
                $Basc_Data['ID'] = $output->ID;
                $Basc_Data['Title'] = $output->Title;
                $Basc_Data['Des'] = $output->Des;
                $Basc_Data['Pic'] = IMAGE_URL . $output->Img;
                $Basc_Data['Content'] = strip_tags($output->Content, "");
                $Basc_Data['DateTime'] = $this->timeBetween($output->DateTime);
                $Basc_Data['Key'] = "";
                $Basc_Data['Link_Share'] = SITEURL . "news.php?ID=" . $output->ID;

                $Arr_Key['ID'] = 1;
                $Arr_Key['Value'] = $Basc_Data['DateTime'];
                $Basc_Data['Key'][] = $Arr_Key;
                $Arr_Key['ID'] = 2;
                $Arr_Key['Value'] = "2313";
                $Basc_Data['Key'][] = $Arr_Key;
                $Arr_Key['ID'] = 3;
                $Arr_Key['Value'] = "اسم القسم";
                $Basc_Data['Key'][] = $Arr_Key;
                $Arr_Key['ID'] = 4;
                $Arr_Key['Value'] = "كلام كثير";
                $Basc_Data['Key'][] = $Arr_Key;
                $Arr_Key['ID'] = 5;
                $Arr_Key['Value'] = $output->Key_5;
                $Basc_Data['Key'][] = $Arr_Key;


                //GET ALL MEDIA
                $Arr_Img = array();
                $Arr_Vid = array();

                foreach ($output->ContentMedia as $OMedia) {
                    if ($OMedia->Type != 'Video') {
                        $Arr_Img[] = IMAGE_URL . $OMedia->Img;
                    } else {
                        $Vid['Img'] = IMAGE_URL . $OMedia->Img;
                        $Vid['Video'] = $OMedia->Link;
                        $Arr_Vid[] = $Vid;
                    }

                }
                $Basc_Data['Images'] = $Arr_Img;
                $Basc_Data['Videos'] = $Arr_Vid;

                $Arr['Basc_Data'] = $Basc_Data;
                //Advanced_Data
                //  $Advanced_Data=$this->Cms_Advanced_Data($Basc_Data['ID']);
                ///  $Arr['Advanced_Data']=$Advanced_Data;
                //Setting_Data
                $Type_Url = "ID=" . $Basc_Data['ID'];
                $Arr['Setting_Data'] = $this->Cms_Setting_Data($Basc_Data['ID'], 'Data', $Type_Url);
                //Stat_Data
                // $Arr['Stat_Data']=$this->Cms_Stat_Data($Basc_Data['ID'],'Data');
                //Key_Value
                //  $Arr['Key_Value']=array();
                //Others_Data
                //  $Arr['Others_Data']=array();
                $Data_Arr[] = $Arr;
            }
        }


        echo json_encode($Data_Arr);
    }


    public function Cms_Display($ID)
    {
        $Final_Json = array();
        $outputs = array();
        $content = Content::findFirst(["Application_ID=" . Application_ID . " AND Module_ID=" . Module_ID . " AND ID={$ID}"]);
        $output = $content->toArray();
        //Basc_Data
        $Basc_Data['ID'] = $output['ID'];
        $Basc_Data['Title'] = $output['Title'];
        $Basc_Data['Des'] = $output['Des'];
        $Basc_Data['Pic'] = IMAGE_URL . $output['Img'];
        $Basc_Data['Content'] = strip_tags($output['Content'], "");
        $Basc_Data['DateTime'] = $output['DateTime'];
        $Basc_Data['Key'] = "";
        $Basc_Data['Link_Share'] = SITEURL . "news.php?ID=" . $output['ID'];
        //GET ALL MEDIA
        $Arr_Img = array();
        $Arr_Vid = array();
        $resultMedia = $content->ContentMedia->toArray();
        foreach ($resultMedia as $OMedia) {
            if ($OMedia['Type'] != 'Video') {
                $Arr_Img[] = IMAGE_URL . $OMedia['Img'];
            } else {
                $Vid['Img'] = IMAGE_URL . $OMedia['Img'];
                $Vid['Video'] = $OMedia['Link'];
                $Arr_Vid[] = $Vid;
            }

        }
        $Basc_Data['Images'] = $Arr_Img;
        $Basc_Data['Videos'] = $Arr_Vid;
        $Arr['Basc_Data'] = $Basc_Data;

        //Advanced_Data
        //  $Advanced_Data=$this->Cms_Advanced_Data($Basc_Data['ID']);
        ///  $Arr['Advanced_Data']=$Advanced_Data;
        //Setting_Data
        $Type_Url = "ID=" . $Basc_Data['ID'];
        $Arr['Setting_Data'] = $this->Cms_Setting_Data($Basc_Data['ID'], 'Data', $Type_Url);
        //Stat_Data
        //  $Arr['Stat_Data']=$this->Cms_Stat_Data($Basc_Data['ID'],'Data');
        //Key_Value
        $Arr['Key_Value'] = $this->Cms_Key_Value($Basc_Data['ID']);

        //Others_Data
        $Arr['Others_Data'] = $this->Cms_Key_Others_Data($Basc_Data['ID']);

        echo json_encode($Arr);
    }

    function More_Replace_Image($more)
    {
        if ($more == '')
            $more = 0;
        $start = 3 * $more;
        $end = $start + 3;
        return $paging = "LIMIT $start,3";
    }

    function Artgine_Order($table)
    {
        return ' ' . str_replace('{table}', $table, Module_Order) . ' ';
    }

    function More_Replace($more = '')
    {
        if (!empty($_REQUEST['recentdata'])) {
            return ' LIMIT 0,10';
        }
        if (!empty($_REQUEST['Lastone'])) {
            return ' LIMIT 0,1';
        }
        if (!empty($_REQUEST['ID'])) {
            return ' LIMIT 0,1';
        }
        if (!empty($_REQUEST['Random'])) {
            return '';
        }

        if (!empty($_REQUEST['page'])) {
            $more = $_REQUEST['page'];
        } elseif (!empty($_REQUEST['Page'])) {
            $more = $_REQUEST['Page'];
        } else {
            $more = '';
        }
        if (empty($more)) {
            return ' LIMIT 0,10';
        } elseif ($more == 1) {
            return ' LIMIT 0,10';
        } else {
            return ' LIMIT ' . (($more - 1) * 10) . ',10';
        }
    }

    public function timeBetween($start, $end = null)
    {
        $end = (is_null($end)) ? time() : $end;
        $time = $end - $start;

        if ($time <= 60) {

            if ($time <= 1) {
                return 'منذ ثانية واحدة';
            }
            if ($time <= 2) {
                return 'منذ ثانيتين';
            }
            if ($time <= 10) {
                return 'منذ ' . $time . ' ثواني';
            }
            if ($time <= 59) {
                return 'منذ ' . $time . ' ثانية';
            }
            if ($time <= 60) {
                return 'منذ دقيقة واحدة';
            }

        }

        if (60 < $time && $time <= 3600) {
            $r = intval($time / 60);

            if ($r <= 1) {
                return 'منذ دقيقة واحدة';
            }

            if ($r <= 2) {
                return 'منذ دقيقتين';
            }

            if ($r <= 10) {
                return 'منذ ' . $r . ' دقائق';
            }

            if ($r <= 59) {
                return 'منذ ' . $r . ' دقيقة';
            }

            if ($r <= 60) {
                return 'منذ ساعة واحدة';
            }

        }


        if (3600 < $time && $time <= 86400) {
            $r = intval($time / 3600);

            if ($r <= 1) {
                return 'منذ ساعة واحدة';
            }
            if ($r <= 2) {
                return 'منذ ساعتين';
            }
            if ($r <= 10) {
                return 'منذ ' . $r . ' ساعات';
            }

            if ($r <= 23) {
                return 'منذ ' . $r . ' ساعة';
            }

            if ($r <= 24) {
                return 'منذ يوم أمس';
            }

        }


        if ($time > 86400) {
            return date('M d y \a\t h:i A', $start);
        }
    }

    public function addResponse()
    {
        if (empty($_POST) && empty($_GET) && empty($_REQUEST)) {
            $this->showmsg(CPURL . '/' . Module, 1);
        } else {
            $response = $_REQUEST;

            unset($response['Action_ID']);
            unset($response['Application_ID']);
            unset($response['Layoud_ID']);
            unset($response['Target_Action_ID']);
            unset($response['Module_ID']);
            unset($response['route']);
            unset($response['__cfduid']);
            unset($response['_ga']);
            unset($response['_url']);
            unset($response['Page']);
            unset($response['_gat']);

            unset($response['PHPSESSID']);
            $IP = $this->getIP();
            $Form_ID = $response['Form_ID'];
            if ($Form_ID == '')
                $Form_ID = $response['FormID'];

            $data['ID'] = "";
            unset($response['FormID']);

            $data['Form_ID'] = $Form_ID;
            $data['Response'] = json_encode($response);
            $data['IP'] = $IP;
            if (!empty($_SESSION['App_User_ID']))
                $data['User_ID'] = $_SESSION['App_User_ID'];
            ELSE
                $data['User_ID'] = 0;
            $data['Date'] = time();
            $FormMsg = $this->addFormResponse($data);

            echo $FormMsg = json_encode($FormMsg);
        }
    }

    public function App_Intro()
    {
        $arrs = array();
        $result_apps = \UsersIntro::find(["Application_ID=" . Application_ID]);
        if (count($result_apps) < 1) {
            $arrs = array();
            echo $this->json_encode_convert($arrs, 'Application_Intro');
            return;
        }
        foreach ($result_apps as $output_app) {
            $arr['ID'] = $output_app->ID;
            $arr['Title'] = $output_app->Title;
            $arr['Des'] = $output_app->Des;
            $arr['Img'] = IMAGE_URL . $output_app->Img;
            $arrs[] = $arr;
        }
        echo $this->json_encode_convert($arrs, 'Application_Intro');


    }

    public function json_encode_convert($outputs, $Key = "")
    {
        /*
    if (strstr($_SERVER['HTTP_USER_AGENT'], 'iPod') || strstr($_SERVER['HTTP_USER_AGENT'], 'iPhone') || strstr($_SERVER['HTTP_USER_AGENT'], 'iPad')) {
          return json_encode($outputs);
        } else {
          $arr_Key[$Key] = $outputs;
          return json_encode($arr_Key);
        }
        */
        return json_encode($outputs);
    }

    function Artgine_Response($Stat, $Msg, $Paramters = array(), $handle = 'Err')
    {
        $Err['Stat'] = $Stat;
        $Err['Msg'] = $Msg;
        $Err['paramters'] = $Paramters;
        //$Err = $this->json_encode_convert($Err,"Message_Error");
        echo $this->json_encode_convert($Err, $handle);
        exit;
    }

    function Login()
    {
        $Pass = $_REQUEST['Pass'];
        $user = UsersMobile::findFirst(["Application_ID='" . Application_ID . "' and (Mail='$_REQUEST[User]' OR User='$_REQUEST[User]')'"]);
        if ($user) {
            //check Password
            if (!$this->security->checkHash($Pass, $user->Pass)) {
                $Parameters = array();
                $this->Artgine_Response(0, 'تسجيل الدخول خاطئ ', $Parameters);
                return;
            }
            $this->session->set('auth-identity', [

                'id' => $user->ID,

            ]);
            $Parameters = array(
                'userID' => $user->ID,
                'Img' => IMAGE_URL . '/' . $user->Img
            );
            $this->Artgine_Response(1, 'Done', $Parameters);

        } else {
            $Parameters = array();
            $this->Artgine_Response(0, 'تسجيل الدخول خاطئ ', $Parameters);
        }
    }

//    private static function Application_ID() {
//        return $_REQUEST['Application_ID'];
//    }
    public function SocialLogin()
    {


        if ($_REQUEST['Login_Type'] == 'f') {
            $Login_Type = 'facebook';
        } elseif ($_REQUEST['Login_Type'] == 't') {
            $Login_Type = 'twitter';

        } elseif ($_REQUEST['Login_Type'] == 'i') {
            $Login_Type = 'instagram';
        } else {
            $Login_Type = 'web';
        }


        if ($Login_Type == 'web') {

            $Pass = $this->security->hash($_REQUEST['Pass']);
            if ($_REQUEST['Title'] == '')
                $_REQUEST['Title'] = $_REQUEST['User'];

            if ($_REQUEST['Gender'] == '')
                $_REQUEST['Gender'] = 1;
            $Img = "";
            //Register new user
            if ($_FILES['Pic'])
                $Img = $this->Upload_File($_FILES['Pic'], 'products');
            $Join_Date = TIMENOW;
            $user = new UsersMobile();
            $user->save(
                [
                    "Title" => $_REQUEST['Title'],
                    "Address" => $_REQUEST['Address'],
                    "Map" => $_REQUEST['Map'],
                    "Mobile" => $_REQUEST['Mobile'],
                    "User" => $_REQUEST['User'],
                    "City_ID" => $_REQUEST['City_ID'],
                    "Pass" => $Pass,
                    "Gender" => $_REQUEST['Gender'],
                    "Login_Type" => "web",
                    "Join_Date" => $Join_Date,
                    "Application_ID" => Application_ID,
                    "Module_ID" => Module_ID,
                    "Img" => $Img,
                    "Mail" => $_REQUEST['Mail'],
                ]);
            $userID = $user->ID;
            if ($_REQUEST['Type'] != '') {
                $user_rel = new \UsersGroupsRel();
                $user_rel->save(
                    [
                        "User_ID" => $userID,
                        "Group_ID" => $_REQUEST['Type'],
                        "Join_Date" => $Join_Date,
                        "Application_ID" => Application_ID,
                        "Module_ID" => Module_ID,
                    ]);

                $this->connection->insert(
                    'data_products_shops',
                    array($userID, $_REQUEST['Description'], $_REQUEST['Address'], $_REQUEST['Mobile'], $_REQUEST['Title'], $_REQUEST['Map'], Application_ID, $_REQUEST['Target_Module_ID'], $Img, $Img),
                    array('User_ID', 'Description', 'Shop_Address', 'Shop_Phone', 'Title', 'Shop_Map', 'Application_ID', 'Module_ID', 'Logo', 'Img',)
                );


            }


            $_SESSION['App_User_ID'] = $userID;
            $Parameters = array(
                'userID' => $userID,
                'Img' => $Img

            );
            $this->Artgine_Response(1, 'Done', $Parameters);
        } else {
            //Try to login
            $user = UsersMobile::findFirst(["Application_ID='" . Application_ID . "' and Social_ID='$_REQUEST[Social_ID]' AND Login_Type='$Login_Type'"])->toArray();
            if ($user) {
                $_SESSION['App_User_ID'] = $user['ID'];
                $Parameters = array(
                    'userID' => $user['ID'],
                    'Img' => $user['Img']

                );
                $this->Artgine_Response(1, 'Done', $Parameters);
            }
            if ($_REQUEST['Display_Name'] != '')
                $Title = $_REQUEST['Display_Name'];
            else
                $Title = $_REQUEST['Title'];

            if ($_REQUEST['Pass'] != '')
                $Pass = $_REQUEST['Pass'];
            else
                $Pass = "";


            if ($_REQUEST['Gender'] != '')
                $Gender = $_REQUEST['Gender'];
            else
                $Gender = "";


            $Pass = $this->security->hash($_REQUEST['Pass']);

            //Register new user
            $Join_Date = TIMENOW;
            //$avatar = GetSocialAvatar($_REQUEST['Picture']);
            $user = new UsersMobile();
            $user->save(
                [
                    "Title" => $Title,
                    "User" => $Title,
                    "Pass" => $Pass,
                    "Gender" => $Gender,
                    "Login_Type" => $Login_Type,
                    "Join_Date" => $Join_Date,
                    "Application_ID" => Application_ID,
                    "Module_ID" => Module_ID,
                    "Img" => '',
                    "Mail" => '',
                    "Access_Token" => "",
                    "Social_Avatar" => "",
                    "Social_ID" => $_REQUEST['Social_ID'],
                    "Social_Type" => $_REQUEST['Social_Type'],

                ]);
            $userID = $user->ID;
            if ($userID) {
                $_SESSION['App_User_ID'] = $userID;
                $Parameters = array(
                    'userID' => $userID,
                    'Img' => ""

                );
                $this->Artgine_Response(1, 'Done', $Parameters);
            } else {
                $Parameters = array(
                    'userID' => $userID
                );
                $this->Artgine_Response(0, 'not Done', $Parameters);
            }
        }
    }

    function Profile_Str($User_ID)
    {
        $output = UsersMobile::findFirst(["Application_ID='" . Application_ID . "' and `ID`='" . $User_ID . "'"])->toArray();
        $object_empty = new Jsonobjects;
        $output = $this->Json_GetHelp_Data($output, "");
        $Others_Data['Mail'] = $output['Mail'];
        $Arr_Json = $this->Json_CData($output, $Others_Data);

        $final_results = $this->json_encode_convert($Arr_Json, "Profile");
        echo $final_results;
    }
    public function Json_CData($output,$Others_Data=array(),$Key_Value=array(),$Application_ID=4,$Module_ID=0,$Action_ID=0,$Target_Module_ID=0)
    {


        $Arr_Basc_Data=$this->Json_Basic_Data($output['ID'],$output['Title'],$output['Des'],$output['Pic'],$output['Link_Share'],$output['DateTime'],$output['Links'],$output['Images'],$output['Videos'],$output['Key'],$output['Parameter_Filter']);

        $Arr_Setting_Data=$this->Json_Arr_Setting($output['Target_Action_ID'],$output['Target_Layout_ID'],$output['Havesub'],$output['Api'],$output['Key'],$output['Dialog'],$output['Color'],$output['ID'],$output['User_ID'],$output['Link_Share'],$output['Mobile'],$output['Map'],$Application_ID,$Module_ID,$Action_ID,$Target_Module_ID);
        $Arr_Stat_Data=$this->Json_Stat_Data($output['Visit_Num'],$output['Comment_Num']);

        $Arr_Advanced_Data=$this->Json_Advanced_Data($output['Dept'],$output['Source'],$output['Shop'],$output['Model'],$output['User'],$output['Json'],$output['Author']);
        if( empty( $Others_Data ) )
            $Others_Data=new Jsonobjects;

        $Arr_Json=$this->Json_Action_Creat($Arr_Basc_Data,$Arr_Advanced_Data,$Arr_Setting_Data,$Arr_Stat_Data,$Others_Data,$Key_Value);

        return $Arr_Json;
    }
    public function Json_Help_Data($Key=0,$KTable="")
    {
        $Help_Arr=new Jsonobjects;
        if($Key!='' && $Key!='0')
        {
            $Help_Arr = $this->connection->fetchOne('SELECT ID,Img,Title  FROM '.$KTable.'  WHERE ID=' . $Key, Phalcon\Db::FETCH_ASSOC);
            $Help_Arr['Img']=IMAGE_URL .$Help_Arr['Img'];
        }
        return $Help_Arr;
    }
    public function Json_Arr_Setting($Target_Action_ID, $Target_Module_ID, $Target_Layout_ID, $Havesub, $Api, $Key, $Dialog, $Color, $Footer) {
        $Setting = array();
        $Setting['Target_Action_ID'] = "$Target_Action_ID";
        $Setting['Target_Module_ID'] = "$Target_Module_ID";
        $Setting['Target_Layout_ID'] = "$Target_Layout_ID";
        $Setting['Havesub'] = "$Havesub";
        $Setting['Key'] = "$Key";
        $Setting['Api'] = "$Api";
        $Setting['Dialog'] = "$Dialog";
        $Setting['Color'] = "$Color";
        $Setting['Footer'] = $Footer;

        return $Setting;
    }

    public function Json_Basic_Data($ID, $Title, $Des, $Pic, $Link_Share, $DateTime, $Links, $ArrImg = array(), $ArrVideo = array(), $Value = 0) {

        $Arr['ID'] = "$ID";
        $Arr['Title'] = "$Title";
        $Arr['Des'] = "$Des";
        $Arr['Pic'] = "$Pic";
        $Arr['Key'] = "$Value";
        $Arr['Link_Share'] = "$Link_Share";
        $Arr['DateTime'] = "$DateTime";
        $Arr['Links'] = "$Links";
        if (count($ArrImg) == 0)
            $ArrImg = array();
        if (count($ArrVideo) == 0)
            $ArrVideo = array();
        $Arr['Images'] = $ArrImg;
        $Arr['Videos'] = $ArrVideo;
        return $Arr;
    }
    public function Json_Stat_Data($Num_Visit, $Num_Comment) {
        $Stat = array();
        $Stat['Num_Visit'] = "$Num_Visit";
        $Stat['Comment_Num'] = "$Num_Comment";
        return $Stat;
    }
    public function Json_Advanced_Data($Dept = array(), $Source = array(), $Shop = array(), $Model = array(), $User = array(), $Content_Json = array(), $Author = array()) {
        $More_Data['Dept'] = $Dept;
        $More_Data['Source'] = $Source;
        $More_Data['Shop'] = $Shop;
        $More_Data['Model'] = $Model;
        $More_Data['User'] = $User;
        $More_Data['Author'] = $Author;
        $More_Data['Content_Json'] = $Content_Json;

        return $More_Data;
    }
    public function Json_Action_Creat($Arr_Basc_Data,$Arr_Advanced_Data=array(),$Arr_Setting_Data=array(),$Arr_Stat_Data=array(),$Arr_Others_Data=array(),$Key_Value=array())
    {
        $Arr['Basc_Data']=$Arr_Basc_Data;
        $Arr['Advanced_Data']=$Arr_Advanced_Data;
        $Arr['Setting_Data']=$Arr_Setting_Data;
        $Arr['Stat_Data']=$Arr_Stat_Data;
        $Arr['Others_Data']=$Arr_Others_Data;
        $Arr['Key_Value']=$Key_Value;
        return $Arr;
    }
    public function Json_GetHelp_Data($output,$KTable,$Setting_Json=0)
    {
        if($Setting_Json==1)
        {
            $Json['Json']=json_decode($output['Json'],true);
            $output['Json']=$Json;
        }
        else
        {
            $Json=array();
            $output['Json']=$Json;
        }

        if($KTable!="")
        {
            $output['Dept']=$this->Json_Help_Data($output['Dept_ID'],$KTable."_depts");
            $output['Source']=$this->Json_Help_Data($output['Source_ID'],$KTable."_source");
            $output['Shop']=$this->Json_Help_Data($output['Shop_ID'],$KTable."_models");
            $output['Model']=$this->Json_Help_Data($output['Model_ID'],$KTable."_shops");
            $output['User']=$this->Json_Help_Data($output['User_ID'],"users");
            $output['Author']=$this->Json_Help_Data($output['Author_ID'],$KTable."_author");
        }
        else
        {
            $output['Dept']=new Jsonobjects;
            $output['Source']=new Jsonobjects;
            $output['Shop']=new Jsonobjects;
            $output['Model']=new Jsonobjects;
            $output['User']=new Jsonobjects;
            $output['Author']=new Jsonobjects;

        }
        return $output;
    }
    public function Upload_File($FILES, $folder='', $type='image', $showerror=true) {
        $file['name'] = strtolower($FILES['name']);
        $file['size'] = $FILES['size']/1000000;
        $file['type'] = $FILES['type'];
        $tmpName = $FILES['tmp_name'];
        $ext = strtolower(substr($file['name'], strrpos($file['name'], '.')+1));
        $valid = 1;
        if(is_array($type)){
            $max_size = 10;
            $valid_exe = $type;
        }
        elseif($type == 'image') {
            $max_size = 10;
            $valid_exe = array('jpg', 'jpeg', 'png', 'gif');
        }
        elseif($type == 'sound'){
            $max_size = 50;
            $valid_exe = array('mp3');
        }
        elseif($type == 'json'){
            $max_size = 50;
            $valid_exe = array('json');
        }
        elseif($type == 'video') {
            $max_size = 50;
            $valid_exe = array('avi', 'mpeg', 'flv', '3gp', 'mpg', 'mp4', 'caf', 'mov');
        }
        else{
            $max_size = 20;
            $valid_exe = array('jpg', 'jpeg', 'png', 'gif', 'doc', 'docx', 'pdf', 'zip', 'txt');
        }
        if(!in_array($ext, $valid_exe)) {
            $valid = 0;
            $error = 'نوع الملف غير مسموح به';
        }
        if($file['size'] > $max_size) {
            $valid = 0;
            $error = 'حجم الملف تعدى الحجم المسموح به';
        }
        if($valid == 1) {
            $path=ROOT_DIR.'/'.UPLOAD_DIR.'/'.$folder;
            $path=str_ireplace("engine/app/","",$path);
            if(!file_exists($path)) {
                mkdir($path);
            }
            $secname = md5(rand(10000, 50000).time()).'.'.$ext;
            $target_path = $path.'/'.$secname;
            move_uploaded_file($tmpName, $target_path);
            if(file_exists($target_path)){
                return $folder.'/'.$secname;
            }
            else{
                if($showerror){
                    $this->showmsg('فشل رفع الملف من فضلك حاول مرة اخرى', 0);
                }
                else{
                    return false;
                }
            }
        }
        else{
            if($showerror){
                $this->showmsg($error, 0);
            }
            else{
                return false;
            }
        }
    }
    public function Cms_Stat_Data($Item_ID, $Type)
    {
        $Stat_Data = array();
        $Stat_Data['Num_Visit'] = 0;
        $Stat_Data['Comment_Num'] = 0;
        $sql = "SELECT * FROM data_cms_stat WHERE `Type` =  '" . $Type . "' and Item_ID='" . $Item_ID . "'";
        $output = $this->connection->fetchone($sql);
        $output = \DataCmsStat::findFirst(["Type =  '" . $Type . "' and Item_ID='" . $Item_ID ])->toArray();
        if ($output) {
            $Stat_Data['Num_Visit'] = $output['Num_Visit'];
            $Stat_Data['Comment_Num'] = $output['Comment_Num'];
        }
        return $Stat_Data;
    }
	
	public function getIP(){
		if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
	    $ip = $_SERVER['HTTP_CLIENT_IP'];
		} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
		    $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
		} else {
		    $ip = $_SERVER['REMOTE_ADDR'];
		}
		return $ip;
	}
	public function addFormResponse($data) {
        //$this->connection->insert('data_form_response', $data);
		$data = new DataFormsResponse();
		$data->save($data);
		$FormMsg['Stat']=1;
		$FormMsg['Msg']="تم الارسال بنجاح";
        return $FormMsg;
    }
	



}