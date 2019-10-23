<div class="">
    <div class="page-bar " style="position: relative">
        <ul class="page-breadcrumb">
            <li>
                <i class="fa fa-home" aria-hidden="true"></i>
                <a href="{{url('users_application_module')}}"><span> الرئيسية </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
             <li>
                <a href="{{url('content/main/8')}}"><span> المنتجات </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <a href="{{url('content/productsList')}}"><span> محتوى </span></a>
                <i class="fa fa-angle-left"></i>
            </li>
            <li>
                <span>آراء العملاء</span>
            </li>
        </ul>
    </div>
    <div class="clearfix"></div>

    <div class="col-lg-12">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-12 col-xs-12 hidden-xs">
                <div class="" style="width: 100%; min-height: 180px; overflow: hidden ; background: url('{{url.getStatic('images/products/banner-product.png')}}') center center no-repeat ; background-size: contain"></div>
            </div>
        </div>
    </div>
    <div class="portlet light clearfix">
        <div class="portlet-title">
            <div class="caption font-dark">
                <i class="fa fa-users font-dark"></i>
                <span class="caption-subject bold uppercase">  اراء العملاء</span>
            </div>

        </div>
        <div class="portlet-body">
            <div class="panel-group accordion" id="accordion1">
                <div class="panel panel-info">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-calls" href="#collapse-clients-filter">
								  <i class="fa fa-filter" aria-hidden="true"></i> فلتر <i class="fa fa-angle-down" aria-hidden="true"></i>
								</a>
                        </h4>
                    </div>
                    <div id="collapse-clients-filter" class="panel-collapse collapse">
                        <div class="panel-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label class=" control-label"> اسم المنتج</label>
                                            <select id="product_name" class="form-control">
                                                <option></option>
                                                {% for product in products %}
                                                    <option value="{{product.ID}}">{{product.Title}}</option>
                                                {% endfor%}
                                            </select>
                                        </div>
                                    </div>
									<div class="col-sm-3">
                                        <div class="form-group">
                                            <label class=" control-label">اسم العميل </label>
                                            <input id="client_name" type="text" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label class=" control-label">تاريخ من</label>
                                            <input id="date_from" type="date" class="form-control">
                                        </div>
                                    </div>
                                    <div class="col-sm-3">
                                        <div class="form-group">
                                            <label class=" control-label">تاريخ الى</label>
                                            <input id="date_to" type="date" class="form-control">
                                        </div>
                                    </div>

                                </div>
                                <button type="button" id="filter_reviews" class="btn btn-primary">فلتر</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="filtered_reviews_container">
                <table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_11">
                <thead>
                    <tr>
                        <th>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                <input type="checkbox" class="group-checkable"
                                       data-set="#sample_11 .checkboxes"/>
                                <span></span>
                            </label>
                        </th>
                        <th> ID</th>
                        <th>المنتج</th>
                        <th> العميل </th>
                        <th> تقييم  </th>
                        <th>نص التقييم</th>
                        <th> تااريخ التقييم</th>
                        <th>الاجراءات</th>
                        <th>الموافقة</th>

                    </tr>
                </thead>
                <tbody>
                    {% for review in page.items %}
                        <tr class="odd gradeX">
                        <td>
                            <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                                    <input type="checkbox" class="checkboxes" value="{{review.id}}"/>
                                    <span></span>
                                </label>
                        </td>
                        <td>{{review.id}}</td>
                        <td>
                            {% if review.product != null %}
                                <a href="{{url('content/productView/'~review.product.ID)}}">{{review.product.Title}}</a>
                            {% endif %}
                        </td>
                        <td>
                            {% if review.user != null %}
                                <a href="{{url('clients/view/'~review.user.ID)}}">{{review.user.Title}}</a>
                            {% endif %}
                        </td>
                        <td> <span class="stars" data-rating="{{review.rating}}" data-num-stars="5"></span> </td>
                        <td>{{review.review}}</td>
                        <td>{{review.formattedDate()}}</td>
                        <td>
                            <a
                                data-client_name="{{review.user.Title}}"
                                data-client_id="{{review.user.ID}}"
                                data-product_id="{{review.product.ID}}"
                                data-product_name="{{review.product.Title}}"
                                data-rating="{{review.rating}}"
                                data-review="{{review.review}}"
                                data-review_id="{{review.id}}"
                                data-review_status="{{review.status.id}}"
                             href="#opinion" class="view-review btn btn-xs btn-info" data-toggle="modal" data-target="#opinion"> <i class="fa fa-eye" aria-hidden="true"></i>  مشاهدة كاملة</a>

                            <button data-review_id="{{review.id}}" class="btn btn-xs btn-danger delete_review"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
                        </td>
                        <td>
                            {% if review.status != null %}
                                {% if review.status.id == 1 %}
                                <a href="#opinion" class="btn btn-xs btn-default" data-toggle="modal" data-target="#opinion">
                                    {% if lang == 1 %}
                                        {{review.status.name_ar}}
                                    {% else %}
                                        {{review.status.name}}
                                    {% endif %}
                                </a>
                                {% elseif review.status.id == 2 %}
                                <span class="label label-success">
                                    {% if lang == 1 %}
                                        {{review.status.name_ar}}
                                    {% else %}
                                        {{review.status.name}}
                                    {% endif %}
                                </span>
                                {% else %}
                                <span class="label label-default">
                                    {% if lang == 1 %}
                                        {{review.status.name_ar}}
                                    {% else %}
                                        {{review.status.name}}
                                    {% endif %}
                                </span>
                                {% endif %}
                            {% else %}
                             <a
                                data-client_name="{{review.user.Title}}"
                                data-client_id="{{review.user.ID}}"
                                data-product_id="{{review.product.ID}}"
                                data-product_name="{{review.product.Title}}"
                                data-rating="{{review.rating}}"
                                data-review="{{review.review}}"
                                data-review_id="{{review.id}}"
                                data-review_status="{{review.status}}"
                              href="#opinion" class="view-review btn btn-xs btn-default" data-toggle="modal" data-target="#opinion">  تقييم الرأي</a>
                            {% endif %}
                        </td>

                    </tr>
                    {% endfor %}
                </tbody>
            </table>
            <ul class="pagination" style="margin-right:40%;">
            <li><a href="{{url('product_reviews/index?page=1')}}">&laquo;&laquo;</a></li>
            <li><a href="{{url('product_reviews/index?page='~page.before)}}">&laquo;</a></li>
            <?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
            {% if i == page.current %}
            <li class="active"><span>{{i}}</span></li>
            {% else %}
            <li><a href="{{url('product_reviews/index?page='~i)}}">{{i}}</a></li>
            {% endif %}
            <?php } ?>
            <li><a href="{{url('product_reviews/index?page='~page.next)}}">&raquo;</a></li>
            <li><a href="{{url('product_reviews/index?page='~page.last)}}">&raquo;&raquo;</a></li>
            </ul>
            </div>
             
            <div class="col-xs-12">
