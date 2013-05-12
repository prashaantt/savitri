# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#seconds
count=0
i=0
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
	  			$("#poem-html").empty()
	  			links = new Array()
	  			lastsentence = response[0].stanza_id
	  			$.each response, (val, te) ->
	  				if(lastsentence==te.stanza_id)
		  				$("#poem-text").append(">" + te.line + "  ")
		  				$("#poem-html").append("<p>" + te.line + "</p>")
		  			else
		  				$("#poem-text").append("\r\n")
		  				$("#poem-text").append(">" + te.line + "  ")
		  				$("#poem-html").append("<br></br><p>" + te.line + "</p>")
		  				lastsentence=te.stanza_id
	  				if(response[val+1] && lastsentence==response[val+1].stanza_id)
	  					$("#poem-text").append("\r\n")
	  				else
	  					$("#poem-text").append("[||"+te.section+"."+te.runningno+"||]["+count+"]\r\n")
	  					count++
	  					links.push te.share_url
	  			
	  			if(i!=0)
	  				total=links.length + count-1
	  			else
	  				total=links.length
	  			$("#poem-text").append("\r\n\r\n\r\n\r\n\r\n")
	  			j=0
	  			while i < total
	  				$("#poem-text").append("["+i+"]: "+links[j]+"\r\n")
	  				i++
	  				j++

	  	$.get '/lines/range/'+ linefrom + '-' + lineto, callback, 'json'



$ ->
	$("#new-blog-post").click (e) ->
	  $("#post_content").html($('.wmd-preview').html())
	  $("#wmd-input").html($('.wmd-input').val())

	$("#previewbtn").on "click", ->
	  if $("#wmd-input").is(":visible")
	    $("#wmd-input").hide()
	    $("#wmd-preview").show()
	    $(".btn-toolbar button").each ->
	      unless $(this).attr("disabled")
	        $(this).addClass "disabled"
	        $(this).attr "disabled", "disabled"

	    $(this).removeClass("btn-info").addClass "btn-warning"
	    $(this).text "Edit"
	  else
	    $("#wmd-preview").hide()
	    $("#wmd-input").show()
	    $(".btn-toolbar button").each ->
	      if $(this).hasClass("disabled")
	        $(this).removeAttr "disabled"
	        $(this).removeClass "disabled"

	    $(this).text "Preview"
	    $(this).removeClass("btn-warning").addClass "btn-info"
