$(document).ready(function()
  {
      $('#new_prodimage').fileupload({
        formData:  {
            name: 'authenticity_token', value: $('meta[name="csrf-token"]').attr('content'),
            product_id: $('#product_id').attr('value')
          } ,
          add : function(e, data) {
          var types = /(\.|\/)(gif|jpe?g|png)$/i;
                var file= data.files[0];
                var maxFileSize = 3145728;
                var oversized = false;
            if (file.size > maxFileSize) {
               alert(file.name+" is over the size 3 MB limit");
               oversized = true;
            }
            if (types.test(file.type) || types.test(file.name)) {
              if (oversized == false) data.submit();
            }
            else
              { alert(file.name+" is not a gif, jpeg, or png image file") }
          },
          submit : function(e, data) {
            $(".profile_fileinput-button").addClass('processing');
          },
          fail : function(e, data) {
          alert("Oops, something went wrong, contact our support if the problem persists");
          $(".profile_fileinput-button").removeClass('processing');
          },
          done : function(e, data) {
          $(".profile_fileinput-button").removeClass('processing');
          }

    });

    $("#upload_new_img").click(function() {
        displayProductImageUploadDlg();
     });

    $('#product_img_upload_dlg').dialog({
            width: 400,
            height: 110,
            position:['middle',250],
            resizable: false,
            autoOpen: false,
            title: "Upload Product image",
            modal: true,
            draggable: true,
            closeOnEscape: true
    });

});


displayProductImageUploadDlg = function() {
    $("#product_img_upload_dlg").dialog("open");
}