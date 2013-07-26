# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	path = window.location.pathname.split('/')
	if (path[1] == 'search')
	  $('.searchbox').hide()

  $("#search-form").submit ->
    unless $("#search-menu").val().indexOf("in:") is $("#search-menu").val().lastIndexOf("in:")
      alert "in: filters can be used only once in a query"
      return false

  $("#search-form-results").submit ->
    unless $("#query").val().indexOf("in:") is $("#query").val().lastIndexOf("in:")
      alert "in: filters can be used only once in a query"
      return false
