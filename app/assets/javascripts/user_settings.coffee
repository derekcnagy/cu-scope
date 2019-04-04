# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  validate_new_password_form = ->
    if ($('#change_password_new_password').val() isnt $('#change_password_password_confirmation').val())
      $('#new_passwords_not_match_error').show()
      return false

  $('#change_password_form').on 'submit', ->
    validate_new_password_form()