# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".test_status").on "click", ->
    $(this).siblings('.test_details').toggle("slow")

  $(".feature_name").on "click", ->
    $(this).siblings('.feature_details').toggle("slow")

  $(".scenario_name").on "click", ->
    $(this).siblings('.scenario_details').toggle("slow")

  $("#team_selector").on "change", ->
    $('.profile_selector').hide()
    $("#team_#{this.value}_profiles").show()
