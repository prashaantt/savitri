# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#seconds
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

$ ->
	$("#view-poemtext").click (event) ->
	  event.preventDefault()
	  linefrom = $("#post_from").val()
	  lineto = $("#post_to").val()
	  if linefrom == ""
	  	alert "From is mandatory"
	  	return ""
	  if lineto == ""
	  	lineto = linefrom
	  if linefrom.split(/\./).length > 2 or lineto.split(/\./).length > 2 or not linefrom.match(/^\d+(\.\d+)*$/) or not lineto.match(/^\d+(\.\d+)*$/)
		  alert "Invalid from or to values"
		  return ""
	  callback = (response) -> 
	  			$("#poem-text").empty()
	  			$("#poem-html").empty()
	  			links = new Array()
	  			nums = new Array()
	  			$.each response, (val1) -> 
	  				lastsentence = response[val1][response[val1].length - 1].no
	  				poem_html = "<p>"
		  			$.each response[val1], (val, te) ->
		  				linknum = te.stanza_id + 100
		  				if(lastsentence==te.no)
		  					$("#poem-text").append("\r\n")
			  				$("#poem-text").append(">" + te.line + "  ")
			  				poem_html += "<br/>" + te.line + " ||"+te.section+"."+te.runningno+"||"
			  				$("#poem-text").append("[||"+te.section+"."+te.runningno+"||]["+linknum+"]\r\n")
		  					nums.push linknum
		  					links.push te.share_url
			  			else
			  				$("#poem-text").append("\r\n")
			  				$("#poem-text").append(">" + te.line + "  ")
			  				poem_html += "<br/>" + te.line
			  		poem_html += "</p>"
	  				$("#poem-html").append(poem_html)

  				total=nums.length
	  			i=0
	  			while i < total
	  				$("#poem-text").append("["+nums[i]+"]: "+links[i]+"\r\n")
	  				i++


	  $.get '/stanzas/range/'+ linefrom.replace(".","-") + '-' + lineto.replace(".","-"), callback, 'json'
