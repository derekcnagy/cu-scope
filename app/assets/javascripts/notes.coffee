# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  $("#note_for_scenarios_title").on "click", ->
    $('#note_for_scenarios_table').toggle("slow")

  $("#note_for_error_messages_title").on "click", ->
    $('#note_for_error_messages_table').toggle("slow")

  $("#note_for_individual_test_title").on "click", ->
    $('#note_for_individual_test_table').toggle("slow")