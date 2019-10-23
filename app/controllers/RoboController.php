<?php
namespace Vokuro\Controllers;
use Vokuro\Pentavalue\Jsonobjects;
define('Application_ID', $_REQUEST['Application_ID']);
define('Module_ID', $_REQUEST['Module_ID']);
define('Action_ID', $_REQUEST['Action_ID']);
define('IMAGE_URL', "http://penta-test.com/robo_cms/uploads/");
define('SITEURL', 'URL/');
define('TIMENOW', time());
define('MEDIAURL',"http://penta-test.com/robo_cms/uploads/");
// creator 
//--> get control 
//--> get header
//--> get footer
//--> get dz
// menu 
// change layout 
// change key value layout 
// login 
// setting 
// cash 
// application display 
// get ads
// Animation
class RoboController extends ControllerApiBase {

  public function onConstruct() {
      $this->view->disable();
  }


  public function indexAction() {
    extract($_REQUEST);
    switch (Action_ID) {
		// change layout 
      case "1":
		$this->Update_Layout_V4();
        break;
      case "2":
		$this->Update_Menu_Layout_V4();
        break;
      case "3":
		$this->Update_KeyValue_Layout_V4();
        break;
      case "4":
		$this->Update_Control_Layout_V4();
        break;
      case "5":
		$this->Update_Animation_V4();
        break;
      case "6":
		$this->Update_Theme_V4();
        break;
		
      case "50":
		$this->Get_Animation_V4();
        break;
      case "51":
        $this->Get_Layout_V4();
        break;	
	  case "52":
        $this->Get_KeyValue_V4();
        break;	
	  case "53":
        $this->Get_Menu_Layout_V4();
        break;	
        case "54":
        $this->Get_Color_V4();
        break;
        case "55":
        $this->Get_Cash_V4();
        break;
      case "100":
        $this->Robo_Login_V4($User, $Pass);
        break;
      case "101":
        $this->Robo_Single_App_V4();
        break;
      case "102":
        $this->Robo_Setting_V4();
        break;
		Case "103":
		$this->Robo_Menu_V4();
		break;
		case "104":
        $this->Robo_Token_V4();
        break;
       case "105":
        $this->Robo_Ads_V4();
        break;
       case "106":
        $this->Robo_Creator_V4();
        break;
       case "107":
        $this->Robo_Setting_Data_V4();
        break;
       case "108":
        $this->Robo_AllControl_Data_V4();
        break;


		
    }
  }
  
