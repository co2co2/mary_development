document.addEventListener('DOMContentLoaded', function() {
 // var ageDisclaimer= document.createElement('dialog')
 // ageDisclaimer.innertext = 'Are you 19 years old?'
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
    });
  }
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
jQuery(function() {
  return $('#recipe_strain_name').autocomplete({
    source: $('#recipe_strain_name').data('autocomplete-source')
  });

});
