$(document).on('turbolinks:load', function(){
  function selectedTab(){
    url = window.location.href
    console.log(url.split('?tab=')[1]);
    if (url.split('?tab=')[1] === 'suggesting_tab'){
      $('a[href="#suggesting_tab"]').tab('show');
    }
  }
  selectedTab();
});

$(document).on('click', 'a.btn-add-to-cart', {}, function(e){
  product_id = $(e.currentTarget).id
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
