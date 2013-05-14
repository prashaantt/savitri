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
