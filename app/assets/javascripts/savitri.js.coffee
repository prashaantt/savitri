# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $("#source").length > 0
    $("#playpauseicon").removeClass("icon-play").addClass("icon-pause")
    
    callback = (response) ->
      showIntro response

    $.get '/savitri/show/', callback, 'json'

jQuery ->

  $("#playpause").on "click", (event) ->
    if window.timer.isActive
      $("#playpauseicon").removeClass("icon-pause").addClass("icon-play")
    else
      $("#playpauseicon").removeClass("icon-play").addClass("icon-pause")

    window.timer.toggle()

  $("#refresh").on "click", (event) ->
    window.timer.stop()
    $("#source").empty()
    $("#display").remove()
    $("#playpauseicon").removeClass("icon-play").addClass("icon-pause")

    callback = (response) ->
      showIntro response
    
    $.get '/savitri/show/', callback, 'json'

  $("#context").on "click", (event) ->
    window.location = "/read/" + window.ref

showIntro = (selectionData) ->
  d = JSON.stringify(selectionData, undefined, 2)
  data = jQuery.parseJSON(d)
  text = data.text
  window.ref = data.source
  textDOM = {}
  lineByline = ((if text.length > 2 then true else false))
  $("#text").prepend "<p id=\"display\">"

  i = 0

  while i < text.length
    words = text[i].split(" ")
    linespan = document.createElement("span")
    key = "l" + i
    $(linespan).attr "id", key
    $(linespan).css("opacity", 0).addClass "animated"  if lineByline
    $("#source").css("opacity", 0).removeClass()
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
    $("#display").append linespan
    textDOM[key] = values
    i++
  $("#source").html("<a href='/read/" + window.ref + "'>||" + window.ref + "||</a>").css("opacity", 0).addClass("animated")
  line = 0
  word = 0
  count = 4
  lineWordArray = _.pairs(textDOM) #lineWordArray[I][0] == "lI", lineWordArray[I][1][J] == "wI-J"
  numLines = Object.keys(lineWordArray).length
  window.timer = $.timer(->
    # $(".controlbutton").show("slow")
    if lineByline
      if line is 0 and count < 2
        if count is 1
          $("#display").children().removeClass("fadeIn").addClass "fadeOut"
          $("#source").removeClass("fadeIn").addClass "fadeOut"

        count++
      else
        if numLines > line
          $("#" + lineWordArray[line][0]).removeClass("fadeOut").addClass "fadeIn"
          line++
        else
          $("#source").removeClass("fadeOut").addClass "fadeIn"
          line = 0
          count = 0
    else
      if count is 0 or line is 0 and word is 0 and count < 5
        if count is 3
          $("#display").children().children().removeClass("fadeIn").addClass "fadeOut"
          $("#source").removeClass("fadeIn").addClass "fadeOut"
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
            $("#source").removeClass("fadeOut").addClass "fadeIn"
            line = 0
            count = 0
  )
  if lineByline
    window.timer.set
      time: 3000
      autostart: true

  else
    window.timer.set
      time: 500
      autostart: true

selectionData = undefined
textDOM = {}
