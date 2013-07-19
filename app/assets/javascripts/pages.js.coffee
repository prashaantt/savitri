# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$("#new-page").click (e) ->
	  $("#page_content").html($('.wmd-preview').html())
	  $("#wmd-input").html($('.wmd-input').val())

$ ->
  $("#page_category").change ->
  	if $("#page_category").val() == "Non-Menu"
      $("#page-priority").hide()
      $("#parent").show()
    else
       $("#page-priority").show()
       $("#parent").hide()