document.addEventListener('DOMContentLoaded', function() {

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