<div class="portlet light bordered">

    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"> <?php echo $translate->_("Search Results For Content"); ?></span>
        </div>

        <div class="actions">

        </div>

    </div>



    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <form name="deleteContentForm" id="deleteContentForm" method="post" action="">

                    <table
                        class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                        id="sample_1" role="grid" aria-describedby="sample_1_info">
                        <thead>
                        <tr role="row">
                            <th class="sorting">
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample_1 .checkboxes">
                                    <span></span>
                                </label></th>
                            <th class="sorting"><?php echo $translate->_("Main Picture"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Title"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Desc"); ?></th>
                            <th class="sorting"><?php echo $translate->_("OrderBy"); ?></th>

                            <th class="sorting"><?php echo $translate->_("Visitors Count"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Date"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Time"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Active"); ?></th>

                            <th class="sorting"><?php echo $translate->_("Edit/Delete"); ?></th>

                        <tbody>
                        <?php foreach ($result_set as $result): ?>
                            <tr>
                            <td class="sorting">
                                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="group-checkable" id="select-all" data-set="#sample_1 .checkboxes" value="<?php echo $result['content_id'] ?>">
                                    <span></span>
                                </label></td>
                            <td class="sorting"><img src="{{url('/uploads/')}}<?php echo $result['content_Img'] ?>" style="width: 50px;height: 50px;"></td>
                            <td class="sorting"><?php echo $result['content_Title'] ?></td>
                            <td class="sorting"><?php echo $result['content_Des'] ?></td>
                            <td class="sorting"><?php echo $result['content_Order'] ?></td>

                            <td class="sorting"><?php echo $result['content_Visit'] ?></td>
                            <td class="sorting"><?php echo date('m/d/Y', $result['content_Date']) ?></td>
                            <td class="sorting"><?php echo date('H:i:s', $result['content_Date']) ?></td>
                            <td class="sorting"><?php echo $result['content_Active'] ?></td> 
                            <td class="sorting"><div class="btn-group" style="position:relative">
                                    <button class="btn btn-xs dark dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false"> إجراء
                                        <i class="fa fa-angle-down"></i></button><ul class="dropdown-menu" role="menu"><li>
                                            <a href="{{url()}}content/edit/<?php echo $result['content_id'] ?>" data-toggle="modal"><i class="icon-tag"></i> تعديل </a></li>
                                        <li><a href="{{url()}}content/delete/<?php echo $result['content_id'] ?>"><i class="icon-user"></i> حذف </a></li></ul></div></td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>

                    <div class="btn-group">
                        <button class="btn  dark dropdown-toggle" type="button" data-toggle="dropdown"
                                aria-expanded="false"> <?php echo $translate->_("Checked Fuctions"); ?>
                            <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-menu" role="menu">

                            <li>
                                <button type="submit" class="delete-general">
                                    <i class="icon-user"></i> <?php echo $translate->_("Delete Checked"); ?> </button>
                            </li>

                        </ul>
                    </div>


                </form>
            </div>

        </div>
    </div>
    <style>
        .contentImg {
            height: 100px;
            width: 100px;
        }
    </style>
</div>