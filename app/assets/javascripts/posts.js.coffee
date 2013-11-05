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

isValidRange = (ranges) ->
  valid = 0;
  $.each ranges, (k, v) ->
    range = v.split("-")

    unless range[0].match(/^\d+\.\d+$/)
      valid = 1
      return false
    
    unless typeof range[1] == "undefined"
      unless range[1].match(/^\d+\.\d+$/)
        valid = 1
        return false
      range_from = range[0].split(".")
      range_to = range[1].split(".")
      if parseInt(range_to[0]) < parseInt(range_from[0])
        valid = 2
        return false
      else if (parseInt(range_to[0]) == parseInt(range_from[0]) and parseInt(range_to[1]) < parseInt(range_from[1]))
        valid = 2
        return false
  
  return valid

$ ->
  $("#view-poemtext").click (event) ->
    event.preventDefault()
    rooturl = window.location.origin
    ranges = $("#ranges").val().replace(/\s/g, "").split(",")
    valid = isValidRange(ranges)
    unless valid == 0
      if valid == 1
        alert "Enter values as 71.39"
      else if valid == 2
        alert "Ensure the \"to\" value in the range is greater than the \"from\" value"
      return
    $("#poem-text").empty()
    $("#poem-html").empty()
    range_counter = 0
    references = {}
    $.each ranges, (range_index, range_value) ->
      range = range_value.split("-")
      # maintain order of references
      references[range] = []
      linefrom = range[0]
      lineto = ""
      if typeof range[1] != "undefined"
        lineto = range[1]
      else
        lineto = range[0]

      callback = (response) ->
        html = ""
        text = ""
        link = ""
        $.each response, (index) -> 
          lastsentence = response[index][response[index].length - 1].no
          html += "<p>"
          $.each response[index], (val, te) ->
            text += "\r\n>" + te.line + "  "
            html += "<br>" + te.line
            if lastsentence == te.no
              html += " ||" + te.section + "." + te.runningno + "||" + "</p>"
              linknum = te.stanza_id + 100
              text += "[||" + te.section + "." + te.runningno + "||][" + linknum + "]\r\n"
              link += "[" + linknum + "]: " + rooturl + te.share_url + "\r\n"
          references[range][0] = html
          references[range][1] = text
          references[range][2] = link

      xhr = $.get '/stanzas/range/'+ linefrom.replace(".", "-") + '-' + lineto.replace(".", "-"), callback, 'json'
      xhr.done ->
        ++range_counter
        if range_counter == ranges.length
          poem_html = ""
          poem_text = ""
          links_text = "\r\n"
          $.each references, (range) ->
            poem_html += references[range][0]
            poem_text += references[range][1]
            links_text += references[range][2]
          $("#poem-text").append(poem_text + links_text)
          $("#poem-html").append(poem_html)

$ ->
  $("#insert_into_post").click (event) ->
    event.preventDefault()
    if $("#poem-text").text().trim() is ""
      $("#view-poemtext").click()
      setTimeout (->
        text = $("#poem-text").text()
        if text.trim().length > 0
          mdbox = $("#wmd-input")
          mdbox.val(mdbox.val() + text)
          $("#poem-text").empty()
          $("#poem-html").empty()
          $("#myModal").modal "hide"
      ), 2000
    else
      text = $("#poem-text").text()
      if text.trim().length > 0
        mdbox = $("#wmd-input")
        mdbox.val mdbox.val() + text
        $("#poem-text").empty()
        $("#poem-html").empty()
        $("#myModal").modal "hide"

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

$ ->
  $('.best_in_place').best_in_place()
  $(".best_in_place").bind "ajax:success", ->
    $(".best_in_place").each ->
      that = $(this)
      text = that.html()
      that.html text.autoLink()
    @innerHTML = @innerHTML.replace(/\r\n|\r|\n/g,"<br />")
    $(this).animate
      backgroundColor: "#FDF1CA"
    , 1000
    $(this).animate
      backgroundColor: "#FFF"
    , 3000

  $(".best_in_place").each ->
    that = $(this)
    text = that.html()
    that.html text.autoLink()

$ ->
  $("#post_tag_tokens").tokenInput "/blogs/light-of-supreme/tags.json",
    crossDomain: false
    prePopulate: $("#post_tag_tokens").data("pre")
    preventDuplicates: true
    noResultsText: "No results. Press 'space' to create this."
    theme: "facebook"

window.subtome = {suggestedUrl: 'http://cloud.feedly.com/#subscription/feed/{feed}', suggestedName: 'Feedly'};
