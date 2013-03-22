# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  prmstr = window.location.search.substr(1)
  prmstr = "pages=1"  if prmstr == ""
  if typeof window["Annotator"] isnt "undefined"
    $("#content").annotator().annotator "addPlugin", "Store",
      urls:
        create: "/notebooks"
        read: "/notes"
        update: "/notesu"
        destroy: "/notesd"
        search: "/notess"

      annotationData:
        uri: window.location.pathname + "?" + prmstr
        prefix: "/"

      loadFromSearch:
        limit: 20
        uri: window.location.pathname + "?" + prmstr
