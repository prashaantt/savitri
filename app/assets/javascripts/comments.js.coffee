# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("#comment_body").bind "input propertychange", ->
    if $(this).val()
      $("#btn-comment").removeAttr "disabled"
    else
      $("#btn-comment").attr "disabled", "disabled"
