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


  // reviews ajax call
  $('#new_review').on('submit', function(e) {
    // prevent browser from submiting review
    e.preventDefault();

    // make the ajax callbacks
    $.ajax({
      url: $(this).attr('action'),
      method: $(this).attr('method'),
      data: $(this).serialize(),
      dataType: 'html'
    }).done(function(responseData) {
      $('#user-reviews').prepend(responseData);

      // Clear out text field
      $('#review_comment').val('');

    }).fail(function(jqXHR, textStatus, errorThrown) {
      alert('Review is too short!');
    })

  })



  //favourite ajax call

  $('#fav').on('click',function(e){
    e.preventDefault();
    e.stopPropagation();
    if ($(this).hasClass('favourite')){
      $.ajax({
        url: $(this).attr('href'),
        method: "PUT",
        data: "type=favourite"
      }).done(function(){
        $('#fav').addClass('unfavourite')
        $('#fav').removeClass('favourite')
        $('#fav-image').addClass('unfavourite')
        $('#fav-image').removeClass('favourite')
        var num = parseInt($('#favouritesValue').text()) + 1;
        $('#favouritesValue').text(num);
      });
    }else{
      $.ajax({
        url: $(this).attr('href'),
        method: "PUT",
        data: "type=unfavourite"
      }).done(function(){
        $('#fav').addClass('favourite')
        $('#fav').removeClass('unfavourite')
        $('#fav-image').addClass('favourite')
        $('#fav-image').removeClass('unfavourite')
        var num = parseInt($('#favouritesValue').text()) - 1;
        $('#favouritesValue').text(num);
      });
    }
  });
  //star rating on load
  var ratingLength = document.querySelectorAll('.rating > span').length;

  // grabs custom data attribute from the show page
  var recipeRating = $('.rating').attr('data-rating');
  // Rounds downwards using | 0
  var roundedDownRating = recipeRating | 0;
  if (Math.ceil(recipeRating)) {
    var roundedUpRating = Math.ceil(recipeRating);
  }else{
    var roundedUpRating = 0;
  }
  var stars = document.querySelectorAll('.rating > span')

    var displayRating = stars[ratingLength - roundedUpRating]
    if (displayRating){
      displayRating.classList.add('rated')
      if(recipeRating - roundedDownRating != 0){
        displayRating.innerHTML = displayRating.innerHTML + `<style>.rated:before{width:${(recipeRating - roundedDownRating)*100}%;}</style>`;
      }
    }



  // Star rating
  $('.rating > span').click(function(e){
    $('.rating > span').removeClass();
    $('style').remove();
    path = window.location.pathname
    recipeId = path.substr(path.lastIndexOf('/')+1)
    $.ajax({
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      url: `/recipes/${recipeId}/rate`,
      method: 'PUT',
      data: `rating=${ratingLength - $(this).index()}`,
      custom: $(this)
    }).done(function(){
      this.custom.addClass("rated")
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

  // Ingredients Filter fields

  $('.addIngredient').click(function(e){
    e.preventDefault()
    var newIngredient = `
    <div class="ingredient">
    <a href="/"class="removeIngredient"><img src="https://image.flaticon.com/icons/png/512/54/54351.png"></a>
    <input type="text" name="ingredient[]" class="ingredient_">
    </div>`
    $(this).closest(".ingredient").before(newIngredient)
    // $(this).removeClass('addIngredient');
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
    dialogContent.innerText = 'Are you over 18 years old?'
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

//Geocoder and google map api
var geocoder;

function initialize() {
  geocoder = new google.maps.Geocoder();
}

    function codeLatLng(lat, lng) {
        var latlng = new google.maps.LatLng(lat, lng);
        geocoder.geocode({
          'latLng': latlng
        }, function (results, status) {
          if (status === google.maps.GeocoderStatus.OK) {
            if (results[1]) {
              console.log(results[1]);
            } else {
              alert('No results found');
            }
          } else {
            alert('Geocoder failed due to: ' + status);
          }
        });
      }


    window.onload = function(){
     navigator.geolocation.getCurrentPosition(function(position){

    var currentLocation = `lat=${position.coords.latitude}&long=${position.coords.longitude}`;
    localStorage.setItem("currentLocation",currentLocation)
    });


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

function deleteReview() {

  //delete review ajax call
  $('.delete').parent().on('submit', function(e) {
      e.preventDefault();
      $.ajax({
        url: $(this).attr('action'),
        method: 'DELETE',
        data: $(this).serialize(),
      }).done(function(){
        $(e.target).closest('div').slideUp();
      }).fail(function() {
        console.log('failed to delete review.')
      })
  });
}
