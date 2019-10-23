<?php
/**
 * @var \Phalcon\Mvc\View\Engine\Php $this
 */
?>

<?php use Phalcon\Tag; ?>

<div class="row">
    <nav>
        <ul class="pager">
            <li class="previous"><?php echo $this->tag->linkTo(["screen_media/index", "Go Back"]); ?></li>
            <li class="next"><?php echo $this->tag->linkTo(["screen_media/new", "Create "]); ?></li>
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
            <th>Media</th>
            <th>Screen</th>
            <th>Type</th>

                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($page->items as $screen_media): ?>
            <tr>
                <td><?php echo $screen_media->id ?></td>
            <td><?php echo $screen_media->title ?></td>
            <td><?php echo $screen_media->media ?></td>
            <td><?php echo $screen_media->screen_id ?></td>
            <td><?php echo $screen_media->type ?></td>

                <td><?php echo $this->tag->linkTo(["screen_media/edit/" . $screen_media->id, "Edit"]); ?></td>
                <td><?php echo $this->tag->linkTo(["screen_media/delete/" . $screen_media->id, "Delete"]); ?></td>
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
                <li><?php echo $this->tag->linkTo("screen_media/search", "First") ?></li>
                <li><?php echo $this->tag->linkTo("screen_media/search?page=" . $page->before, "Previous") ?></li>
                <li><?php echo $this->tag->linkTo("screen_media/search?page=" . $page->next, "Next") ?></li>
                <li><?php echo $this->tag->linkTo("screen_media/search?page=" . $page->last, "Last") ?></li>
            </ul>
        </nav>
    </div>
</div>
