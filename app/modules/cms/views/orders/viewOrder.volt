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
                    id="sample_view_order" role="grid" aria-describedby="sample_1_info">
                    <thead>
                        <tr role="row">
                            <th class="sorting"><?php echo $translate->_("Item ID"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Product"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Date"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Total Price"); ?> {%if order.Status==8%}<i class="fa fa-pencil"></i>{%endif%}</th>
                            <th class="sorting"><?php echo $translate->_("Original Price"); ?></th>
                            <th class="sorting"><?php echo $translate->_("Count"); ?></th>
<!--                            <th class="sorting">--><?php //echo $translate->_("Options"); ?><!--</th>-->
<!--                            <th class="sorting">--><?php //echo $translate->_("Action"); ?><!--</th>-->
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                        foreach($purchase as $item):
                            $item_check = \Models\Content::findFirst(["ID={$item->item_id}"]);
                            if(!$item_check){
                                $item->delete();
                                continue;
                            }
                    ?>
                    <tr class="gradeX">
                        <input type="hidden" name="order_details_ids[]" value="{{item.ID}}" />
                        <td><?php echo $item->ID ?></td>
                        <td><?php echo $item->Content->Title ?></td>
                        <td><?php echo date('m/d/Y h:i:s', $item->Date) ?></td>
                        <td {%if order.Status==8%}contenteditable="true"{%endif%} id="cost_{{item.ID}}"><?php echo $item->Cost ?></td>
                        <td>
                            <?php
                            if(count($item->Content->getDataKeyvalueUserdata(["DKV_ID={$price_kv_id}"]))>0){
                                echo $item->Content->getDataKeyvalueUserdata(["DKV_ID={$price_kv_id}"])[0]->Value;
                            }

                            ?>
                        </td>
                        <td><?php echo $item->Count ?></td>
<!--                        <td>-->
<!---->
<!--                            --><?php
//                            $kv_items= \DataCmsOrdersKeyvalue::find(array("Purchase_ID={$item->ID}"));
//                            if(count($kv_items)!==0):
//                                ?>
<!---->
<!--                                        <table>-->
<!--                                            <tbody>-->
<!--                                             --><?php
//                                            foreach ($kv_items as $kv_item):
//                                                ?>
<!--                                                <tr class="">-->
<!--                                                    <td>--><?php //echo $kv_item->DataKeyvalue->DataKeyvalueLang->Title; ?><!--</td>-->
<!--                                                    <td>--><?php //echo Vokuro\Pentavalue\Keyvalue::getKeyvalue($kv_item->DataKeyvalue->CoreKeyvalueType->ID,$kv_item->DKV_ID,$kv_item->Value) ?><!--</td>-->
<!--                                                </tr>-->
<!--                                            --><?php //endforeach;?>
<!--                                            </tbody>-->
<!--                                        </table>-->
<!---->
<!--                            --><?php //endif;?>
<!---->
<!--                        </td>-->
<!--                        <td>-->
<!---->
<!--                            <a href="{{url('orders/editPurchase/')}}--><?php //echo $item->ID ?><!--" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>-->
<!---->
<!--                        </td>-->
                    </tr>


                    <?php endforeach; ?>
                    </tbody>

                </table>
            </div>

            <div class="bordered bold gap">{{translate._("Order Status")}} :
                {%if(lang_id==2)%}
                    {{order.OrderStatus.display_name}}
                {%else%}
                    {{order.OrderStatus.display_name_ar}}
                {%endif%}
            </div>
            <div class="gap">
                {%if order.Status==8%} <input type="button" value="{{translate._("Save")}}" id="update" class="btn btn-danger" />{%endif%}
                {%if order.Status==10%} <a class="btn btn-danger" href="{{url('orders/confirm/') ~order.ID}}?not_id={{notifi_id}}">{{translate._("Confirm Purchase Order")}}</a>{%endif%}
            </div>

            <div class="row"><div class="ajax-message alert alert-success" style="display: none;"></div></div>
        </div>
    </div>


</div>

<script>

    $( "#update" ).click(function() {
        var purchase = {};
        $('input[name^="order_details_ids"]').each(function() {
            var purchase_id = $(this).val();
            var Cost = $('#cost_'+purchase_id).text();
            purchase[purchase_id]= Cost;

        });

        $.ajax({
            type: "POST",
            data: {purchase:purchase},
            url: main_url+'cms_module/orders/updatePurchaseAjax/<?php echo $this->request->getQuery("notifi")?>',
            success: function(msg){
                if(msg==1){
                    $(".ajax-message").show();
                    $(".ajax-message").html("Success");
                    $('#update').hide();
                }else{
                    alert("You Must update all prices");
                }
            }
        });
    });

</script>