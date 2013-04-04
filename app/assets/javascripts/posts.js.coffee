# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#seconds
$ ->
	  $("#post_book").change ->
	  	bookno = $("select#post_book :selected").text()
	  	callback = (response) -> 
	  			$("#post_canto").empty()
	  			$.each response.cantos, (val, te) ->
					  $("#post_canto").append new Option(te.no,te.no)

	  	$.get '/books/'+ bookno, callback, 'json'

$ ->
	  $("#post_canto").change ->
	  	cantono = $("select#post_canto :selected").text()
	  	callback = (response) -> 
	  			$("#post_section").empty()
	  			$.each response.sections, (val, te) ->
					  $("#post_section").append new Option(te.no,te.no)

	  	$.get '/cantos/'+ cantono, callback, 'json'

$ ->
	  $("#post_section").change ->
	  	sectionno = $("select#post_section :selected").text()
	  	callback = (response) -> 
	  			$("#poem-text").empty()
	  			$("#post_from").empty()
	  			$("#post_to").empty()
	  			$.each response.lines, (val, te) ->
	  				$("#poem-text").append("<p>" + te.line + "</p>")
	  				$("#post_from").append new Option(te.no,te.no)
	  				$("#post_to").append new Option(te.no,te.no)

	  	$.get '/sections/'+ sectionno, callback, 'json'

$ ->
	  $("#post_to").change ->
	  	linefrom = $("select#post_from :selected").text()
	  	lineto = $("select#post_to :selected").text()
	  	callback = (response) -> 
	  			$("#poem-text").empty()
	  			$("#poem-html").append("<blockquote>")
	  			$.each response, (val, te) ->
	  				$("#poem-text").append("\r\n >" + te.line + "\r\n")
	  				$("#poem-html").append("<p>" + te.line + "</p>")
	  			$("#poem-html").append("</blockquote>")

	  	$.get '/lines/range/'+ linefrom + '-' + lineto, callback, 'json'


$ ->
  	$("#insert_into_post").click (e) ->
		  e.preventDefault()
		  $("#wmd-input").append $("#poem-text").html()
		  $("#wmd-preview").append $("#poem-html").html()
		  $("#myModal").modal "hide"

$ ->
	$("#new-blog-post").click (e) ->
	  $("#post_content").html($('.wmd-preview').html())
	  potext = $("#poem-text").html()
	  $(".redactor_editor").append potext
	  $("#redactor_content").append potext
	  $("#myModal").modal "hide"

