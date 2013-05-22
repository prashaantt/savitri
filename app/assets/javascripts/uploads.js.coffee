$ ->
	$('#upload_photo').fileupload
		dataType: "script"
		add: (e, data) ->
	      types = /(\.|\/)(gif|jpe?g|png)$/i
	      file = data.files[0]
	      if types.test(file.type) || types.test(file.name)
	        data.context = $(tmpl("template-upload", file))
	        data.submit()
	      else
	        alert("#{file.name} is not a gif, jpeg, or png image file")
	    progress: (e, data) ->
	      if data.context
	        progress = parseInt(data.loaded / data.total * 100, 10)
	        data.context.find('.bar').css('width', progress + '%')

$ ->
  $(".embedurl").hide()
  $(".previewmusic").hide()
  $(".progress").hide()
  $(".direct-upload").each ->
    form = $(this)
    $(this).fileupload
      url: form.attr("action")
      type: "POST"
      autoUpload: true
      dataType: "xml" # This is really important as s3 gives us back the url of the file in a XML document
      add: (event, data) ->
        $.ajax
          url: "/signed_urls"
          type: "GET"
          dataType: "json"
          data: # send the file name to the server so it can generate the key param
            doc:
              title: data.files[0].name

          async: false
          success: (data) ->
            
            # Now that we have our data, we update the form so it contains all
            # the needed data to sign the request
            form.find("input[name=key]").val data.key
            form.find("input[name=policy]").val data.policy
            form.find("input[name=signature]").val data.signature

        data.submit()

      send: (e, data) ->
        $(".progress").show()
        $(".progress").fadeIn()

      progress: (e, data) ->
        
        percent = Math.round((e.loaded / e.total) * 100)
        $(".bar").css "width", percent + "%"

      fail: (e, data) ->
        console.log "fail"

      success: (data) ->
        
        # Here we get the file url on s3 in an xml doc
        url = $(data).find("Location").text()
        $("#previewmusic").append("<audio controls>"+"<source src='"+url+"'"+"type='audio/mpeg'>"+"</audio>")
        $(".previewmusic").show()
        $("#embedurl").val("<audio controls>"+"<source src='"+url+"'"+"type='audio/mpeg'>"+"</audio>")
        $(".embedurl").show()
        $("#real_file_url").val url # Update the real input in the other form

      done: (event, data) ->
        $(".progress").fadeOut 300, ->
          $(".bar").css "width", 0