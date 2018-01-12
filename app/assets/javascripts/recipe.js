document.addEventListener('DOMContentLoaded', function() {
// Age verification dialog box
  document.cookie="newCookie=value";
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
           document.cookies = "ageConfirm=true";
           $("#dialog").dialog("close");
        },
        'No': function() {
            document.cookies = "ageConfirm=";
            window.location.href = "http://www.google.com",
            $("#dialog").dialog("close");
        }
      }
    })
    var dialogContent = document.querySelector('.ui-dialog-content')
    dialogContent.innerText = 'Are you over 19 years old?'
  }

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
        console.log('checked')
      } else {
        $('#recipe_recipe_category_id').val('')
        console.log('unchecked')
      }
    })
  });

})


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
