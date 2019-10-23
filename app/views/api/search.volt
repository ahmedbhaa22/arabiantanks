<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<?php use Phalcon\Tag; ?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["api/index", "Go Back"]); ?></li>
            <li class="next"><?php echo $this->tag->linkTo(["api/new", "Create "]); ?></li>
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
                <th>Id</th>
            <th>Title</th>
            <th>Des</th>
            <th>Project</th>
            <th>Screen</th>
            <th>Success Of Response</th>
            <th>Fail Of Response</th>
            <th>Empty Of Response</th>
            <th>Type Of Method</th>
            <th>Api Of Link</th>

                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($page->items as $api): ?>
            <tr>
                <td><?php echo $api->id ?></td>
            <td><?php echo $api->title ?></td>
            <td><?php echo $api->des ?></td>
            <td><?php echo $api->project_id ?></td>
            <td><?php echo $api->screen_id ?></td>
            <td><?php echo $api->success_response ?></td>
            <td><?php echo $api->fail_response ?></td>
            <td><?php echo $api->empty_response ?></td>
            <td><?php echo $api->type_method ?></td>
            <td><?php echo $api->api_link ?></td>

                <td><?php echo $this->tag->linkTo(["api/edit/" . $api->id, "Edit"]); ?></td>
                <td><?php echo $this->tag->linkTo(["api/delete/" . $api->id, "Delete"]); ?></td>
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
                <li><?php echo $this->tag->linkTo("api/search", "First") ?></li>
                <li><?php echo $this->tag->linkTo("api/search?page=" . $page->before, "Previous") ?></li>
                <li><?php echo $this->tag->linkTo("api/search?page=" . $page->next, "Next") ?></li>
                <li><?php echo $this->tag->linkTo("api/search?page=" . $page->last, "Last") ?></li>
            </ul>
        </nav>
    </div>
</div>
