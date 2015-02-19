# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if typeof window["Annotator"] isnt "undefined"
    $("#content").annotator().annotator "addPlugin", "Tags"
    $("#content").annotator().annotator "addPlugin", "Store",
      urls:
        create: "/notebooks"
        read: "/notes"
        update: "/notesu"
        destroy: "/notesd"
        search: "/notess"

      annotationData:
        uri: window.location.pathname + window.location.search
        prefix: "/"

      loadFromSearch:
        limit: 20
        uri: window.location.pathname + window.location.search

$ ->
  ind=window.location.pathname.split('/')
  $("#bk"+ind[2]).removeClass("collapsed");
  $("#collapse"+ind[2]).addClass("in");
  $("#collapse"+ind[2]).css("height","auto");
  $(".sectionlbl").show()

$ ->
  #show the static text "Section" after page load
  $(".sectionlbl").show()

$ ->
  #start color animation after page load
  if window.location.hash
    hashvalue = "p" + window.location.hash.split("#")[1]
    defaultBGColor = $("body").css("background-color");
    $("#" + hashvalue).animate
      #backgroundColor: "#FFEAA8"
      backgroundColor: "#CAB99C"
    , 1000
    $("#" + hashvalue).animate
      backgroundColor: defaultBGColor
    , 3000
  $('.go-top').click ->
    $('html, body').animate { scrollTop: 0 }, 'slow'
