$('tr').click ->
  if url = $(this).data('url')
    location.href = url

$('#course_registration_ids').change ->
  checked = $(this).is(':checked')
  $(this).parents('.registrations').find('input').prop('checked', checked)

