// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
document.addEventListener('DOMContentLoaded', function() {
  $(document).on('turbolinks:load', function() {

    $(".close").click(function () {
        //there are multiple elements which has .close icon so close the tab whose close icon is clicked
        $(this).parent().collapse('hide') //remove li of tab
    });

  })
})
