
$(document).ready(function() {
   $(".prod-wrap .prod_wishlist_flag").click(function() {
    toggleWishFlag(this);
  });



});

toggleWishFlag = function(elem) {
  var parentElem = $(elem).parents(".prod-wrap");
  var divId = parentElem.attr("id");
  var divId_arr =  divId.split("_");
  var prodId = divId_arr[1];
  if (parentElem.hasClass('selected')) {
    remWish(prodId);
  } else {
    addWish(prodId);
  }
}

addWish = function(prodid) {
  var div = $('#item_'+prodid);
  var itemImage = $('#item_'+prodid + ' IMG').attr('src');
  var currentCount= parseInt($("#view_wishlist SPAN").text()) ;
  $.ajax({
        url: "/add_wish",
        type: 'POST',
        async : true,
        data: {prodid: prodid, token: token},
        success: function(response) {
          if (response.status == 'success') {
            div.addClass('selected');
              currentCount = currentCount+1;
              $("#view_wishlist SPAN").text(currentCount + ' items');
              $.gritter.add({
                title: 'Added to Wishlist!',
                image: itemImage,
                text: 'Item was added into your wishlist.'
              });
          }
        }
      });
}

remWish = function(prodid) {
  var div = $('#item_'+prodid);
  var itemImage = $('#item_'+prodid + ' IMG').attr('src');
  var currentCount= parseInt($("#view_wishlist SPAN").text()) ;
  $.ajax({
        url: "/rem_wish",
        type: 'POST',
        async : true,
        data: {prodid: prodid, token: token},
        success: function(response) {
          if (response.status == 'success') {
            div.removeClass('selected');
            currentCount = currentCount-1;
            $("#view_wishlist SPAN").text(currentCount + ' items');
            $.gritter.add({
                title: 'Removed from Wishlist!',
                image: itemImage,
                text: 'Item removed from your wishlist.'
              });
          }
        }
      });
}