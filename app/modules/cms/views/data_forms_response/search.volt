<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<?php use Phalcon\Tag; ?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["data_forms_response/index", "Go Back"]); ?></li>
            <li class="next"><?php echo $this->tag->linkTo(["data_forms_response/new", "Create "]); ?></li>
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
            <th>Form Of ID</th>
            <th>Response</th>
            <th>IP</th>
            <th>User Of ID</th>
            <th>Date</th>

                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($page->items as $data_forms_response): ?>
            <tr>
                <td><?php echo $data_forms_response->ID ?></td>
            <td><?php echo $data_forms_response->Form_ID ?></td>
            <td><?php echo $data_forms_response->Response ?></td>
            <td><?php echo $data_forms_response->IP ?></td>
            <td><?php echo $data_forms_response->User_ID ?></td>
            <td><?php echo $data_forms_response->Date ?></td>

                <td><?php echo $this->tag->linkTo(["data_forms_response/edit/" . $data_forms_response->ID, "Edit"]); ?></td>
                <td><?php echo $this->tag->linkTo(["data_forms_response/delete/" . $data_forms_response->ID, "Delete"]); ?></td>
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
                <li><?php echo $this->tag->linkTo("data_forms_response/search", "First") ?></li>
                <li><?php echo $this->tag->linkTo("data_forms_response/search?page=" . $page->before, "Previous") ?></li>
                <li><?php echo $this->tag->linkTo("data_forms_response/search?page=" . $page->next, "Next") ?></li>
                <li><?php echo $this->tag->linkTo("data_forms_response/search?page=" . $page->last, "Last") ?></li>
            </ul>
        </nav>
    </div>
</div>
