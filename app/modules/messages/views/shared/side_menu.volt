<div class="inbox-sidebar ">
    <a href="{{url('index/compose')}}" data-title="Compose" class="btn green compose-btn btn-block" style="width: 100%;">
        <i class="fa fa-edit"></i> <?php echo $translate->_("Compose"); ?> </a>
    <ul class="inbox-nav   bordered clearfix">
        <li class="active">
            <a href="{{url('index')}}" class="uppercase" data-type="inbox" data-title="Inbox">
            <h5> 
                 <i class="fa fa-inbox"></i>
                <?php echo $translate->_("Inbox"); ?>
                <span class="badge badge-success">{{msgService.getUnreadCount()}}</span>
            </h5>
            </a>
            <hr/>
        </li>
        <!-- <li>
            <a href="javascript:;" class="uppercase" data-type="important" data-title="Inbox"> Important </a>
        </li> -->
        <li>
            <a href="{{url('index/sent')}}" class="uppercase" data-type="sent" data-title="Sent">
            <h5>
                 <i class="fa fa-paper-plane"></i>
                <?php echo $translate->_("Sent"); ?> 
                <!-- <span class="badge badge-success">5</span> -->
            </h5>           
            </a>
            <hr/>
        </li>
        <li>
            <a href="{{url('index/drafts')}}" class="uppercase" data-type="draft" data-title="Draft"> 
                <h5>
                 <i class="fa fa-pencil"></i>
                 <?php echo $translate->_("Draft"); ?>
                <span class="badge badge-success">{{msgService.getDraftsCount()}}</span>
                </h5>
            </a>
            <hr/>
        </li>
        <li>
            <a href="{{url('index/trashed')}}" class="uppercase" data-title="Trash"> 
            <h5>
            <i class="fa fa-trash"></i>
            <?php echo $translate->_("Trash"); ?>
                <span class="badge badge-success">{{msgService.getTrashedCount()}}</span>
            </h5>
            </a>
        </li>
    </ul>
</div>

<!-- class="sbold" for active -->