<div class="page-bar " style="position: relative">
    <ul class="page-breadcrumb">
        <li>
            <i class="fa fa-home" aria-hidden="true"></i>
            <a href="{{url('cms_module/home/index/1')}}"><span> الرئيسية </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="{{url('cms_module/home/index/2')}}"><span> المنتجات </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <a href="{{url('offers_module/index')}}"><span> العروض </span></a>
            <i class="fa fa-angle-left" aria-hidden="true"></i>
        </li>
        <li>
            <span>عرض جديد</span>
        </li>
    </ul>
</div>
<div class="clearfix"></div>
<div class="col-lg-12">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
            <div class=""
                 style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{this.url_shared.get()}}img/alarabiatanks.png') center center no-repeat ; background-size: contain"></div>
        </div>
    </div>
</div>

{%if(create==1)%}
{{ partial("index/partials/new_add", ['regions':regions]) }}
{%else%}
{{ partial("index/partials/new_view", ['offer':offer,'offer_rel_type':offer_rel_type]) }}
{%endif%}
<!-- END EXAMPLE TABLE PORTLET-->
{%if(create==0)%}
<div id="offer_items">

</div>
<script>

    var url= "{{url('offers_module/index/offer_items/' ~offer.id)}}";
    $("#offer_items").load(url);


</script>

{%endif%}

{%if(create==0)%}
<div id="products_view">

</div>


<script>

    var url= "{{url('offers_module/index/products/' ~offer.id)}}";
    $("#products_view").load(url);


</script>

{%endif%}


<div class="clearfix"></div>