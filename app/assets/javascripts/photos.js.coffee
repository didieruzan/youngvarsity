jQuery ->
  $('#new_photo').fileupload
    dataType: "script"
    type: "POST"
    recalculateProgress: false
    #forceIframeTransport: true, // to simulate IE => forcing iframe instead of XHR
    formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') } ]
    add: (e, data) ->
      maxFileSize = 6291456
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      oversized = false
      if (file.size > maxFileSize)
         alert("#{file.name} is over the size 5 MB limit")
         oversized = true

      if types.test(file.type) || types.test(file.name)
       # data.context = $(tmpl("template-upload", file))
       # $('#new_photo').append(data.context)
        if (oversized == false)
           $('#photo_src_selection').dialog('close')
           displayUploadProgress()
           data.submit()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")
    progress: (e, data) ->
      # displayWaitOverlay()
      # progress = parseInt(data.loaded / data.total * 100, 10)
      # $('#progress .bar').css( 'width', progress + '%' )

    progressall: (e, data) ->
         progress = parseInt(data.loaded / data.total * 100, 10)
         $('.progress .bar').css( 'width', progress + '%' )
    done: (e, data) ->
      hideUploadProgress()
    fail: (e, data) ->
      alert("Oops, something went wrong while uploading the file")
      hideUploadProgress()
