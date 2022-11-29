class Manager < User
  has_and_belongs_to_many :program_courses
  has_many :faculty_programs, through: :program_courses

  protected

  rails_admin do
    navigation_label "Manager"
    weight -1
  end
end

