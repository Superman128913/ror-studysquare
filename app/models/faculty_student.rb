class FacultyStudent < Faculty

  default_scope includes(:institute).where('institutes.level = ? OR institutes.level = ?', 'WO', 'HBO')

  protected

  rails_admin do
    parent Institute
    label_plural "Faculteiten"


    field :name
    field :acronym
    field :institute

    configure :institute do
      associated_collection_cache_all false
      associated_collection_scope do
        Proc.new { |scope|
          scope = scope.where('institutes.level = ? OR institutes.level = ?', 'WO', 'HBO')
        }
      end
    end
    
    list do
      sort_by :institute, :name
    end
  end
end