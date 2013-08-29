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
	  rooturl = window.location.origin
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
		  					links.push rooturl+te.share_url
			  			else
			  				$("#poem-text").append("\r\n")
			  				$("#poem-text").append(">" + te.line + "  ")
			  				poem_html += "<br/>" + te.line
			  		poem_html += "</p>"
	  				$("#poem-html").append(poem_html)

  				total=nums.length
	  			i=0
	  			$("#poem-text").append("\r\n")
	  			while i < total
	  				$("#poem-text").append("["+nums[i]+"]: "+links[i]+"\r\n")
	  				i++


	  $.get '/stanzas/range/'+ linefrom.replace(".","-") + '-' + lineto.replace(".","-"), callback, 'json'


$ ->
	$("#size_later").click ->
  	$("#publishat").css("display","inline")
  if($("#size_later").is(":checked"))
  	$("#publishat").css("display","inline")

$ ->
	$("#size_now").click ->
  	$("#publishat").css("display","none")
  	now = new Date()
  	$("#post_published_at_3i").val(now.getDate())
  	$("#post_published_at_2i").val(now.getMonth()+1)
  	$("#post_published_at_1i").val(now.getFullYear())
  	$("#post_published_at_4i").val(now.getHours())
  	$("#post_published_at_5i").val(now.getMinutes())

$ ->
	if ( $.browser.mozilla == true )
		if ( window.location.pathname.search(/posts/)!=-1 )
				audiofiles = $("audio")
				audiofiles.each ->
					audiodiv = $(this).find(">:first-child")
					fileloc = audiodiv.attr('src')
					closetdiv = $(this).parent()
					$(closetdiv).append($("<div class=\"span6\"><b><a href=\""+fileloc+"\"
							>Download Audio <i class=\"icon-download-alt\"></i></a></b><br/></div>"))

	$("#recentcomments").click (event) ->
		if ($("#rcom").find("li").length == 0)
				callback = (response) -> 
					recentcomdiv = $("#rcom")
					commentsdiv = ""
					if(response.length != 0)
						$.each response, (val1) -> 
							comment = response[val1]
							commentsdiv=commentsdiv.concat("<li class=\"content-indent\"\>")
							commentsdiv=commentsdiv.concat("<a href=\""+comment.cached_share_url+"\" 
								class=\"sidebar-links\">"+comment.commenter+": \""+comment.cached_post_title+"\"")
						recentcomdiv.append(commentsdiv)
					else
						recentcomdiv.append("<li>No Recent Comments</li>")


				$.get '/blogs/'+ window.location.pathname.split("/")[2] + '/recentcomments/', callback, 'json'

$ ->
	$("#recentposts").click (event) ->
		if ($("#rpos").find("li").length == 0)
				callback = (response) -> 
					recentpostsdiv = $("#rpos")
					postsdiv = ""
					if (response.length != 0)
						$.each response, (val1) -> 
							post = response[val1]
							postsdiv=postsdiv.concat("<li class=\"content-indent\"\>")
							postsdiv=postsdiv.concat("<a href=\""+post.cached_share_url+"\" 
								class=\"sidebar-links\">"+post.title+"\"")

						recentpostsdiv.append(postsdiv)
					else
						recentpostsdiv.append("<li>No Recent Posts</li>")



				$.get '/blogs/'+ window.location.pathname.split("/")[2] + '/recentposts/', callback, 'json'
