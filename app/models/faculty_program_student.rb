class FacultyProgramStudent < FacultyProgram

  default_scope includes(:institute).where('institutes.level = ? OR institutes.level = ?', 'WO', 'HBO')

  protected

  rails_admin do
    parent FacultyStudent
    label_plural 'Opleidingen'

    field :name
    field :acronym
    field :faculty
    field :program_courses

    configure :faculty do
      associated_collection_cache_all false
      associated_collection_scope do
        Proc.new { |scope|
          scope = scope.includes(:institute).where('institutes.level = ? OR institutes.level = ?', 'WO', 'HBO')
        }
      end
    end
    
    list do
      exclude_fields :program_courses
    end
  end
end