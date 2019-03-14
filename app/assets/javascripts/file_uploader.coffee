# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#team").on "change", ->
#    $('#test_three').toggle("slow")
    $('#test_three').text this.value
#    $('#test_three').text "Bad WOlf"
    $('#profile').empty();

  $("#test_two").on "click", ->
    $(this).siblings('#test_three').toggle("slow")
