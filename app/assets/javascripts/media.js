var imgCropData = {};
var jcrop_api;

$(document).ready(function()
  {

	$('#corner-control').click(function() {
	    //$('#corner-control-wrap').toggleClass('clicked');
      document.location.href="/controls";

	});

  $('#photo_src_selection').dialog({
            width: 800,
            position:['middle',150],
            resizable: false,
            autoOpen: false,
            title: "Photo import source selection",
            modal: true,
            draggable: false,
            closeOnEscape: false
    });

   $('#googleplus_photo_src_dlg').dialog({
            width: 800,
            position:['middle',150],
            resizable: false,
            autoOpen: false,
            title: "Google+ photo selection",
            modal: true,
            draggable: false,
            closeOnEscape: false
    });

   $('#picasa_photo_src_dlg').dialog({
            width: 800,
            position:['middle',150],
            resizable: false,
            autoOpen: false,
            title: "Picasa photo selection",
            modal: true,
            draggable: false,
            closeOnEscape: false
    });

   $("#fetched_photo_selection").dialog({
            width: 940,
            position:['middle',50],
            resizable: false,
            autoOpen: false,
            title: "Imported Photo selection",
            modal: true,
            draggable: false,
            closeOnEscape: false
    });

   $("#import_album_googleplus").click(function() {
    var album_url = $("#googleplus_photo_src").val().trim();
    if (album_url == "") return;
    $.ajax({
      url: "/import_googleplus",
      type: 'POST',
      async : true,
      data: {album_url: album_url},
      success: function(response) {
        if (response.status == 'ok') {
          open_fill_image_Selection_dlg(response)
        } else if (response.status == 'empty') {
          alert("This album seems to be empty, double check the album url.");
        } else {
          alert("You've entered an invalid URL");
        }
      }
    });
  });

   $("#fetched_photo_selection .close_dlg").click(function() {
    $('#fetched_photo_selection').dialog("close");
  });

   $("#fetched_photo_selection").on("click", "#import_photos_btn", function(){
      importPhotosToServer();
    });

  $("#import_album_picasa").click(function() {
    var album_url = $("#picasa_photo_src").val().trim();
    if (album_url == "") return;
    $.ajax({
      url: "/import_picasa",
      type: 'POST',
      async : true,
      data: {album_url: album_url},
      success: function(response) {
        if (response.status == 'ok') {
          open_fill_image_Selection_dlg(response)
        } else if (response.status == 'empty') {
          alert("This album seems to be empty, double check the album url.");
        } else {
          alert("You've entered an invalid URL");
        }
      }
    });
  });



  $("#photo_import_googleplus, .photo_import_wrap.icon_googleplus").click(function() {
    $('#photo_src_selection').dialog("close");
    $("#googleplus_photo_src").val("");
    $('#googleplus_photo_src_dlg').dialog("open");
  });

  $("#photo_import_picasa").click(function() {
    $('#photo_src_selection').dialog("close");
    $("#picasa_photo_src").val("");
    $('#picasa_photo_src_dlg').dialog("open");
  });

  $('#import_photo').click(function() {
      $('#photo_src_selection').dialog("open");
  });


  $('#crop_img_btn').click(function() {
    cropImage();
  });


  var $img_container = $('#fetched_photo_selection #wrapper');

  $img_container.imagesLoaded( function(){
      $img_container.masonry({
        itemSelector : '.photo_cell_wrap',
          isAnimated: true
          //, columnWidth: 305
        //, cornerStampSelector: '.corner-stamp'
      });
  });

  $('#fetched_photo_selection #wrapper').on("click", ".photo_cell_wrap", function(){
    $(this).toggleClass('selected');
  });

});


open_fill_image_Selection_dlg = function(response) {
    $('#googleplus_photo_src_dlg').dialog("close");
    $("#picasa_photo_src_dlg").dialog("close");
    $('#fetched_photo_selection').dialog("open");
    var $img_container = $('#fetched_photo_selection #wrapper');
    var image_entries = response.data.image_entries;
    var wrapper = $("#fetched_photo_selection #wrapper").empty();
    var image_cell = '<img src="" />';
    $.each( image_entries, function( key, value ) {
      image_cell = '<div data-img="'+value.file+'" class="photo_cell_wrap" id="photo_'+value.id+'"><div class="select_flag"></div><img class="photo_cell" src="'+value.thumbnail+'" /></div>';
      wrapper.append(image_cell);
    });
      $img_container.imagesLoaded( function(){
        $img_container.masonry( 'reload' );
      });

  }



  updatePhotoCoords = function(coords) {


        var imgDim = $("#photo_edit_dialog .photo_dialog_img_wrap .jcrop-holder");
        imgCropData['coords'] = coords
        imgCropData['coords']['iw'] = imgDim.width();
        imgCropData['coords']['ih'] = imgDim.height();
        $("#photo_edit_dialog #crop_img_btn").removeClass('disabled');
  }



  cropImage = function () {
       // mixpanel.track("Photo controls - Process crop");
        waitAnim();
        $("#photo_edit_dialog").dialog('close');

        $.ajax({
        url: "/crop_save_image",
        type: 'POST',
        async : true,
        data: {crop_data: imgCropData},
        success: function(response) {

        }
      });

  }


  importPhotosToServer = function () {
    var photo_images = [];

    $('#fetched_photo_selection').dialog("close");
    waitAnim();

    $("#fetched_photo_selection .photo_cell_wrap.selected").each(function() {
      photo_images.push($(this).data('img'));
    });


      $.ajax({
        url: "/import_selected_photos",
        type: 'POST',
        async : true,
        data: {photo_images: photo_images},
        success: function(response) {
          if (response.status == 'ok') {
           location.reload();

          }
        }
      });


  }