  function Robo_Setting_Value($Type,$Value)
  {
	  if($Value=='')
		  $Value="";
		$Arr[$Type]=$Value;
		//$Arr['Value']=$Value;
		return $Value;
  }
     function Layout_Setting($Setting,$Type,$Api,$Module_ID,$Action_ID) {
	 $Setting_Data=array();
	 $Layout_ID=$Setting['Layout_ID'];
	 $Dialog=0;
	 $Dialog_Type=0;
	 $Target_Layout_ID=0;
	 $Setting_ID=0;
	 $Color="";
	 $Target_Bg="";
	 $Cell=array();
	 $Dz=array();
	 $Logic=array();
	
		$Target_Module_ID=0;
		$Target_Action_ID=0;
		$Url_Action_ID=$Action_ID;
		$Url_Module_ID=$Module_ID;

	 $sql = "SELECT * FROM users_application_layout_setting WHERE `Type` =  '".$Type."' and Layout_ID='".$Layout_ID."'";
	 $output = $this->db->fetchone($sql);

	 IF($output)
	 {
	 $Target_Module_ID=$output['Target_Module_ID'];
	 $Target_Action_ID=$output['Target_Action_ID'];
	 $Api_Setting_Db=$output['Api'];
	 $Dialog=$output['Dialog'];
	 $Target_Layout_ID=$output['Target_Layout_ID'];
	 $Dialog_Type=$output['Dialog_Type'];
	 $Setting_ID=$output['ID'];
	 $Target_Bg=$output['Bg'];
	 $Color=$output['Color'];
	 }

	 $Logic['Layout_ID']= $this->Robo_Setting_Value('Layout_ID',$Setting['Layout_ID']);
	 $Logic['Action_ID']= $this->Robo_Setting_Value('Action_ID',$Action_ID);
	 $Logic['Module_ID']= $this->Robo_Setting_Value('Module_ID',$Setting['Module_ID']);
	 $Logic['Action_To_Action']= $this->Robo_Setting_Value('Action_To_Action',$Setting['Action_To_Action']);
	 $Logic['Actions_Type']= $this->Robo_Setting_Value('Actions_Type',$this->Robo_ReturnActionType_V4($Action_ID));
	 $Logic['Target_Layout_ID']= $this->Robo_Setting_Value('Target_Layout_ID',$Target_Layout_ID);
	 $Logic['Setting_ID']= $this->Robo_Setting_Value('Setting_ID',$Setting_ID);
	 $Logic['Login']= $this->Robo_Setting_Value('Login',$Setting['Login']);
	 
	 $Menu['Menu_Version_ID']= $this->Robo_Setting_Value('Menu_Version_ID',$Setting['Menu_Version_ID']);
	 $Cell['First_Cell_DB']= $this->Robo_Setting_Value('First_Cell_DB',$Setting['First_Cell_DB']);
	 $Cell['Remaining_Cell_DB']= $this->Robo_Setting_Value('Remaining_Cell_DB',$Setting['Remaining_Cell_DB']);
	 $Cell['Remaining_Cell']= $this->Robo_Setting_Value('Remaining_Cell',$Setting['Remaining_Cell']);
	 $Cell['First_Cell']= $this->Robo_Setting_Value('First_Cell',$Setting['First_Cell']);
	 $Cell['Dialog']= $this->Robo_Setting_Value('Dialog',$Dialog);
	 $Cell['Dialog_Type']= $this->Robo_Setting_Value('Dialog_Type',$Dialog_Type);
	 $Cell['Loop']= $this->Robo_Setting_Value('Loop',$Setting['Loop']);


	 $Dz['Target_Bg']= $this->Robo_Setting_Value('Target_Bg',$Target_Bg);
	 $Dz['Target_Color']= $this->Robo_Setting_Value('Target_Color',$Color);
		

	 
	IF($Target_Action_ID!='' && $Target_Action_ID!=' ' && $Target_Action_ID!='0' )
		{
		$Url_Action_ID=$Target_Action_ID;
		}
		else
		{		
				IF($Setting_Data['Target_Layout_ID']!='' && $Setting_Data['Target_Layout_ID']!=' ' && $Setting_Data['Target_Layout_ID']!='0' )
				{
				$temp= $this->db->fetchOne("SELECT ID,Target_Action_ID,Target_Module_ID FROM `users_application_module_layout_action_new` WHERE 
				`ID` = ".$Setting_Data['Target_Layout_ID']." LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
				$Url_Action_ID=$temp['Target_Action_ID'];

				}
				else
				{
				
				$temp= $this->db->fetchOne("SELECT Target_Action_ID,Target_Module_ID FROM `users_application_module_layout_action_new` WHERE 
				`Action_ID` = ".$Action_ID." AND `Module_ID` = ".$Module_ID." And `Main`=1 LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
				$Url_Action_ID=$temp['Target_Action_ID'];
				}
		}

		
		IF($Target_Module_ID!='' && $Target_Module_ID!=' ' && $Target_Module_ID!='0' )
		{
		$Url_Module_ID=$Target_Module_ID;
		}
		else
		{
		
				IF($Setting_Data['Target_Layout_ID']!='' && $Setting_Data['Target_Layout_ID']!=' ' && $Setting_Data['Target_Layout_ID']!='0' )
				{
				$temp= $this->db->fetchOne("SELECT Target_Action_ID,Target_Module_ID FROM `users_application_module_layout_action_new` WHERE 
				`ID` = ".$Setting_Data['Target_Layout_ID']." LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
				$Url_Module_ID=$temp['Target_Module_ID'];
				}
				else
				{
					
				$temp= $this->db->fetchOne("SELECT Target_Action_ID,Target_Module_ID FROM `users_application_module_layout_action_new` WHERE 
				`Action_ID` = ".$Action_ID." AND `Module_ID` = ".$Module_ID." And `Main`=1 LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
				$Target_Action_ID=$temp['Target_Action_ID'];
					IF($temp['Target_Module_ID']!='' && $temp['Target_Module_ID']!=' ' && $temp['Target_Module_ID']!='0' )
					{
					$Url_Module_ID=$temp['Target_Module_ID'];
					}
					else
					{
						$Url_Module_ID=$Module_ID;
					}
					
				}
		}
	

		  $temp= $this->db->fetchOne('SELECT base_url FROM users_application_module WHERE ID='.$Url_Module_ID, \Phalcon\Db::FETCH_ASSOC);
		  $Base_URL=$temp['base_url'];
		  if($Base_UR=='')
		  {
			  $Base_URL="http://robo-apps.com/robo_v4/engine/api/?Str=1&";
		  }
		  $Api_Url=$Base_URL."&Application_ID=".Application_ID.'&Module_ID='.$Url_Module_ID."&Action_ID=".$Url_Action_ID.'&'.$Api.'&'.$Api_Setting_Db;
		
		
		
		if($Setting==0)
		{
	
		$temp= $this->db->fetchOne("SELECT ID FROM `users_application_module_layout_action_new` WHERE Main=1 and
		`Action_ID` = ".$Url_Action_ID." AND Module_ID=".$Url_Module_ID." LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
		$Setting_Data['Target_Layout_ID']=$temp['ID'];
		}
	
	  
	 
	 $Button=$this->Robo_Button_V4($Module_ID,$Action_ID,$Cell_ID);

	 $Logic['Api']= $this->Robo_Setting_Value('Api',$Api_Url);


	 $Arr_Cell['Cell']=$Cell;
	 $Arr_Cell['Dz']=$Dz;
	 $Arr_Cell['Logic']=$Logic;
	 $Arr_Cell['Button']=$Button;

	 return $Arr_Cell;
 }
  
   function Robo_AllControl_Data_V4() {
	header('Content-Type: application/json');
	$Layout_ID=$_REQUEST['Layout_ID'];
    $Arr=array();
	$GroupArr=array();
	 $sql = "SELECT ID FROM  `users_application_group_control` WHERE   `Layout_ID` =".$Layout_ID." AND `Application_ID` ='".Application_ID."'";
    $results = $this->db->fetchAll($sql);
	foreach($results as $output){
		$Control=array();
		$Group_ID=$output['ID'];
		$Setting['Action_To_Action']=0;
		$Setting['Group_ID']=$Group_ID;
		$Group_Arr['Setting']=$Setting;
		$sql = "SELECT users_application_module_layout_action_control.ID, users_application_module_layout_action_control.Api
		FROM  `users_application_module_layout_action_control_group` 
		INNER JOIN users_application_module_layout_action_control ON users_application_module_layout_action_control.ID = users_application_module_layout_action_control_group.Control_ID
		WHERE users_application_module_layout_action_control_group.Group_ID =".$Group_ID;
		$results = $this->db->fetchAll($sql);
		foreach($results as $output){
			if($output['Api']!='')
			$Group_Arr['Data']=json_decode(file_get_contents($output['Api']));
		}
		$GroupArr['Groups'][]=$Group_Arr;
	}

  echo json_encode($GroupArr);
   }
 
    function Robo_Setting_Data_V4() {
 	 $Application_ID=$_REQUEST['Application_ID'];
	 $ControlArr=array();
	 $Setting_Data=array();
	 $Dialog=0;
	 $Setting_ID=0;
	 $Target_Color="";
	 $Target_Bg="";

		
	 $Setting=0;
	 $sql = "SELECT * FROM data_cms_setting WHERE `Application_ID` =  '".$Application_ID."'";
    $results = $this->db->fetchAll($sql);
	if($results)
	{
	foreach($results as $output){
	 $Item_ID=$output['Item_ID'];
	 $Module_ID=$output['Module_ID'];
	 $Action_ID=$output['Action_ID'];
	 $Type=$output['Type'];
	 
	 $Dialog=$output['Dialog'];
	 $Target_Action_ID=$output['Target_Action_ID'];
	 $Target_Layout_ID=$output['Target_Layout_ID'];
	 $Target_Module_ID=$output['Target_Module_ID'];
	 $Target_Color=$output['Color'];
	 $Target_Bg=$output['Bg'];
	 $Api_Setting_Db=$output['Api'];
	 
	 $Setting_Data['Setting_ID']=$output['ID'];
	 $Setting=1;
	 
	
	
	 $Logic['Type']= $this->Robo_Setting_Value('Type',$Type);
	 $Logic['Item_ID']= $this->Robo_Setting_Value('Item_ID',$Item_ID);
	 $Logic['Layout_ID']= $this->Robo_Setting_Value('Layout_ID',$Setting['Layout_ID']);
	 $Logic['Action_ID']= $this->Robo_Setting_Value('Action_ID',$Action_ID);
	 $Logic['Module_ID']= $this->Robo_Setting_Value('Module_ID',$Module_ID);
	 $Logic['Action_To_Action']= $this->Robo_Setting_Value('Action_To_Action',$Setting['Action_To_Action']);
	 $Logic['Actions_Type']= $this->Robo_Setting_Value('Actions_Type',$this->Robo_ReturnActionType_V4($Action_ID));
	 $Logic['Target_Layout_ID']= $this->Robo_Setting_Value('Target_Layout_ID',$Target_Layout_ID);
	 $Logic['Setting_ID']= $this->Robo_Setting_Value('Setting_ID',$Setting_ID);
	 $Logic['Login']= $this->Robo_Setting_Value('Login',$Setting['Login']);
	 $Menu['Menu_Version_ID']= $this->Robo_Setting_Value('Menu_Version_ID',$Setting['Menu_Version_ID']);
	 $Cell['First_Cell_DB']= $this->Robo_Setting_Value('First_Cell_DB',$Setting['First_Cell_DB']);
	 $Cell['Remaining_Cell_DB']= $this->Robo_Setting_Value('Remaining_Cell_DB',$Setting['Remaining_Cell_DB']);
	 $Cell['Dialog']= $this->Robo_Setting_Value('Dialog',$Dialog);
	 $Cell['Dialog_Type']= $this->Robo_Setting_Value('Dialog_Type',$Dialog_Type);
	 $Cell['Loop']= $this->Robo_Setting_Value('Loop',$Setting['Loop']);


	 $Dz['Target_Bg']= $this->Robo_Setting_Value('Target_Bg',$Target_Bg);
	 $Dz['Target_Color']= $this->Robo_Setting_Value('Target_Color',$Color);
		
		
	
	IF($Target_Action_ID!='' && $Target_Action_ID!=' ' && $Target_Action_ID!='0' )
		{
		$Url_Action_ID=$Target_Action_ID;
		}
		else
		{		 
				
				IF($Setting_Data['Target_Layout_ID']!='' && $Setting_Data['Target_Layout_ID']!=' ' && $Setting_Data['Target_Layout_ID']!='0' )
				{
				$temp= $this->db->fetchOne("SELECT ID,Target_Action_ID,Target_Module_ID FROM `users_application_module_layout_action_new` WHERE 
				`ID` = ".$Setting_Data['Target_Layout_ID']." LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
				$Url_Action_ID=$temp['Target_Action_ID'];
				
				}
				else
				{
				
				$temp= $this->db->fetchOne("SELECT Target_Action_ID,Target_Module_ID FROM `users_application_module_layout_action_new` WHERE 
				`Action_ID` = ".$Action_ID." AND `Module_ID` = ".$Module_ID." And `Main`=1 LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
				$Url_Action_ID=$temp['Target_Action_ID'];
				}
		}

		
		IF($Target_Module_ID!='' && $Target_Module_ID!=' ' && $Target_Module_ID!='0' )
		{
		$Url_Module_ID=$Target_Module_ID;
		}
		else
		{
		
				IF($Setting_Data['Target_Layout_ID']!='' && $Setting_Data['Target_Layout_ID']!=' ' && $Setting_Data['Target_Layout_ID']!='0' )
				{
				$temp= $this->db->fetchOne("SELECT Target_Action_ID,Target_Module_ID FROM `users_application_module_layout_action_new` WHERE 
				`ID` = ".$Setting_Data['Target_Layout_ID']." LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
				$Url_Module_ID=$temp['Target_Module_ID'];
				}
				else
				{
					
				$temp= $this->db->fetchOne("SELECT Target_Action_ID,Target_Module_ID FROM `users_application_module_layout_action_new` WHERE 
				`Action_ID` = ".$Action_ID." AND `Module_ID` = ".$Module_ID." And `Main`=1 LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
				$Target_Action_ID=$temp['Target_Action_ID'];
					IF($temp['Target_Module_ID']!='' && $temp['Target_Module_ID']!=' ' && $temp['Target_Module_ID']!='0' )
					{
					$Url_Module_ID=$temp['Target_Module_ID'];
					}
					else
					{
						$Url_Module_ID=$Module_ID;
					}
					
				}
		}
	

		  $temp= $this->db->fetchOne('SELECT base_url FROM users_application_module WHERE id='.$Url_Module_ID, \Phalcon\Db::FETCH_ASSOC);
		  $Base_URL=$temp['Base_URL'];
		  if($Base_UR=='')
		  {
			  $Base_URL="http://robo-apps.com/robo_v4/engine/api/?Str=1&";
		  }
		  $Api_Url=$Base_URL."&Application_ID=".Application_ID.'&Module_ID='.$Url_Module_ID."&Action_ID=".$Url_Action_ID.'&'.$Api.'&'.$Api_Setting_Db;
		
		
		
		if($Setting==0)
		{
	
		$temp= $this->db->fetchOne("SELECT ID FROM `users_application_module_layout_action_new` WHERE Main=1 and
		`Action_ID` = ".$Url_Action_ID." AND Module_ID=".$Url_Module_ID." LIMIT 1", \Phalcon\Db::FETCH_ASSOC);
		$Setting_Data['Target_Layout_ID']=$temp['ID'];
		}
	
	
	 
	 

	  }
	 
	 $Button=array();//$this->Robo_Button_V4($Module_ID,$Action_ID,$Cell_ID);

	 $Logic['Api']= $this->Robo_Setting_Value('Api',$Api_Url);


	 $Arr_Cell['Cell']=$Cell;
	 $Arr_Cell['Dz']=$Dz;
	 $Arr_Cell['Logic']=$Logic;
	 $Arr_Cell['Button']=$Button;
       $ControlArr[] = $Arr_Cell;
    }

	 
	 echo $final_results = json_encode($ControlArr);

 }
  
	function Get_Color_V4()
	{
		$color=array();
		$ColorArr=array();
		
		$select_color = $this->db->fetchOne("SELECT * FROM users_application_theme_color WHERE Application_ID='".Application_ID."'AND  `History` =0 limit 1", \Phalcon\Db::FETCH_ASSOC);

		$Folder_Color_ID=$select_color['Folder_Color_ID'];
		 $Core_Theme_Color_ID=$select_color['Core_Theme_Color_ID'];
		if($Core_Theme_Color_ID==0)
			$Core_Theme_Color_ID=$Folder_Color_ID;
		
		
		$ColorArr=array();
		$ColorArr = $this->db->fetchAll("SELECT StatsBar_Text_Bar,Header_Bar_color,StatsBar_Color,FColor,ID FROM core_theme_color", \Phalcon\Db::FETCH_ASSOC);
			foreach ($ColorArr as $output_Color) {

				$Color_Arr['ID'] = $output_Color['ID'];
				if($output_Color[ID]==$Core_Theme_Color_ID)
				$Color_Arr['Selected']=1;
				else
				$Color_Arr['Selected']=0;
			
				$Color_Arr['FColor'] = $output_Color['FColor'];
				$Color_Arr['HeaderBar'] = $output_Color['Header_Bar_color'];
				$Color_Arr['StatsBar'] = $output_Color['StatsBar_Color'];
				$Color_Arr['StatsBarText'] = $output_Color['StatsBar_Text_Bar']; 
				
				$Color[]=$Color_Arr;
			}
			echo $final_results = json_encode($Color);

}
  
  	function Get_Menu_Layout_V4()
	{
		
		
		$arr_app= $this->db->fetchOne("SELECT menu_version_id FROM users_application WHERE ID='".Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
		$Menu_Layout_ID=$arr_app['menu_layout_id'];
		$Menu_Depts_ID=$arr_app['menu_depts_id'];
		$Menu_Version_ID=$arr_app['menu_version_id'];
		$Field_ID=$arr_app['field_id'];
	

			$Menu_Depts = $this->db->fetchAll("SELECT ID,Img FROM core_module_menu_depts ORDER BY `ID` DESC", \Phalcon\Db::FETCH_ASSOC);
			foreach ($Menu_Depts as $output_depts) {
			
			$Layout['Depts_ID']=$output_depts['ID'];
			$Layout['Depts_Img']=SITEURL.'/media/'.$output_depts['Img'];
		
			$design_arr = $this->db->fetchAll("SELECT Menu_Dept_ID,ID,Img FROM core_module_menu  where Menu_Dept_ID='".$Layout['Depts_ID']."' ORDER BY `ID` DESC", \Phalcon\Db::FETCH_ASSOC);
				foreach ($design_arr as $output) {
				$ARR_Layout=array();
				$ARR_Layout['Depts_Img']=SITEURL.'/media/'.$output['Path'].$output['Img'];
				$ARR_Layout['ID']=$output['ID'];
				
				if($ARR_Layout['ID']==$Menu_Version_ID)
					$ARR_Layout['Selected']=1;
				else
					$ARR_Layout['Selected']=0;
			
				$ARRLayout[]=$ARR_Layout;
				$Layout['Layout']=$ARRLayout;
				}
				$ARRLayout=array();
				$Depts[]=$Layout;

			}
			
			


		echo $final_results = json_encode($Depts);
	}

  
	function Robo_Button_V4($Module_ID,$Action_ID,$Cell_ID) {
		$Arr_Button=array();
		$result8 = $this->db->fetchAll("SELECT * FROM users_application_module_action_cell_button	
		WHERE  Application_ID='".Application_ID."' and Cell_ID='".$Cell_ID."' and `Module_ID` =".$Module_ID."
		 AND `Action_ID`=".$Action_ID, \Phalcon\Db::FETCH_ASSOC);
        foreach ($result8 as $output8) {
		  $Button['ID']=$output8['ID'];
		  $Button['Api']=$output8['Api'];
		  $Button['Api_Paramater']=$output8['Api_Paramater'];
		  $Button['Orders']=$output8['Orders'];
		  $Arr_Button[]=$Button;
		}
		return $Arr_Button;
	}
  function Robo_ReturnActionType_V4($Action_ID) {
   
   switch($Action_ID)
   {
	   case  3: 
	   case  1: 
	   case  4: 
	   case  2: 
	   $Action_Type="2";
	   break;
	   case  $Action_ID: 
	   $Action_Type="$Action_ID";

	   break;
	   	   
   }
    return $Action_Type;
   
   }
  function Robo_Cell_Font($Cell,$Module_ID,$Action_ID)
  {
	  
		$Arr_Font=array();
	    $result8 = $this->db->fetchAll("SELECT * FROM users_application_module_action_cell_font	
		WHERE  Application_ID='".Application_ID."' and Cell_ID='".$Cell."' and `Module_ID` =".$Module_ID."
		 AND `Action_ID`=".$Action_ID, \Phalcon\Db::FETCH_ASSOC);

        foreach ($result8 as $output8) {
          $ArrFont['Title'] = @trim($output8['Title']);
          $ArrFont['Font'] = @trim($output8['Font']);
          $ArrFont['Code'] ='\\'.@trim($output8['Code']);
          $ArrFont['Code_Ios'] ='\\'.@trim($output8['Code_Ios']);
          $ArrFont['UnSelected_Color'] = @trim($output8['UnSelected_Color']);
          $ArrFont['Selected_Color'] = @trim($output8['Selected_Color']);
          $Arr_Font[] = $ArrFont;
        }
		
		return $Arr_Font;
  }
  
  function Robo_Cell_Color($Cell)
  {
		$Color = array();
        $Color['Title_Color'] = "";
        $Color['Des_Color'] = "";
        $Color['Key_Color'] = "";
        $Color['Value_Color'] = "";
        $Color['Other_Color'] = "";
		$result8 = $this->db->fetchAll("SELECT * FROM users_application_module_action_cell_new
		WHERE ID='".$Cell."' ", \Phalcon\Db::FETCH_ASSOC);
	
        foreach ($result8 as $output8) {
          $Color['Cell_ID'] =$output8['Cell_ID'];
          $Color['Title_Color'] = @trim($output8['Title_Color']);
          $Color['Des_Color'] = @trim($output8['Des_Color']);
          $Color['Key_Color'] = @trim($output8['Key_Color']);
          $Color['Value_Color'] = @trim($output8['Value_Color']);
          $Color['Other_Color'] = @trim($output8['Other_Color']);
          $Color['Selected'] = @trim($output8['Selected']);
          $Color['Unselected'] = @trim($output8['Unselected']);		  		  
		  
        }
		
		return $Color;
  }
	
  function Robo_Design_Remaining_Cell_V4($string_url,$Design_Updated,$CELL_Remaining_Cell,$IOS)
  {

		if($Action_ID!=6)
		{
			IF($Design_Updated==0)
			{
				
					if($IOS!=1)
							$Var="android";
						else
							$Var="ios/";
					    $output_app = $this->db->fetchOne("SELECT * FROM users_application_theme_color WHERE History=0 and Application_ID='".Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
						$Color_ID=$output_app['Folder_Color_ID'];
						$arr_files=$this->Theme_Path_Dz_Cell($Color_ID,$CELL_Remaining_Cell,$Var);
			}
			ELSE
			{	
					if($IOS!=1)
					$Var="Android/";
					else
					$Var="IOS/";
				
				$Path_New=ROOT_PATH."/media/core_data/applications/".Application_ID."/module/".$Module_ID."/".$Action_ID."/";
				$Path_New.=$Var.$_REQUEST['Screen_Dim']."/".$CELL_Remaining_Cell;
				$arr_files = $this->read_all_files($Path_New);
			}
			
			$CELL['Remaining_Cell_Images']=$this->Theme_Path_Dz_Orders($IOS,$arr_files,$string_url);

	 }
	 else
	 {
        $CELL['Remaining_Cell_Images']=new Jsonobjects;


	 }
	 
	 return  $CELL['Remaining_Cell_Images'];
	 
}
	
	
  function Robo_Design_First_Cell_V4($string_url,$Design_Updated,$CELL_First_Cell,$IOS)
  {
			IF($Design_Updated==0)
		{
					
					if($IOS!=1)
						$Var="android";
					else
						$Var="ios/";

				    $output_app = $this->db->fetchOne("SELECT * FROM users_application_theme_color WHERE History=0 and  Application_ID='".Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
					$Color_ID=$output_app['Folder_Color_ID'];

					$arr_files=$this->Theme_Path_Dz_Cell($Color_ID,$CELL_First_Cell,$Var);
							 // =$this->Theme_Path_Dz_Control($Color_ID,$Control_ID,$Layout_ID,$Theme_PlatForm,$Cell_ID);
							  // =$this->Theme_Path_Dz_Footer($Color_ID,$Theme_PlatForm);
		
		}
		ELSE
		{	
			$Path_New=ROOT_PATH."/media/core_data/applications/".Application_ID."/module/".$Module_ID."/".$Action_ID."/";
			
				if($IOS!=1)
				$Var="Android/";
				else
				$Var="IOS/";

			$Path_New.=$Var.$_REQUEST['Screen_Dim']."/".$CELL_First_Cell;
			$arr_files = $this->read_all_files($Path_New);
		}
		
			return	$CELL['First_Cell_Images']=$this->Theme_Path_Dz_Orders($IOS,$arr_files,$string_url);

	
}
	
	
	function Robo_Cell_Key($Cell_ID,$Module_ID,$Action_ID)
	{
			$Font=array();
			$CELL['Remaining_Cell_Font']=$this->Robo_Cell_Font($CELL_Remaining_Cell,$Module_ID,$Action_ID);
			$result8 = $this->db->fetchAll("SELECT * FROM users_layout_cell_keyvalue WHERE Cell_ID='$CELL_Remaining_Cell' ", \Phalcon\Db::FETCH_ASSOC);
			foreach ($result8 as $output8) {
			  $Arr['DKV_ID'] = $output8['DKV_ID'];
			  $Arr['Orders'] = $output8['Orders'];
			  $Font[] = $Arr;
			}
	
		return $Font;
		
	}
  function Robo_Creator_V4()
  {
	 	  $Str=$_REQUEST['Str'];
	 	  $IOS=$_REQUEST['IOS'];
		  $Application_ID=$_REQUEST['Application_ID'];

	 $result2 = $this->db->fetchAll("SELECT * FROM users_application_module_layout_action_new WHERE `Application_ID` =".Application_ID, \Phalcon\Db::FETCH_ASSOC);
   	 foreach ($result2 as $output2) {
        $Action_ID = $output2['Action_ID'];
        $Module_ID = $output2['Module_ID'];
        $First_Cell = $output2['First_Cell'];
        $Remaining_Cell = $output2['Remaining_Cell'];
        $Control = $output2['Control'];
        $Target_Action_ID = $output2['Target_Action_ID'];
		
		$results_module = $this->db->fetchAll("SELECT * FROM users_application_module WHERE   `id`='".$Module_ID."'", \Phalcon\Db::FETCH_ASSOC);
		  foreach ($results_module as $output_app) {
			$Copy_Module_ID = $output_app['copy_module_id'];
			$Orginal_ID = $output_app['orginal_id'];
				if($Copy_Module_ID!=0)
				{
				  $Orginal_ID=$Copy_Module_ID;
				}
	
				
				
        $Header['Layout_ID'] = $output2['Header_Layout_ID'];
        $Header['Setting'] = $output2['Header_Setting'];
		
		$Type_Module = $this->db->fetchOne('SELECT Type_Module FROM  `core_module` WHERE  `ID` ='.$Orginal_ID.' limit 1');
		$Setting['Action_To_Action'] =0;	  
		if($Type_Module['Type_Module']=="social")
		$Setting['Action_To_Action'] =1;
		}
        $Setting['Actions_ID'] = $Action_ID;
        $Setting['Module_ID'] = $Module_ID;
        $Setting['Actions_Type'] =$this->Robo_ReturnActionType_V4($Action_ID);
        $Setting['Layout_ID'] = $output2['ID'];
        $Setting['Login'] = $output2['Login'];
        $Setting['Loop'] = $output2['Loop'];
        $Setting['Menu_Version_ID'] = $output2['Menu_Version_ID'];
		$Setting['First_Cell_DB']=$First_Cell;
		$Setting['Remaining_Cell_DB']=$Remaining_Cell;


		$CELL['BgColor'] = $output2['BgColor'];
          

		// users_layout_cell_keyvalue
		//المفروض هنا نحط الكي اليوزر مختارها 
		$CELL['First_Cell_Font']=array();
		$CELL['First_Cell_Key']=array();
		$CELL['Remaining_Cell_Font']=array();
		$CELL['First_Cell_Key']=array();
	


	
        $Images_First_Cell = array();
        $Images_Remaining_Cell = array();
        $string_url = SITEURL.'/';
		$CELL['First_Cell_Color']=$this->Robo_Cell_Color($First_Cell);
		$CELL_First_Cell=$CELL['First_Cell_Color']['Cell_ID'];
        $Setting['First_Cell'] = $CELL_First_Cell;

		if($CELL_First_Cell!=0 && $CELL_First_Cell!='' && $CELL_First_Cell!=' ')
		{
		$CELL['First_Cell_Images']=$this->Robo_Design_First_Cell_V4($string_url,$Design_Updated,$CELL_First_Cell,$IOS);
		$CELL['First_Cell_Lang'] =$this->Lang_Cell_Var($CELL_First_Cell,$Action_ID,$Copy_Module_ID,$Orginal_ID,$Module_ID,$Application_ID);
		$CELL['First_Cell_Key']=$this->Robo_Cell_Key($CELL_Remaining_Cell,$Module_ID,$Action_ID);			
		$CELL['Remaining_Cell_Color']=$this->Robo_Cell_Color($Remaining_Cell);
		}
		$CELL_Remaining_Cell=$CELL['Remaining_Cell_Color']['Cell_ID'];
        $Setting['Remaining_Cell'] = $CELL_Remaining_Cell;
		if($CELL_Remaining_Cell!=0 && $CELL_Remaining_Cell!='' && $CELL_Remaining_Cell!=' ')
		{
		$CELL['Remaining_Cell_Images']=$this->Robo_Design_Remaining_Cell_V4($string_url,$Design_Updated,$CELL_Remaining_Cell,$IOS);
		$CELL['Remaining_Cell_Lang'] =$this->Lang_Cell_Var($CELL_Remaining_Cell,$Action_ID,$Copy_Module_ID,$Orginal_ID,$Module_ID,$Application_ID);
		$CELL['Remaining_Cell_Font']=$this->Robo_Cell_Key($CELL_First_Cell,$Module_ID,$Action_ID);	 
		}

		$One_Layout=array();
		$Type_Url="Sub_ID=".$Setting['Layout_ID'];
		$One_Layout['Setting']=$this->Layout_Setting($Setting,'Depts',$Type_Url,$Module_ID,$Action_ID);

		 
		$Header['Menu'] =$this->Creator_Menu($Application_ID,$Module_ID,$Action_ID,$Copy_Module_ID,$Orginal_ID,$Layout_ID);
		  $One_Layout['Header'] = $Header;//search bar 1 // 0 static
		  $One_Layout['Control']=$this->Creator_Control_V4(Application_ID,$Module_ID,$Action_ID,$Copy_Module_ID,$Orginal_ID,$Control,$Setting['Layout_ID'],$IOS);
		  $One_Layout['Cell']=$CELL;

		  $Actions[] = $One_Layout;
	
	
		  $Header['Menu']=array();
		}
     
	 $arr['Layout'] = $Actions;

    echo json_encode($arr);
}
  function Robo_Ads_V4() {
    $module = array();

    $results = $this->db->fetchAll("SELECT Orginal_ID,Action_ID,Img,Dept_ID,Link,Module_ID FROM users_application_ads where `Application_ID` ='".Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
    foreach ($results as $output) {
      $outputs['Img'] = IMAGE_URL.'/'.$output['Img'];
      $outputs['Link'] = $output['Link'];
      $outputs['Dept_ID'] = $output['Dept_ID'];
      $outputs['Module_ID'] = $output['Module_ID'];
      $outputs['Target_Layout_ID'] = $output['Target_Layout_ID'];
      $outputs['Action_ID'] = $output['Action_ID'];
      $module[] = $outputs;
    }
    $output = $this->db->fetchOne('SELECT ads_setting FROM users_application where `id`='.Application_ID, \Phalcon\Db::FETCH_ASSOC);
    $Ads_Setting = $output['ads_setting'];
    $arr_ads = unserialize($Ads_Setting);
    $arr_ads['Type']=$arr_ads['Type'];
    //$arr_ads['Place']="1";
	
    $arr['Module'] = $module;
    $arr_ads['Publisher_ID'] = $arr_ads['Android_Publisher_ID'];
	
    $arr['Setting_Ads'] = $arr_ads;
	
	//pub-8026641102427101

    $final_results = json_encode($arr);
    echo $final_results;
  }

  
 function Robo_Token_V4() {
	$Lang_ID=$_REQUEST['Lang_ID'];
	$paramters=array();	
	$paramters['Lang_ID']=$Lang_ID;
	
    if(empty($_SESSION['User_ID'])){
      $Account_ID = 0;
    }
    else{
      $Account_ID = $_SESSION['User_ID'];
    }
    $tokenid = $this->db->fetchOne("SELECT ID FROM cp_app_account_token WHERE Token_MD5='".md5($_REQUEST[Token])."'", \Phalcon\Db::FETCH_ASSOC);
    if (!$tokenid) {
      $this->db->insert(
      'cp_app_account_token',
      array($_REQUEST['Token'], md5($_REQUEST['Token']), $Account_ID, $_REQUEST['Type'], '1'),
      array('Token','Token_MD5','Account_ID','Type','Active')
      );
    }
    $this->Artgine_Response(1, 'Done', array());
  }
 
  
  function Get_Layout_V4() {
	$Layout_ID=$_REQUEST['Layout_ID'];
	 $ARR_Layout = array();
	//Action_KEY_ID=2&Module_KEY_ID=2
	//IOS=1 ANDROID =2
	    $output = $this->db->fetchOne("SELECT Module_ID,Action_ID,Layout_ID FROM `users_application_module_layout_action_new` WHERE `ID`=".$Layout_ID, \Phalcon\Db::FETCH_ASSOC);	
	    $Action_KEY_ID = $output['Action_ID'];
	    $Module_KEY_ID = $output['Module_ID'];

		$Action_KEY_ID=$this->Robo_ReturnActionType_V4($Action_KEY_ID);
	    $output = $this->db->fetchOne("SELECT orginal_id,copy_module_id FROM `users_application_module` WHERE `id`=".$Module_KEY_ID, \Phalcon\Db::FETCH_ASSOC);
	    $Copy_Module_ID = $output['Copy_Module_ID'];
	    $Orginal_ID = $output['Orginal_ID'];
		if($Copy_Module_ID!=0)
		{
			$Module_KEY_ID=$Copy_Module_ID;
		}
		else
		{
			$Module_KEY_ID=$Orginal_ID;

		}
		$Depts=array();
    $results_depts = $this->db->fetchAll("SELECT ID,Img FROM `core_module_action_layout_depts`  ORDER BY `ID` Asc", \Phalcon\Db::FETCH_ASSOC);	
	foreach ($results_depts as $output_depts) {
		$Layout['Depts_ID']=$output_depts['ID'];
		$Layout['Depts_Img']=SITEURL.'/media/'.$output_depts['Img'];
		$ARR_Layout=array();
		$results = $this->db->fetchAll("SELECT Title,Img,ID,First_Cell,Remaining_Cell FROM `core_module_action_layout_new` WHERE  `Module_ID` = $Module_KEY_ID AND `Depts_ID` = ".$Layout['Depts_ID']." AND  `Action_ID` = $Action_KEY_ID ORDER BY `ID` DESC", \Phalcon\Db::FETCH_ASSOC);	
		foreach ($results as $output) {
			$ARR_First_Cell=$output['First_Cell'];
			$ARR_Remaining_Cell=$output['Remaining_Cell'];			
			$ARR['Title'] =$ARR_First_Cell.'-'.$ARR_Remaining_Cell;
			$ARR['Img']=SITEURL.'/media/'.$output['Img'];		
			$ARR['ID'] =$output['ID'];	
			if($Layout_ID==$ARR['ID'])
			$ARR['Selected'] ="1";	
			else
			$ARR['Selected'] ="0";		
			$ARR_Layout[]=$ARR;
			$ARR=array();
		}
		$Layout['Layout']=$ARR_Layout;
		$Depts[]=$Layout;
	}
	
	
	
   echo $final_results = json_encode($Depts);
  }
	
	
  
  
 
    function  Update_Animation_V4()
   {
	$ID=$_REQUEST['ID'];
	$Menu_Navigate_ID=$_REQUEST['Menu_Navigate_ID'];
	 $output = $this->db->fetchOne('SELECT ID FROM users_application_menu_layout where Menu_Navigate_ID='.$Menu_Navigate_ID.' and  `History` =1 AND `Application_ID`='.Application_ID, \Phalcon\Db::FETCH_ASSOC);
    $Layout_ID = $output['ID'];
	$Lang_ID=$_REQUEST['Lang_ID'];
	$paramters=array();	
	$paramters['Lang_ID']=$Lang_ID;
	
	IF($Layout_ID!='')
	$this->db->execute("UPDATE `users_application_menu_layout` SET Animation_ID =  '".$ID."' WHERE  `ID` =".$Layout_ID);

	IF($ID!='' && $Layout_ID!='')
		 $stat['Done']=1;
	else
	  	 $stat['Done']=0;
	 
    $final_results = json_encode($stat);
    echo $final_results;
 }
   function  Get_Animation_V4()
   {
     $results = $this->db->fetchAll("SELECT * FROM `core_module_menu_animation`  ", \Phalcon\Db::FETCH_ASSOC);	
	foreach ($results as $output) {
		$Arr['ID'] =$output['ID'];
		$Arr['Title'] =$output['Title'];
		$Arr_Animation[]=$Arr;
	}

    $final_results = json_encode($Arr_Animation);
    echo $final_results;
 }
  
  
   public function Update_KeyValue_Layout_V4()
	{
	$GroupID=$_REQUEST['Group_ID'];
	$Layout_ID=$_REQUEST['Layout_ID'];	
	$Lang_ID=$_REQUEST['Lang_ID'];
	$paramters=array();	
	$paramters['Lang_ID']=$Lang_ID;
	if($Layout_ID!='' && $GroupID!='')
	{
	
	$this->db->execute("UPDATE  `data_keyvalue_group` SET  `key_value_layout_id` =  '".$Layout_ID."' WHERE `id` =".$GroupID);
		

    $Stat=1;
	
	$Msg="تم بنجاح";
    
	}
	else
	{
		$Stat=0;
		$Msg="هناك فشل ";
	}
	$Err['Stat'] = $Stat;
    $Err['Msg'] = $Msg;
    $Err['paramters'] =$paramters;
    
    echo $this->json_encode_convert($Err, $handle);
  
  }

   public function Update_Layout_Target_In_All_V4() {
	   //search control
	   //search form 
	   //search footer
	   //search menu 
	   //search menu header 
	   //search in data 
   }
   public function Update_Layout_V4() {
	$Layout_ID=$_REQUEST['Layout_ID'];
	$Layout_Selected_ID=$_REQUEST['Layout_Selected_ID'];
	$Lang_ID=$_REQUEST['Lang_ID'];
	$Path=$_REQUEST['Path'];
	$Data=$_REQUEST['Data'];
	$paramters=array();	
	$paramters['Lang_ID']=$Lang_ID;
	$paramters['Setting_ID']=$Setting_ID;

	$output = $this->db->fetchOne("SELECT First_Cell,Remaining_Cell FROM `core_module_action_layout_new`
		WHERE  `ID` = $Layout_Selected_ID ORDER BY `ID` DESC", \Phalcon\Db::FETCH_ASSOC);	
	    $First_Cell = $output['First_Cell'];
	    $Remaining_Cell = $output['Remaining_Cell'];
  	   
	   $layoutdata = $this->db->fetchOne("SELECT * FROM `users_application_module_layout_action_new`
		WHERE  `ID` = $Layout_ID ORDER BY `ID` DESC", \Phalcon\Db::FETCH_ASSOC);	
	    $Old_First_Cell = $layoutdata['First_Cell'];
	    $Old_Remaining_Cell = $layoutdata['Remaining_Cell'];
	    $Action_KEY_ID = $layoutdata['Target_Action_ID'];
	    $Module_KEY_ID = $layoutdata['Target_Module_ID'];
      
	
		$layoutdata['First_Cell'] = $this->Creator_buildCell_V4(Application_ID, $layoutdata['Module_ID'], $layoutdata['Action_ID'], $First_Cell,$Old_First_Cell, $Layout_ID);
	
		$layoutdata['Remaining_Cell'] = $this->Creator_buildCell_V4(Application_ID, $layoutdata['Module_ID'], $layoutdata['Action_ID'], $Remaining_Cell,$Old_Remaining_Cell, $Layout_ID);

		//$this->db->execute("DELETE FROM `users_application_module_layout_action_new` WHERE ID=".$Layout_ID);

	if($Data=='1')
	{
			$layout=array($Layout_ID, $Action_KEY_ID, $layoutdata['First_Cell'], $layoutdata['Remaining_Cell'], 0,$layoutdata['Target_Action_ID'],Application_ID,$Module_KEY_ID,$layoutdata['Module_ID']);
				$this->db->insert(
			  'users_application_module_layout_action_new',
			  array($Layout_ID, $Action_KEY_ID, $layoutdata['First_Cell'], $layoutdata['Remaining_Cell'], 0,$layoutdata['Target_Action_ID'],Application_ID,$Module_KEY_ID,$layoutdata['Module_ID']),
			  array('Layout_ID', 'Action_ID', 'First_Cell', 'Remaining_Cell', 'Control', 'Target_Action_ID', 'Application_ID', 'Module_ID', 'Orginal_ID')
			);	
			$Layout_ID=$this->db->lastInsertId();
			$this->db->execute("UPDATE  `data_cms_footer` SET `Target_Layout_ID` =  '".$Layout_ID."' WHERE  ID=".$Setting_ID);
	}
	else
	{
		$this->db->execute("UPDATE  `users_application_module_layout_action_new` SET `Remaining_Cell` =  '".$layoutdata['Remaining_Cell']."',`First_Cell` = '".$layoutdata['First_Cell']."' WHERE  ID=".$Layout_ID);

	}
	/*
		$layout=array($Layout_ID, $Action_KEY_ID, $layoutdata['First_Cell'], $layoutdata['Remaining_Cell'], 0,$layoutdata['Target_Action_ID'],Application_ID,$Module_KEY_ID,$layoutdata['Module_ID']);
				$this->db->insert(
			  'users_application_module_layout_action_new',
			  array($Layout_ID, $Action_KEY_ID, $layoutdata['First_Cell'], $layoutdata['Remaining_Cell'], 0,$layoutdata['Target_Action_ID'],Application_ID,$Module_KEY_ID,$layoutdata['Module_ID']),
			  array('Layout_ID', 'Action_ID', 'First_Cell', 'Remaining_Cell', 'Control', 'Target_Action_ID', 'Application_ID', 'Module_ID', 'Orginal_ID')
			);	
		*/
	 //update menu 
     
	  $paramters['Layout']=$Layout_ID;//$this->db->lastInsertId();
	  $Err['Stat'] = 1;
      $Err['Msg'] = "?? ???? ??????? ?????";
      $Err['paramters'] = $paramters;

    $final_results = json_encode($Err);
    echo $final_results;

  }
   function Creator_buildCell_V4($appid, $moduleid, $actionid, $Cell_ID,$OLD_CELL_ID, $Layout_ID, $Color_ID=0) {



  	if($Color_ID=0)
	  {
      $arrColor_ID = $this->db->fetchOne(" SELECT `theme_color_id` FROM `users_application` where id='".$appid."'");
	  $Color_ID =$arrColor_ID['Theme_Color_ID'];
	  }
	  
        $cell_color = $this->db->fetchOne("SELECT * FROM core_module_action_cell_color WHERE Cell_ID='$Cell_ID' ");

	    $cell_theme_app = $this->db->fetchOne("SELECT * FROM users_application_theme_color WHERE  History=0  and Application_ID='".Application_ID."'");
		if($cell_color['Title_Color']=='')
		$cell_color['Title_Color']=$cell_theme_app['MainTexts'];
	if($cell_color['Des_Color']=='')
		$cell_color['Des_Color']=$cell_theme_app['MinorTexts'];
	if($cell_color['Key_Color']=='')
		$cell_color['Key_Color']=$cell_theme_app['Key_Color'];
	if($cell_color['Value_Color']=='')
		$cell_color['Value_Color']= $cell_theme_app['Value_Color'];
	if($cell_color['Other_Color']=='')
		$cell_color['Other_Color']=$cell_theme_app['Other_Color'];
	if($cell_color['Unselected']=='')
		$cell_color['Unselected']=$cell_theme_app['Unselected'];
	if($cell_color['Selected']=='')
		$cell_color['Selected']=$cell_theme_app['Selected'];

	
				$Title="";
				$Module_ID=$moduleid;
				$Img="";
				$Active=1;
				$Action_ID=$actionid;
				$Title_Color=$cell_color['Title_Color'];
				$Des_Color=$cell_color['Des_Color'];
				$Key_Color=$cell_color['Key_Color'];
				$Value_Color=$cell_color['Value_Color'];
				$Other_Color=$cell_color['Other_Color'];       
				$Layout_ID=$Layout_ID;
				$Application_ID=$appid;
				$this->db->execute("UPDATE `users_application_module_action_cell_new` 
				SET `History` =  '1' WHERE  `ID` =".$OLD_CELL_ID);
				
			   $Data=array($Title, $Module_ID, $Img, $Active, $Action_ID, $Title_Color, $Des_Color, $Key_Color, $Value_Color, $Other_Color,$Selected,$Unselected, $Layout_ID, $Cell_ID, Application_ID, $Color_ID);
			
				$this->db->insert(
			  'users_application_module_action_cell_new',$Data,			  
				array('Title', 'Module_ID', 'Img', 'Active', 'Action_ID', 'Title_Color', 'Des_Color', 'Key_Color', 'Value_Color', 'Other_Color','Selected','Unselected', 'Layout_ID', 'Cell_ID', 'Application_ID', 'Color_ID')
			);				
		
        return $this->db->lastInsertId();
		
  }
   function Creator_Control_V4($Application_ID,$Module_ID,$Action_ID,$Copy_Module_ID,$Orginal_ID,$Control,$Layout_ID=0,$IOS=0)
   {
	  $string_url = SITEURL.'/';
	  		  	if($IOS!=1)
							$Var="android";
						else
							$Var="ios/";
		$ControlArr=array();
		$CELL['Control']=array();
		$Arr_Setting=array();
		$Arr_Control_Setting=array();
		

	
	  
    $where = "1=1";
    if (isset($Application_ID)) {
        $where .= " and Application_ID='{$Application_ID}' ";
    }

    if (isset($Module_ID)) {
        $where .= " and Module_ID='{$Module_ID}' ";
    }

    if (isset($Action_ID)) {
        $where .= " and Action_ID='{$Action_ID}' ";
    }
	
	$output_app = $this->db->fetchOne("SELECT * FROM users_application_theme_color WHERE History=0 and  Application_ID='".Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
	$Color_ID=$output_app['Folder_Color_ID'];	


    $results = $this->db->fetchAll('SELECT * FROM users_application_module_layout_action_control  WHERE  `Layout_ID` ='.$Layout_ID, \Phalcon\Db::FETCH_ASSOC);
    $ControlArr = array();
    $CELL['Control'] = array();
	
	
	$Control_Arr['Group_ID']=0;
    foreach($results as $row){
		
	$Logic = array();
	$Cell = array();
	$Control = array();
	$Dz = array();
	$Permission = array();
	
		$output_app = $this->db->fetchOne("SELECT Group_ID FROM users_application_module_layout_action_control_group 
		WHERE Control_ID='".$row['ID']."'", \Phalcon\Db::FETCH_ASSOC);
        $Control_Arr['ID'] =  $row['ID'];

		$Control_Arr['Group_ID']=$output_app['Group_ID'];	
		$Control_Arr['Title'] = $row['Title'];
		$Logic['ID']= $this->Robo_Setting_Value('ID',$Control_Arr['ID']);
		$Logic['Title']= $this->Robo_Setting_Value('Title',$Control_Arr['Title']);
		$Logic['Group_ID']= $this->Robo_Setting_Value('Group_ID',$Control_Arr['Group_ID']);

        IF (isset($_REQUEST['Control_ID']) && $_REQUEST['Control_Layout_ID'] == '') {
            $_REQUEST['Control_Layout_ID'] = 1;
            $Control_Arr['Layout_ID'] = $_REQUEST['Control_Layout_ID'];
        } else {
            $Control_Arr['Layout_ID'] = $row['Layout_ID'];
        }
		
		$Logic['Layout_ID']= $this->Robo_Setting_Value('Layout_ID',$Control_Arr['Layout_ID']);
		$Logic['Target_Layout_ID']= $this->Robo_Setting_Value('Target_Layout_ID',$row['Target_Layout_ID']);
		$Logic['Data_Type']= $this->Robo_Setting_Value('Data_Type',$row['Data_Type']);
		$Logic['Target_Api']= $this->Robo_Setting_Value('Target_Api',$row['Api']);
		$Logic['Api_Paramater']= $this->Robo_Setting_Value('Api_Paramater',$row['Api_Paramater']);
		$Logic['Login_Stat']= $this->Robo_Setting_Value('Login_Stat',$row['Login_Stat']);

		$Cell['Scroll']= $this->Robo_Setting_Value('Scroll',$row['Scroll']);
		$Cell['Scroll_Type']= $this->Robo_Setting_Value('Scroll_Type',$row['Scroll_Type']);
		$Cell['Visible_Items']= $this->Robo_Setting_Value('Visible_Items',$row['Visible_Items']);
		$Cell['Cell_ID']= $this->Robo_Setting_Value('Cell_ID',$row['Cell_ID']);
		$Cell['Time']= $this->Robo_Setting_Value('Time',5);


		$Control['Key']= $this->Robo_Setting_Value('Key',$row['Control_Key']);
		$Control['Control_Type_ID']= $this->Robo_Setting_Value('Control_Type_ID',$row['Control_ID']);
		$Control['Control_Layout_ID']= $this->Robo_Setting_Value('Control_Layout_ID',$row['Control_Layout_ID']);
		$Control['Type_Place']= $this->Robo_Setting_Value('Type_Place',$row['Type_Place']);
		$Dz['BgColor']= $this->Robo_Setting_Value('BgColor',"#ff2324");
		$Dz['SelectedColor']= $this->Robo_Setting_Value('SelectedColor',"#f02324");
		$Permission['Admin_Del']= $this->Robo_Setting_Value('Admin_Del',"2");
		$Permission['User_Del']= $this->Robo_Setting_Value('User_Del',"2");
		$Permission['User_Edit']= $this->Robo_Setting_Value('User_Edit',"2");
		
		$Control_Arr['Dz']=array();

		IF($Control_Arr['Cell_ID']!='' && $Control_Arr['Cell_ID']!=0 && $Control_Arr['Cell_ID']!=' ')
		{
		$arr_files=$this->Theme_Path_Dz_Cell($Color_ID,$Control_Arr['Cell_ID'],$Var);
		$Dz[]= $this->Robo_Setting_Value('Files',$arr_files);
		}


	 $Arr_Cell['Cell']=$Cell;
	 $Arr_Cell['Dz']=$Dz;
	 $Arr_Cell['Logic']=$Logic;
	 $Arr_Cell['Control']=$Control;
	 $Arr_Cell['Permission']=$Permission;
		
       $ControlArr[] = $Arr_Cell;
    }

	 
	 return $ControlArr;

	  
  }
 

  	function Theme_Path_Dz_Control_V4($Color_ID,$Control_ID,$Layout_ID,$Theme_PlatForm,$Cell_ID=0)
	{		
				$Files['files']=array();
				$arr_files_new=array();
				$Color_Folder=$Color_ID.'/';	
				$Theme_Folder="default/";	
				if($Theme_PlatForm=="android")
				$Theme_PlatForm="android/".$_REQUEST['Screen_Dim'].'/';

			 IF($Control_ID==10)
			 {
			 	$Theme_Path=ROOT_PATH."media/core_data/v4/slice/control/".$Theme_PlatForm;				
			
				$arr_files = $this->listdir($Theme_Path);

				for($i=0;$i<count($arr_files);$i++)
				{				
				$var=$arr_files[$i];
				$arr_files_new[$var]='/'.$Theme_Path.$var;
				}		
				$Files['files']=$arr_files_new;

			 }
			 else
			 {
				 $Files=Theme_Path_Dz_Cell_V4($Color_ID,$Cell_ID,$Theme_PlatForm);
			 }
				
				return $Files;
	}
	function Theme_Path_Dz_Orders_V4($IOS,$arr_files,$string_url)
	{
	if($IOS!=1)
		{
		
			foreach ($arr_files['files'] as $key => $value) {
			  $key = str_replace(".png", "", "$value");
			  $key = basename("$key", ".d").PHP_EOL;
			  $key = @trim($key);
			  $value = str_replace(ROOT_PATH, '', $value);
			  $Images_First_Cell[$key] = $string_url."$value";
			}
		}
		else
		{
			   foreach ($arr_files['files'] as $key => $value) {
			  $key = str_replace(".png", "", "$value");
			  $key = basename("$key", ".d");
				if($_REQUEST['Local_App']==1 && $_REQUEST['Local_App']!='')
				{
				$key = str_replace("@2x", "", "$key");
				$key = str_replace("@3x", "", "$key");	
				$key = str_replace("~ipad", "", "$key");	
				$value = str_replace("@2x", "", "$value");
				$value = str_replace("@3x", "", "$value");	
				$value = str_replace("~ipad", "", "$value");	
				}
				else
				{
					
				}
			  
				$Images_First_Cell['nariman'] = "";
				$Screen_Dim=$_REQUEST['Screen_Dim'];
				if (strpos($key, $Screen_Dim) !== FALSE)
				{
				$key = @trim($key);
				$key = str_replace("~ipad", "", "$key");
				$key = str_replace("@2x", "", "$key");
				$key = str_replace("@3x", "", "$key");
				  $value = str_replace(ROOT_PATH, '', $value);

				  $Images_First_Cell[$key] = $string_url."$value";
			  }
	   
			}
		}
		
		return $Images_First_Cell;
}
	function Theme_Path_Dz_Cell_V4($Color_ID,$Theme_Cell,$Theme_PlatForm)
	{		
				$Files['files']=array();
				$arr_files_new=array();
				$Color_Folder=$Color_ID.'/';	
				$Theme_Folder="default/";	
				if($Theme_PlatForm=="android")
				$Theme_PlatForm="android/".$_REQUEST['Screen_Dim'].'/';

			 	$Theme_Path=ROOT_PATH."media/core_data/v4/slice/cell/".$Theme_Folder.'/'.$Theme_Cell.'/'.$Theme_PlatForm;				
			
				$arr_files = $this->listdir($Theme_Path);

				for($i=0;$i<count($arr_files);$i++)
				{				
				$var=$arr_files[$i];
				$arr_files_new[$var]='/'.$Theme_Path.$var;
				}		
				
				$Theme_Folder="fcolor/";
				  $Theme_Path=ROOT_PATH."media/core_data/v4/slice/cell/".$Theme_Folder.$Color_Folder.'/'.$Theme_Cell.'/'.$Theme_PlatForm;				
				
			
				$arr_files2 = $this->listdir($Theme_Path);
				for($i=0;$i<count($arr_files2);$i++)
				{				
				 $var=$arr_files2[$i];
				 $arr_files_new[$var]='/'.$Theme_Path.$var;
				}
				
				$Files['files']=$arr_files_new;
	
		
				
				return $Files;
	}

    
	
	function Robo_Login_V4($Username, $Password) {
	$Lang_ID=$_REQUEST['Lang_ID'];
	$paramters=array();	
	$paramters['Lang_ID']=$Lang_ID;
	
    if(!empty($_REQUEST['Social_ID']) && !empty($_REQUEST['Social_Type'])){
      $social = $this->db->fetchOne("SELECT * FROM cp_app_account_social WHERE `Social_ID`='".$_REQUEST['Social_ID']."' AND `Social_Type`='".$_REQUEST['Social_Type']."'", \Phalcon\Db::FETCH_ASSOC);
      if($social){
        $output_app = $this->db->fetchOne("SELECT * FROM cp_app_account WHERE `ID`='".$social['User_ID']."'", \Phalcon\Db::FETCH_ASSOC);
      }
      else{
        $this->Artgine_Response(0, "هناك خطأ في البيانات", array(), 'Login_App');
      }
    }
    else{
      $output_app = $this->db->fetchOne("SELECT * FROM cp_app_account WHERE `Username`='".$Username."' AND `Password`='".MD5($Password)."' AND Reg_Type='web'", \Phalcon\Db::FETCH_ASSOC);
    }
    $Application_ID = $output_app['Application_ID'];
    $Type_User = $output_app['Type_User'];
    $Live = $_REQUEST['Live'];
    $ID = $output_app['ID'];
    if ($Type_User == '1') {
      $Err['Stat'] = 1;
	 $_SESSION['Account_ID']=$ID;

      $Err['Msg'] = "تم تسجيل الدخول ";
      $Err['paramters'] = $paramters;
	  $Err['Application']=array();
		$arrs=array();
		
      $result_app2 = $this->db->fetchAll("SELECT * FROM `cp_app_account_application` WHERE `Account_ID`=$ID", \Phalcon\Db::FETCH_ASSOC);
      foreach ($result_app2 as $output_app2) {
        $Application_ID = $output_app2['Application_ID'];

		$arr=$this->Robo_Application_Display($Application_ID);
        if($arr['Title']!='')
        $arrs[] = $arr;
      }
      $Err['Application'] = $arrs;
	
      echo $this->json_encode_convert($Err, 'Login_App');
    } else {
      $Paramters[] = "user";
      $Paramters[] = "pass";
      $this->Artgine_Response(0, "هناك خطا في البيانات", $Paramters, 'Login_App');
    }
  }
  function Robo_Application_Display($Application_ID)
	{
		$Where_Live="";
		if($Live=='')
		{
		//	 $Where_Live="Live='1' and";
		}
				
        $output_app = $this->db->fetchOne("SELECT * FROM users_application WHERE  live='0' and `id`='".$Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
        $arr['ID'] = $output_app['ID'];
		$arr['Type'] = '1';		
        $arr['Title'] = $output_app['Title'];
        $arr['Des'] = $output_app['Des'];
        $arr['BG'] = IMAGE_URL.$output_app['BG'];
        $arr['Splash'] = IMAGE_URL.$output_app['Splash_Screen'];
        $arr['Img'] = IMAGE_URL.$output_app['Icon'];
        $arr['Type_App_Lang'] = $output_app['Type_App_Lang'];
		$arr['Main_Page_Layout_ID']= $output_app['Main_Page_Layout_ID'];
		$arr['Main_Page_Api'] = $output_app['Main_Page_Api'];
		$arr['Entry_Point']= $output_app['Entry_Point'];

		$arr['Main_Page_Title']= "اسم الرئيسيه";

        $output_app_color = $this->db->fetchOne("SELECT * FROM users_application_theme_color WHERE History=0 and `Application_ID`='".$Application_ID."'", \Phalcon\Db::FETCH_ASSOC);        
		$arr['StatsBar_1'] = $output_app_color['StatsBar_Color'];
        $arr['Header_2'] = $output_app_color['Header_Bar_color'];
		$arr['Title_Color_3'] = $output_app_color['StatsBar_Text_Bar'];
		$arr['FColor'] = $output_app_color['FColor'];
		$output = $this->db->fetchOne('SELECT Ads_Setting FROM users_application where `id`='.Application_ID, \Phalcon\Db::FETCH_ASSOC);
		$Ads_Setting = $output['Ads_Setting'];
		$arr_ads = unserialize($Ads_Setting);
		$arr_ads['Type']=$arr_ads['Type'];
		//$arr_ads['Place']="1";
		
		$arr['Module'] = $module;
		$arr_ads['Publisher_ID'] = $arr_ads['Android_Publisher_ID'];
		
		$arr['Setting_Ads'] = $arr_ads;
        /*
		$output_app = $this->db->fetchOne("SELECT Main_Page_Layout_ID FROM users_application WHERE `ID` =".$Application_ID, \Phalcon\Db::FETCH_ASSOC);
		$arr['Main_Page_Layout_ID'] = $output_app['Main_Page_Layout_ID'];
		$arr['Main_Page_Api'] = "http://robo-apps.com/engine/api/?Str=1&Page=1&Module_ID=0&Application_ID=535&Action_ID=103&Menu_Navigate_ID=886";
		$arr['Title'] = "اسم الرئيسيه";
		*/
		
		return $arr;
	}

	function Robo_Setting_V4() {
		$output_app = $this->db->fetchOne("SELECT Setting_App,Menu_Depts_ID FROM users_application WHERE `id`='".Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
		$Arr['Setting_App'] = $output_app['Setting_App'];
		$Arr_Lang['Title'] = "ssdasd";
		$Arr_Color['H1'] = "#aaerweS";
		$Arr['Color'] = $Arr_Color;
		$Arr_Color['H2'] = "#aaerweS";
		$Arr_Module['Module_User_ID'] = "190";
		$Analysis = "12312";
		$Admob = "12312";
		$Arr['Color'] = $Arr_Color;
		$Arr['Lang'] = $Arr_Lang;
		$Arr['Module_ID'] = $Arr_Module;
		$Arr['Analysis'] = $Analysis;
		$Arr['Admob'] = $Admob;
		$setting['setting'] = $Arr;
		$final_results = $this->json_encode_convert($setting, "Setting");
		echo $final_results;
	  }

   function Robo_Single_App_V4() {

      $Err['Stat'] = 1;
      $Err['Msg'] = "تم تسجيل الدخول بنجاح ";
      $Err['paramters'] = array();

         $Application_ID = $_REQUEST['Application_ID'];
		
		
        $output_app = $this->db->fetchOne("SELECT * FROM users_application WHERE  `ID`='".$Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
        $arr['Type'] = '1';
        $arr['Title'] = $output_app['Title'];
        $arr['Type_App_Lang'] = $output_app['Type_App_Lang'];
        $arr['Des'] = $output_app['Des'];
        $arr['Splash'] = IMAGE_URL.$output_app['Splash_Screen'];
        $arr['Img'] = IMAGE_URL.$output_app['Icon'];
        $output_app_color = $this->db->fetchOne("SELECT * FROM users_application_theme_color WHERE History=0 and `Application_ID`='".$Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
        $arr['BG'] = IMAGE_URL.$output_app['BG'];
        $arr['StatsBar_1'] = $output_app_color['StatsBar_Color'];
        $arr['Header_2'] = $output_app_color['Header_Bar_color'];
		$arr['Title_Color_3'] = $output_app_color['StatsBar_Text_Bar'];
		$arr['FColor'] = $output_app_color['FColor'];
		$arr['Main_Page_Layout_ID']= $output_app['Main_Page_Layout_ID'];
		$arr['Entry_Point']= $output_app['Entry_Point'];
		$arr['Main_Page_Api'] = $output_app['Main_Page_Api'];
		$arr['Main_Page_Title']= "??? ????????";
		$output = $this->db->fetchOne('SELECT Ads_Setting FROM users_application where `id`='.Application_ID, \Phalcon\Db::FETCH_ASSOC);
		$Ads_Setting = $output['Ads_Setting'];
		$arr_ads = unserialize($Ads_Setting);
		$arr_ads['Type']=$arr_ads['Type'];
		//$arr_ads['Place']="1";
		
		$arr['Module'] = $module;
		$arr_ads['Publisher_ID'] = $arr_ads['Android_Publisher_ID'];
		
		$arr['Setting_Ads'] = $arr_ads;
        $arr['ID'] = $output_app['ID'];
        if($arr['Title']!='')
        $arrs[] = $arr;
     
      $Err['Application'] = $arrs;
      echo $this->json_encode_convert($Err, 'Login_App');
  }
 
 
   function Robo_Menu_V4() {

    if ($_SESSION['App_User_ID'] != '') {
      $Login = 1;
    } else {
      $Login = 2;
      if ($_REQUEST['UserId'] != '') {
        $Login = 1;
        $_SESSION['App_User_ID'] = $_REQUEST['UserId'];
      }
    }
	$Menu_Navigate_ID=$_REQUEST['Menu_Navigate_ID'];
	if($Menu_Navigate_ID=='')
	{
	$output_app = $this->db->fetchOne("SELECT ID FROM users_application_menu_navigate WHERE `Default` =1 AND  `Application_ID` =".Application_ID, \Phalcon\Db::FETCH_ASSOC);
    $Menu_Navigate_ID = $output_app['ID'];
	}

	 $cat = array();
	 $outputs= array();
	 $DZ= array();

	 $output_app = $this->db->fetchOne("SELECT Menu_Version_ID,Menu_Updated,Menu_Layout_ID,Menu_Depts_ID,Logo,BG FROM users_application WHERE `ID`='".Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
    $Menu_Layout_ID = $output_app['Menu_Layout_ID'];
    $arr['Menu_Layout_ID']  = $output_app['Menu_Layout_ID'];	
    $Menu_Updated  = $output_app['Menu_Updated'];	

	$output_app_color = $this->db->fetchOne("SELECT * FROM users_application_theme_color WHERE History=0 and `Application_ID`='".Application_ID."'", \Phalcon\Db::FETCH_ASSOC);
        

	
   $DZ['Logo'] = IMAGE_URL.'/'.$output_app['Logo'];

   $output_Color = $this->db->fetchOne('SELECT * FROM users_application_menu_layout WHERE  Menu_Navigate_ID='.$Menu_Navigate_ID.' and `Application_ID` ='.Application_ID);
	    $Color = array();
	  $arr['Menu_Version_ID'] =$output_Color['Menu_Version_ID'];	

		if($arr['Menu_Version_ID']==0 || $arr['Menu_Version_ID']=='')
		{
			$arr['Menu_Version_ID']="1";
		}
		
      $DZ['BackGround'] = IMAGE_URL.'/'.$output_app['BG'];
      $DZ['Bg_Button'] = IMAGE_URL.'/'.$output_Color['Bg_Button'];
  //    $arr['BackGround'] = IMAGE_URL.$output_Color['Path'].$output_Color['BG_Android'];
   //  $arr['BackGround'] = IMAGE_URL.$output_Color['Path'].$output_Color['BG_iphone'];
 	$arr['Menu_Navigate_ID'] =$Menu_Navigate_ID;	
 	$arr['Animation_ID'] =$output_Color['Animation_ID'];	

    $DZ['BG_Color'] = $output_Color['BG_Color'];
	$sql="SELECT * FROM users_application_menu  where Header=0 and Menu_Navigate_ID='".$Menu_Navigate_ID."' and Active=1  and (Login='0' or Login='".$Login."')   AND `Application_ID`='".Application_ID."' ORDER BY `Orders` ASC ".$limit;
    $result = $this->db->fetchAll($sql);
    foreach ($result as $output) {
      $cat = array();
      $cat['ID'] = $output['ID'];
      $cat['Title'] = $output['Title'];
	  $Module_ID=$output['Module_ID'];
	  $Action_ID=$output['Action_ID'];

      $cat['Target_Layout_ID'] = $output['Target_Layout_ID'];

	  
      $cat['Des'] = $output['Des'];
      $Pic = $output['Pic'];
	  
      $cat['Pic'] = SITEURL."/media/".$Pic;
	  
	  	  $temp= $this->db->fetchOne('SELECT base_url FROM users_application_module WHERE id='.$Module_ID, \Phalcon\Db::FETCH_ASSOC);
		  $Base_URL=$temp['Base_URL'];
		  if($Base_UR=='')
		  {
			  $Base_URL="http://robo-apps.com/robo_v4/engine/api/?Str=1&";
		  }
		 $cat['Api'] =$Base_URL."&Application_ID=".Application_ID.'&Module_ID='.$Module_ID."&Action_ID=".$Action_ID."&".$output['Var']."=".$output['Key_ID'];
	
	  
	  
	  $image_menu= array();
      $cat['Image'] = $image_menu;
	  
	  
	  $Color['Notify'] = $output_Color['Notify_Color'];	
      $Color['Circle'] = $output_Color['Circle_Color'];
      $Color['Title'] = $output_Color['Label_Color'];
	$Color['Title_Color_Selected'] =$output_Color['Title_Color_Selected'];	
	  $Color['Bar_Color_Selected'] =$output_Color['Bar_Color_Selected'];	

      $Color['Des'] = $output_Color['Description_Color'];
      $cat['Color'] = $Color;

	
      $n = $arr['Menu_Version_ID'];
      if ($n != 1) {
        $Android = stripos($_SERVER['HTTP_USER_AGENT'], "Android");
	   
		$arr_img=array();
		if($Menu_Updated==1)
		{
			 $path="core_data/applications/".Application_ID.'/menu/'.$n.'/';	  		 	 
			  $newpath = UPLOAD_PATH.$path."ios/";
			  $string_url=SITEURL.'/media/'.$path."ios/";
		}
		else		
		{	      
			$path='core_data/menu/slicing/'.$arr['Menu_Version_ID'].'/ios/';
          $newpath = UPLOAD_PATH.$path;
		  $string_url=SITEURL.'/media/'.$path;
		
		}
        $arr_img = $this->listdir($newpath);

        foreach ($arr_img as $key => $value) {
	

          $x = 'png';
          if (($x) ? preg_match('/'.$x.'$/', $value, $matches) : 1) {
            $key = str_ireplace(".png", "", "$value");
            $key = basename("$key", ".d").PHP_EOL;
            $newkey = str_ireplace("_"."$n", "", "$key");
            $newkey = str_ireplace("$newkey ", "", "$newkey");
            $newkey = str_ireplace(" ", "", "$newkey");
			$True = stripos($value, "@3x");
            $iphone2x = stripos($value, "@2x");
            $iPad = stripos($_SERVER['HTTP_USER_AGENT'], "iPad");
            $key = str_ireplace("@2x", "", "$key");
            $key = str_ireplace("~ipad", "", "$key");
            $True_ipad = stripos($value, "~ipad");
            $value = @trim($value);
            $key = @trim($key);
		
							if (!$True && !$True_ipad && !$iPad) {
							  $image_menu[$key] = $string_url.basename($value);
							} elseif ($True_ipad && $iPad && !$True && !$iphone2x) {
							  $image_menu[$key] = $string_url.basename($value);
							}
          }
        
		
		
		
		}
   



   }
        $cat['Image'] =$image_menu;

	  
	  
	  
      $outputs[] = $cat;
    }
    $arr_app['Menu'] = $arr;
    $arr_app['Design'] = $DZ;
    $arr_app['Items'] = $outputs;
    $final_results = json_encode($arr_app);
    echo $final_results;
  }

     function Update_Theme_V4() {
	 $Theme_ID=$_REQUEST['Theme_ID'];
	$Lang_ID=$_REQUEST['Lang_ID'];
	$paramters=array();	
	$paramters['Lang_ID']=$Lang_ID;
		if($Theme_ID!='' && $Theme_ID!=' ')		
		{
		$this->db->execute("UPDATE  `users_application` SET `theme_color_id` =  '".$Theme_ID."',`color_id` = '".$Theme_ID."' WHERE  `ID` =".Application_ID);

		$themedata = $this->db->fetchOne("SELECT * FROM core_theme_color WHERE ID='".$Theme_ID."'");
		$this->db->execute("UPDATE `users_application_theme_color` SET `History` =  '1',`History_Date` =  '2' WHERE  `Application_ID` =".Application_ID);
		$this->db->insert(
				  'users_application_theme_color',
					array(Application_ID, $themedata['MainTexts'], $themedata['MinorTexts'], $themedata['StatsBar_Color'],$themedata['Header_Bar_color'], $themedata['StatsBar_Text_Bar'], $themedata['FColor'], $themedata['SColor'],$Theme_ID,$themedata['Folder_Color_ID']), 
					array('Application_ID', 'MainTexts', 'MinorTexts', 'StatsBar_Color', 'Header_Bar_color', 'StatsBar_Text_Bar', 'FColor', 'SColor', 'Core_Theme_Color_ID','Folder_Color_ID')
				);
				
		$paramters['Theme']=1;	
		}
		else
		{
		  $paramters['Theme']=0;
		}
		

	  $Err['Stat'] = 1;
      $Err['Msg'] = "?? ????? ?????? ????? ";
      $Err['paramters'] = $paramters;

    
    $final_results = json_encode($Err);
    echo $final_results;
	 }
    function Update_Menu_Layout_V4()
	{
	 $Menu_Version_ID=$_REQUEST['Menu_Version_ID'];
	$Lang_ID=$_REQUEST['Lang_ID'];
	$Layout_ID=$_REQUEST['Layout_ID'];
	$paramters=array();	
	$paramters['Lang_ID']=$Lang_ID;
	if($Menu_Version_ID!='')
		{

					$this->db->execute("UPDATE `users_application_menu_layout` SET Menu_Version_ID =  '".$Menu_Version_ID."',`History` =  '1',`History_Date` =  '2' WHERE  `Application_ID` =".Application_ID);
					$this->db->execute("UPDATE  `users_application` SET `menu_version_id`=".$Menu_Version_ID." ,`menu_updated` =  '0'  WHERE  `id` =".Application_ID);
					
					IF($Layout_ID!='')
					$this->db->execute("UPDATE  `users_application_module_layout_action_new` SET `Menu_Version_ID`=".$Menu_Version_ID."  WHERE  `ID` =".$Layout_ID);

		  $paramters['Menu']=1;

		}
		else
		{
		  $paramters['Menu']=0;
		}
		

	  $Err['Stat'] = 1;
      $Err['Msg'] = "تم تسجيل الدخول بنجاح";
      $Err['paramters'] = $paramters;

    
    $final_results = json_encode($Err);
    echo $final_results;
		
	}  
  
    public function Get_KeyValue_V4()
   {
	$Json=array();
	$Module_KEY_ID=$_REQUEST['Module_KEY_ID'];
			$Glayout = $this->db->fetchAll("SELECT * FROM core_cell_keyvalue");
			$Arr_Group=array();
			if ($Glayout) {
			foreach ($Glayout as $G_Title) {
			$Layout['ID']=$G_Title['ID'];
			$Layout['Img']=IMAGE_URL.$G_Title['Img'];
			$Arr_Layout[]=$Layout;
			}
			}
			$Json['Layout']=$Arr_Layout;					
			$Arr_Layout=array();			
			$Glayout = $this->db->fetchAll("SELECT * FROM data_general_groups_lang WHERE Module_ID='".$Module_KEY_ID."' and Application_ID='".Application_ID."' and Lang_ID='1'");
			if ($Glayout) {
			foreach ($Glayout as $G_Title) {
			$Group['ID']=$G_Title['ID'];
			$Group['Title']=$G_Title['Title'];
		    $layoutCheack = $this->db->fetchOne("SELECT Layout_ID  FROM `data_general_groups` WHERE `ID` = '".$Group['ID']."'");
			$Group['Selected']=$layoutCheack['Layout_ID'];
			$Arr_Group[]=$Group;

			}
			 
			}
			$Json['Group']=$Arr_Group;					


    $final_results = json_encode($Json);
    echo $final_results;
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

    public function Artgine_Response($Stat, $Msg, $Paramters = array(), $handle = 'Err')
    {
        $Err['Stat'] = $Stat;
        $Err['Msg'] = $Msg;
        $Err['paramters'] = $Paramters;
        //$Err = $this->json_encode_convert($Err,"Message_Error");
        echo $this->json_encode_convert($Err, $handle);
        exit;
    }

	

 
}
