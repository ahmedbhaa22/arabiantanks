<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-dark">
            <i class="icon-user font-dark"></i>
            <span class="caption-subject bold uppercase"><?php echo $translate->_("Order Details"); ?></span>
        </div>

        <div class="actions">

        </div>

    </div>

    <div class="portlet-body">
        <div id="sample_1_wrapper">
            <div class="table-scrollable">
                <table
                    class="table table-striped table-bordered table-hover table-checkable order-column dataTable no-footer"
                    id="sample_1" role="grid" aria-describedby="sample_1_info">
                    <thead>
                        <tr role="row">
                            <th class="sorting"><?php echo $translate->_("Product"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Date"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Time"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Price"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Count"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Options"); ?></th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        foreach($purchase as $item):
                    ?>
                    <tr class="gradeX">
                        <td><?php echo $item->Content->Title ?></td>
                        <td><?php echo date('m/d/Y', $item->Date) ?></td>
                        <td><?php echo date('H:i:s', $item->Date) ?></td>
                        <td><?php echo $item->Cost ?></td>
                        <td><?php echo $item->Count ?></td>
                        <td>

                            <?php
                            $kv_items= \DataCmsOrdersKeyvalue::find(array("Purchase_ID={$item->ID}"));
                            if(count($kv_items)!==0):
                                ?>

                                        <table>
                                             <?php
                                            foreach ($kv_items as $kv_item):
                                                ?>
                                                <tr class="">
                                                    <td><?php echo $kv_item->DataKeyvalue->DataKeyvalueLang->Title; ?></td>
                                                    <td><?php echo Vokuro\Pentavalue\Keyvalue::getKeyvalue($kv_item->DataKeyvalue->CoreKeyvalueType->ID,$kv_item->DKV_ID,$kv_item->Value) ?></td>
                                                </tr>
                                            <?php endforeach;?>
                                            </tbody>
                                        </table>

                            <?php endif;?>

                        </td>
                    </tr>


                    <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


</div>