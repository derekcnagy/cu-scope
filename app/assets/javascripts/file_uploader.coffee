# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  $('#wait_overlay').hide()

  $(".team_selector").on "change", ->
    $(this).parents('tr').find('td div.profile_selector').hide()
    $(this).parents('tr').find("td div#team_#{this.value}_profiles").show()

  $('.process_file_button').on 'click', ->
    $('#wait_overlay').show()

