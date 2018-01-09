document.addEventListener('DOMContentLoaded', function() {

  var addConcentrate = document.querySelector('a#addConcentrate')

  addConcentrate.addEventListener('click', function(e) {
    e.preventDefault();
    this.style.display = 'none';

    removeBtn = document.querySelector('#showAddConcentrate')
    removeBtn.addEventListener('click', function() {
      addConcentrate.style.display = 'inline';
    })
  })



})
