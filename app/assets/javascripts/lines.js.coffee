# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	  $("#line_stanza_id").change ->
	  	stanzno = $("select#line_stanza_id :selected").text()
	  	callback = (response) -> 
	  			$("#cantono").val(response.canto_id) 
	  			cantoname = (response) ->
	  				$("#cantoname").val(response.title)
	  			$.get '/cantos/'+ response.canto_id, cantoname, 'json'

	  	$.get '/stanzas/'+ stanzno, callback, 'json'

jQuery ->
	$('form').on 'click', '.remove_fields', (event) ->
		$(this).closest('.field').remove()
		event.preventDefault()


	$('form').on 'click', '.add_fields', (event) ->
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'),'g')
		$(this).before($(this).data('fields').replace(regexp,time))
		event.preventDefault()