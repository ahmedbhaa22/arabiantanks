<?php
function buildTree( Phalcon\Mvc\Model\Resultset\Simple $depts , $parentId = 0) {
    foreach ($depts as $dept){

        if ($dept->Parent_Depts_ID == $parentId){
            echo "<li>";
            echo $dept->Title .$dept->ID ;
            echo "<ul class='child'>";
            buildTree(DataCmsDeptsRel::find(),$dept->ID);
            echo "</ul>";
            echo "</li>";
        }

    }
}
echo "<ul>";
buildTree(DataCmsDeptsRel::find());
echo "</ul>";

?>