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
  $("#bk1").removeClass("collapsed");
  $("#collapse1").addClass("in");
  $("#collapse1").css("height","auto");


$ ->
  if window.location.hash
    hashvalue = "p" + window.location.hash.split("#")[1]
    $("#"+hashvalue).css("background", "#E6E6FA")