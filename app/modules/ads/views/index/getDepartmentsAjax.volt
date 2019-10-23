<?php
echo "<ul>";
foreach ($big_array as $value){
    echo "<li>".$value["MainDept"];
    foreach ($value["Cats"] as $cat){
        echo "<ul>";
        echo "<li>".$cat["Dep_Title"];
        if(!empty($cat['Dep_Children'])){
            echo CmsHelpers::displayTree($cat['Dep_Children']);
        }
        echo "</li>";
        echo "</ul>";
    }
    echo "</li>";
}
echo "</ul>";