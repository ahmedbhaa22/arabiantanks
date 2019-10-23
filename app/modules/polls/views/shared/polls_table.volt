<table class="table table-striped table-bordered table-hover table-checkable order-column" id="sample_1">
    <thead>
        <tr>
            <th style="width: 2%;">
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="group-checkable"
                           data-set="#sample_1 .checkboxes"/>
                    <span></span>
                </label>
            </th>
            <th>اسم الإستفتاء</th>
            <th style="width: 5%;"> عدد الإجابات</th>
            <th style="width: 15%;"> إجراءات</th>
        </tr>
    </thead>
    <tbody>

        {% for poll in polls %}
        <tr>
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="checkboxes" value="1"/>
                    <span></span>
                </label>
            </td>
            <td> <a class="bold" href="{{url('polls/view/') ~ poll.id}}"> {{poll.name}} </a></td>
            <td> {{poll.getAnswersCount()}} </td>
            <td> 

                <a href="{{url('polls/view/') ~ poll.id}}" class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </a>

                <a href="{{url('polls/edit/') ~ poll.id}}" class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </a>

                <button onclick="deletePoll({{poll.id}}, this)" class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
            </td>
        </tr>
        {% endfor %}

        <tr>
            <td>
                <label class="mt-checkbox mt-checkbox-single mt-checkbox-outline">
                    <input type="checkbox" class="checkboxes" value="1"/>
                    <span></span>
                </label>
            </td>
            <td> <a class="bold" href="view-poll.html"> Test2 </a></td>
            <td> 13 </td>
            <td> 

                <button class="btn btn-xs btn-info"> <i class="fa fa-eye" aria-hidden="true"></i> </button>

                <button class="btn btn-xs btn-success"> <i class="fa fa-pencil" aria-hidden="true"></i> </button>

                <button class="btn btn-xs btn-danger"> <i class="fa fa-trash-o" aria-hidden="true"></i> </button>
            </td>
        </tr>

    </tbody>
</table>