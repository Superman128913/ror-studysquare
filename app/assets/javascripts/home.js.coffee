$ ->
  institute = $('#institute')
  institute.find('li a').click ->
    institute.find('.name').text($(this).text())
    
    path = $(this).data('faculties-path')
    return unless path

    $.get path, (faculties) ->
      $('#faculty').replaceWith faculties

  ms = $('#ms')
  ms.find('li a').click ->
    ms.find('.name').text($(this).text())

    pat = $(this).data('ms-path')
    return unless pat

    $.get pat, (niveaus) ->
      $('#niveau').replaceWith niveaus

      $('.pull-right #faculty').find('.name').text('Niveau')