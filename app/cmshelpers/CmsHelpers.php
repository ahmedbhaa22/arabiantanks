<?php
use Phalcon\Tag;

class CmsHelpers extends Tag{
    public static function displayChildrenTree($array){
        $code="";
        foreach ($array as $value){
            $code.= "<ul>";
            $code .= "<li>".\Phalcon\Tag::checkField(array("Depts_ID[]", "value" => $value["Dep_ID"],)).$value['Dep_Title'];
            if (!empty($value['Dep_Children'])){
                $code .= self::displayChildrenTree($value['Dep_Children']);
            }
            $code .= "</li>";
            $code .= "</ul>";

        }
        return $code;
    }
    public static function ajaxDeptsTree($big_array){
        $code= "<ul>";
        foreach ($big_array as $value){
            $code.= "<li>".$value["MainDept"];
            foreach ($value["Cats"] as $cat){
                $code.= "<ul>";
                $code.= "<li>".\Phalcon\Tag::checkField(array("Depts_ID[]", "value" => $cat["Dep_ID"],)).$cat["Dep_Title"];
                if(!empty($cat['Dep_Children'])){
                    $code.= self::displayChildrenTree($cat['Dep_Children']);
                }
                $code.= "</li>";
                $code.= "</ul>";
            }
            $code.= "</li>";
        }
        $code.= "</ul>";
        $code.="<div class='form-group'><div class='col-md-12'><label class=\"control-label col-md-2 bg-info col-sm-2\">Content</label><div class=\"col-md-10 col-sm-10\"><input name='Content' type='text' id='auto_complete_content' onfocus='autocompleteTest()' /></div></div></div>";
        $code.="<input name='Content_ID' type='hidden' id='Content_ID' />";
        return $code;
    }
}