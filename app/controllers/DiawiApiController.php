<?php


namespace Vokuro\Controllers;


use Models\UsersMobile;

use Models\Content;

use Models\DataCmsUsersFollow;

use Phalcon\Builder\Controller;

use Phalcon\Http\Request;

use Phalcon\Paginator\Adapter\Model as Paginator;

use Phalcon\Mvc\Model\Criteria;

use Phalcon\Security;

use Phalcon\Security\Random;

use Phalcon\Mvc\Url;

use Vokuro\Forms\AdvancedSearchForm;

use Vokuro\Pentavalue\Keyvalue;

use Phalcon\Mvc\Model\QueryBuilder;

use DataTables\DataTable;
use Vokuro\Models\ResetPasswords;
use Models\GeoCities;
// use Models\GoappDataCmsZones;
// use Models\GoappUsersInfo;


use Vokuro\Pentavalue\Jsonobjects;


class DiawiApiController extends ControllerApiBase

{

    const APPLICATION_ID = 593;

    const URL = "http://penta-test.com/robo_cms/uploads/";


    public function indexAction()
    {

        $this->view->disable();
        $json_obj = new Jsonobjects();
        $action = $_REQUEST['Action'];
        if (isset($_REQUEST['lang'])) {
            $lang_id = $_REQUEST['lang'];
        } else {
            $lang_id = 1;
        }
        $Application = \UsersApplication::findFirst(["ID=" . static::APPLICATION_ID]);

        switch ($action) {

            case "PlacesCategories":

                $arr = array();

                $data = array();

                $depts = \DataCmsDeptsRel::find("Core_Depts_ID=28");

                if (count($depts) < 1) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'There is no departments at this time';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                foreach ($depts as $dept) {
                    $data_row['Dept_ID'] = $dept->ID;
                    $lang = $dept->getDeptRelLang(["lang_id={$lang_id}"]);
                    if ($lang) {
                        $data_row['Title'] = $lang->title;

                        //$data_row['Des'] = $dept->Des;
                    } else {
                        $data_row['Title'] = $dept->Title;

                       // $data_row['Des'] = $dept->Des;
                    }

                   // $data_row['Img'] = static::URL . $dept->Img;

                    $data['Places'][] = $data_row;

                }

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;

            case "CategoryPlaces":

                // Get Places in Category

                $arr = array();

                $data = array();

                $Module_ID = 20195;

                if (!isset($_GET["Dept_ID"])) {

                    $arr['eCode'] = 422;

                    $arr['eMessage'] = 'Dept_ID is not set';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                $dept_id = $this->request->getQuery('Dept_ID');

                $products = \DataCmsDeptsRelItem::find(["Module_ID={$Module_ID} AND Depts_ID={$dept_id}"]);

                if (count($products) < 1) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'There is no places at this time';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                // $dept = \DataCmsDeptsRel::findfirst(["ID={$dept_id}"]);
                // $lang = $dept->getDeptRelLang(["lang_id={$lang_id}"]);
                // if ($lang) {
                    // $data['Department'] = array("ID" => $dept_id, "Name" => $lang->Title, "Des" => $dept->Des);
                // } else {
                    // $data['Department'] = array("ID" => $dept_id, "Name" => $dept->Title, "Des" => $dept->Des);
                // }


                foreach ($products as $product) {

                    $product_row = array();

                    $product_row['ID'] = $product->Content->ID;
                    $langs = $product->Content->getLang(["lang_id={$lang_id}"]);
                    if (count($langs) > 0) {
                        foreach ($langs as $lang) {
                            $product_row['Title'] = $lang->title;
                            $product_row['Desc'] = $lang->des;
                            $product_row['Details'] = $lang->content;
                        }

                    } else {
                        $product_row['Title'] = $product->Content->Title;

                        $product_row['Desc'] = $product->Content->Des;
                        $product_row['Details'] = $product->Content->Content;
                    }


                    $product_row['Img'] = static::URL . $product->Content->Img;

                    foreach ($product->Content->DataKeyvalueUserdata as $keyvalue) {

                        if ($keyvalue->DKV_ID == 40) {

                            //$product_row['Price'] = $keyvalue->Value;

                        }

                    }
					
					$followers = DataCmsUsersFollow::find(["data_cms_id={$product_row['ID']} and type=1"]);
                $product_row['Followers'] = count($followers);
                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $product_row['Followed'] = 0;
                } else {
                    $follow = DataCmsUsersFollow::findFirst(["data_cms_id={$product_row['ID']} and type=1 and user_id={$user->ID}"]);
                    if (!$follow) {
                        $product_row['Followed'] = 0;
                    } else {
                        $product_row['Followed'] = 1;
                    }
                }
				
				
                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $product_row['Favorite '] = 0;
                } else {
                    $follow = DataCmsUsersFollow::findFirst(["data_cms_id={$product_row['ID']} and type=2 and user_id={$user->ID}"]);
                    if (!$follow) {
                        $product_row['Favorite '] = 0;
                    } else {
                        $product_row['Favorite '] = 1;
                    }
                }
				
				//rating
				$product_row['Rate'] = rand(1,5);


                    $data['Places'][] = $product_row; 

                }


                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;

            case "Place":

                $arr = array();

                $data = array();

                $Module_ID = 20195;

                if (!isset($_REQUEST['Place_ID'])) {

                    $arr['eCode'] = 422;

                    $arr['eMessage'] = 'Place_ID is not set';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                $product_id = $_REQUEST['Place_ID'];

                $product = Content::findFirst(["Module_ID={$Module_ID} AND ID={$product_id}"]);

                if (!$product) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'Ther is no matching product';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }

                $product_row = array();
                $product_row['ID'] = $product->ID;
                $langs = $product->getLang(["lang_id={$lang_id}"]);
                if (count($langs) > 0) {
                    foreach ($langs as $lang) {
                        $product_row['Title'] = $lang->title;
                        $product_row['Desc'] = $lang->des;
                        $product_row['Details'] = $lang->content;
                    }

                } else {
                    $product_row['Title'] = $product->Title;

                    $product_row['Desc'] = $product->Des;
                    $product_row['Details'] = $product->Content;
                }
                $product_row['Img'] = static::URL . $product->Img;
				$product_row['Budget'] = 0;
				$product_row['Location'] = "";
				$product_row['Open_From'] = "";
				$product_row['Open_To'] = "";
				$product_row['Class'] = "";
				$options = \DataKeyvalueOption::find(["DKV_ID=97"]);
                            foreach ($options as $option) {
                                $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$option->ID}"]);                                
                                    $product_row[$option_lang->Title] = 0;                                
                            };
				$product_row['Address'] = "";
				$product_row['Wifi'] ="";
				$product_row['Mobile'] ="";
				$product_row['Other_Mobile'] = "";
				$product_row['Other_Mobile_2'] = "";
				$product_row['Other_Mobile_3'] = "";
				$product_row['Other_Mobile_4'] = "";
				
