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
<li><a data-page="{{page.first}}" id="first">&laquo;&laquo;</a></li>
<li><a data-page="{{page.before}}" id="before">&laquo;</a></li>
<?php for($i = 1; $i <= $page->total_pages; $i++){ ?>
{% if i == page.current %}
<li class="active"><span>{{i}}</span></li>
{% else %}
<li><a class="reviews_filter_page" data-page={{i}}>{{i}}</a></li>
{% endif %}
<?php } ?>
<li><a data-page="{{page.next}}" id="next">&raquo;</a></li>
<li><a data-page="{{page.last}}" id="last">&raquo;&raquo;</a></li>
</ul>

<script type="text/javascript">
$('.reviews_filter_page, #first, #before, #next, #last').on('click', function()
{
    var product_name = $('#product_name').val();
    var client_name   = $('#client_name').val();
    var date_from    = $('#date_from').val();
    var date_to      = $('#date_to').val();

   $.ajax({
    type: 'post',
    url: "{{url('product_reviews/filterReviews')}}",
    data:{
        product_name: product_name,
        client_name: client_name,
        date_from: date_from,
        date_to: date_to,
        page: $(this).data('page')
    },
    success: function(response)
    {
        response = JSON.parse(response);
        $('#filtered_reviews_container').html('');
        $('#filtered_reviews_container').html(response.content);
    }
   }); 
});

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
</script>