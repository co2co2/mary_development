document.addEventListener('DOMContentLoaded', function() {
  document.cookie="newCookie=value";
  $("#dialog").dialog ({
  dialogClass: "no-close",
  buttons: {
      'Yes, I am 19 years old!': function() {
         document.cookies = "ageConfirm=true";
         $("#dialog").dialog("close");
      },
      'No, I am not 19 years old.': function() {
          document.cookies = "ageConfirm=";
          window.location.href = "http://www.google.com",
          $("#dialog").dialog("close");
      }
    }
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
jQuery(function() {
  return $('#recipe_strain_name').autocomplete({
    source: $('#recipe_strain_name').data('autocomplete-source')
  });

});