				$options = \DataKeyvalueOption::find(["DKV_ID=97"]);
				$product_row[$option_lang->Title] = 0;
                foreach ($product->DataKeyvalueUserdata as $keyvalue) {
                    $value = $keyvalue->Value;
                    switch ($keyvalue->DKV_ID) {
                        case 92: //budget
                            $product_row['Budget'] = $value;
                            break;

                        case 93: //Location
                            $product_row['Location'] = $value;
                            break;

                        case 94: //OpenFrom
                            $product_row['Open_From'] = $value;
                            break;

                        case 95: //OpenTo
                            $product_row['Open_To'] = $value;
                            break;


                        case 96: //Class
                            $product_row['Class'] = $value;
                            break;


                        case 97: //Mood
                            $value_arr = explode(",", $value);
                            //get Options
                            $options = \DataKeyvalueOption::find(["DKV_ID=97"]);
                            foreach ($options as $option) {
                                $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$option->ID}"]);
                                if (in_array($option->ID, $value_arr)) {
                                    $product_row[$option_lang->Title] = 1;
                                } else {
                                    $product_row[$option_lang->Title] = 0;
                                }
                            }

                            break;


                        case 98: //Address
                            $product_row['Address'] = $value;
                            break;

                        case 99: //WiFi
                            if ($value == 62) {
                                $product_row['Wifi'] = 1;
                            } else {
                                $product_row['Wifi'] = 0;
                            }

                            break;


                        case 100: //Outdoor/Indoor
                            $value_arr = explode(",", $value);
                            //get Options
                            $options = \DataKeyvalueOption::find(["DKV_ID=100"]);
                            foreach ($options as $option) {
                                $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$option->ID}"]);
                                if (in_array($option->ID, $value_arr)) {
                                    $product_row[$option_lang->Title] = 1;
                                } else {
                                    $product_row[$option_lang->Title] = 0;
                                }
                            }
                            break;

                        case 101: //TypeOfpeople
                            $value_arr = explode(",", $value);
                            //get Options
                            $options = \DataKeyvalueOption::find(["DKV_ID=101"]);
                            foreach ($options as $option) {
                                $option_lang = \DataKeyvalueOptionLang::findFirst(["Option_ID={$option->ID}"]);
                                if (in_array($option->ID, $value_arr)) {
                                    $product_row[$option_lang->Title] = 1;
                                } else {
                                    $product_row[$option_lang->Title] = 0;
                                }
                            }
                            break;

                        case 106: //Mobile
                            $product_row['Mobile'] = $value;
                            break;


                        case 107: //Other Mobile
                            $product_row['Other_Mobile'] = $value;
                            break;


                        case 108: //Other Mobile 2
                            $product_row['Other_Mobile_2'] = $value;
                            break;

                        case 109: //Other Mobile 3
                            $product_row['Other_Mobile_3'] = $value;
                            break;

                        case 108: //Other Mobile 4
                            $product_row['Other_Mobile_4'] = $value;
                            break;


                        default:

                            break;
                    }

                }


                $followers = DataCmsUsersFollow::find(["data_cms_id={$product_id} and type=1"]);
                $product_row['Followers'] = count($followers);
                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $product_row['Followed'] = 0;
                } else {
                    $follow = DataCmsUsersFollow::findFirst(["data_cms_id={$product_id} and type=1 and user_id={$user->ID}"]);
                    if (!$follow) {
                        $product_row['Followed'] = 0;
                    } else {
                        $product_row['Followed'] = 1;
                    }
                }
				
				
                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $product_row['Favorite '] = 0;
                } else {
                    $follow = DataCmsUsersFollow::findFirst(["data_cms_id={$product_id} and type=2 and user_id={$user->ID}"]);
                    if (!$follow) {
                        $product_row['Favorite '] = 0;
                    } else {
                        $product_row['Favorite '] = 1;
                    }
                }
				
				//rating
				$product_row['Rate'] = rand(1,10);
				//restrictions
				$product_row['Restrictions'] = "Alcoholic Beverages";

                // $product_row['Likes']= 2132;
                // $product_row['CheckIn']= 232;

                //get media Images

                $media = \DataCmsMedia::find(["Module_ID={$Module_ID} AND Type='Img'"]);
                if (count($media) > 0) {
                    foreach ($media as $key => $value) {
                        $product_row['Media'][] = static::URL . $value->Img;
                    }
                } else {
                    $product_row['Media'][] = [];
                }

                //get Menus
                //$media = \DataCmsMedia::find(["Module_ID={$Module_ID} AND Type='Img'"]);
                if (count($media) > 0) {
                    foreach ($media as $key => $value) {
                        $product_row['Menus'][] = static::URL . $value->Img;
                    }
                } else {
                    $product_row['Menus'][] = [];
                }
                //get promotions
                $product_row['promos'] = [];
                $promotions = \DataModuleRelationsCms::find(array("parent_cms_id={$product->ID}"));
                foreach ($promotions as $promo) {
                    $promo_row['ID'] = $product->ID;
                    $langs = $promo->Offers->getLang(["lang_id={$lang_id}"]);
                    if (count($langs) > 0) {
                        foreach ($langs as $lang) {
                            $promo_row['Title'] = $lang->title;
                            $promo_row['Desc'] = $lang->des;
                            $promo_row['Details'] = $lang->content;
                        }

                    } else {
                        $promo_row['Title'] = $promo->Offers->Title;

                        $promo_row['Desc'] = $promo->Offers->Des;
                        $promo_row['Details'] = $promo->Offers->Content;
                    }
                    $promo_row['Img'] = static::URL . $promo->Offers->Img;
                    $product_row['promos'][] = $promo_row;
                }

                $data[] = $product_row;

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $product_row;


                echo json_encode($arr);

                break;

            case "EventsCategories":

                $arr = array();

                $data = array();

                $depts = \DataCmsDeptsRel::find("Core_Depts_ID=29");

                if (count($depts) < 1) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'There is no departments at this time';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                foreach ($depts as $dept) {
                    $data_row['Dept_ID'] = $dept->ID;
                    $lang = $dept->getDeptRelLang(["lang_id={$lang_id}"]);
                    if ($lang) {
                        $data_row['Title'] = $lang->title;

                      //  $data_row['Des'] = $dept->Des;
                    } else {
                        $data_row['Title'] = $dept->Title;

                       // $data_row['Des'] = $dept->Des;
                    }

                    //$data_row['Img'] = static::URL . $dept->Img;

                    $data['Event_Categories'][] = $data_row;

                }

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;

            case "CategoryEvents":

                // Get Places in Category

                $arr = array();

                $data = array();

                $Module_ID = 20196;

                if (!isset($_GET["Dept_ID"])) {

                    $arr['eCode'] = 422;

                    $arr['eMessage'] = 'Dept_ID is not set';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                $dept_id = $this->request->getQuery('Dept_ID');

                $products = \DataCmsDeptsRelItem::find(["Module_ID={$Module_ID} AND Depts_ID={$dept_id}"]);

                if (count($products) < 1) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'There is no places at this time';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                // $dept = \DataCmsDeptsRel::findfirst(["ID={$dept_id}"]);
                // $lang = $dept->getDeptRelLang(["lang_id={$lang_id}"]);
                // if ($lang) {
                    // $data['Department'] = array("ID" => $dept_id, "Name" => $lang->Title, "Des" => $dept->Des);
                // } else {
                    // $data['Department'] = array("ID" => $dept_id, "Name" => $dept->Title, "Des" => $dept->Des);
                // }


                foreach ($products as $product) {

                    $product_row = array();

                    $product_row['ID'] = $product->Content->ID;
                    $langs = $product->Content->getLang(["lang_id={$lang_id}"]);
                    if (count($langs) > 0) {
                        foreach ($langs as $lang) {
                            $product_row['Title'] = $lang->title;
                            $product_row['Desc'] = $lang->des;
                            $product_row['Details'] = $lang->content;
                        }

                    } else {
                        $product_row['Title'] = $product->Content->Title;

                        $product_row['Desc'] = $product->Content->Des;
                        $product_row['Details'] = $product->Content->Content;
                    }


                    $product_row['Img'] = static::URL . $product->Content->Img;

                    $product_row['Mega'] = 0;

                    foreach ($product->Content->getDataKeyvalueUserdata("DKV_ID=115 AND Value=70") as $keyvalue) {

                        $product_row['Mega'] = 1;


                    }


                    $data['Events'][] = $product_row;

                }


                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;


            case "MegaEventsInCategory":


                // Get Places in Category

                $arr = array();

                $data = array();

                $Module_ID = 20196;

                if (!isset($_GET["Dept_ID"])) {

                    $arr['eCode'] = 422;

                    $arr['eMessage'] = 'Dept_ID is not set';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                $dept_id = $this->request->getQuery('Dept_ID');

                $products = $this->modelsManager->createBuilder()
                    ->from("Models\Content")
                    ->join("DataCmsDeptsRelItem")
                    ->join("DataKeyvalueUserdata")
                    ->andWhere("DataKeyvalueUserdata.Value = :value:", ["value" => 70])
                    ->andWhere("DataCmsDeptsRelItem.Depts_ID = :dept_id:", ["dept_id" => $dept_id])
                    ->groupBy(array('Models\Content.ID'))
                    ->getQuery()
                    ->execute();

                if (count($products) < 1) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'There is no places at this time';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                // $dept = \DataCmsDeptsRel::findfirst(["ID={$dept_id}"]);
                // $lang = $dept->getDeptRelLang(["lang_id={$lang_id}"]);
                // if ($lang) {
                    // $data['Department'] = array("ID" => $dept_id, "Name" => $lang->Title, "Des" => $dept->Des);
                // } else {
                    // $data['Department'] = array("ID" => $dept_id, "Name" => $dept->Title, "Des" => $dept->Des);
                // }


                foreach ($products as $product) {

                    $product_row = array();

                    $product_row['ID'] = $product->ID;
                    $langs = $product->getLang(["lang_id={$lang_id}"]);
                    if (count($langs) > 0) {
                        foreach ($langs as $lang) {
                            $product_row['Title'] = $lang->title;
                            $product_row['Desc'] = $lang->des;
                            $product_row['Details'] = $lang->content;
                        }

                    } else {
                        $product_row['Title'] = $product->Title;

                        $product_row['Desc'] = $product->Des;
                        $product_row['Details'] = $product->Content;
                    }


                    $product_row['Img'] = static::URL . $product->Img;


                    $data['Events'][] = $product_row;

                }


                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;


            case "Event":

                $arr = array();

                $data = array();

                $Module_ID = 20196;

                if (!isset($_REQUEST['Event_ID'])) {

                    $arr['eCode'] = 422;

                    $arr['eMessage'] = 'Event_ID is not set';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }

                $product_id = $_REQUEST['Event_ID'];

                $product = Content::findFirst(["Module_ID={$Module_ID} AND ID={$product_id}"]);

                if (!$product) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'Ther is no matching product';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }

                $product_row = array();
                $product_row['ID'] = $product->ID;
                $langs = $product->getLang(["lang_id={$lang_id}"]);
                if (count($langs) > 0) {
                    foreach ($langs as $lang) {
                        $product_row['Title'] = $lang->title;
                        $product_row['Desc'] = $lang->des;
                        $product_row['Details'] = $lang->content;
                    }

                } else {
                    $product_row['Title'] = $product->Title;

                    $product_row['Desc'] = $product->Des;
                    $product_row['Details'] = $product->Content;
                }
                $product_row['Img'] = static::URL . $product->Img;
				$product_row['Location'] = "";
				$product_row['Start_Time'] = "";
				$product_row['End_Time'] = "";
				$product_row['Date'] = "";
				$product_row['Mega_Event'] = "";
				$product_row['ِAddress'] = "City Stars Mall, Nasr City";

                foreach ($product->DataKeyvalueUserdata as $keyvalue) {

                    $value = $keyvalue->Value;
                    switch ($keyvalue->DKV_ID) {
                        case 111: //Location
                            $product_row['Location'] = $value;
                            break;

                        case 112: //StartTime
                            $product_row['Start_Time'] = $value;
                            break;

                        case 113: //EndTime
                            $product_row['End_Time'] = $value;
                            break;

                        case 114: //Date
                            $product_row['Date'] = $value;
                            break;

                        case 115: //MegaEvent
                            if ($value == 70) {
                                $product_row['Mega_Event'] = 1;
                            } else {
                                $product_row['Mega_Event'] = 0;
                            }

                            break;


                        default:

                            break;
                    }

                }
                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $product_row['Going'] = 0;
                } else {
                    $follow = DataCmsUsersFollow::findFirst(["data_cms_id={$product_id} and type=3 and user_id={$user->ID}"]);
                    if (!$follow) {
                        $product_row['Going'] = 0;
                    } else {
                        $product_row['Going'] = 1;
                    }
                }


                $data[] = $product_row;

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $product_row;

                echo json_encode($arr);

                break;

            case "User":

                $arr = array();

                $data = array();

                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'you are not logged in';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $user_id = $user->ID;

                $user = UsersMobile::findFirst(["ID={$user_id} AND Application_ID=" . static::APPLICATION_ID]);

                if (!$user) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'User Not Found';

                    $arr['eContent'] = [];

                    echo json_encode($arr);

                    break;

                }

                $data_row['ID'] = $user->ID;

                $data_row['UserName'] = $user->User;

                $data_row['Mobile'] = $user->Mobile;

                $data_row['E-Mail'] = $user->Mail;

                $data_row['Pass_Hash'] = $user->Pass;

                $data_row['Name'] = $user->Title;

                //$data_row['DateOfBirth'] = date("m/d/Y", $user->AdvancedInfo->Date_Birth);

                $data_row['Gender'] = $user->Gender;

                $followers = DataCmsUsersFollow::find(["user_id={$user_id} AND module_id=20195 and type =1"]);
                $data_row['Num_Follow'] = count($followers);

                $favs = DataCmsUsersFollow::find(["user_id={$user_id} AND module_id=20195 and type =2"]);
                $data_row['Num_Fav'] = count($favs);

                $data_row['User_Img'] = static::URL . $user->Img;

                $data[] = $data_row;

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;

            case "UserFav":
                $arr = array();

                $data = array();

                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'you are not logged in';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $user_id = $user->ID;

                $user = UsersMobile::findFirst(["ID={$user_id} AND Application_ID=" . static::APPLICATION_ID]);

                if (!$user) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'User Not Found';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }

                $favs = DataCmsUsersFollow::find(["user_id={$user_id} AND module_id=20195 and type =2"]);
                foreach ($favs as $product) {

                    $product_row = array();

                    $product_row['ID'] = $product->Content->ID;
                    $langs = $product->Content->getLang(["lang_id={$lang_id}"]);
                    if (count($langs) > 0) {
                        foreach ($langs as $lang) {
                            $product_row['Title'] = $lang->title;
                            $product_row['Desc'] = $lang->des;
                            $product_row['Details'] = $lang->content;
                        }

                    } else {
                        $product_row['Title'] = $product->Content->Title;

                        $product_row['Desc'] = $product->Content->Des;
                        $product_row['Details'] = $product->Content->Content;
                    }


                    $product_row['Img'] = static::URL . $product->Content->Img;
					$product_row['Rate'] = rand(1, 5);


                    $data['Places'][] = $product_row;

                }


                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;

            case "UserFollow":
                $arr = array();

                $data = array();

                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'you are not logged in';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $user_id = $user->ID;

                $user = UsersMobile::findFirst(["ID={$user_id} AND Application_ID=" . static::APPLICATION_ID]);

                if (!$user) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'User Not Found';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }

                $favs = DataCmsUsersFollow::find(["user_id={$user_id} AND module_id=20195 and type =1"]);
                foreach ($favs as $product) {

                    $product_row = array();

                    $product_row['ID'] = $product->Content->ID;
                    $langs = $product->Content->getLang(["lang_id={$lang_id}"]);
                    if (count($langs) > 0) {
                        foreach ($langs as $lang) {
                            $product_row['Title'] = $lang->title;
                            $product_row['Desc'] = $lang->des;
                            $product_row['Details'] = $lang->content;
                        }

                    } else {
                        $product_row['Title'] = $product->Content->Title;

                        $product_row['Desc'] = $product->Content->Des;
                        $product_row['Details'] = $product->Content->Content;
                    }


                    $product_row['Img'] = static::URL . $product->Content->Img;


                    $data['Places'][] = $product_row;

                }


                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;

            case "FollowPlace":
                $arr = array();

                $data = array();

                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'you are not logged in';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $user_id = $user->ID;

                $user = UsersMobile::findFirst(["ID={$user_id} AND Application_ID=" . static::APPLICATION_ID]);

                if (!$user) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'User Not Found';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }
                if (!isset($_REQUEST['Place_ID'])) {

                    $arr['eCode'] = 422;

                    $arr['eMessage'] = 'Place_ID is not set';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }
                $place_id = $_REQUEST['Place_ID'];
                //check if the user is already following the place
                $place = DataCmsUsersFollow::findFirst(["user_id={$user_id} AND data_cms_id={$place_id} AND type=1 AND module_id=20195"]);
                if (!$place) {
                    
                    $place = new DataCmsUsersFollow();
                    $place->user_id = $user_id;
                    $place->data_cms_id = $place_id;
                    $place->module_id = 20195;
                    $place->application_id = static::APPLICATION_ID;
                    $place->type = 1;
                    $place->save();
                    $arr['eCode'] = 200;
                    $arr['eMessage'] = "Success";
                    $arr['eContent'] = $json_obj;
                    echo json_encode($arr);
                    return;

                } else {
                    $arr['eCode'] = 200;
                    $arr['eMessage'] = "Already Following";
                    $arr['eContent'] = $json_obj;
                    echo json_encode($arr);
                    return;
                }
                break;

            case "FavPlace":
                $arr = array();

                $data = array();

                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'you are not logged in';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $user_id = $user->ID;

                $user = UsersMobile::findFirst(["ID={$user_id} AND Application_ID=" . static::APPLICATION_ID]);

                if (!$user) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'User Not Found';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }
                if (!isset($_REQUEST['Place_ID'])) {

                    $arr['eCode'] = 422;

                    $arr['eMessage'] = 'Place_ID is not set';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }
                $place_id = $_REQUEST['Place_ID'];
                //check if the user is already following the place
                $place = DataCmsUsersFollow::findFirst(["user_id={$user_id} AND data_cms_id={$place_id} AND type=2 AND module_id=20195"]);
                if (!$place) {
                    $place = new DataCmsUsersFollow();
                    $place->user_id = $user_id;
                    $place->data_cms_id = $place_id;
                    $place->module_id = 20195;
                    $place->application_id = static::APPLICATION_ID;
                    $place->type = 2;
                    $place->save();
                    $arr['eCode'] = 200;
                    $arr['eMessage'] = "Added to favourites";
                    $arr['eContent'] = $json_obj;
                    echo json_encode($arr);
                    return;

                } else {
                    $arr['eCode'] = 200;
                    $arr['eMessage'] = "Already in favourites";
                    $arr['eContent'] = $json_obj;
                    echo json_encode($arr);
                    return;
                }
                break;

            case "GoingToEvent":
                $arr = array();

                $data = array();

                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'you are not logged in';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $user_id = $user->ID;

                $user = UsersMobile::findFirst(["ID={$user_id} AND Application_ID=" . static::APPLICATION_ID]);

                if (!$user) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'User Not Found';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }
                if (!isset($_REQUEST['Event_ID'])) {

                    $arr['eCode'] = 422;

                    $arr['eMessage'] = 'Event_ID is not set';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;

                }
                $place_id = $_REQUEST['Event_ID'];
                //check if the user is already going to this event
                $place = DataCmsUsersFollow::findFirst(["user_id={$user_id} AND data_cms_id={$place_id} AND type=3 AND module_id=20196"]);
                if (!$place) {
                    
                    $place = new DataCmsUsersFollow();
                    $place->user_id = $user_id;
                    $place->data_cms_id = $place_id;
                    $place->module_id = 20196;
                    $place->application_id = static::APPLICATION_ID;
                    $place->type = 3;
                    if(!$place->save()){
                    	die(print_r($place->getMessages()));
                    }
                    $arr['eCode'] = 200;
                    $arr['eMessage'] = "Going";
                    $arr['eContent'] = $json_obj;
                    echo json_encode($arr);
                    return;

                } else {
                    $arr['eCode'] = 200;
                    $arr['eMessage'] = "Already Going";
                    $arr['eContent'] = $json_obj;
                    echo json_encode($arr);
                    return;
                }
                break;


            case "EditProfile":

                $arr = array();

                $data = array();

                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'you are not logged in';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $user_id = $user->ID;

                $first_name = $this->request->getQuery("First_Name");

                $last_name = $this->request->getQuery("Last_Name");

                $mobile = $this->request->getQuery("Mobile");

                $user = UsersMobile::findFirst(["ID={$user_id}"]);

                $user->Mobile = $mobile;

                $user->AdvancedInfo->First_Name = $first_name;

                $user->AdvancedInfo->Last_Name = $last_name;

                if (!$user->save()) {

                    $arr['eCode'] = 1;

                    $arr['eMessage'] = implode(",", $user->getMessages());;

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }

                $user->save();

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Saving Done";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;

            case "CheckLogin":

                $arr = array();

                $data = array();

                $user_name = $this->request->get("User");

                $pass = $this->request->get("Pass");

                $user = UsersMobile::findFirst(["User='" . $user_name . "' AND Application_ID=" . static::APPLICATION_ID]);

                if (!$user) {
                	
					$user = UsersMobile::findFirst(["Mail='" . $user_name . "' AND Application_ID=" . static::APPLICATION_ID]);
					
					if(!$user){
						$user = UsersMobile::findFirst(["Mobile='" . $user_name . "' AND Application_ID=" . static::APPLICATION_ID]);
						if(!$user){
							$arr['eCode'] = 204;

		                    $arr['eMessage'] = 'User Not Found';
		
		                    $arr['eContent'] = $json_obj;
		
		                    echo json_encode($arr);
		
		                    break;
						}
					}

                    

                }

                if (!$this->security->checkHash($pass, $user->Pass)) {

                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'Password is wrong';

                    $arr['eContent'] = '';

                    echo json_encode($arr);

                    break;

                }

                $this->session->set('goapp-identity', [

                    'id' => $user->ID,
                    'name' => $user->Title,
                    'Application_Route' => 0,
                    'Application_ID' => static::APPLICATION_ID,

                ]);

                $data['ID'] = $user->ID;

                $data['Name'] = $user->Title;

                $data['UserName'] = $user->User;

                $data['E-Mail'] = $user->Mail;

                $data['Mobile'] = $user->Mobile;

                $data['Session_ID'] = "PHPSESSID=" . $this->session->getId();
                $arr['eCode'] = 200;

                $arr['eMessage'] = "Login Successfully";

                $arr['eContent'] = $data;

                echo json_encode($arr);

                break;

            case "Register_Token":

                $arr = array();

                $data = array();

                $token = $this->request->getQuery("Token");

                $type = $this->request->getQuery("Type");

                $user_token = \UsersToken::findFirst(["Token='" . $token . "'"]);

                if ($user_token) {

                    $Token_ID = $user_token->ID;

                    $bool = false;

                    $arr['eCode'] = 200;

                    $arr['eMessage'] = "true";

                    $data['accessToken'] = $user_token->Token;

                    $data['tokenType'] = $user_token->Type;

                    $data['userName'] = $user_token->User->User;

                    $data['issueDate'] = "issueDate";

                    $data['expiryDate'] = "expiryDate";

                    $data['expiresIn'] = "expiresIn";

                    $arr['eContent'] = $data;

                    echo json_encode($arr);

                    break;

                }

                $arr['eCode'] = 409;

                $arr['eMessage'] = 'Error';

                $arr['eContent'] = $json_obj;

                echo json_encode($arr);

                break;

            case "Cities":

                $arr = array();

                $data = array();

                $module_id = 20172;

                $country_id = $this->request->getQuery("Country");

                $cities = \DataCmsDeptsRel::find(["Core_Depts_ID={$country_id} AND Module_ID={$module_id}"]);

                if (conut($cities) < 0) {

                    $arr['eCode'] = 204;

                    $arr['eMessage'] = 'There is no Cities';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }

                foreach ($cities as $city) {

                    $data_row = array();

                    $data_row['ID'] = $city->ID;

                    $data_row['Name'] = $city->Title;

                    $data_row['Areas'] = array();

                    foreach ($city->DeptsContent as $content) {

                        $area['ID'] = $content->Item_ID;

                        $area['Name'] = $content->Content->Title;

                        $data_row['Areas'][] = $area;

                    }

                    $data[] = $data_row;

                }

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;


            case "Register_Account":

                $arr = array();

                $data = array();

                $mail = $this->request->get("Email");

                //check if e-mail exists in the same app
                $check_user = UsersMobile::findFirst(["Mail='{$mail}' AND Application_ID=" . static::APPLICATION_ID]);
                if ($check_user) {
                    $arr['eCode'] = 204;

                    $arr['eMessage'] = "User Exists With the Same E-Mail";

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;
                }

                $name = $this->request->get("Name");

                $user_name = $this->request->get("User");

                $pass = $this->request->get("Pass");

                $mobile = $this->request->get("Phone");

                $gender = $this->request->get("Gender");
				
				$pic =  "profile_pic_sample.png";
				
				 if ($this->request->hasFiles() == true) {
		            foreach ($this->request->getUploadedFiles() as $file) {
		                if ($file->getKey() == "ProfilePic") {
		                    //die("Islam");
		                    $random = new Random();
		                    $random_name = $random->uuid() . "." . $file->getExtension();
		
		                    $file->moveTo(static::UPLOAD_LOCATION . $random_name);
							$pic = $random_name;
		
		                }
		            }
		
		        }

                

                $date_birth = $this->request->get("DateOfBirth") ?: "";

                $zone = $this->request->get("zone") ?: "1";

                $user = new UsersMobile();

                $user->Mail = $mail;

                $user->Pass = $this->security->hash($pass);

                $user->Mobile = $mobile;

                $user->Gender = $gender;

                $user->Application_ID = static::APPLICATION_ID;

                $user->Title = $name;

                $user->Module_ID = 0;

                $user->User = $user_name;

                $user->Img = $pic;

                if (!$user->save()) {

                    // foreach ($user->getMessages() as $message) {

                    // $this->flash->error($message);

                    // }

                    $arr['eCode'] = 1;

                    $arr['eMessage'] = implode(",", $user->getMessages());

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    break;

                }

                $user_info = new GoappUsersInfo();
                $user_info->user_id = $user->ID;
                $user_info->zone_id = $zone;
                $user_info->application_id = $user->Application_ID;
                $user_info->save();

                $data_row['ID'] = $user->ID;

                $data_row['Mail'] = $user->Mail;

                $data_row['User'] = $user->User;

                $data[] = $data_row;

                $arr['eCode'] = 200;

                $arr['eMessage'] = "User Created Successfully";

                $arr['eContent'] = $data_row;


                echo json_encode($arr);

                break;

            case "Discover":

                $q = $this->request->get("q");
                if ($lang_id == 1) {
                    $search = Content::find(["(Title like '%" . $q . "%' AND Module_ID=20195) 
                OR (Des like'%" . $q . "%'AND Module_ID=20195) 
                "]);
                    if (count($search) < 1) {

                        $arr['eCode'] = 204;

                        $arr['eMessage'] = "There is no matching item";

                        $arr['eContent'] = $json_obj;

                        echo json_encode($arr);

                        break;

                    }

                    $data = array();

                    foreach ($search as $item) {

                        $data_row["ID"] = $item->ID;

                        $data_row["Title"] = $item->Title;

                        $data_row['Desc'] = $item->Des;
						
                        $data_row['Img'] = static::URL . $item->Img;
						
						$data_row['Rate'] = 4;

                        

                        $data[] = $data_row;

                    }
                } else {
                    $getContent = Content::find(["Module_ID=20181"]);
                    $data = array();
                    foreach ($getContent as $filter) {

                        $search = $filter->getLang(["lang_id={$lang_id} AND title like '%" . $q . "%'"]);
                        if (count($search) < 1) {

                            $arr['eCode'] = 204;

                            $arr['eMessage'] = "There is no matching item ";

                            $arr['eContent'] = $j;

                            echo json_encode($arr);

                            break;

                        }


                        foreach ($search as $item) {

                            $data_row["ID"] = $item->Content->ID;

                            $data_row["Title"] = $item->title;

                            $data_row['Desc'] = $item->des;

                            //$data_row['Details']=$item->content;

                            $data_row['Img'] = static::URL . $item->Content->Img;

                            foreach ($item->Content->DataKeyvalueUserdata as $keyvalue) {

                                if ($keyvalue->DKV_ID == 40) {

                                    $data_row['Price'] = $keyvalue->Value;

                                }

                                if ($keyvalue->DKV_ID == 50) {

                                    $data_row['Price'] = $keyvalue->Value;

                                }

                            }

                            $data[] = $data_row;

                        }

                    }
                }

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;

                echo json_encode($arr);

                break;

            case "Contact":

                $phone = \DataKeyvalueUserdata::findFirst(["Item_ID=106 AND DKV_ID=66"]);
                $fb = \DataKeyvalueUserdata::findFirst(["Item_ID=106 AND DKV_ID=64"]);
                $web = \DataKeyvalueUserdata::findFirst(["Item_ID=106 AND DKV_ID=67"]);
                $mail = \DataKeyvalueUserdata::findFirst(["Item_ID=106 AND DKV_ID=65"]);
                $data["facebook"] = $fb->Value;
                $data["web"] = $web->Value;
                $data["phone"] = $phone->Value;
                $data["mail"] = $mail->Value;
                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;
                echo json_encode($arr);

                break;

            case "About":

                $About = Content::find(["ID=107 OR ID= 216"]);
                $data = [];
                foreach ($About as $info) {
                    if ($info->ID == 216) {
                        $langs = $info->getLang(["lang_id={$lang_id}"]);
                        if (count($langs) > 0) {
                            foreach ($langs as $lang) {

                                $data_row['Goals'] = $lang->content;
                            }

                        } else {
                            $data_row['Goals'] = $info->Content;

                        }
                    } else {
                        $langs = $info->getLang(["lang_id={$lang_id}"]);
                        if (count($langs) > 0) {
                            foreach ($langs as $lang) {

                                $data_row['Vision'] = $lang->content;
                            }

                        } else {
                            $data_row['Vision'] = $info->Content;

                        }
                    }


                }

                $arr['eCode'] = 200;

                $arr['eMessage'] = 'Success';

                $arr['eContent'] = $data_row;

                echo json_encode($arr);

                break;


            case "ChangePassword":
                $arr = [];
                //check logged in
                $user = $this->checkUserLoggedin();
                if (!$user) {
                    $arr['eCode'] = 401;

                    $arr['eMessage'] = 'you are not logged in';

                    $arr['eContent'] = '0';

                    echo json_encode($arr);

                    return;
                }
                $old_pass = $this->request->getQuery("Pass");
                $new_pass = $this->request->getQuery("New");
                $confirm_pass = $this->request->getQuery("Confirm");
                if (!$this->security->checkHash($old_pass, $user->Pass)) {
                    $arr['eCode'] = 4011;

                    $arr['eMessage'] = 'Check your old password';

                    $arr['eContent'] = '0';

                    echo json_encode($arr);

                    return;
                }
                if (strlen($new_pass) < 8) {
                    $arr['eCode'] = 4012;

                    $arr['eMessage'] = 'Password Must Be At Least 8 Characters';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                if ($new_pass !== $confirm_pass) {
                    $arr['eCode'] = 4013;

                    $arr['eMessage'] = 'Check that the new password are the same as the confirmation password';

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $user->Pass = $this->security->hash($new_pass);
                if (!$user->save()) {
                    $arr['eCode'] = 1;

                    $arr['eMessage'] = implode(",", $user->getMessages());

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $arr['eCode'] = 200;

                $arr['eMessage'] = "Password Has been changed sucessfully";
                echo json_encode($arr);
                break;

            case "ForgetPassword":
                $arr = [];
                $mail = $this->request->get("Mail");
                $user = $this->checkUserByMail($mail);
                if ($user == false) {
                    $arr['eCode'] = 4014;

                    $arr['eMessage'] = "E-Mail is Not registered";

                    $arr['eContent'] = $json_obj;

                    echo json_encode($arr);

                    return;
                }
                $resetPassword = new ResetPasswords();
                $resetPassword->usersId = $user->ID;
                if (!$resetPassword->save()) {
                    return;
                }
                //send reset link
                $this->sendResetPassLink($resetPassword);
                $arr['eCode'] = 200;

                $arr['eMessage'] = "Check Your Mail";
                echo json_encode($arr);
			
			case "Zone":

                $arr = array();

                $data = array();
                
                
				$cities = GeoCities::find();

                foreach ($cities as $city) {

                    $data_row = array();

                    $data_row['ID'] = $city->id;

                    $data_row['Title'] = $city->name;
                    $data[] = $data_row;

                }

                $arr['eCode'] = 200;

                $arr['eMessage'] = "Success";

                $arr['eContent'] = $data;


                echo json_encode($arr);

                break;
				
			


            default:

                $arr['Status'] = 400;

                $arr['eContent'] = 'Bad Request';

                echo json_encode($arr);

                break;

        }


    }


    public function resetPasswordAction()
    {
        $this->view->disable();
        $code = $this->dispatcher->getParam('code');
        $mail = $this->dispatcher->getParam('email');
        $app = $this->dispatcher->getParam('app');
        $reset = ResetPasswords::findFirst(["code='{$code}'"]);
        if (!$reset) {
            $arr['eCode'] = 4015;
            $arr['eMessage'] = "Code is Wrong";
            echo json_encode($arr);
            return;
        }
        $new_pass = base64_encode(openssl_random_pseudo_bytes(8));
        $user = UsersMobile::findFirst(["Mail='{$mail}' AND Application_ID=574"]);
        $user->Pass = $this->security->hash($new_pass);
        $user->save();
        //send the new password
        $this->sendNewPass($user, $new_pass);
        $arr['eCode'] = 200;
        $arr['eMessage'] = "The NewPass is sent:" . $new_pass;
        echo json_encode($arr);
        return;
    }

    public function checkUserLoggedin()
    {
        $identity = $this->session->get('goapp-identity');

        if (isset($identity['id'])) {

            $user = UsersMobile::findFirst("ID=" . $identity['id']);

            if ($user == false) {

                throw new Exception('The user does not exist');

            }


            return $user;

        }


        return false;
    }

    public function checkUserByMail($mail)
    {
        $user = UsersMobile::findFirst(["Mail='{$mail}' AND Application_ID=" . static::APPLICATION_ID]);
        if (!$user) {
            return false;
        }
        return $user;
    }

    public function sendResetPassLink($reset)
    {
        $this->getDI()
            ->getMail()
            ->send([
                $reset->user->Mail => $reset->user->Title
            ], "Reset your password", 'reset_app', [
                'resetUrl' => '/reset-password-app/' . $reset->code . '/' . $reset->user->Mail . '/' . $reset->user->Application_ID
            ]);
    }

    public function sendNewPass($user, $newPass)
    {
        $this->getDI()
            ->getMail()
            ->send([
                $user->Mail => $user->Title
            ], "Your New Password", 'new_pass', [
                'newPass' => $newPass
            ]);
    }

    public function getContent($app_id, $module_id)
    {

        $content = Content::find(["Application_ID={$app_id} AND Module_ID={$module_id}"])->toArray();

        return $content;

    }


}

