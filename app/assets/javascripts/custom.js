$(document).on('click', 'a.btn-add-to-cart', {}, function(e){
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'post',
    url: '/carts',
    data: {
      product_id: product_id,
      quantity: 1
    }
  });
  return false;
});
