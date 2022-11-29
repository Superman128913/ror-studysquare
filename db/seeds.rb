# TEST CURSUSSEn
# https://www.rabobank.nl/images/rabobank_omnikassa_integratiehandleiding_29420242.pdf
# 2€ Transactie geannuleerd
# 3€ Transactie verlopen
# 4€ Transactie geopend
# 5€ Transactiemislukt
# Andere gevallen Transactie gelukt

course = Course.create! do |c|
  c.price = 2
  c.program_course = ProgramCourse.first
  c.course_type = CourseType.first
end

course.timeslots.create! do |t|
  t.starts_at = Time.now + 1.day
end
course.visible = true

course.save
puts course.errors.inspect
course.save!

