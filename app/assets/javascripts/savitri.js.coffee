# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
 if $("#source").length >0 
	  	callback = (response) -> 
	  			text5 = response
	  			showIntro text5

	  	$.get '/savitri/show/', callback, 'json'  

showIntro = (selectionData) ->
  d = JSON.stringify(selectionData, undefined, 2)
  data = jQuery.parseJSON(d)
  text = data.text
  source = data.source
  textDOM = {}
  lineByline = ((if text.length > 2 then true else false))
  $("div#text").append "<blockquote>"
  i = 0

  while i < text.length
    words = text[i].split(" ")
    linespan = document.createElement("span")
    key = "l" + i
    $(linespan).attr "id", key
    $(linespan).css("opacity", 0).addClass "animated"  if lineByline
    values = []
    j = 0

    while j < words.length
      unless lineByline
        element = document.createElement("span")
        content = document.createTextNode(words[j])
        element.appendChild content
        $(element).css("opacity", 0).addClass "animated"
        wordId = "w" + i + "-" + j
        values.push wordId
        $(element).attr "id", wordId
        linespan.appendChild element
      else
        $(linespan).append words[j]
      $(linespan).append "&nbsp;"  if j < words.length - 1
      j++
    $(linespan).append "<br>"  if i < text.length - 1
    $("blockquote").append linespan
    textDOM[key] = values
    i++
  $("div#source").html("||" + source + "||").css("opacity", 0).addClass "animated"
  line = 0
  word = 0
  count = 4
  lineWordArray = _.pairs(textDOM) #lineWordArray[I][0] == "lI", lineWordArray[I][1][J] == "wI-J"
  numLines = Object.keys(lineWordArray).length
  timer = $.timer(->
    if lineByline
      if line is 0 and count < 2
        if count is 1
          $("blockquote").children().removeClass("fadeIn").addClass "fadeOut"
          $("div#source").removeClass("fadeIn").addClass "fadeOut"
        count++
      else
        if numLines > line
          $("#" + lineWordArray[line][0]).removeClass("fadeOut").addClass "fadeIn"
          line++
        else
          $("div#source").removeClass("fadeOut").addClass "fadeIn"
          line = 0
          count = 0
    else
      if count is 0 or line is 0 and word is 0 and count < 5
        if count is 3
          $("blockquote").children().children().removeClass("fadeIn").addClass "fadeOut"
          $("div#source").removeClass("fadeIn").addClass "fadeOut"
        count++
      else
        if lineWordArray[line][1].length > word
          $("#" + lineWordArray[line][1][word]).removeClass("fadeOut").addClass "fadeIn"
          word++
        else
          word = 0
          unless numLines is line + 1
            line++
          else
            $("div#source").removeClass("fadeOut").addClass "fadeIn"
            line = 0
            count = 0
  )
  if lineByline
    timer.set
      time: 3000
      autostart: true

  else
    timer.set
      time: 500
      autostart: true

text5 = undefined
textDOM = {}