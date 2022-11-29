$ ->
  $('#course_timeslots_attributes_field a').click ->
    # TODO: this event below doesn't fire because the click is too early
    $('.starts_at_field .hasDatepicker').change (val) ->

