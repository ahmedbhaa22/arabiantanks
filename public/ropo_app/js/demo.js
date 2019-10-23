$(function($) {
  var fields = [
    {
      label: 'Linear Scale',
      attrs: {
        type: 'LinearScale'
      }
    },
    {
      label: 'Multiple Choice grid',
      attrs: {
        type: 'red'
      }
    },
	{
    label: 'Star Rating',
    attrs: {
      type: 'starRating'
    },
    icon: '🌟'
  }, 
  
	{
    label: 'Range',
    attrs: {
      type: 'range'
    },
    icon: ''
  }
  ];


  var templates = {
    LinearScale: function() {
      return {
        field:
        '<div id="LinearScale" class="custom-comp">' +
            '<input class=" form-control custom--input" placeholder="Question 1">'+
            '<input class=" form-control  custom--input-2" placeholder="Label 1">'+
            //'<input type="radio" name="progress" value="1" > '+ '<span class="radio-span">1</span>'+
            //'<input type="radio" name="progress" value="1" > '+ '<span class="radio-span">2</span>'+
            //'<input type="radio" name="progress" value="1" > '+ '<span class="radio-span">3</span>'+
            //'<input type="radio" name="progress" value="1" > '+ '<span class="radio-span">4</span>'+
            //'<input type="radio" name="progress" value="1" > '+ '<span class="radio-span">5</span>'+
          '<select class="form-control custom--input-2">'+
            '<option value="volvo">0</option>'+
            '<option value="saab">1</option>'+
          '</select>'+

          '<select class="form-control custom--input-2">'+

            '<option value="2">2</option>'+
            '<option value="3">3</option>'+
            '<option value="4">4</option>'+
            '<option value="5">5</option>'+
            '<option value="6">6</option>'+
            '<option value="7">7</option>'+
            '<option value="8">8</option>'+
            '<option value="9">9</option>'+
            '<option value="10">10</option>'+
          '</select>'+

            '<input class=" form-control  custom--input-2" placeholder="Label 5">'+

        '</div>'
      };
    },

    red: function() {
      return {
        field:
        '<div id="multiple-grid" class="custom-comp">' +
            '<div class="row"> ' +
              '<input class=" form-control  custom--input-2" placeholder="r1">' +
              '<input type="radio" name="progress" value="1" > '+ '<input class=" form-control  custom--input-2" placeholder="r2">' +
            '</div>' +

            '<div class="row">' +
              '<input class=" form-control  custom--input-2" placeholder="r1">' +
              '<input type="radio" name="progress" value="1" > '+ '<input class=" form-control  custom--input-2" placeholder="r2">' +
            '</div>' +
        '</div>'
      };
    }, 
	starRating: function(fieldData) {
      return {
        field: '<span id="' + fieldData.name + '">',
        onRender: function() {
          $(document.getElementById(fieldData.name)).rateYo({
            rating: 3.6
          });
        }
      };
    }, 
	range: function() {
     
      return {
        field:
        '<div id="range" class="custom-comp">' +		
			'<input type="number" step="1" min="0" max="10"> '+
        '</div>'
      };
    }
  };





  var inputSets = [{
        label: 'custom User Details',
        name: 'user-details', // optional
        showHeader: true, // optional

        fields: [
          {
            type: 'text',
            label: 'First Name',
            className: 'form-control'
          },

          {
            type: 'select',
            label: 'Profession',
            className: 'form-control',
            values: [{
              label: 'Street Sweeper',
              value: 'option-2',
              selected: false
            }, {
              label: 'Brain Surgeon',
              value: 'option-3',
              selected: false
            }]
          },
        {
          type: 'textarea',
          label: 'Short Bio:',
          className: 'form-control'
        }
        ]
      }, {
        label: 'User Agreement',
        fields: [{
          type: 'header',
          subtype: 'h3',
          label: 'Terms & Conditions',
          className: 'header'
        }, {
          type: 'paragraph',
          label: 'Leverage agile frameworks to provide a robust synopsis for high level overviews. Iterative approaches to corporate strategy foster collaborative thinking to further the overall value proposition. Organically grow the holistic world view of disruptive innovation via workplace diversity and empowerment.',
        }, {
          type: 'paragraph',
          label: 'Bring to the table win-win survival strategies to ensure proactive domination. At the end of the day, going forward, a new normal that has evolved from generation X is on the runway heading towards a streamlined cloud solution. User generated content in real-time will have multiple touchpoints for offshoring.',
        }, {
          type: 'checkbox',
          label: 'Do you agree to the terms and conditions?',
        }]
      }];

  var typeUserDisabledAttrs = {
    autocomplete: ['access']
  };

  var typeUserAttrs = {
    text: {
      className: {
        label: 'Class',
        options: {
          'red form-control': 'Red',
          'green form-control': 'Green',
          'blue form-control': 'Blue'
        },
        style: 'border: 1px solid red'
      }
    }
  };

  // test disabledAttrs
  var disabledAttrs = ['placeholder'];

  var fbOptions = {
    subtypes: {
      text: ['datetime-local']
    },
    onSave: function(e, formData) {
      toggleEdit();
      $('.render-wrap').formRender({
        formData: formData,
        templates: templates
      });
      window.sessionStorage.setItem('formData', JSON.stringify(formData));
    },
    stickyControls: {
      enable: true
    },
    sortableControls: true,
    fields: fields,
    templates: templates,
    inputSets: inputSets,
    typeUserDisabledAttrs: typeUserDisabledAttrs,
    typeUserAttrs: typeUserAttrs,
    disableInjectedStyle: false,
    disableFields: ['autocomplete']
    // controlPosition: 'left'
    // disabledAttrs
  };
  var formData = window.sessionStorage.getItem('formData');
  var editing = true;

  if (formData) {
    fbOptions.formData = JSON.parse(formData);
  }

  /**
   * Toggles the edit mode for the demo
   * @return {Boolean} editMode
   */
  function toggleEdit() {
    document.body.classList.toggle('form-rendered', editing);
    return editing = !editing;
  }

  var setFormData = '[{"type":"text","label":"Full Name","subtype":"text","className":"form-control","name":"text-1476748004559"},{"type":"select","label":"Occupation","className":"form-control","name":"select-1476748006618","values":[{"label":"Street Sweeper","value":"option-1","selected":true},{"label":"Moth Man","value":"option-2"},{"label":"Chemist","value":"option-3"}]},{"type":"textarea","label":"Short Bio","rows":"5","className":"form-control","name":"textarea-1476748007461"}]';

  var formBuilder = $('.build-wrap').formBuilder(fbOptions);
  var fbPromise = formBuilder.promise;

  fbPromise.then(function(fb) {
    var apiBtns = {
      showData: fb.actions.showData,
      clearFields: fb.actions.clearFields,
      getData: function() {
        console.log(fb.actions.getData());
      },
      setData: function() {
        fb.actions.setData(setFormData);
      },
      addField: function() {
        var field = {
            type: 'text',
            class: 'form-control',
            label: 'Text Field added at: ' + new Date().getTime()
          };
        fb.actions.addField(field);
      },
      removeField: function() {
        fb.actions.removeField();
      },
      testSubmit: function() {
        var formData = new FormData(document.forms[0]);
        console.log('Can submit: ', document.forms[0].checkValidity());
        // Display the key/value pairs
        console.log('FormData: ', );
        for(var pair of formData.entries()) {
           console.log(pair[0]+ ': '+ pair[1]);
        }
      },
      resetDemo: function() {
        window.sessionStorage.removeItem('formData');
        location.reload();
      }
    };

    // Object.keys(apiBtns).forEach(function(action) {
      // document.getElementById(action)
      // .addEventListener('click', function(e) {
        // apiBtns[action]();
      // });
    // });

    document.getElementById('setLanguage')
    .addEventListener('change', function(e) {
      fb.actions.setLang(e.target.value);
    });

    document.getElementById('getXML').addEventListener('click', function() {
      alert(formBuilder.actions.getData('xml'));
    });
    document.getElementById('getJSON').addEventListener('click', function() {
      alert(formBuilder.actions.getData('json', true));
    });
    document.getElementById('getJS').addEventListener('click', function() {
      alert('check console');
      console.log(formBuilder.actions.getData());
    });
  });

  document.getElementById('edit-form').onclick = function() {
    toggleEdit();
  };
});

