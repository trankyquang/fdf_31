$(document).on('turbolinks:load', function(){
  $('input.only-number').on('keyup', function(event){
    if(isNaN($(this).val())){
      $(this).val(1)
    }
  });

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $('#image-upload').change(function(){
    $('#img_prev').removeClass('hidden');
    $('#current-profile-image').addClass('hidden');
    readURL(this);
  });

  $('.hot-trends-items').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    autoplay: true,
    autoplaySpeed: 2000
  });

  $('.slider-vertical').remove();
  $('#price-slider').slider({});

  $('.product-rate').empty();
  $('.product-rate').raty({
    path: '/assets',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    readOnly: true,
    score: function(){
      return $(this).attr('data-score');
    }
  });

  $('.user-rate-product').raty({
    path: '/assets',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    score: function(){
      return $(this).attr('data-score');
    },
    readOnly: $(this).attr('read-only') == 'true',
    click: function(score, event){
      product_id = $('.user-rate-product').attr('product-id');
      rate_id = $('.user-rate-product').attr('rate-id');
      user_id = $('.user-rate-product').attr('user-id');
      $.ajax({
        method: 'post',
        url: product_id + '/ratings/',
        data: {
          rating: {
            product_id: product_id,
            user_id: user_id,
            point: score
          }
        },
        success: function(){
          $('.user-rate-product').raty('score', score);
          $('.user-rate-product').raty('readOnly', true);
        }
      });
      return false;
    },
  });

  $('.recently-viewed-rating').raty({
    path: '/assets',
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    score: function(){
      return $(this).attr('data-score');
    },
    readOnly: true
  });

  function loadFacebookComment(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = '//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.8&appId=213223815761488';
    fjs.parentNode.insertBefore(js, fjs);
  };

  loadFacebookComment(document, 'script', 'facebook-jssdk');

  function selectedTab(){
    url = window.location.href
    console.log(url.split('?tab=')[1]);
    if (url.split('?tab=')[1] === 'suggesting_tab'){
      $('a[href="#suggesting_tab"]').tab('show');
    }
  }

  selectedTab();
});

$(document).on('click', '.number-spinner .btn', {}, function(e){
  currentVal = $(e.currentTarget).parent().parent().find('input').val();
  if($(e.currentTarget).attr('data-dir')=='up'){
    newVal = 1
  }else{
    if (currentVal === '1'){
      return false;
    }
    newVal = -1
  }
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'post',
    url: 'carts/',
    data: {
      product_id: product_id,
      quantity: newVal
    }
  });
  return false;
});

$(document).on('click', 'a.btn-remove-product', {}, function(e){
  product_id = $(e.currentTarget).attr('product');
  $.ajax({
    method: 'delete',
    url: '/carts',
    data: {
      product_id: product_id
    },
  });
  return false;
});

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
