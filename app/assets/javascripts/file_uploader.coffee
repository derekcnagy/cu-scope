# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".team_selector").on "change", ->
#    $(this).parents('tr').find('input').hide()
    $(this).parents('tr').find('td div.profile_selector').hide()
#    $('#test_two').text "team_#{this.value}_profiles"
    $(this).parents('tr').find("td div#team_#{this.value}_profiles").show()
