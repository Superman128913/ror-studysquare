cart = $('.winkelwagen')

do observeCart = ->
  $(cart).find('.cart-toggle').click ->
    $(cart).toggleClass("expand-cart");

$('.single-cursus form').on 'ajax:success', (event, data) ->
  $(cart).html(data)
  observeCart()

