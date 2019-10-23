<ul>
  <li>
    {% for root_name,root_data in tree %}
      <div class="main-cat">
          {{root_name}}
      </div>

      {% for child in root_data['children'] %}
        <ul class="child">

          <li><input class="dept_id" type="checkbox" name="depts[]" value="{{child['id']}}">  {{child['name']}}
            <ul class="child"></ul>
          </li>
        </ul>
      {% endfor %}
    {% endfor %}
  </li>
</ul>