<!--
                <button class="delete-btn btn btn-success btn-md">
                    <i class="fa fa-file-excel-o" aria-hidden="true"></i>إستخراج ملف اكسيل
                </button>
-->
                <button id="delete_selected" class="delete-btn btn btn-danger btn-sm">
                    <i class="fa fa-trash"></i>حذف المحدد
                </button>
            </div>
        </div>
    </div>
    <!-- END EXAMPLE TABLE PORTLET-->

<!-- BEGIN DASHBOARD STATS 1-->
</div>

<!-- reviews modal -->
<div id="opinion" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">الموافقة على التقييم</h4>
      </div>
        <form action="{{url('product_reviews/changeStatus/')}}" method="post" role="form" enctype="multipart/form-data">
            <input id="modal_review_id" type="hidden" name="review_id">
          <div class="modal-body">

            <h5>اسم العميل: <a target="_blank" id="modal_client_name" class="text-info"></a></h5>
            <h5>اسم المنتج: <a target="_blank" id="modal_product_name" class="text-info"></a></h5>
            <h5><span id="modal_rating" class="stars" data-rating="1" data-num-stars="5"></span></h5>
            <p id="modal_review"></p>
              <input name="review_status" id="modal_review_status" type="checkbox" class="make-switch" checked data-on-text="موافقة" data-off-text="رفض">
          </div>

          <div class="modal-footer">
            <button type="submit" class="btn btn-sm btn-success">حفظ</button>
            <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">اغلاق</button>
          </div>
          </form>
    </div>

  </div>
