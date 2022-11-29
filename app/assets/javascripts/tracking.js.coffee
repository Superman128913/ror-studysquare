$ ->
  $('input, textarea').change ->
    mixpanel.track "#{$(this).parent().siblings('label').text()} ingevuld"

