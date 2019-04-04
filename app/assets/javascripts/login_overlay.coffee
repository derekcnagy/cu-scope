# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#login_button').on 'click', ->
    $('#login_overlay').show()

  $('#create_account_button').on 'click', ->
    $('#user_login').hide()
    $('#create_account').show()

  $('#cancel_create_account_button').on 'click', ->
    $('#user_login').show()
    $('#create_account').hide()

  $('#cancel_login').on 'click', ->
    $('#login_overlay').hide()

  validate_new_user_form = ->
    if ($('#create_user_password').val() isnt $('#password_confirmation').val())
      $('#passwords_not_match_error').show()
      return false

  $('#create_account_form').on 'submit', ->
    validate_new_user_form()