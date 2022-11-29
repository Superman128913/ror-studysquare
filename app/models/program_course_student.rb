class ProgramCourseStudent < ProgramCourse

  default_scope eager_load({faculty_programs: :institute}).where('institutes.level = ? OR institutes.level = ?', 'WO', 'HBO')

  protected

  rails_admin do
    parent ProgramCourse
    label_plural "Student"
    weight -1

    field :id
    field :name
    field :acronym
    field :year
    field :active
    field :faculty_programs
    field :managers
    field :courses
    field :coupons

    configure :faculty_programs do
      # associated_collection_cache_all false
      associated_collection_scope do
        Proc.new { |scope|
          scope = scope.includes(:institute).where('institutes.level = ? OR institutes.level = ?', 'WO', 'HBO')
        }
      end
    end


    list do
      exclude_fields :acronym, :year, :courses, :coupons
    end

    edit do
      exclude_fields :courses
    end
  end
end