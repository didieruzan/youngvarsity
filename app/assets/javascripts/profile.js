
// Masonry corner stamp modifications
  // $.Mason.prototype.resize = function() {
  //   this._getColumns();
  //   this._reLayout();
  // };

  // $.Mason.prototype._reLayout = function( callback ) {
  //   var freeCols = this.cols;
  //   if ( this.options.cornerStampSelector ) {
  //     var $cornerStamp = this.element.find( this.options.cornerStampSelector ),
  //         cornerStampX = $cornerStamp.offset().left -
  //           ( this.element.offset().left + this.offset.x + parseInt($cornerStamp.css('marginLeft')) );
  //     freeCols = Math.floor( cornerStampX / this.columnWidth );
  //   }
  //   // reset columns
  //   var i = this.cols;
  //   this.colYs = [];
  //   while (i--) {
  //     this.colYs.push( this.offset.y );
  //   }

  //   for ( i = freeCols; i < this.cols; i++ ) {
  //     this.colYs[i] = this.offset.y + $cornerStamp.outerHeight(true);
  //   }

  //   // apply layout logic to all bricks
  //   this.layout( this.$bricks, callback );
  // };

$(document).ready(function()
  {

    $("#photo_edit_dialog").on('click', '#crop_img_btn.enabled', function(e) {
      $("#photo_edit_dialog").dialog('close');
      waitAnim();
      cropImage();

    });


 		$('.edit_user_profile').click(function() {
 		 	$('.saveNotif').fadeOut();
		});

		$('.edit_user_avatar, .edit_user_profile').fileupload({
      type: "POST",
      recalculateProgress: false,
      dataType: "script",
      //forceIframeTransport: true, // to simulate IE => forcing iframe instead of XHR
  		formData: [ { name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content') } ],
			add : function(e, data) {
				  var types = /(\.|\/)(gif|jpe?g|png)$/i;
        		  var file= data.files[0];
        		  var maxFileSize = 6291456;
        		  var oversized = false;
		      if (file.size > maxFileSize) {
		         alert(file.name+" is over the size 5 MB limit");
		         oversized = true;
		      }
		      if (types.test(file.type) || types.test(file.name)) {
            displayUploadProgress();
		        if (oversized == false) data.submit();
		    	}
		      else
		        { alert(file.name+" is not a gif, jpeg, or png image file") }
     		},
     		submit : function(e, data) {
          $("#crop_bg_image_btn").hide();
          $('#profile_img_upload_dlg').dialog('close');
     			$(".profile_fileinput-button").addClass('processing');
          mixpanel.track("PSI Edit - Upload photo");
     		},
     		fail : function(e, data) {
          // console.log(e);
          // console.log(data);
// 				  alert("Oops, something went wrong, contact our support if the problem persists (error 63)");
         // alert("Upload complete\nRefresh page to see updated file");

          document.location.href="/profile_ref";
				  $(".profile_fileinput-button").removeClass('processing');
     		},
        progress : function(e, data) {
          if (typeof(data) != "undefined") {
            progress = parseInt(data.loaded / data.total * 100, 10);
            $('.progress .bar').css( 'width', progress + '%' );
          }
        },
     		done : function(e, data) {
 				  $(".profile_fileinput-button").removeClass('processing');
          hideUploadProgress();
     		}

		});


		$("#tooltip_fanpage_edit_ttip1 div.hide").click(function() {
			$("#tooltip_fanpage_edit_ttip1").fadeOut();
			setCookieNoLimit('fanpage_edit_ttip1', 'hide');
		});


  		$('#upload_photo_btn').click(function() {
	        displayWaitOverlay();
	    });

		$("INPUT.colorPicker").miniColors({
		    change: function(hex, rgb) {
		    	var identifier = $(this).attr("id");
		    	if (identifier == 'user_box_bg_color')
		    	{
		    		$('#profileBoxWrapper').css('background-color', 'rgba('+rgb.r+', '+rgb.g+', '+rgb.b+', 0.5)');
		    	} else {
					$('#profileBoxWrapper').css('color', hex);
		    	}


		    }
		});

		$('.box_bg_color_transparent').change(function() {
			if ( $('.box_bg_color_transparent').is(':checked') ) {
				$('#bg_color_selector').addClass('transparent_symbol');
				$('#profileBoxWrapper').css('background', 'none');
			} else {
				var hexColor = ($('#user_box_bg_color').val()).substring(1,7);
				var rgb = hex2rgb(hexColor);
				$('#bg_color_selector').removeClass('transparent_symbol');
				$('#profileBoxWrapper').css('background-color', 'rgba('+rgb[0]+', '+rgb[1]+', '+rgb[2]+', 0.5)');
			}
	    });

	    $('.box_pos').change(function() {
	    	if ( $('#user_box_pos_right').is(':checked') )
				$("#profileBoxWrapper").css('right', '35px').css('left', 'auto');
			else
				$("#profileBoxWrapper").css('left', '35px').css('right', 'auto');
	    });



  		var photo_dialog = $('#photo_dialog').dialog({
			    width:1050,
			    position:['middle',100],
			    show: { effect: 'drop', direction: "up" },
				resizable: false,
				dialogClass: "photo_dialog_ui",
			    autoOpen: false,
			    modal: true,
			    draggable: true,
			    closeOnEscape: true
			  });

      var photo_edit_dialog = $('#photo_edit_dialog').dialog({
          width:830,
          position:['middle',100],
          show: { effect: 'drop', direction: "up" },
        resizable: false,
        dialogClass: "photo_dialog_ui",
          autoOpen: false,
          modal: true,
          draggable: true,
          closeOnEscape: true
        });

	    // $('#profile_expend').click(function() {
	    //    $('#signup_profile UL').toggle();
	    // });




	    $('#edit_profile_img').click(function() {
	    	init_profile_image_dlg();
	      	$('#profile_img_upload_dlg').dialog('open');
	    });

	    $('#edit_profile_img_submit').click(function() {
	    	if (!$(this).hasClass('disabled') ) {
	    		$('#profile_img_upload_dlg form').submit();

	    	}
	    });

		$('#user_cover_image').change(function() {
	      validate_profile_image();
	    });

	    var profile_img_upload_dlg = $('#profile_img_upload_dlg').dialog({
				  	width: 400,
				  	height: 110,
				  	position:['middle',250],
					resizable: false,
				    autoOpen: false,
				    title: "Update Profile image",
				    modal: true,
				    draggable: true,
				    closeOnEscape: true
		});

		// var pub_profile_preview_pane =$('#pub_profile_preview_pane_wrap').dialog({
		// 		  	width: 800,
		// 		  	maxWidth: 820,
		// 		  	maxHeight: 640,
		// 		  	position:['middle',250],
		// 			resizable: true,
		// 		    autoOpen: false,
		// 		    title: "Fan page preview",
		// 		    modal: false,
		// 		    draggable: true,
		// 		    dialogClass: "fanpage_preview_dlg",
		// 		    closeOnEscape: true
		// });


		var $container = $('.middle_grid');

		$container.imagesLoaded( function(){
		  $container.masonry({
		    itemSelector : '.grid_item',
		      // options...
  				isAnimated: true

		    //, cornerStampSelector: '.corner-stamp'
		  });
		});


	    // $('#pub_profile_preview_btn').click(function() {
	    //   $('#pub_profile_preview_pane_wrap').dialog('open');
	    // });

	    // $('.profile_form_fieldset input[type="text"]').change(function() {
	    //   var identifier = $(this).attr('id');
	    //    modifyPreview(identifier);
	    // });

	    $('#user_sport').change(function() {
	      modifySportIcon( $('#user_sport').val() );
	    });


      //$('.grid_item > .photo_wrap > IMG').on("click", function(event){
      $('.middle_grid').on("click", '.grid_item > .photo_wrap > IMG', function(event){
         var parentId = $(this).parents(".grid_item").attr("id");
         var parentId_arr =  parentId.split("_");
         $.get("/photos/show/", { guid: parentId_arr[1] } );
         var dlg = $('#photo_dialog');
         dlg.imagesLoaded( function(){
          dlg.dialog('open');
        });
      });


      $('.middle_grid').on('click', '.grid_item > .photo_crop', function(e) {
         $('#photo_edit_dialog .photo_dialog_img_wrap').empty();
         $("#photo_edit_dialog #crop_img_btn").addClass('disabled');
         var parentId = $(this).parents(".grid_item").attr("id");
         var parentId_arr =  parentId.split("_");
         $.get("/show4crop/", { guid: parentId_arr[1] } );
         var dlg = $('#photo_edit_dialog');
         dlg.imagesLoaded( function(){
          dlg.dialog('open');
        });
      });

      $('.middle_grid').on('click', '.comment_ico', function(e) {
         $(this).parents(".grid_item").children('.comment_input_row').show();
         $('.middle_grid').masonry( 'reload' );
      });

      $('.middle_grid').on('click', '.photo_share', function(e) {
       var cell_id = $(this).parents(".grid_item").attr("id")
       $("#"+cell_id+" .share_btn_wrap").toggle();
      });



      $('.middle_grid').on('click', '.photo_share .share_btn_wrap .btn', function(e) {
       var photo_cell_id = $(this).parents(".grid_item").attr("id")
       sharePhotoOnFB(photo_cell_id);
       return;
      });


      $('.middle_grid').on('click', '.add_edit_caption', function(e) {
      if ( $(this).hasClass('saving') ) {
        mixpanel.track("Photo controls - Saving edited caption");
        var cell_id = $(this).parents(".grid_item").attr("id");
        savePhotoDesc(cell_id);
        return;
      }
      var desc_div = $(this).parents(".grid_item").children('.photo_desc');

       if ( (desc_div).is(':hidden') ) {
          mixpanel.track("Photo controls - Display edit caption");
          desc_div.show();
          $('.middle_grid').masonry( 'reload' );
        }
    });


    $('.middle_grid').on('click', '.grid_item .photo_desc', function(e) {
          // var cell_id = $(this).parents(".grid_item").attr("id");
          // var photoDesc = $("#" + cell_id + " .photo_desc").text();
          $(this).parents(".grid_item").children('.add_edit_caption').addClass('saving');

      });



  });

	modifySportIcon = function(sport) {
		var sportIcon = "◾";
		switch (sport) {
			case 'baseball':
				sportIcon = "";
				break;
			case 'football':
				sportIcon = "◾";
				break;
			case 'basketball':
				sportIcon = "E";
				break;
			case 'lacrosse':
				sportIcon = "⛸";
				break;
			case 'soccer':
				sportIcon = "F";
				break;
			case 'skateboard':
				sportIcon = "";
				break;
		}
		$(".sportIcon").attr('data-sporticon', sportIcon);
	}






	displayWaitOverlay = function() {
	    $('#anim_overlay_wrap').css('width', $(document).width()+'px').css('height', $(document).height()+'px');
		$('#anim_overlay_wrap').fadeIn();
	}

	hideWaitOverlay = function() {
		$('#anim_overlay_wrap').fadeOut();
	}






	init_profile_image_dlg =function () {
		$('#edit_profile_img_submit').addClass('disabled');
    	$('#profile_img_upload_dlg p').text('');
	}

	validate_profile_image = function()
	{
		init_profile_image_dlg();
		// var file = document.getElementById('user_cover_image').files[0];

		// if ((file.type != 'image/jpeg') && (file.type != 'image/gif') && (file.type != 'image/png'))
		// {
		// 	$('#profile_img_upload_dlg p').text('JPG, GIF or PNG files types only!');
		// } else if (file.size > 5242880) {
		// 	$('#profile_img_upload_dlg p').text('Maximum file size: 5MB');
		// } else {
		// 	$('#edit_profile_img_submit').removeClass('disabled');
  //   		$('#profile_img_upload_dlg p').text('');
		// }


	}

	fileSelected = function() {
		var file = document.getElementById('user_cover_image').files[0];
		if (file) {
		var fileSize = 0;
		if (file.size > 1024 * 1024)
		  fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
		else
		  fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';

		document.getElementById('fileSize').innerHTML = 'Size: ' + fileSize;
		document.getElementById('fileType').innerHTML = 'Type: ' + file.type;
	}
}

  savePhotoDesc = function(cell_id) {
    var parentWrap = $("#"+cell_id);
    var cell_id_arr = cell_id.split("_");
    var photoDesc = $("#" + cell_id + " .photo_desc").text();
    var photoId = cell_id_arr[1];

    $.ajax({
      url: "/photo_save_desc",
      type: 'POST',
      async : true,
      data: {photo_id: photoId, photo_desc: photoDesc}
    });
  }


  sharePhotoOnFB = function(photo_cell_id) {
    mixpanel.track("Photo controls - Share photo");
    var cell_id_arr = photo_cell_id.split("_");
    var photoId = cell_id_arr[1];
    waitAnim();
    $.ajax({
      url: "/photo_share_on_fb",
      type: 'POST',
      async : true,
      data: {photo_id: photoId},
      success: function(response) {
        stopWaitAnim();
      }
    });
  }

