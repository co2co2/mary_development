$(document).on('turbolinks:load', function() {

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

  })

  $('#recipe_strain_name').autocomplete({
  source: $('#recipe_strain_name').data('autocomplete-source')
});

});

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
