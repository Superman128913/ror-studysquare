class FacultyProgramScholier < FacultyProgram

  default_scope includes(:institute).where('institutes.level = ?', 'MS')

  protected

  rails_admin do
    parent FacultyScholier
    label_plural 'Jaren'

    field :name
    field :acronym
    field :faculty
    field :program_courses

    configure :faculty do
      associated_collection_cache_all false
      associated_collection_scope do
        Proc.new { |scope|
          scope = scope.includes(:institute).where('institutes.level = ?', 'MS')
        }
      end
    end

    list do
      exclude_fields :program_courses
    end
  end
end