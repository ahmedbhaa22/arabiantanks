<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
<!--        <li>-->
<!--            <i class="fa fa-home" aria-hidden="true"></i>-->
<!--            <a href="index.html"><span> الرئيسية </span></a>-->
<!--            <i class="fa fa-angle-left"></i>-->
<!--        </li>-->
<!--        <li>-->
<!--            <a href="production.html"><span> المنتجات </span></a>-->
<!--            <i class="fa fa-angle-left"></i>-->
<!--        </li>-->
<!--        <li>-->
<!--            <a href="production_content.html"><span> محتوى </span></a>-->
<!--            <i class="fa fa-angle-left"></i>-->
<!--        </li>-->
        <li>
            <a href="{{url('discounts_module/index/index')}}"><span> الخصومات </span></a>
        </li>
    </ul>
</div>
<div class="clearfix"></div>

<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class=""
                 style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get()}}img/alarabiatanks.png') center center no-repeat ; background-size: contain"></div>        </div>
    </div>
</div>
<div class="row"><p><?php $this->flashSession->output() ?></p></div>
{%if(create==1)%}
{{ partial("index/partials/new_add") }}
{%else%}
{{ partial("index/partials/new_view",['discount':discount]) }}
{%endif%}

{%if(create==0)%}
<div id="products_view">

</div>


 <script>
     var discount_percentage = {{discount.percentage}};
    var url= "{{url('discounts_module/index/products/' ~discount.id)}}";
    $("#products_view").load(url);


</script>

{%endif%}


