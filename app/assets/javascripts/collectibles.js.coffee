# Initialization code
$ ->
  $('#new_collectible').fileupload
    dataType: "script"
    formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') } ]
    # formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content'), name: 'user_id', value: 1 } ]
    add: (e, data) ->
      maxFileSize = 5242881
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      oversized = false
      if (file.size > maxFileSize)
         alert("#{file.name} is over the size 5 MB limit")
         oversized = true

      if types.test(file.type) || types.test(file.name)
        if (oversized == false)
           data.submit()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")
    fail: (e, data) ->
      alert("Oops, something went wrong while uploading the file")
    progress: (e, data) ->
       progress = parseInt(data.loaded / data.total * 100, 10)
       $('.progress .bar').css( 'width', progress + '%' )

    progressall: (e, data) ->
         progress = parseInt(data.loaded / data.total * 100, 10)
         $('.progress .bar').css( 'width', progress + '%' )
    done: (e, data) ->
          $(".progress .bar").css('width', '100%');
          setTimeout ( ->
            $(".progress .bar").hide();
            $(".progress .bar").css('width', '0%');
            setTimeout ( ->
              $(".progress .bar").show();
            ), 1000
          ), 1000


  $('.edit_collectible').fileupload
    dataType: "script"
    type: "PUT"
    formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') } ]
    # formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content'), name: 'user_id', value: 1 } ]
    add: (e, data) ->
      maxFileSize = 6291456
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]
      oversized = false
      if (file.size > maxFileSize)
         alert("#{file.name} is over the size 5 MB limit")
         oversized = true

      if types.test(file.type) || types.test(file.name)
        if (oversized == false)
           data.submit()
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")
    fail: (e, data) ->
      alert("Oops, something went wrong while uploading the file")
    progress: (e, data) ->
       progress = parseInt(data.loaded / data.total * 100, 10)
       $('.progress .bar').css( 'width', progress + '%' ).css( 'visibility', 'visible' )

    progressall: (e, data) ->
         progress = parseInt(data.loaded / data.total * 100, 10)
         $('.progress .bar').css( 'width', progress + '%' ).css( 'visibility', 'visible' )
    done: (e, data) ->
          $(".progress .bar").css('width', '100%');
          setTimeout ( ->
            $(".progress .bar").hide().css( 'visibility', 'hidden' );
            $(".progress .bar").css('width', '0%');
            setTimeout ( ->
              $(".progress .bar").show();
            ), 1000
          ), 1000

$ ->
  $(".edit_collectible .display_crop_btn").click ->
    $("#crop_card_image_dialog").fadeIn()
  $(".cancel_crop_btn").click ->
    $("#crop_card_image_dialog").fadeOut()
  # $(".apply_crop_btn").click ->
    #crop




