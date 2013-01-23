# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#content").annotator().annotator('addPlugin', 'Store'

	   # The endpoint of the store on your server.
	  urls: 
    # These are the default URLs.
		    create:  '/notebooks'
		    read:    '/notes'
		    update:  '/notesu'
		    destroy: '/notesd'
		    search:  '/notess'

  	    # Attach the uri of the current page to all annotations to allow search.
  		annotationData:
    	uri: document.URL
	  # This will perform a "search" action rather than "read" when the plugin
	  # loads. Will request the last 20 annotations for the current url.
	  # eg. /store/endpoint/search?limit=20&uri=http://this/document/only
  	  prefix: '/'
	  loadFromSearch:
	    limit: 20
	    uri: window.location.href
  
	    )
