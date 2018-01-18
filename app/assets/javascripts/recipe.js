document.addEventListener('DOMContentLoaded', function() {
  $('.carousel').carousel()
$(document).on('turbolinks:load', function() {
  //toggle menus
  $(document).ready(function() {
    $('#categoriesBtn').click( function(e) {
      $('#categories').collapse('show');
      $('#effects').collapse('hide');
      $('#mainNavBar').collapse('hide');
    })
    $('#effectsBtn').click( function(e) {
      $('#effects').collapse('show');
      $('#categories').collapse('hide');
      $('#mainNavBar').collapse('hide');
    })
    // $('button.navbar-toggler').click( function() {
    //   $('#effects').collapse('hide');
    //   $('#categories').collapse('hide');
    // })
    $('#mainNavBar').on('shown.bs.collapse', function () {
      $('#effects').collapse('hide');
      $('#categories').collapse('hide');
    })
  })

  //autocomplete for strains
  $('#recipe_strain_name').focusout(function(){
    var strainText = $('#recipe_strain_name').val();
    $.ajax({
      url: $('#recipe_strain_name').data('autocomplete-source'),
      method: 'GET',
      dataType: 'json'
    }).done(function(responseData) {
        for (var key in responseData)
        {
          if ( responseData[key].toLowerCase() === strainText.toLowerCase()) {
            $('#strainId').val(key);
          }
        }
      }).fail(function() {
        console.log(`fail to get strains info`)
      })

    });

    $('#recipe_strain_name').autocomplete({
      source: $('#recipe_strain_name').data('autocomplete-source')
    });


// Category - concentrate checkbox
  $(function(){
    $('#recipe_recipe_category_id').change(function() {
      if ($('#recipe_recipe_category_id option:selected').text() === 'Concentrates') {
        $('#recipe_concentrate').prop('checked', true);
      } else {
        $('#recipe_concentrate').prop('checked', false);
      }
    })

    $('#recipe_concentrate').change(() => {
      if ($('#recipe_concentrate').is(':checked')) {
        $('#recipe_recipe_category_id').val('1')
      } else {
        $('#recipe_recipe_category_id').val('')
      }
    })
  });

  // Filter

  $('.addIngredient').click(function(e){
    e.preventDefault()
    var newIngredient = `
    <div class="ingredient">
    <a href="/"class="removeIngredient"><img src="https://image.flaticon.com/icons/png/512/54/54351.png
"></a>
    <input type="text" name="ingredient[]" id="ingredient_">
    </div>`
    $(this).closest(".ingredient").before(newIngredient)
    // $(this).removeClass('addIngredient');
  })
  $(document).on('keyup', '#ingredient_',function(){
    if ($(this).value != "") {
      this.parentElement.children[0].children[0].src="https://image.flaticon.com/icons/png/512/54/54351.png";
    }
  })
  $(document).on('click','.removeIngredient',function(e){
      e.preventDefault()
    this.parentElement.remove();
  })

});

  // Age verification dialog box
  var now = new Date().getTime();
  var askAt = window.localStorage.getItem('ageVerification');
  if( !askAt || now > parseInt(askAt) ){
    $("#dialog").dialog ({
      draggable: false,
      modal: true,
      dialogClass: "no-close",
      buttons: {
        'Yes': function() {

          var now = new Date().getTime();
          var askAt = now + (24*60*60*1000); // current time + 24 hrs
          window.localStorage.setItem('ageVerification', askAt);
          $("#dialog").dialog("close");
        },
        'No': function() {
          window.location.replace("http://www.google.com"),
          $("#dialog").dialog("close");
        }
      }
    })
    var dialogContent = document.querySelector('.ui-dialog-content')
    dialogContent.innerText = 'Are you over 19 years old?'
  }

  // no scroll when modal overlay is on
  var body = document.body,
    overlay = document.querySelector('.ui-widget-overlay'),
    enterbtn = document.querySelector('button.ui-button:first-child');
    if (overlay) {
      body.classList.add('noscroll');
    }
    if (enterbtn) {
      enterbtn.addEventListener('click', function() {
        body.classList.remove('noscroll');
        overlay.scrollTop = 0;
      }, false);
    } else {
      body.classList.remove('noscroll');
    }

})

// Form - add a concentrate button toggle
function hideConcentrateLink() {
  var addConcentrate = document.querySelector('a#addConcentrate')

  addConcentrate.addEventListener('click', function(e) {
    e.preventDefault();
  })
  addConcentrate.style.display = 'none';
}

function addConcentrateLink() {
  addConcentrate.style.display = 'inline';
}
