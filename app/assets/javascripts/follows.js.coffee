# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ($) ->
  $("#follow_user").bind "ajax:error", (event, data, status, xhr) ->
     window.location.replace('/users/sign_in')