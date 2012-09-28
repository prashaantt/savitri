# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	
	  stanzno = $("select#line_stanza_id :selected").val()
	  callback = (response) -> 
	  			$("#cantono").val(response.canto_id) 
	  			cantoname = (response) ->
	  				$("#cantoname").val(response.title)
	  			$.get '/cantos/'+ response.canto_id, cantoname, 'json'
	  $.get '/stanzas/'+ stanzno, callback, 'json'
