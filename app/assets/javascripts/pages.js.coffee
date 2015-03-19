# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(".new_page,.edit_page").submit ->
    text = $("#wmd-input").val()
    md_text = marked($('#wmd-input').val(), { renderer: renderer })
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

# Related Content
$ ->
  $('.collapse_related_content').click ->
    $closest = $(this).closest('.sidebar-heading').next('.collapse')
    if $closest.hasClass('in')
      $closest.removeClass('in')
      $closest.css('display', 'none')

    else
      $closest.addClass('in')
      $closest.css('display', 'block')

$ ->
  $('.collapse_related_content').click()

$ ->
  if $('.collapse_related_content').length
    $('.sidebar-menu').parent().prev().removeClass('span8 offset2').addClass('span9')