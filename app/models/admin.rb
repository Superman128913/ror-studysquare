class Admin < User
  def program_courses
    ProgramCourse.all
  end

  protected

  rails_admin do
    navigation_label "Admin"
  end
end

