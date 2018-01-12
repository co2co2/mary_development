document.addEventListener('DOMContentLoaded', function() {

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
    console.log(dialogContent);
    dialogContent.innerText = 'Are you over 19 years old?'
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