</div>
<!-- end reviews modal -->

<script>
    $.fn.stars = function () {
        return $(this).each(function () {
            var rating = $(this).data("rating");
            var numStars = $(this).data("numStars");
            var fullStar = new Array(Math.floor(rating + 1)).join('<i class="fa fa-star"></i>');
            var halfStar = ((rating % 1) !== 0) ? '<i class="fa fa-star-half-empty"></i>' : '';
            var noStar = new Array(Math.floor(numStars + 1 - rating)).join('<i class="fa fa-star-o"></i>');
            $(this).html(fullStar + halfStar + noStar);
        });
    }
    $('.stars').stars();


    // handle modals
    $('.view-review').on('click', function()
    {
       $('#modal_client_name').text($(this).data('client_name'));
       $('#modal_client_name').attr('href', "{{url('clients/view/')}}"+$(this).data('client_id'));
       
       $('#modal_product_name').text($(this).data('product_name'));
       $('#modal_product_name').attr('href', "{{url('content/productView/')}}"+$(this).data('product_id'));

       $('#modal_rating').data('rating', $(this).data('rating'));
       $('#modal_review').text($(this).data('review'));
       $('#modal_review_id').val($(this).data('review_id'));
       
       switch($(this).data('review_status'))
       {
        case 2:
        $('#modal_review_status').attr('checked', true);
        break;
        case 3:
        $('#modal_review_status').attr('checked', false);
        break;
       }

    });

    $('.delete_review').on('click', function()
    {
       if(confirm('أنت على وشك حذف رأي للعميل، إستكمال العملية؟'))
       {
        $.ajax({
            type: 'post',
            url: "{{url('product_reviews/delete/')}}"+$(this).data('review_id'),
            success: function(response)
            {
                response = JSON.parse(response);

                switch(response.status)
                {
                    case 0:
                    alert(response.msg);
                    break;
                    case 1:
                    window.location.href = "{{url('product_reviews/index')}}";
                    break;
                }
            }
        });
       } 
    });

    $('#delete_selected').click(function()
            {
               var selected_ids = $('.checkboxes:checked').map(function()
               {
                return $(this).val();
               }).get(); 

               if(selected_ids.length > 0)
               {
                if(confirm('أنت على وشك القيام بحذف مجموعة منتجات، إستكمال العملية؟'))
                {
                    $.ajax({
                    type: 'post',
                    url: "{{url('product_reviews/deleteSelected')}}",
                    data: {selected_ids: selected_ids},
                    success: function(response)
                    {
                        response = JSON.parse(response);

                        switch(response.status)
                        {
                            case 0:
                            alert(response.msg);
                            break;
                            case 1:
                            window.location.href = "{{url('product_reviews/index/')}}";
                            break;
                        }
                    }
                });
                }
               }
            });

    $('#filter_reviews').on('click', function(){
        var product_name = $('#product_name').val();
        var client_name  = $('#client_name').val();
        var date_from    = $('#date_from').val();
        var date_to      = $('#date_to').val();

        $.ajax({
            type: 'post',
            url: "{{url('product_reviews/filterReviews')}}",
            data: {
                product_name: product_name,
                client_name: client_name,
                date_from: date_from,
                date_to: date_to
            },
            success: function(response)
            {
                response = JSON.parse(response);
                $('#filtered_reviews_container').html('');
                $('#filtered_reviews_container').html(response.content);
            }
        });
    });
</script>