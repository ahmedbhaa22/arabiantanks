<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<?php use Phalcon\Tag; ?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["users_application_module/index", "Go Back"]); ?></li>
            <li class="next"><?php echo $this->tag->linkTo(["users_application_module/new", "Create "]); ?></li>
        </ul>
    </nav>
</div>

<div class="page-header">
    <h1>Search result</h1>
</div>

<?php echo $this->getContent(); ?>

<div class="row">
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
            <th>Application Of ID</th>
            <th>Package Of ID</th>
            <th>Orginal Of ID</th>
            <th>Copy Of Module Of ID</th>
            <th>Title</th>
            <th>Login</th>
            <th>Setting</th>
            <th>Auth Of Setting</th>
            <th>BG Of Iphone</th>
            <th>BG Of Ipad</th>
            <th>BG Of Android</th>
            <th>Base Of URL</th>
            <th>Get Of Orders Of Setting</th>
            <th>Color</th>
            <th>With Of Key Of Value</th>
            <th>Mapping Of Api</th>
            <th>Plugin Of Api</th>
            <th>Active</th>

                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($page->items as $users_application_module): ?>
            <tr>
                <td><?php echo $users_application_module->ID ?></td>
            <td><?php echo $users_application_module->Application_ID ?></td>
            <td><?php echo $users_application_module->Package_ID ?></td>
            <td><?php echo $users_application_module->Orginal_ID ?></td>
            <td><?php echo $users_application_module->Copy_Module_ID ?></td>
            <td><?php echo $users_application_module->Title ?></td>
            <td><?php echo $users_application_module->Login ?></td>
            <td><?php echo $users_application_module->Setting ?></td>
            <td><?php echo $users_application_module->Auth_Setting ?></td>
            <td><?php echo $users_application_module->BG_Iphone ?></td>
            <td><?php echo $users_application_module->BG_Ipad ?></td>
            <td><?php echo $users_application_module->BG_Android ?></td>
            <td><?php echo $users_application_module->Base_URL ?></td>
            <td><?php echo $users_application_module->Get_Orders_Setting ?></td>
            <td><?php echo $users_application_module->Color ?></td>
            <td><?php echo $users_application_module->With_Key_Value ?></td>
            <td><?php echo $users_application_module->Mapping_Api ?></td>
            <td><?php echo $users_application_module->Plugin_Api ?></td>
            <td><?php echo $users_application_module->Active ?></td>

                <td><?php echo $this->tag->linkTo(["users_application_module/edit/" . $users_application_module->ID, "Edit"]); ?></td>
                <td><?php echo $this->tag->linkTo(["users_application_module/delete/" . $users_application_module->ID, "Delete"]); ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>
</div>

<div class="row">
    <div class="col-sm-1">
        <p class="pagination" style="line-height: 1.42857;padding: 6px 12px;">
            <?php echo $page->current, "/", $page->total_pages ?>
        </p>
    </div>
    <div class="col-sm-11">
        <nav>
            <ul class="pagination">
                <li><?php echo $this->tag->linkTo("users_application_module/search", "First") ?></li>
                <li><?php echo $this->tag->linkTo("users_application_module/search?page=" . $page->before, "Previous") ?></li>
                <li><?php echo $this->tag->linkTo("users_application_module/search?page=" . $page->next, "Next") ?></li>
                <li><?php echo $this->tag->linkTo("users_application_module/search?page=" . $page->last, "Last") ?></li>
            </ul>
        </nav>
    </div>
</div>
