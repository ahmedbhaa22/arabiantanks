<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<?php use Phalcon\Tag; ?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["screen/index", "Go Back"]); ?></li>
            <li class="next"><?php echo $this->tag->linkTo(["screen/new", "Create "]); ?></li>
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

                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($page->items as $screen): ?>
            <tr>
                <td><?php echo $screen->id ?></td>
            <td><?php echo $screen->title ?></td>
            <td><?php echo $screen->des ?></td>
            <td><?php echo $screen->project_id ?></td>

                <td><?php echo $this->tag->linkTo(["screen/edit/" . $screen->id, "Edit"]); ?></td>
                <td><?php echo $this->tag->linkTo(["screen/delete/" . $screen->id, "Delete"]); ?></td>
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
                <li><?php echo $this->tag->linkTo("screen/search", "First") ?></li>
                <li><?php echo $this->tag->linkTo("screen/search?page=" . $page->before, "Previous") ?></li>
                <li><?php echo $this->tag->linkTo("screen/search?page=" . $page->next, "Next") ?></li>
                <li><?php echo $this->tag->linkTo("screen/search?page=" . $page->last, "Last") ?></li>
            </ul>
        </nav>
    </div>
</div>
