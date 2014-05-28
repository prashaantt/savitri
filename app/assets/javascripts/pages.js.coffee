# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".new_page,.edit_page").submit ->
    text = $("#wmd-input").val()
    md_text = $("#page_content").text()
    name = $("#page_name").val()
    text = text.replace(/\!\[enter image description here\]/, "![" + name + "]")
    md_text = md_text.replace(/alt="enter image description here"/, "alt=\"" + name + "\"")
    $("#wmd-input").val text
    $("#page_content").val md_text

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