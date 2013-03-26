# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	  	callback = (response) -> 
	  			text5 = response
	  			showIntro text5

	  	$.get '/savitri/', callback, 'json'  

showIntro = (selectionData) ->
  d = JSON.stringify(selectionData, undefined, 2)
  data = jQuery.parseJSON(d)
  text = data.text
  source = data.source
  lineByline = ((if text.length > 2 then true else false))
  $("div#text").append "<blockquote>"
  i = 0

  while i < text.length
    words = text[i].split(" ")
    linespan = document.createElement("span")
    lineId = "line" + i
    $(linespan).attr "id", lineId
    $(linespan).css("opacity", 0).addClass "animated"  if lineByline
    key = lineId
    values = []
    j = 0

    while j < words.length
      element = document.createElement("span")
      content = document.createTextNode(words[j])
      element.appendChild content
      wordId = "word" + i + "-" + j
      values.push wordId
      $(element).attr "id", wordId
      $(element).css("opacity", 0).addClass "animated"  unless lineByline
      linespan.appendChild element
      $(linespan).append "&nbsp;"  if j < words.length - 1
      j++
    $(linespan).append "<br>"  if i < text.length - 1
    $("blockquote").append linespan
    $("div#source").html("||" + source + "||").css("opacity", 0).addClass "animated"
    textDOM[key] = values
    i++
  line = 0
  word = 0
  count = 4
  pairs = _.pairs(textDOM) #pair[I][0] == "lineI", pair[I][1][J] == "wordI-J"
  numLines = Object.keys(pairs).length
  timer = $.timer(->
    if lineByline
      if line is 0 and count < 2
        if count is 1
          $("blockquote").children().removeClass("fadeIn").addClass "fadeOut"
          $("div#source").removeClass("fadeIn").addClass "fadeOut"
        count++
      else
        if numLines > line
          $("#" + pairs[line][0]).removeClass("fadeOut").addClass "fadeIn"
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
        if pairs[line][1].length > word
          $("#" + pairs[line][1][word]).removeClass("fadeOut").addClass "fadeIn"
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