# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if typeof window["Annotator"] isnt "undefined"
    $("#content").annotator().annotator "addPlugin", "Store",
      urls:
        create: "/notebooks"
        read: "/notes"
        update: "/notesu"
        destroy: "/notesd"
        search: "/notess"

      annotationData:
        uri: window.location.pathname
        prefix: "/"

      loadFromSearch:
        limit: 20
        uri: window.location.pathname

$ ->
  ind=window.location.pathname.split('/')
  $("#bk"+ind[2]).removeClass("collapsed");
  $("#collapse"+ind[2]).addClass("in");
  $("#collapse"+ind[2]).css("height","auto");

$ ->
  #show the static text "Section" after page load
  $(".sectionlbl").show()

$ ->
  #start color animation after page load
  if window.location.hash
    hashvalue = "p" + window.location.hash.split("#")[1]
    currentColor = jQuery.Color("#" + hashvalue)
    $("#" + hashvalue).animate
      backgroundColor: "#FDF1CA"
    , 1000
    $("#" + hashvalue).animate
      backgroundColor: currentColor
    , 3000