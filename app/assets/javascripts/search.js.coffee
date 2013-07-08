# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	path = window.location.pathname.split('/')
	if (path[1] == 'search')
		$('.searchbox').hide()
	